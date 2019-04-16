Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0557C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721AD206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sL/wnHvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfDPTiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:38:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36418 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfDPTiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:38:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so24745951qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DHvwucClEuE6vcfN7CuEc8eFK+qMiBspP3oOBK+KZZE=;
        b=sL/wnHvmS8sJ5Cgb3Z/Ioo4m4Apbm4Eve1PwNIh0xYbgNh9Vq/AFdwbWhtBb2XDgcH
         U+XlSoQjehVMSTlhE4hbEZ7fsx9HJDnkExCEXL9rTkN9QiX16Y2FvKWTLyT4HumqseVu
         3ejFYFn/9cM5kSutWvOF6wi2ClYNEOBzACNvN/CDnG329cP6gI53yhlzJRTjCSIQZuo7
         6qA5W4s7vHgrSoYYlAMXt7iV6XhbeOTSAR2ztxVcDNpOh4+ysiRzXhm3XgUHRVQY6hRw
         t7RPjuVGg3NiDSZQXMlwDW5XqbAHI28D6/FSvuHTxGdAIBe5IgdW7a3r0lBMLh8AuB0O
         LhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DHvwucClEuE6vcfN7CuEc8eFK+qMiBspP3oOBK+KZZE=;
        b=rgRlBDYREevXegaD5BqZaz+VbktMkH01IBSczsa3/F4G7T4wNIFuWFt54vAnRlKxt0
         t55shLH/bEphhxwpsRhL2KhuKoL87LlXVRmjMTaDrh3fyah0ziek6IzZWRogImHFuQVr
         mgvsuhv1mXSqkK7jy2y4p+aVgOU0MNipiMb3Pj1VSKufTWtmjSr4I/eg/N9/qsT0vxpn
         OKKf59oduSeeC7QVHJcaBmU5gcaR5PqaadKSIF7aL43XvQAaBokb3I3JGPx30b1WvA0n
         Vi/4e39SKvNtA2gil2vT8INar1xa+p7ROgwtssDuJFYHub1zBMqcSDZL3NLZ946gmfRe
         9n2g==
X-Gm-Message-State: APjAAAWx2o8RlIcnJW80l6h6TW+JtK2+YoOm/IBZwwa1kjE2wzrN/D0h
        YFPs3Hnxfjy7S2Kx8A5NuWmmHg==
X-Google-Smtp-Source: APXvYqxvSzU3L2NQrIcypK1zKQZYEFuHAWcQTeJchBku3CjTAKGvQLtnr8h3i+DB2p97TgkmshwU2w==
X-Received: by 2002:aed:3f49:: with SMTP id q9mr69900551qtf.279.1555443528979;
        Tue, 16 Apr 2019 12:38:48 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id k41sm46150797qtc.89.2019.04.16.12.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 12:38:48 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Tue, 16 Apr 2019 15:38:41 -0400
Message-Id: <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable cpufreq cooling device to update the thermal pressure in
event of a capped maximum frequency or removal of capped maximum
frequency.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6fff161..d5cc3c3 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
+#include <linux/sched/thermal.h>
 
 #include <trace/events/thermal.h>
 
@@ -177,6 +178,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 
 		if (policy->max > clipped_freq)
 			cpufreq_verify_within_limits(policy, 0, clipped_freq);
+
+		sched_update_thermal_pressure(policy->cpus,
+				policy->max, policy->cpuinfo.max_freq);
 		break;
 	}
 	mutex_unlock(&cooling_list_lock);
-- 
2.1.4

