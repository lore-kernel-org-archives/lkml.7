Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9A4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3B12082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKzToboE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDLE03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:26:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39845 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfDLE02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:26:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so4547838pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 21:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U3HPwsqJGqRWQNXWHNMvNFAgdg6011DnVFuiYQhfI1w=;
        b=RKzToboE++2aPVliLhYrBAQY4d4NXlwLHhkQUUPBZ1eoNm0PW63BfkMOGinzIuJo+O
         PaoGejbCDTIhQBOrN0GOtNBulNbp8ltmcl8BvGtLAe+63aYvJku35CaG1zo/W+G/eIBo
         Gr4xMEokkXVkr03oJuRBVXixW2u2JMKQxSXwnITfbLV3+1/Ru3kwTVG4Z8vmoBAolq9q
         0kT/qAOq1toMhE1BwA1f+LR+ln+psX30H6UXerxLVS+gIAh6IQDFUt1As2QSyz7txTv+
         ghkz4eyoBWaM30nAtlw37uYFvx5m4MnQbWAm73ze/4kDQ6RLSK7yTp+b7/hkB6k4wCOl
         eeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U3HPwsqJGqRWQNXWHNMvNFAgdg6011DnVFuiYQhfI1w=;
        b=WynPGifpJfhG8kIfcQ7ziPO/fcsR21KiE+U6VYP8S4DCClhePKuIiVcSFrBXYLWMUF
         7/MfnHc1+eOLgmy9lialoT9fDZe2FrFWJwcyCPiMKOVY66a1ZRiX0j6RDPFOfCjgDqxb
         K3kW3MCmPijlGvfNylW+r0nveavsXJBdJwMcLSUc1dLdeUCxVfknCVwUpvWBBPlKaCoY
         bLZiqHrBdvBDf5THtAfGxgsl3T/5KUpVQY+RoHHztQCT3iiAykmm79pWpQHRrz7AkHPj
         /+/rfoEBY7NvbGP7a8yZTsEM7ySCcD2BoyuptG2HmMO8ivkmNTXwyo241VBPcEJ7XoXI
         K5Gg==
X-Gm-Message-State: APjAAAVjDJK9mQSLW4Xc2MbtuE11RFwY7dVsfAwTADPR4XJlkHBq4Y1C
        zz8IiSiEzKmbuqB1/df17Q4=
X-Google-Smtp-Source: APXvYqzxECzuQQ1OsgROEYQCjzDiJmVrEfYqL/5VPCx2BRaFi/XHilMMdZQ0u9iCAvtU2qnUh+kY/g==
X-Received: by 2002:a62:7648:: with SMTP id r69mr34752500pfc.114.1555043187990;
        Thu, 11 Apr 2019 21:26:27 -0700 (PDT)
Received: from bobo.local0.net (115-64-237-195.tpgi.com.au. [115.64.237.195])
        by smtp.gmail.com with ESMTPSA id t64sm89997000pfa.86.2019.04.11.21.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 21:26:27 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/sched: run nohz idle load balancer on HK_FLAG_MISC CPUs
Date:   Fri, 12 Apr 2019 14:26:13 +1000
Message-Id: <20190412042613.28930-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nohz idle balancer runs on the lowest idle CPU. This can
interfere with isolated CPUs, so confine it to HK_FLAG_MISC
housekeeping CPUs.

HK_FLAG_SCHED is not used for this because it is not set anywhere
at the moment. This could be folded into HK_FLAG_SCHED once that
option is fixed.

The problem was observed with increased jitter on an application
running on CPU0, caused by nohz idle load balancing being run on
CPU1 (an SMT sibling).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/fair.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdab7eb6f351..d29ca323214d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9522,22 +9522,26 @@ static inline int on_null_domain(struct rq *rq)
  * - When one of the busy CPUs notice that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
+ * - HK_FLAG_MISC CPUs are used for this task, because HK_FLAG_SCHED not set
+ *   anywhere yet.
  */
 
 static inline int find_new_ilb(void)
 {
-	int ilb = cpumask_first(nohz.idle_cpus_mask);
+	int ilb;
 
-	if (ilb < nr_cpu_ids && idle_cpu(ilb))
-		return ilb;
+	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
+			      housekeeping_cpumask(HK_FLAG_MISC)) {
+		if (idle_cpu(ilb))
+			return ilb;
+	}
 
 	return nr_cpu_ids;
 }
 
 /*
- * Kick a CPU to do the nohz balancing, if it is time for it. We pick the
- * nohz_load_balancer CPU (if there is one) otherwise fallback to any idle
- * CPU (if there is one).
+ * Kick a CPU to do the nohz balancing, if it is time for it. We pick any
+ * idle CPU in the HK_FLAG_MISC housekeeping set (if there is one).
  */
 static void kick_ilb(unsigned int flags)
 {
-- 
2.20.1

