Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F06AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D52D20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPULVRJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfDPTi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:38:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36414 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfDPTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:38:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so24745855qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KNbekIfBRRm8uM1KdnvYGnhJo7PPeihMU4LxOw05fOc=;
        b=dPULVRJjB3vqxeNVjKurm9q6bgO2XVeQgLiDeXQptGe8f2megTmgP6kpFst3QBJfZW
         W5bGXDdhGFOMqMwcD8oiGUCOofULwc5Q43oCKAfUdUZXkG2VgW8efkNuJR2fsOzJZpbX
         4UR0+IMSYJFc1S6HkZIrhiQXW+6Od/uwjGdhoJFdOjvkUoakOPX8Dk9QiDnhDiqtkFzB
         bcFEHaYNs+swYiwsToSJh3pNQc/C9icY3uLvZpz1ozTB0TvZZ1ViMYqHLq4Uy5CoaFSg
         hsYUAbEIOXkWmXLPusFcxBldxHFkWLAoEuIcVT43pUvTsr07s5LmvZutt8TOW874to1S
         k6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KNbekIfBRRm8uM1KdnvYGnhJo7PPeihMU4LxOw05fOc=;
        b=WBdrdeCZqHi088S2x7WH3/HNf7tmr3r/GANdUcJUj5xDKUFoFOpSKxzUZWic+tEVLt
         +t8J8FN3Dnrkb4LYkyTIdMlCJ7hcGIUC49435Y7bRUFUYBUbz/YiTA1/OLbsNrdngek1
         27qsH1BefVxTAje4HTFAp5qk5Z1+wyEzibNdDs2P8kEN21SjaymnZwWVAxB3uu/LbIZb
         6NnoRM6KSCEvTnG980U5bZtD8hitIY4lFmYMHYUEFT6+AvIECwn3bQS5Jz1mACC5vzl3
         /oCw0qHWUA0NbkL4PEBMciagHWE6wkjhkRGaCjDhcU4Mt+XeAqbgyNtqxbaMP3X9miyU
         A2Kg==
X-Gm-Message-State: APjAAAUJB51+ZpPXM7Kevlw1SatEmYibNVfYnkIUg6nnWbagqf+GYep8
        StsNbLSP4i2kSNTJQ8NitT6wag==
X-Google-Smtp-Source: APXvYqxRXonfPGuecbZLV9V8yrw+bJDae8Sdq8WQ2Q9QaffTrkrM+mI6pRrrhevIbcj2RboR0TDYZg==
X-Received: by 2002:a0c:d2f2:: with SMTP id x47mr64643661qvh.90.1555443527688;
        Tue, 16 Apr 2019 12:38:47 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id k41sm46150797qtc.89.2019.04.16.12.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 12:38:47 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: [PATCH V2 2/3] sched/fair: update cpu_capcity to reflect thermal pressure
Date:   Tue, 16 Apr 2019 15:38:40 -0400
Message-Id: <1555443521-579-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_capacity relflects the maximum available capacity of a cpu. Thermal
pressure on a cpu means this maximum available capacity is reduced. This
patch reduces the average thermal pressure for a cpu from its maximum
available capacity so that cpu_capacity reflects the actual
available capacity.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8213ff6..c5454d3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -23,6 +23,7 @@
 #include "sched.h"
 
 #include <trace/events/sched.h>
+#include <linux/sched/thermal.h>
 
 /*
  * Targeted preemption latency for CPU-bound tasks:
@@ -7967,6 +7968,9 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	if (!capacity)
 		capacity = 1;
 
+	capacity *= sched_get_thermal_pressure(cpu);
+	capacity >>= SCHED_CAPACITY_SHIFT;
+
 	cpu_rq(cpu)->cpu_capacity = capacity;
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
-- 
2.1.4

