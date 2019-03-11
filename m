Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14754C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA86120657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCKB0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 21:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfCKB0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 21:26:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 009A6309179A;
        Mon, 11 Mar 2019 01:26:00 +0000 (UTC)
Received: from llong.com (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3829F5D70E;
        Mon, 11 Mar 2019 01:25:53 +0000 (UTC)
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
Subject: [PATCH-next] ipc: Fix race condition in ipc_idr_alloc()
Date:   Sun, 10 Mar 2019 21:25:36 -0400
Message-Id: <20190311012536.21747-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 11 Mar 2019 01:26:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipc_idr_alloc(), the sequence number of the kern_ipc_perm object was
also set before calling idr_alloc(). That gets changed recently in order
to conserve the sequence number space. That can lead to a possible race
condition where another thread of the same kern_ipc_perm may have called
ipc_obtain_object_check() concurrently with a recently deleted IPC id.
If idr_alloc() function happens to allocate the deleted index value,
that thread will incorrectly get a handle to the new IPC id.

However, we don't know if we should increment seq before the index value
is allocated and compared with the previously allocated index value. To
solve this dilemma, we will always put a new sequence number into the
kern_ipc_perm object before calling idr_alloc(). If it happens that the
sequence number don't need to be changed, we write back the right value
afterward. This will ensure that a concurrent ipc_obtain_object_check()
will not incorrectly match a deleted IPC id to to a new one.

Reported-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/util.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 78e14acb51a7..6cb4129a2649 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -221,15 +221,34 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
+		/*
+		 * It is possible that another thread of the same
+		 * kern_ipc_perm may have called ipc_obtain_object_check()
+		 * concurrently with a recently deleted IPC id (idx|seq).
+		 * If idr_alloc() happens to allocate this deleted idx value,
+		 * the other thread may incorrectly get a handle to the new
+		 * IPC id.
+		 *
+		 * To prevent this race condition from happening, we will
+		 * always store a new sequence number into the kern_ipc_perm
+		 * object before calling idr_alloc(). If we find out that we
+		 * don't need to change seq, we write back the right value.
+		 */
+		new->seq = ids->seq + 1;
+		if (new->seq > IPCID_SEQ_MAX)
+			new->seq = 0;
+
 		if (ipc_mni_extended)
 			idx = idr_alloc_cyclic(&ids->ipcs_idr, new, 0, ipc_mni,
 						GFP_NOWAIT);
 		else
 			idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
 
-		if ((idx <= ids->last_idx) && (++ids->seq > IPCID_SEQ_MAX))
-			ids->seq = 0;
-		new->seq = ids->seq;
+		/* Make ids->seq and new->seq stay in sync */
+		if (idx <= ids->last_idx)
+			ids->seq = new->seq;
+		else
+			new->seq = ids->seq;
 		ids->last_idx = idx;
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
-- 
2.18.1

