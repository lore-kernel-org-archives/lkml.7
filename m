Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA696C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8753720692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKUQm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:42:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32859 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:42:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXpXR-0000LU-Uh; Thu, 21 Nov 2019 17:42:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 908D31C1A38;
        Thu, 21 Nov 2019 17:42:37 +0100 (CET)
Date:   Thu, 21 Nov 2019 16:42:37 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Do not pass 'rb_root' down the memtype tree
 helper functions
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, bp@alien8.de,
        dave@stgolabs.net, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121011601.20611-3-dave@stgolabs.net>
References: <20191121011601.20611-3-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <157435455750.21853.439571085343311739.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a2cb4c9af3150189b0e31039333d6fa0c54776e8
Gitweb:        https://git.kernel.org/tip/a2cb4c9af3150189b0e31039333d6fa0c54776e8
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Wed, 20 Nov 2019 17:15:59 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 17:37:31 +01:00

x86/mm/pat: Do not pass 'rb_root' down the memtype tree helper functions

Get rid of the passing the rb_root down the helper calls; there
is only one: &memtype_rbroot.

No change in functionality.

[ mingo: Fixed the changelog which described a different version of the patch. ]

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: bp@alien8.de
Cc: dave@stgolabs.net
Link: https://lkml.kernel.org/r/20191121011601.20611-3-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat_rbtree.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index c3d119c..d31ca77 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -52,12 +52,11 @@ enum {
 	MEMTYPE_END_MATCH	= 1
 };
 
-static struct memtype *memtype_match(struct rb_root_cached *root,
-				     u64 start, u64 end, int match_type)
+static struct memtype *memtype_match(u64 start, u64 end, int match_type)
 {
 	struct memtype *match;
 
-	match = memtype_interval_iter_first(root, start, end);
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
 	while (match != NULL && match->start < end) {
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
 		    (match->start == start) && (match->end == end))
@@ -73,10 +72,9 @@ static struct memtype *memtype_match(struct rb_root_cached *root,
 	return NULL; /* Returns NULL if there is no match */
 }
 
-static int memtype_rb_check_conflict(struct rb_root_cached *root,
-				u64 start, u64 end,
-				enum page_cache_mode reqtype,
-				enum page_cache_mode *newtype)
+static int memtype_check_conflict(u64 start, u64 end,
+				  enum page_cache_mode reqtype,
+				  enum page_cache_mode *newtype)
 {
 	struct memtype *match;
 	enum page_cache_mode found_type = reqtype;
@@ -116,8 +114,7 @@ int rbt_memtype_check_insert(struct memtype *new,
 {
 	int err = 0;
 
-	err = memtype_rb_check_conflict(&memtype_rbroot, new->start, new->end,
-					new->type, ret_type);
+	err = memtype_check_conflict(new->start, new->end, new->type, ret_type);
 	if (err)
 		return err;
 
@@ -139,11 +136,9 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 	 * it then checks with END_MATCH, i.e. shrink the size of a node
 	 * from the end for the mremap case.
 	 */
-	data = memtype_match(&memtype_rbroot, start, end,
-			     MEMTYPE_EXACT_MATCH);
+	data = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
 	if (!data) {
-		data = memtype_match(&memtype_rbroot, start, end,
-				     MEMTYPE_END_MATCH);
+		data = memtype_match(start, end, MEMTYPE_END_MATCH);
 		if (!data)
 			return ERR_PTR(-EINVAL);
 	}
