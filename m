Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED92C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D801217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684702;
	bh=fqIg1+4ddXiDWAYjJ+4q42V7rJFwbYFQNg/d4mcv/xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=QzekP0LFi6auCZfzK4hknZf+cHfD4CYsnqpk841viXJRONLiQJXfxsSOH6BpCFzQI
	 97ALBb6E8xPDUkP4bb9su4hOGHS8kl+mj5CHW9TLx5NGwDdiHfeGk8YtwhP/FOqmiO
	 Vei/S/V6wrIOEIvdKWlEFDapvr9Tku1LEtZKUU1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfEAEZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:25:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35568 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfEAEY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:56 -0400
Received: by mail-it1-f196.google.com with SMTP id l140so7129033itb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=BZvfoMetd7XOqGPD4+QBEFZbIkXgaAiftB+eMxWYjro=;
        b=K8EFTPnN9oBSBcWx0nMwe23kNaD8EUrK4o9NoiY1k8kpR3ALRdAXE//RhCcj5/nJK5
         v3GBveSJr8JrwWpF9Gl53dbyFhC6UPgY6xzEHto+bxTp8TdjX6XFz8AEtFnGj/UQUdgy
         RaEes96XcdqqFQvP1tachHmSrhM+L7loo8+LzL2P0mtPunuFIBF0FuqW//D6TRBuy3cx
         5HX279Al9GxYV7VqEwTWRF1s3E4l+dUFMI7hcCBTy6AmIpNc5ZqqhvFIe8RLfzEwKwKx
         Slf/L/bxVH9zMe9l1WqoThxa8YyO4G5JvUl8+rABg34V0wpZZp+43SbXdANJmdCgNNeE
         dAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=BZvfoMetd7XOqGPD4+QBEFZbIkXgaAiftB+eMxWYjro=;
        b=GLL2lXX4dtr/pE+zKYPNqo0WIjCv44WpcsYfRzPqPSLtbF0uzYZnK/2b92/7mv4kT/
         VfLLQFZDPOjW6oeDYok9/I6//pUiBcQr6tbp/UPlIvYFg5cDBcMMjkhsJTz6yqA5rN6x
         tSJqGyfK0TJ8jlk0qW5Nb5l5RF2x0gpoDnHUrI7ZQduxzIHxN9vPQPvMMkk+ib67bgEy
         T4aUd63R6Tzo/Z880jCKciqABHu4bWHqOOrYNRsQo7Pd6h3g5Xpz+SOVfz00Wuvta3a5
         iFREXA89kXqnNN+Ytl1q1r1S609CFYuDHTPp0OAH2dTdwsH89XKFvfjRY8lpIMv9imam
         Solw==
X-Gm-Message-State: APjAAAXieDNCqnMbvylc1ZvuzWv8bxEp2vPNp+T/tuFrF0xamJmwNige
        Bh0V04C6Mx8blgufro/SQSg=
X-Google-Smtp-Source: APXvYqwJ0d9ivnthPotOOaSSttNDuuvEIhaR2lNxdUomeP8/8QmFfo69WNgN3gn8Upln3P0mpuvktA==
X-Received: by 2002:a24:6b92:: with SMTP id v140mr6934310itc.161.1556684695618;
        Tue, 30 Apr 2019 21:24:55 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:55 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 18/18] perf/x86/intel/cstate: Support multi-die/package
Date:   Wed,  1 May 2019 00:24:27 -0400
Message-Id: <6c4891c7f2f1eacfcab00bf5d84b5ac119f654b9.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some cstate counters becomes die-scope on Xeon Cascade Lake-AP. Perf
cstate driver needs to support die-scope cstate counters.

Use topology_die_cpumask() to replace topology_core_cpumask().
For previous platforms which doesn't have multi-die,
topology_die_cpumask() is identical as topology_core_cpumask().
There is no functional change for previous platforms.

Name the die-scope PMU "cstate_die".

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/intel/cstate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 94a4b7fc75d0..52c5fea29457 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -302,7 +302,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
-				      topology_core_cpumask(event->cpu));
+				      topology_die_cpumask(event->cpu));
 	} else {
 		return -ENOENT;
 	}
@@ -385,7 +385,7 @@ static int cstate_cpu_exit(unsigned int cpu)
 	if (has_cstate_pkg &&
 	    cpumask_test_and_clear_cpu(cpu, &cstate_pkg_cpu_mask)) {
 
-		target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+		target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
 		/* Migrate events if there is a valid target */
 		if (target < nr_cpu_ids) {
 			cpumask_set_cpu(target, &cstate_pkg_cpu_mask);
@@ -414,7 +414,7 @@ static int cstate_cpu_init(unsigned int cpu)
 	 * in the package cpu mask as the designated reader.
 	 */
 	target = cpumask_any_and(&cstate_pkg_cpu_mask,
-				 topology_core_cpumask(cpu));
+				 topology_die_cpumask(cpu));
 	if (has_cstate_pkg && target >= nr_cpu_ids)
 		cpumask_set_cpu(cpu, &cstate_pkg_cpu_mask);
 
@@ -661,7 +661,13 @@ static int __init cstate_init(void)
 	}
 
 	if (has_cstate_pkg) {
-		err = perf_pmu_register(&cstate_pkg_pmu, cstate_pkg_pmu.name, -1);
+		if (topology_max_die_per_package() > 1) {
+			err = perf_pmu_register(&cstate_pkg_pmu,
+						"cstate_die", -1);
+		} else {
+			err = perf_pmu_register(&cstate_pkg_pmu,
+						cstate_pkg_pmu.name, -1);
+		}
 		if (err) {
 			has_cstate_pkg = false;
 			pr_info("Failed to register cstate pkg pmu\n");
-- 
2.18.0-rc0

