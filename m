Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F382C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457FF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770383;
	bh=d/QvHy1mbmZ1Y7oqNNEWpBY5hqMcobT5CjgmyMznXT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=MbLNOLK2nxyLltRLiQ86g5dRD4thJ7jt9Ol1DSBmyzvJ/WiH20w0aNSDwGVcFR0m6
	 1DjQYqfOIQZLQR/+NxEz5oZlJVrcce8PrZVqgiF6Tc9pbR5AMfZWdcAozOJrTZiWDS
	 oevXzWmbdHso84Sf/IG5Qo7N/0QBhoC+3O6Yudok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfEMR7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbfEMR7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so7147183pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=CGKgJK9ntJVDJAbdtSfQk6iXN0Z85XjoYFkLOVcga7E=;
        b=oo4uaQd1UxkA5lSemK0tniHLL4CrCH1aLMtIL4Dnywbk9P8By46DHj3Vqa0Xys6c8z
         8vCS+wM2NSHFU3PZWX3w9qM42gLATVlvSYzSKe94SeoIZkGbC4ZL6eJPXVNPTL1zqaQq
         Q4UJL0tFCol6l/Lm7WTZ3Hnw0di/xjBZn52BAX2684cchcHd8uCJvXtyytgwAHivx6Kh
         6XOfEb+myelOLu3XNv7HiGCp3jFA9KlXlTy38tqL1p+rHuo6DLdTfwvC5pZUVhF68KW8
         rbPFJ+AlK1K8C6DE1qACaKPTvNRSpSgLLUSyl8S69AgUamzYhmPxGgS2RcyGYd1dhq/z
         QI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=CGKgJK9ntJVDJAbdtSfQk6iXN0Z85XjoYFkLOVcga7E=;
        b=rakhdKuP5z7AVoRIku+S73B0cyQzhYzN+aCW1rNPdTMoHFc+WRFEUQhv/ohXIVkbXY
         OQbIvNi+W06kQh86zk+uSTmICDo2X2Pz3EBmdIX98REwE5/Sf4vYV++gaXiUdtqQ7BzB
         DZAE69DY8m9CUTBsP3YVk0NhMgeUKTLaVGGOPZThQ92hrOMypsd1EgVBdPxzFdE1+UpA
         /vDPrY2Hgu4ID8o+csZUYy652l/gXiIlVXhwNWscn3Rq3Xha+TmKq4Qz7yJaY7K/qHJJ
         pGw0pDtVWquJELi8RDF+ZEmrwxxgZgO8T7zSIg0G1ZHePshBFJl/BURJbl0Aslb56rRb
         BEUQ==
X-Gm-Message-State: APjAAAWlXRWlI/jH8torfp50AwPo3s5npUvUpbw8Ioh1kb82HvwdiIuL
        Xi5wTJdf8v5UFZrTnQ2uj8s=
X-Google-Smtp-Source: APXvYqwmPDifk9+WIjnG0RN/eCOFBwUQjgEvP2lRzgkowLrR5fMkw3kf5WOVqTlfXP/GJCy2FagrNw==
X-Received: by 2002:aa7:9214:: with SMTP id 20mr34772208pfo.202.1557770376127;
        Mon, 13 May 2019 10:59:36 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:35 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 14/19] perf/x86/intel/rapl: Support multi-die/package
Date:   Mon, 13 May 2019 13:58:58 -0400
Message-Id: <851320c8c87ba7a54e58ee8579c1bf566ce23cbb.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
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
index 37ebf6fc5415..6f5331271563 100644
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

