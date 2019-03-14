Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391C72085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7Cwfo3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCNGn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:43:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43556 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfCNGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:43:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id l11so3308731pgq.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qELTA4aujWEU9keNr9yQA2v0lmekRZinbYpRGs9xFkI=;
        b=u7Cwfo3HTNXiwKrg1Xm7VMazORbN94o2bgbSQzTbrMMH/hv2AKW3bvhAABqWicB/v4
         b9asgi0FzheRGcnrFHLPLb4TWJFo6FCTgETwkXrrarLL5+LNgizsrqJnUFDCoutWuuqR
         0ys3qt/rgIrjMeEOQMF1tUJbUIKoqzngo0Pw5nfz0P5pZbzD2MgMLpzU7u8vYP1AX2SE
         UTIQp1N9YYQv44EaDziD2yLPLUdGeRIlzbsiovemP4HQwk9YKbxdCVVb5Oquqs7roSz/
         tAL1P3fwgMxIMURRzGJ2geREkGPTznTxUDRymTjz/gYQ1dthykaya/JICIL1lYNV/VBF
         NhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qELTA4aujWEU9keNr9yQA2v0lmekRZinbYpRGs9xFkI=;
        b=R2c6Q+xCgH3dabOTGLHht7YTLDQHSIcRan6BPaw0Qb7RkWXlQcPhv5cBN2xKll4YKq
         25i5bAaYtsQlbvjl0/17HvwuoOo5AzHSZU1pgpIe4uLje245Y7g8v6O2LK2N8nungfDI
         In+FfteHMC5mCblx0gcntJ4wCpwHIcxfb2U7P98NaXlE8NrxXSrMwVIz/c6KYvwviE1W
         EMR2hsVlD4sEiu8aOujDwe9048AbzRaUL6iANSC/apIdtFAzgcFIYqsX7EpKI8R+iEFm
         zDtZOWdHz1LHTBNUrsqm19ahHD40foadT3gM4k58X1wtxrKHeDtyGeX4yeAl3pWhnhue
         3hng==
X-Gm-Message-State: APjAAAU9Weuq/eHl6t5uEf+t4kVhXo6b6SfOwCUVBQBBfYpAjTUT8bBp
        T1LvYxPY5doBc6dzBcer8GDM7b6QF7E=
X-Google-Smtp-Source: APXvYqzEbwwxjCug9kdh/7bejtUsTgAC7OJlUejiEL+ajhn8s2NdVFN0pvHFBtOZYPx8uOLJs3Y6tQ==
X-Received: by 2002:a65:5c0b:: with SMTP id u11mr34473391pgr.352.1552545805889;
        Wed, 13 Mar 2019 23:43:25 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id l7sm49201244pfj.162.2019.03.13.23.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:43:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Russell King <linux@armlinux.org.uk>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] ARM: twd: Update cpufreq transition notifier to handle multiple CPUs
Date:   Thu, 14 Mar 2019 12:12:49 +0530
Message-Id: <3c977305886032ba871bd266d555ede47b4576fc.1552545525.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq core currently calls the cpufreq transition notifier
callback once for each affected CPU. This is going to change soon and
the cpufreq core will call the callback only once for each cpufreq
policy. The callback must look at the newly added field in struct
cpufreq_freqs, "cpus", which contains policy->related_cpus (both
online/offline CPUs) and perform per-cpu actions for them if any.

This patch updates twd_cpufreq_transition() to use the new "cpus" field
and run twd_update_frequency() for each online CPU present in the
freqs->cpus.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/kernel/smp_twd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index b30eafeef096..df7db45d931b 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -162,15 +162,18 @@ static int twd_cpufreq_transition(struct notifier_block *nb,
 	unsigned long state, void *data)
 {
 	struct cpufreq_freqs *freqs = data;
+	int cpu;
 
 	/*
 	 * The twd clock events must be reprogrammed to account for the new
 	 * frequency.  The timer is local to a cpu, so cross-call to the
 	 * changing cpu.
 	 */
-	if (state == CPUFREQ_POSTCHANGE)
-		smp_call_function_single(freqs->cpu, twd_update_frequency,
-			NULL, 1);
+	if (state != CPUFREQ_POSTCHANGE)
+		return NOTIFY_OK;
+
+	for_each_cpu_and(cpu, freqs->cpus, cpu_online_mask)
+		smp_call_function_single(cpu, twd_update_frequency, NULL, 1);
 
 	return NOTIFY_OK;
 }
-- 
2.21.0.rc0.269.g1a574e7a288b

