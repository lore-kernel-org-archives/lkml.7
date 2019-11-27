Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B45C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E9A20869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890754;
	bh=bg068m6eQEBEESa5p5w78Mq6U6ACRkCkcOhx0Dbo9xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=naFX3mg1pjcKZGXTDqZ7slvsn4g3l8xQpF42DeLNI3VkKTAmTRItuw8m0PxTVWYln
	 YsJq9Hg5o00AQ6VYZqJLK1kklF15by/3kCKtXqSNor14bk+IB5RYfJEPpDgp5tX8C9
	 Ss67UI1H3N/BBwCZDosIziMwlf9rphGKMSWc1das=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfK0VjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbfK0Uoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:44:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F339D2158A;
        Wed, 27 Nov 2019 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887471;
        bh=bg068m6eQEBEESa5p5w78Mq6U6ACRkCkcOhx0Dbo9xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPhmzekZrSgaqW7eDPzMpR13pMYqV8y9JJT1SwMr7GP5NYh072tMRsUagvBspYJeT
         2OH+ezwddNGSMzZ0qZxnvXW7dW9cMBQQ1MJI5Yj9jTsQtuoJfFftLSSVUHP8aFRk5C
         ttMiL724pQ4a6zH8C9Zxy8jDCpgReN+VNUUS1mzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 4.9 125/151] media: vivid: Fix wrong locking that causes race conditions on streaming stop
Date:   Wed, 27 Nov 2019 21:31:48 +0100
Message-Id: <20191127203045.625770964@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Popov <alex.popov@linux.com>

commit 6dcd5d7a7a29c1e4b8016a06aed78cd650cd8c27 upstream.

There is the same incorrect approach to locking implemented in
vivid_stop_generating_vid_cap(), vivid_stop_generating_vid_out() and
sdr_cap_stop_streaming().

These functions are called during streaming stopping with vivid_dev.mutex
locked. And they all do the same mistake while stopping their kthreads,
which need to lock this mutex as well. See the example from
vivid_stop_generating_vid_cap():
  /* shutdown control thread */
  vivid_grab_controls(dev, false);
  mutex_unlock(&dev->mutex);
  kthread_stop(dev->kthread_vid_cap);
  dev->kthread_vid_cap = NULL;
  mutex_lock(&dev->mutex);

But when this mutex is unlocked, another vb2_fop_read() can lock it
instead of vivid_thread_vid_cap() and manipulate the buffer queue.
That causes a use-after-free access later.

To fix those issues let's:
  1. avoid unlocking the mutex in vivid_stop_generating_vid_cap(),
vivid_stop_generating_vid_out() and sdr_cap_stop_streaming();
  2. use mutex_trylock() with schedule_timeout_uninterruptible() in
the loops of the vivid kthread handlers.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: <stable@vger.kernel.org>      # for v3.18 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-kthread-cap.c |    8 +++++---
 drivers/media/platform/vivid/vivid-kthread-out.c |    8 +++++---
 drivers/media/platform/vivid/vivid-sdr-cap.c     |    8 +++++---
 3 files changed, 15 insertions(+), 9 deletions(-)

--- a/drivers/media/platform/vivid/vivid-kthread-cap.c
+++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
@@ -777,7 +777,11 @@ static int vivid_thread_vid_cap(void *da
 		if (kthread_should_stop())
 			break;
 
-		mutex_lock(&dev->mutex);
+		if (!mutex_trylock(&dev->mutex)) {
+			schedule_timeout_uninterruptible(1);
+			continue;
+		}
+
 		cur_jiffies = jiffies;
 		if (dev->cap_seq_resync) {
 			dev->jiffies_vid_cap = cur_jiffies;
@@ -930,8 +934,6 @@ void vivid_stop_generating_vid_cap(struc
 
 	/* shutdown control thread */
 	vivid_grab_controls(dev, false);
-	mutex_unlock(&dev->mutex);
 	kthread_stop(dev->kthread_vid_cap);
 	dev->kthread_vid_cap = NULL;
-	mutex_lock(&dev->mutex);
 }
--- a/drivers/media/platform/vivid/vivid-kthread-out.c
+++ b/drivers/media/platform/vivid/vivid-kthread-out.c
@@ -147,7 +147,11 @@ static int vivid_thread_vid_out(void *da
 		if (kthread_should_stop())
 			break;
 
-		mutex_lock(&dev->mutex);
+		if (!mutex_trylock(&dev->mutex)) {
+			schedule_timeout_uninterruptible(1);
+			continue;
+		}
+
 		cur_jiffies = jiffies;
 		if (dev->out_seq_resync) {
 			dev->jiffies_vid_out = cur_jiffies;
@@ -301,8 +305,6 @@ void vivid_stop_generating_vid_out(struc
 
 	/* shutdown control thread */
 	vivid_grab_controls(dev, false);
-	mutex_unlock(&dev->mutex);
 	kthread_stop(dev->kthread_vid_out);
 	dev->kthread_vid_out = NULL;
-	mutex_lock(&dev->mutex);
 }
--- a/drivers/media/platform/vivid/vivid-sdr-cap.c
+++ b/drivers/media/platform/vivid/vivid-sdr-cap.c
@@ -149,7 +149,11 @@ static int vivid_thread_sdr_cap(void *da
 		if (kthread_should_stop())
 			break;
 
-		mutex_lock(&dev->mutex);
+		if (!mutex_trylock(&dev->mutex)) {
+			schedule_timeout_uninterruptible(1);
+			continue;
+		}
+
 		cur_jiffies = jiffies;
 		if (dev->sdr_cap_seq_resync) {
 			dev->jiffies_sdr_cap = cur_jiffies;
@@ -309,10 +313,8 @@ static void sdr_cap_stop_streaming(struc
 	}
 
 	/* shutdown control thread */
-	mutex_unlock(&dev->mutex);
 	kthread_stop(dev->kthread_sdr_cap);
 	dev->kthread_sdr_cap = NULL;
-	mutex_lock(&dev->mutex);
 }
 
 const struct vb2_ops vivid_sdr_cap_qops = {


