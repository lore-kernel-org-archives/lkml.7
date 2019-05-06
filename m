Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3DEC04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E4720B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178014;
	bh=RjsL/Ro3n6bGlr2/VDiTzvtHYudT4NRKjI3tiYQNkgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=nihphlNHf9PHETyLcOz5Rg08i6V4K8zWZ0DE0pJ6JpRIAtJtkxAoxV+r4NXCkM6v1
	 C8KU20R0VZg4OveviMPJJoG2ue8XDv8WuirfMmgqTbQgZjP8PTlZXluhiUSCQkeoHN
	 iiTrYWahMDq28IAiaqzrol/W5MtLM3uDc3koF0yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfEFV0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36572 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfEFV0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:47 -0400
Received: by mail-io1-f65.google.com with SMTP id e19so2634176iob.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=/r/wJJuIve3cfROEOjQXmKOysyLZKrQ8MKJaix41P8Y=;
        b=l4Zux9CLadNQDk3oTwHbkN7o28DsDibkY8AY2cR1I7KATEicc8ajZaTuDbm0mZn171
         ZxIFFZEnJHgZbndLiEMVqZmEWdxy0py2/dS3mgH497e4P+hpqEp3jLczYKIGB9AIrbBC
         HrAW88p+uOi7XFFBUbjXsWhHUjUm5MT9GZXm2ZRvqi5l0vBDeII3co7PzbCwOh2Tii1I
         ceCI4ynvXr7w46s1zgfOFehnAw1b89XbO7hJPv4+afEvZeafaqTmLbDLyhM3l9rrUCYE
         Ngm4wHGQGhI/wQkN6FgCd2vzPnKPWXNL0aqFYuXTsUMTzq/GKhpnO+kx9IrXaBmCvJ9U
         +l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=/r/wJJuIve3cfROEOjQXmKOysyLZKrQ8MKJaix41P8Y=;
        b=Tonhih7xlfuO4fpAy7WGpi156oIYXhHMTAAJm9OtNaAQo7/OklMHlDpvOU12kerpMf
         lZbTL31l/WPyK0Nrrg4Z9pSNn3P0oLq1rIx8fsoStx5Qdxogbiyoxa2m6WUY2pwkJe+D
         zQvzjkxDi03T1VFJPpS0Ia5x0fpFQsP8FSRQ/BoJb0gZ8ItufL2vW00Z8XlLLpADKjg4
         ecEFiJOsKBVFtsWb31UFLgKGTjh6GHplHVxxVWBimdP0jSyFMxHQW3ok/fjCuRGpuTWi
         SSk3Fz7DUrJaqe637gVT9ymsBvVp/Yatw1sQtK6UbFHs92VuHQQGMq0PFllK7LfRiQtn
         3D2g==
X-Gm-Message-State: APjAAAUgc3HZtpc4cnm98Voue32n2jCVsHdvKjj/FKUiec+01cgdR2hp
        w7AekEiSaOYEp0UMp0XidoJY3T3E
X-Google-Smtp-Source: APXvYqxXxwIkU1NSFkOIGEA6JA271eLAsJnX2tYJEPz+c8MaLwriPvsbJl8KEpIcz0VclcEhboSZAQ==
X-Received: by 2002:a6b:b503:: with SMTP id e3mr3075269iof.216.1557178006814;
        Mon, 06 May 2019 14:26:46 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:46 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 17/22] perf/x86/intel/rapl: Support multi-die/package
Date:   Mon,  6 May 2019 17:26:12 -0400
Message-Id: <914b7783c40acb58bffd90a2d378062659c974cb.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

RAPL becomes die-scope on Xeon Cascade Lake-AP. Perf RAPL driver needs
to support die-scope RAPL domain.

Use topology_logical_die_id() to replace topology_logical_package_id().
For previous platforms which doesn't have multi-die,
topology_logical_die_id() is identical as topology_logical_package_id().

Use topology_die_cpumask() to replace topology_core_cpumask().
For previous platforms which doesn't have multi-die,
topology_die_cpumask() is identical as topology_core_cpumask().

There is no functional change for previous platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/intel/rapl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 94dc564146ca..e49f69c51b10 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -161,7 +161,7 @@ static u64 rapl_timer_ms;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int pkgid = topology_logical_package_id(cpu);
+	unsigned int pkgid = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -571,7 +571,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -598,14 +598,14 @@ static int rapl_cpu_online(unsigned int cpu)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_package_id(cpu)] = pmu;
+		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
 	}
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_core_cpumask(cpu));
+	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -675,7 +675,7 @@ static void cleanup_rapl_pmus(void)
 
 static int __init init_rapl_pmus(void)
 {
-	int maxpkg = topology_max_packages();
+	int maxpkg = topology_max_packages() * topology_max_die_per_package();
 	size_t size;
 
 	size = sizeof(*rapl_pmus) + maxpkg * sizeof(struct rapl_pmu *);
-- 
2.18.0-rc0

