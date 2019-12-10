Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA42C2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03678214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951994;
	bh=+QR8GFzPfwyOnKnTUMIxWPURL3ecDyQu6Fu4vHW5d4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nfRQdM9L/B5phEUb2yvszsMd6YIYXm6alQaVb4n7d107zbcKLD/HQX09V+KYjS6R7
	 LIz6EKwmksylDEklO/MRzJ6phugD0kEMd5Lgv4ZjS/MmPAfl5fo4g8PoU/0G91tyyN
	 7qltQwHbOUdgfpOAi0NcTXw1OBWMfL6iQ722F8XM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfLJE0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLJE0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:32 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23F0207FF;
        Tue, 10 Dec 2019 04:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951992;
        bh=+QR8GFzPfwyOnKnTUMIxWPURL3ecDyQu6Fu4vHW5d4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q85ZIWZcXbb3IlsvVmtz2dNee+xj1kzuqwnfnt2QpIPtSBYKMu3wDptjAVk5z2bsc
         3Hrxu92381l09kl7EUO4k+Soio2wJOY1hKcerYCFRtmCRLz8wdU2/C1wB8MM7SUEre
         X9Yicc9sKMpsSzsR6jDXhmnP7Ej48xSQn5XTFFag=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Stefan Reiter <stefan@pimaker.at>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/11] rcu/nocb: Fix dump_tree hierarchy print always active
Date:   Mon,  9 Dec 2019 20:26:19 -0800
Message-Id: <20191210042629.3808-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Reiter <stefan@pimaker.at>

Commit 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if
dump_tree") added print statements to rcu_organize_nocb_kthreads for
debugging, but incorrectly guarded them, causing the function to always
spew out its message.

This patch fixes it by guarding both pr_alert statements with dump_tree,
while also changing the second pr_alert to a pr_cont, to print the
hierarchy in a single line (assuming that's how it was supposed to
work).

Fixes: 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if dump_tree")
Signed-off-by: Stefan Reiter <stefan@pimaker.at>
[ paulmck: Make single-nocbs-CPU GP kthreads look less erroneous. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fa08d55..758bfe1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2321,6 +2321,8 @@ static void __init rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
 	bool firsttime = true;
+	bool gotnocbs = false;
+	bool gotnocbscbs = true;
 	int ls = rcu_nocb_gp_stride;
 	int nl = 0;  /* Next GP kthread. */
 	struct rcu_data *rdp;
@@ -2343,21 +2345,31 @@ static void __init rcu_organize_nocb_kthreads(void)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rdp->cpu >= nl) {
 			/* New GP kthread, set up for CBs & next GP. */
+			gotnocbs = true;
 			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
 			rdp->nocb_gp_rdp = rdp;
 			rdp_gp = rdp;
-			if (!firsttime && dump_tree)
-				pr_cont("\n");
-			firsttime = false;
-			pr_alert("%s: No-CB GP kthread CPU %d:", __func__, cpu);
+			if (dump_tree) {
+				if (!firsttime)
+					pr_cont("%s\n", gotnocbscbs
+							? "" : " (self only)");
+				gotnocbscbs = false;
+				firsttime = false;
+				pr_alert("%s: No-CB GP kthread CPU %d:",
+					 __func__, cpu);
+			}
 		} else {
 			/* Another CB kthread, link to previous GP kthread. */
+			gotnocbscbs = true;
 			rdp->nocb_gp_rdp = rdp_gp;
 			rdp_prev->nocb_next_cb_rdp = rdp;
-			pr_alert(" %d", cpu);
+			if (dump_tree)
+				pr_cont(" %d", cpu);
 		}
 		rdp_prev = rdp;
 	}
+	if (gotnocbs && dump_tree)
+		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
 }
 
 /*
-- 
2.9.5

