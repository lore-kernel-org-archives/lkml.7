Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF58EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E98218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfC2Utz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:49:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730275AbfC2Uty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:49:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A18D72663;
        Fri, 29 Mar 2019 20:49:53 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1CE1B47B;
        Fri, 29 Mar 2019 20:49:51 +0000 (UTC)
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
Subject: [RESEND PATCH 3/3] ipc: Do cyclic id allocation for the ipc object.
Date:   Fri, 29 Mar 2019 16:49:30 -0400
Message-Id: <20190329204930.21620-3-longman@redhat.com>
In-Reply-To: <20190329204930.21620-1-longman@redhat.com>
References: <20190329204930.21620-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 29 Mar 2019 20:49:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Spraul <manfred@colorfullife.com>

For ipcmni_extend mode, the sequence number space is only 7 bits. So
the chance of id reuse is relatively high compared with the non-extended
mode.

To alleviate this id reuse problem, this patch enables cyclic allocation
for the index to the radix tree (idx).
The disadvantage is that this can cause a slight slow-down of the fast
path, as the radix tree could be higher than necessary.

To limit the radix tree height, I have chosen the following limits:
- 1) The cycling is done over in_use*1.5.
- 2) At least, the cycling is done over
   "normal" ipcnmi mode: RADIX_TREE_MAP_SIZE elements
   "ipcmni_extended": 4096 elements

Result:
- for normal mode:
	No change for <= 42 active ipc elements. With more than 42
	active ipc elements, a 2nd level would be added to the radix
	tree.
	Without cyclic allocation, a 2nd level would be added only with
	more than 63 active elements.

- for extended mode:
	Cycling creates always at least a 2-level radix tree.
	With more than 2730 active objects, a 3rd level would be
	added, instead of > 4095 active objects until the 3rd level
	is added without cyclic allocation.

For a 2-level radix tree compared to a 1-level radix tree, I have
observed < 1% performance impact.

Notes:
1) Normal "x=semget();y=semget();" is unaffected: Then the idx
  is e.g. a and a+1, regardless if idr_alloc() or idr_alloc_cyclic()
  is used.

2) The -1% happens in a microbenchmark after this situation:
	x=semget();
	for(i=0;i<4000;i++) {t=semget();semctl(t,0,IPC_RMID);}
	y=semget();
	Now perform semget calls on x and y that do not sleep.

3) The worst-case reuse cycle time is unfortunately unaffected:
   If you have 2^24-1 ipc objects allocated, and get/remove the last
   possible element in a loop, then the id is reused after 128
   get/remove pairs.

Performance check:
A microbenchmark that performes no-op semop() randomly on two IDs,
with only these two IDs allocated.
The IDs were set using /proc/sys/kernel/sem_next_id.
The test was run 5 times, averages are shown.

1 & 2: Base (6.22 seconds for 10.000.000 semops)
1 & 40: -0.2%
1 & 3348: - 0.8%
1 & 27348: - 1.6%
1 & 15777204: - 3.2%

Or: ~12.6 cpu cycles per additional radix tree level.
The cpu is an Intel I3-5010U. ~1300 cpu cycles/syscall is slower
than what I remember (spectre impact?).

V2 of the patch:
- use "min" and "max"
- use RADIX_TREE_MAP_SIZE * RADIX_TREE_MAP_SIZE instead of
	(2<<12).

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Acked-by: Waiman Long <longman@redhat.com>
---
 ipc/ipc_sysctl.c | 2 ++
 ipc/util.c       | 7 ++++++-
 ipc/util.h       | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 73b7782eccf4..bfaae457810c 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -122,6 +122,7 @@ static int one = 1;
 static int int_max = INT_MAX;
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
+int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -252,6 +253,7 @@ static int __init ipc_mni_extend(char *str)
 {
 	ipc_mni = IPCMNI_EXTEND;
 	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
+	ipc_min_cycle = IPCMNI_EXTEND_MIN_CYCLE;
 	pr_info("IPCMNI extended to %d.\n", ipc_mni);
 	return 0;
 }
diff --git a/ipc/util.c b/ipc/util.c
index 6e0fe3410423..1a492afb1d8b 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -221,9 +221,14 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
+		int max_idx;
+
+		max_idx = max(ids->in_use*3/2, ipc_min_cycle);
+		max_idx = min(max_idx, ipc_mni);
 
 		/* allocate the idx, with a NULL struct kern_ipc_perm */
-		idx = idr_alloc(&ids->ipcs_idr, NULL, 0, 0, GFP_NOWAIT);
+		idx = idr_alloc_cyclic(&ids->ipcs_idr, NULL, 0, max_idx,
+					GFP_NOWAIT);
 
 		if (idx >= 0) {
 			/*
diff --git a/ipc/util.h b/ipc/util.h
index 8c834ed39012..d316399f0c32 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -27,12 +27,14 @@
  */
 #define IPCMNI_SHIFT		15
 #define IPCMNI_EXTEND_SHIFT	24
+#define IPCMNI_EXTEND_MIN_CYCLE	(RADIX_TREE_MAP_SIZE * RADIX_TREE_MAP_SIZE)
 #define IPCMNI			(1 << IPCMNI_SHIFT)
 #define IPCMNI_EXTEND		(1 << IPCMNI_EXTEND_SHIFT)
 
 #ifdef CONFIG_SYSVIPC_SYSCTL
 extern int ipc_mni;
 extern int ipc_mni_shift;
+extern int ipc_min_cycle;
 
 #define ipcmni_seq_shift()	ipc_mni_shift
 #define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
@@ -40,6 +42,7 @@ extern int ipc_mni_shift;
 #else /* CONFIG_SYSVIPC_SYSCTL */
 
 #define ipc_mni			IPCMNI
+#define ipc_min_cycle		RADIX_TREE_MAP_SIZE
 #define ipcmni_seq_shift()	IPCMNI_SHIFT
 #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
-- 
2.18.1

