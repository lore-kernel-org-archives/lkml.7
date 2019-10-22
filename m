Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CECCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33192184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7KBtZnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbfJVUem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:34:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41268 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389449AbfJVUei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:34:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id c17so25868137qtn.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cu2iRByuQkBOdiS3ftuWg2x1Invt9O2eimcBFeYIbQQ=;
        b=C7KBtZnlB3OLT3U/IskLPfrl3eYN7TUJSCVxUyZTTHjT39Q8gfZqWYNG/+7MnuzkzU
         jlvkgRS5cMhKcRFdBesSUcwLQMK7SQDxdOefzxZVbTboj9zhfgFvIEQGAQu9ClpOaaGJ
         usZxOmUcITG5BSz18Q3N9ySOJpP+vQo8F08cjsseG+y/jW4ldXvgNhzfbtnOP/8KGFLX
         Jkck8I97wwtNbLpAzlnaczz4Xu1WxWvaFf+4mEpu6LY9P+UX3qA63Ohvey0Q/eniq3+s
         piVm6NiLzEekGjtl6K4snX2hLIxfFKiHNpBeuBI7gaKboqZoueX3HbJNV0cTv5JRs/uX
         fGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cu2iRByuQkBOdiS3ftuWg2x1Invt9O2eimcBFeYIbQQ=;
        b=HdcCv8pJV/BxolGYJ0/OAWwSB8xEcVCMm9riPhuT5ydoM2YPBGeVEcz2V1fincrHGl
         iPNFOehjeCLbQHib31w3IFY5yafOzd8me8lK6jwJQxtkMh2+09JHVhWApSUwH/C3kAuI
         5e13jMFjCS0bBszx0SDhb2vkB4wlmbnC3m0ZFhZiP4ccOlXqtXaINHmmN4PaiB7lcDTP
         QG7JeYd2HAFqe0px7T8Nm+TbJURpPfcCug4pzJwsXMS9idSPjekfYQzlG7X1XrORzhbH
         EBlxRTp+kh0DeikMDCMCOHF7M0voEdhWX9t+E4V0DhtKPRljb8igWMXWbCONYp/Hyd2g
         il8g==
X-Gm-Message-State: APjAAAWRZpcOKHUEru873e1IBef0s0V1eTrGMVdSJhiXV3k/vN4sbJHd
        crHHzIeUcmEAf1A+crYU9mLaJw==
X-Google-Smtp-Source: APXvYqwmF2Eif6hUS3VRwX1OSpSCpqeWF5dLxB6Ve3D4fRDRdppov3egMef+I+jToBIYIfLlnrkcSQ==
X-Received: by 2002:aed:35e7:: with SMTP id d36mr5404833qte.59.1571776477484;
        Tue, 22 Oct 2019 13:34:37 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r126sm8895038qke.98.2019.10.22.13.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 13:34:36 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v4 6/6] sched: thermal: Enable tuning of decay period
Date:   Tue, 22 Oct 2019 16:34:25 -0400
Message-Id: <1571776465-29763-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal pressure follows pelt signas which means the
decay period for thermal pressure is the default pelt
decay period. Depending on soc charecteristics and thermal
activity, it might be beneficial to decay thermal pressure
slower, but still in-tune with the pelt signals.
One way to achieve this is to provide a command line parameter
to set the decay coefficient to an integer between 0 and 10.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v3->v4:
	- Removed the sysctl setting to tune decay period and instead
	  introduced a command line parameter to control it. The rationale
	  here being changing decay period of a PELT signal runtime can
	  result in a skewed average value for atleast some cycles.

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/sched/thermal.c                          | 25 ++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a84a83f..61d7baa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4273,6 +4273,11 @@
 			incurs a small amount of overhead in the scheduler
 			but is useful for debugging and performance tuning.
 
+	sched_thermal_decay_coeff=
+			[KNL, SMP] Set decay coefficient for thermal pressure signal.
+			Format: integer betweer 0 and 10
+			Default is 0.
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
index 0c84960..0da31e1 100644
--- a/kernel/sched/thermal.c
+++ b/kernel/sched/thermal.c
@@ -10,6 +10,28 @@
 #include "pelt.h"
 #include "thermal.h"
 
+/**
+ * By default the decay is the default pelt decay period.
+ * The decay coefficient can change is decay period in
+ * multiples of 32.
+ *   Decay coefficient    Decay period(ms)
+ *	0			32
+ *	1			64
+ *	2			128
+ *	3			256
+ *	4			512
+ */
+static int sched_thermal_decay_coeff;
+
+static int __init setup_sched_thermal_decay_coeff(char *str)
+{
+	if (kstrtoint(str, 0, &sched_thermal_decay_coeff))
+		pr_warn("Unable to set scheduler thermal pressure decay coefficient\n");
+
+	return 1;
+}
+__setup("sched_thermal_decay_coeff=", setup_sched_thermal_decay_coeff);
+
 static DEFINE_PER_CPU(unsigned long, delta_capacity);
 
 /**
@@ -40,6 +62,7 @@ void update_thermal_pressure(int cpu, u64 capped_freq_ratio)
  */
 void trigger_thermal_pressure_average(struct rq *rq)
 {
-	update_thermal_load_avg(rq_clock_task(rq), rq,
+	update_thermal_load_avg(rq_clock_task(rq) >>
+				sched_thermal_decay_coeff, rq,
 				per_cpu(delta_capacity, cpu_of(rq)));
 }
-- 
2.1.4

