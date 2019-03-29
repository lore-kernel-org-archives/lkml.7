Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DF3218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfC2Uty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:49:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbfC2Utw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:49:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E215307B95F;
        Fri, 29 Mar 2019 20:49:51 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE3055C23D;
        Fri, 29 Mar 2019 20:49:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>
Subject: [RESEND PATCH 2/3] ipc: Conserve sequence numbers in ipcmni_extend mode
Date:   Fri, 29 Mar 2019 16:49:29 -0400
Message-Id: <20190329204930.21620-2-longman@redhat.com>
In-Reply-To: <20190329204930.21620-1-longman@redhat.com>
References: <20190329204930.21620-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 29 Mar 2019 20:49:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Spraul <manfred@colorfullife.com>

Rewrite, based on the patch from Waiman Long:

The mixing in of a sequence number into the IPC IDs is probably to
avoid ID reuse in userspace as much as possible. With ipcmni_extend
mode, the number of usable sequence numbers is greatly reduced leading
to higher chance of ID reuse.

To address this issue, we need to conserve the sequence number space
as much as possible. Right now, the sequence number is incremented for
every new ID created. In reality, we only need to increment the sequence
number when new allocated ID is not greater than the last one allocated.
It is in such case that the new ID may collide with an existing one.
This is being done irrespective of the ipcmni mode.

In order to avoid any races, the index is first allocated and
then the pointer is replaced.

Changes compared to the initial patch:
- Handle failures from idr_alloc().
- Avoid that concurrent operations can see the wrong
  sequence number.
(This is achieved by using idr_replace()).
- IPCMNI_SEQ_SHIFT is not a constant, thus renamed to
	ipcmni_seq_shift().
- IPCMNI_SEQ_MAX is not a constant, thus renamed to
	ipcmni_seq_max().

Suggested-by: Matthew Wilcox <willy@infradead.org>
Original-patch-from: Waiman Long <longman@redhat.com>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Acked-by: Waiman Long <longman@redhat.com>
---
 include/linux/ipc_namespace.h |  1 +
 ipc/util.c                    | 35 ++++++++++++++++++++++++++++++-----
 ipc/util.h                    |  8 ++++----
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 6ab8c1bada3f..c309f43bde45 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -19,6 +19,7 @@ struct ipc_ids {
 	struct rw_semaphore rwsem;
 	struct idr ipcs_idr;
 	int max_idx;
+	int last_idx;	/* For wrap around detection */
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	int next_id;
 #endif
diff --git a/ipc/util.c b/ipc/util.c
index 07ae117ccdc0..6e0fe3410423 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -120,6 +120,7 @@ void ipc_init_ids(struct ipc_ids *ids)
 	rhashtable_init(&ids->key_ht, &ipc_kht_params);
 	idr_init(&ids->ipcs_idr);
 	ids->max_idx = -1;
+	ids->last_idx = -1;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	ids->next_id = -1;
 #endif
@@ -193,6 +194,10 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
  *
  * The caller must own kern_ipc_perm.lock.of the new object.
  * On error, the function returns a (negative) error code.
+ *
+ * To conserve sequence number space, especially with extended ipc_mni,
+ * the sequence number is incremented only when the returned ID is less than
+ * the last one.
  */
 static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 {
@@ -216,17 +221,37 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
-		new->seq = ids->seq++;
-		if (ids->seq > IPCID_SEQ_MAX)
-			ids->seq = 0;
-		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
+
+		/* allocate the idx, with a NULL struct kern_ipc_perm */
+		idx = idr_alloc(&ids->ipcs_idr, NULL, 0, 0, GFP_NOWAIT);
+
+		if (idx >= 0) {
+			/*
+			 * idx got allocated successfully.
+			 * Now calculate the sequence number and set the
+			 * pointer for real.
+			 */
+			if (idx <= ids->last_idx) {
+				ids->seq++;
+				if (ids->seq >= ipcid_seq_max())
+					ids->seq = 0;
+			}
+			ids->last_idx = idx;
+
+			new->seq = ids->seq;
+			/* no need for smp_wmb(), this is done
+			 * inside idr_replace, as part of
+			 * rcu_assign_pointer
+			 */
+			idr_replace(&ids->ipcs_idr, new, idx);
+		}
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
 		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
 				0, GFP_NOWAIT);
 	}
 	if (idx >= 0)
-		new->id = (new->seq << IPCMNI_SEQ_SHIFT) + idx;
+		new->id = (new->seq << ipcmni_seq_shift()) + idx;
 	return idx;
 }
 
diff --git a/ipc/util.h b/ipc/util.h
index 9746886757de..8c834ed39012 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -34,13 +34,13 @@
 extern int ipc_mni;
 extern int ipc_mni_shift;
 
-#define IPCMNI_SEQ_SHIFT	ipc_mni_shift
+#define ipcmni_seq_shift()	ipc_mni_shift
 #define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
 
 #else /* CONFIG_SYSVIPC_SYSCTL */
 
 #define ipc_mni			IPCMNI
-#define IPCMNI_SEQ_SHIFT	IPCMNI_SHIFT
+#define ipcmni_seq_shift()	IPCMNI_SHIFT
 #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
 
@@ -123,8 +123,8 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *);
 #define IPC_SHM_IDS	2
 
 #define ipcid_to_idx(id)  ((id) & IPCMNI_IDX_MASK)
-#define ipcid_to_seqx(id) ((id) >> IPCMNI_SEQ_SHIFT)
-#define IPCID_SEQ_MAX	  (INT_MAX >> IPCMNI_SEQ_SHIFT)
+#define ipcid_to_seqx(id) ((id) >> ipcmni_seq_shift())
+#define ipcid_seq_max()	  (INT_MAX >> ipcmni_seq_shift())
 
 /* must be called with ids->rwsem acquired for writing */
 int ipc_addid(struct ipc_ids *, struct kern_ipc_perm *, int);
-- 
2.18.1

