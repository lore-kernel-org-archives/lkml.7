Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FDCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C09218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbfB1Srr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:47:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388466AbfB1Sro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:47:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD038307E047;
        Thu, 28 Feb 2019 18:47:43 +0000 (UTC)
Received: from llong.com (ovpn-121-201.rdu2.redhat.com [10.10.121.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29FA519C5B;
        Thu, 28 Feb 2019 18:47:41 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v12 2/3] ipc: Conserve sequence numbers in ipcmni_extend mode
Date:   Thu, 28 Feb 2019 13:47:24 -0500
Message-Id: <1551379645-819-3-git-send-email-longman@redhat.com>
In-Reply-To: <1551379645-819-1-git-send-email-longman@redhat.com>
References: <1551379645-819-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 28 Feb 2019 18:47:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/ipc_namespace.h |  1 +
 ipc/util.c                    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 6ab8c1b..c309f43 100644
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
index 07ae117..0a835a4 100644
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
@@ -216,10 +221,11 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
-		new->seq = ids->seq++;
-		if (ids->seq > IPCID_SEQ_MAX)
-			ids->seq = 0;
 		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
+		if ((idx <= ids->last_idx) && (++ids->seq > IPCID_SEQ_MAX))
+			ids->seq = 0;
+		new->seq = ids->seq;
+		ids->last_idx = idx;
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
 		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
-- 
1.8.3.1

