Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F2AC742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD1B2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfGLIsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:48:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35919 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbfGLIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:48:03 -0400
X-UUID: a6087602278f4ecba3588607e09d4a2c-20190712
X-UUID: a6087602278f4ecba3588607e09d4a2c-20190712
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1209527918; Fri, 12 Jul 2019 16:47:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 12 Jul 2019 16:47:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Jul 2019 16:47:47 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <labbott@redhat.com>, <sumit.semwal@linaro.org>,
        <gregkh@linuxfoundation.org>, <riandrews@android.com>,
        <arve@android.com>, <devel@driverdev.osuosl.org>,
        <dri-devel@lists.freedesktop.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>
Subject: [PATCH] staging: android: ion: Remove unused rbtree for ion_buffer
Date:   Fri, 12 Jul 2019 16:47:17 +0800
Message-ID: <20190712084717.12441-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 92F56628C2D35BF0FDAA2809FBCCFE1AB61FCD8B124717D9CCEB10392A8CBEA92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ion_buffer_add() insert ion_buffer into rbtree every time creating
an ion_buffer but never use it after ION reworking.
Also, buffer_lock protects only rbtree operation, remove it together.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: YJ Chiang <yj.chiang@mediatek.com>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 drivers/staging/android/ion/ion.c | 36 -------------------------------
 drivers/staging/android/ion/ion.h | 10 +--------
 2 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 92c2914239e3..e6b1ca141b93 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -29,32 +29,6 @@
 static struct ion_device *internal_dev;
 static int heap_id;
 
-/* this function should only be called while dev->lock is held */
-static void ion_buffer_add(struct ion_device *dev,
-			   struct ion_buffer *buffer)
-{
-	struct rb_node **p = &dev->buffers.rb_node;
-	struct rb_node *parent = NULL;
-	struct ion_buffer *entry;
-
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct ion_buffer, node);
-
-		if (buffer < entry) {
-			p = &(*p)->rb_left;
-		} else if (buffer > entry) {
-			p = &(*p)->rb_right;
-		} else {
-			pr_err("%s: buffer already found.", __func__);
-			BUG();
-		}
-	}
-
-	rb_link_node(&buffer->node, parent, p);
-	rb_insert_color(&buffer->node, &dev->buffers);
-}
-
 /* this function should only be called while dev->lock is held */
 static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 					    struct ion_device *dev,
@@ -100,9 +74,6 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 
 	INIT_LIST_HEAD(&buffer->attachments);
 	mutex_init(&buffer->lock);
-	mutex_lock(&dev->buffer_lock);
-	ion_buffer_add(dev, buffer);
-	mutex_unlock(&dev->buffer_lock);
 	return buffer;
 
 err1:
@@ -131,11 +102,6 @@ void ion_buffer_destroy(struct ion_buffer *buffer)
 static void _ion_buffer_destroy(struct ion_buffer *buffer)
 {
 	struct ion_heap *heap = buffer->heap;
-	struct ion_device *dev = buffer->dev;
-
-	mutex_lock(&dev->buffer_lock);
-	rb_erase(&buffer->node, &dev->buffers);
-	mutex_unlock(&dev->buffer_lock);
 
 	if (heap->flags & ION_HEAP_FLAG_DEFER_FREE)
 		ion_heap_freelist_add(heap, buffer);
@@ -694,8 +660,6 @@ static int ion_device_create(void)
 	}
 
 	idev->debug_root = debugfs_create_dir("ion", NULL);
-	idev->buffers = RB_ROOT;
-	mutex_init(&idev->buffer_lock);
 	init_rwsem(&idev->lock);
 	plist_head_init(&idev->heaps);
 	internal_dev = idev;
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index e291299fd35f..74914a266e25 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -23,7 +23,6 @@
 
 /**
  * struct ion_buffer - metadata for a particular buffer
- * @node:		node in the ion_device buffers tree
  * @list:		element in list of deferred freeable buffers
  * @dev:		back pointer to the ion_device
  * @heap:		back pointer to the heap the buffer came from
@@ -39,10 +38,7 @@
  * @attachments:	list of devices attached to this buffer
  */
 struct ion_buffer {
-	union {
-		struct rb_node node;
-		struct list_head list;
-	};
+	struct list_head list;
 	struct ion_device *dev;
 	struct ion_heap *heap;
 	unsigned long flags;
@@ -61,14 +57,10 @@ void ion_buffer_destroy(struct ion_buffer *buffer);
 /**
  * struct ion_device - the metadata of the ion device node
  * @dev:		the actual misc device
- * @buffers:		an rb tree of all the existing buffers
- * @buffer_lock:	lock protecting the tree of buffers
  * @lock:		rwsem protecting the tree of heaps and clients
  */
 struct ion_device {
 	struct miscdevice dev;
-	struct rb_root buffers;
-	struct mutex buffer_lock;
 	struct rw_semaphore lock;
 	struct plist_head heaps;
 	struct dentry *debug_root;
-- 
2.17.1

