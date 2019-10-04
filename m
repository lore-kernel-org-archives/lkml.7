Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3968DC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1251620700
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfJDNqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:46:30 -0400
Received: from foss.arm.com ([217.140.110.172]:45510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388333AbfJDNqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:46:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6845B15A1;
        Fri,  4 Oct 2019 06:46:29 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E22F3F739;
        Fri,  4 Oct 2019 06:46:28 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] kmemleak: Do not corrupt the object_list during clean-up
Date:   Fri,  4 Oct 2019 14:46:24 +0100
Message-Id: <20191004134624.46216-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of an error (e.g. memory pool too small), kmemleak disables
itself and cleans up the already allocated metadata objects. However, if
this happens early before the RCU callback mechanism is available,
put_object() skips call_rcu() and frees the object directly. This is not
safe with the RCU list traversal in __kmemleak_do_cleanup().

Change the list traversal in __kmemleak_do_cleanup() to
list_for_each_entry_safe() and remove the rcu_read_{lock,unlock} since
the kmemleak is already disabled at this point. In addition, avoid an
unnecessary metadata object rb-tree look-up since it already has the
struct kmemleak_object pointer.

Fixes: c5665868183f ("mm: kmemleak: use the memory pool for early allocations")
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reported-by: Marc Dionne <marc.c.dionne@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 03a8d84badad..244607663363 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -526,6 +526,16 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 	return object;
 }
 
+/*
+ * Remove an object from the object_tree_root and object_list. Must be called
+ * with the kmemleak_lock held _if_ kmemleak is still enabled.
+ */
+static void __remove_object(struct kmemleak_object *object)
+{
+	rb_erase(&object->rb_node, &object_tree_root);
+	list_del_rcu(&object->object_list);
+}
+
 /*
  * Look up an object in the object search tree and remove it from both
  * object_tree_root and object_list. The returned object's use_count should be
@@ -538,10 +548,8 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
 
 	write_lock_irqsave(&kmemleak_lock, flags);
 	object = lookup_object(ptr, alias);
-	if (object) {
-		rb_erase(&object->rb_node, &object_tree_root);
-		list_del_rcu(&object->object_list);
-	}
+	if (object)
+		__remove_object(object);
 	write_unlock_irqrestore(&kmemleak_lock, flags);
 
 	return object;
@@ -1834,12 +1842,16 @@ static const struct file_operations kmemleak_fops = {
 
 static void __kmemleak_do_cleanup(void)
 {
-	struct kmemleak_object *object;
+	struct kmemleak_object *object, *tmp;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(object, &object_list, object_list)
-		delete_object_full(object->pointer);
-	rcu_read_unlock();
+	/*
+	 * Kmemleak has already been disabled, no need for RCU list traversal
+	 * or kmemleak_lock held.
+	 */
+	list_for_each_entry_safe(object, tmp, &object_list, object_list) {
+		__remove_object(object);
+		__delete_object(object);
+	}
 }
 
 /*
