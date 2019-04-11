Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C6EC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3D1217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH+pvqRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfDKDfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:35:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42406 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:35:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so2773542pgh.9;
        Wed, 10 Apr 2019 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++5Kahm69pfih1hlK32V2CQsRTIBHswnoEuweJf+4FY=;
        b=WH+pvqRX3E2xh2rFecOyDRCL/X74JCuPg/LesGHhNgXVZDyFJA0pQLS9Vy3VdLRxvP
         vTSlK0Zk5yKDB7vLIIUxly10b8IO+D989VVDom5iZ7qDXy3L5dW65+HleAdiQodR7A+2
         Md3pdYPS+GqAam57HbHSogR6EqZEN81o8OR03KxxXDccb/s5bQki31tJb7gGL+5Yr0t6
         EePjGtlxj/m/LDQ47/STaqzMd40vfqCO3/gVetZjVvVOqTrm2kh6XqKyGnpWMxj+6bbZ
         FXEiBQtOxW1hn5hzUuVUz+tgJ21i9wa8d77Yd/AusxdfZpjw8qF2Jo2BBguFKMaz02Sw
         xlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++5Kahm69pfih1hlK32V2CQsRTIBHswnoEuweJf+4FY=;
        b=gE0+uWRBrMdCRHoJUdoJ1Crf8FnRVLCIe+Z3zsYPDJbr8SSQCP1TN2sBf+Jj1C0HWp
         9uSBIj3ctwihTd58SJ0DQIURMSH9bxVuKQY4f05d4yf2hg53yBuit8AcgAacM+V3m4/i
         EzIiD6nionAV0bu1RBwXQPscw8mBnqS5qI0kFCsNQQk3lEKGBYBSEq+ILS3/Jkrgulp3
         Cj4IfOLorYaw827LD4EUYp+QcOj7VOFEJa2oL149CkFM6P5dGgxBEuVOjnuaGIrtzYrN
         0gs+YRBNY3HX0x+NlinKoxp4j2hfEJJuC18D9o4+Kli/1CrXGcwF/QOkJBX9CsR4hmau
         RMMA==
X-Gm-Message-State: APjAAAUP998tv1IVqqGmM+ktRqH7mZKYT+X3ywxHbXRiG5EjlGgfsqaB
        mT48jmL2Wo/YBclKH08AO/o=
X-Google-Smtp-Source: APXvYqwTHeF65/Hp98rNuZyayD9mE9HdJHFhhwJYBomZ+S1ESXIs7o+WkVag66TeJ4YVjbnqclZNJA==
X-Received: by 2002:a63:115c:: with SMTP id 28mr15643940pgr.270.1554953721421;
        Wed, 10 Apr 2019 20:35:21 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
        by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 20:35:20 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/5] kernel/sched/isolation: require a present CPU in housekeeping mask
Date:   Thu, 11 Apr 2019 13:34:47 +1000
Message-Id: <20190411033448.20842-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During housekeeping mask setup, currently a possible CPU is required.
That does not guarantee the CPU would be available at boot time, so
check to ensure that at least one present CPU is in the mask.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/isolation.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b02d148e7672..687302051a27 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -65,6 +65,7 @@ void __init housekeeping_init(void)
 static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask;
+	cpumask_var_t tmp;
 	int err;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
@@ -75,16 +76,23 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		return 0;
 	}
 
+	alloc_bootmem_cpumask_var(&tmp);
 	if (!housekeeping_flags) {
 		alloc_bootmem_cpumask_var(&housekeeping_mask);
 		cpumask_andnot(housekeeping_mask,
 			       cpu_possible_mask, non_housekeeping_mask);
-		if (cpumask_empty(housekeeping_mask))
+
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp)) {
+			pr_warn("Housekeeping: must include one present CPU, "
+				"using boot CPU:%d\n", smp_processor_id());
 			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
+			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
+		}
 	} else {
-		cpumask_var_t tmp;
-
-		alloc_bootmem_cpumask_var(&tmp);
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp))
+			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		cpumask_andnot(tmp, cpu_possible_mask, non_housekeeping_mask);
 		if (!cpumask_equal(tmp, housekeeping_mask)) {
 			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
@@ -92,8 +100,8 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 			free_bootmem_cpumask_var(non_housekeeping_mask);
 			return 0;
 		}
-		free_bootmem_cpumask_var(tmp);
 	}
+	free_bootmem_cpumask_var(tmp);
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
 		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
-- 
2.20.1

