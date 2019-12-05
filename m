Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B9C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1D0214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575511431;
	bh=UoJEDq5c8Ix/swM73GaX0xjhzayPHneSxnn8zjlfXrE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rXKjNVuXJIjP7agpL2+pXUw8k2is2vl5oPnjpc5i/KHweMjjaXj8TZohkzdqNn1nn
	 /JZZybuMVxW3Ql6U8CL4srgKM0l3EqEEV22xWDcy4d8yuVOK33ORrsuBDFBqwmiNbL
	 7gyeNkdBH6e+VtRHlQYqsAzZQf5qnuE6U1ixCIGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfLECDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:03:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfLECDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:03:50 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C1EF2077B;
        Thu,  5 Dec 2019 02:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575511429;
        bh=UoJEDq5c8Ix/swM73GaX0xjhzayPHneSxnn8zjlfXrE=;
        h=From:To:Cc:Subject:Date:From;
        b=a/GQx7rjM/oQEU+Tqg2A/0stoPasy9COR5Qb+/q7TXXCtsDxqPH+wLB3/qokD5rgH
         e4m1RdhnzwJ70fYKCiXZ7mKg7SdfJ1RtBBSGE6tboDoeinRlDHMXHNAtroxsFfK5yj
         /5tUbGsq7F1IiXts1fBWkMohO8psZVwwBgpoWi+Y=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Flavio Leitner <fbl@sysclose.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/1] proc/stat: Fix wrong guest nice cpustat value
Date:   Thu,  5 Dec 2019 03:03:44 +0100
Message-Id: <20191205020344.14940-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Flavio Leitner <fbl@sysclose.org>

The value being used for guest_nice should be CPUTIME_GUEST_NICE
and not CPUTIME_USER.

Fixes: 26dae145a76c ("procfs: Use all-in-one vtime aware kcpustat accessor")
Signed-off-by: Flavio Leitner <fbl@sysclose.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 fs/proc/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 37bdbec5b402..fd931d3e77be 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -134,7 +134,7 @@ static int show_stat(struct seq_file *p, void *v)
 		softirq		+= cpustat[CPUTIME_SOFTIRQ];
 		steal		+= cpustat[CPUTIME_STEAL];
 		guest		+= cpustat[CPUTIME_GUEST];
-		guest_nice	+= cpustat[CPUTIME_USER];
+		guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
 		sum		+= kstat_cpu_irqs_sum(i);
 		sum		+= arch_irq_stat_cpu(i);
 
@@ -175,7 +175,7 @@ static int show_stat(struct seq_file *p, void *v)
 		softirq		= cpustat[CPUTIME_SOFTIRQ];
 		steal		= cpustat[CPUTIME_STEAL];
 		guest		= cpustat[CPUTIME_GUEST];
-		guest_nice	= cpustat[CPUTIME_USER];
+		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
-- 
2.23.0

