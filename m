Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1D8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1C72082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="LtoTuRu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfEOVjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:39:41 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54779 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEOVjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:39:40 -0400
Received: by mail-it1-f196.google.com with SMTP id a190so2661860ite.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=SiXgF9x2/J3d2aHVUGJadEDzzKTOQ6u3eFYsxUlLv6Y=;
        b=LtoTuRu+ueQTHokRdPa41+QCP5yRsq+8mJD2uWJQ6yA4dysOm/SWnaxqAIU0BOHKyA
         EmCHL6Mo2VXSw3kpuiy7K2B1jc/DVOwKsdYnCaiZ8ZIytsTuGlae6qYyXCO82nIqHfaK
         8KyzDMzo3iKT7HSFnrFh4bcd3pFqKWg9eC9RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=SiXgF9x2/J3d2aHVUGJadEDzzKTOQ6u3eFYsxUlLv6Y=;
        b=HpkwUi2zd/gMdlWwsuOxbMpYHecm8pFmAV8AXFjxvyNX9T9/qEmqYPA61L8U19oTHy
         Nuum2VibQvVfmas0s1GeOJQGz2fRp+KW56fChNy3uUp1hEHEep0mfuFyHlEkCs2CJF49
         inPAWnFtp7eIk94j+jS7AesOz28rUeoRS+u8Nt412CYY5AGZw5n/wSDXzCIXKJ+ha+S+
         1uAq4+T/Olug4wNgZk6mAtW7d2p2Q1ykSeRvfbXWCAO4Ht40o1y7PXWXeH7YFwTsvdKk
         k8POlUoMgIaAOERYNwC10uzKwm23EL56YqvXYBQNHVSifzXM8BVP+J7ty2A5g/9FvUBJ
         b/bw==
X-Gm-Message-State: APjAAAVcPEpq1ddTZNF0l+9DcK94N0FwPrS6G0ltwpbJVeq3rt1CrGum
        qzgv4/yOS2FdH2sAW6PVPIvM6g==
X-Google-Smtp-Source: APXvYqwqSrLBXoegOr6A8dYwtSLbSzWVwvo3JxWRbUWJE52+oTd/kMINHBVQntZPmL2oGN5Ebp/5Tw==
X-Received: by 2002:a05:6638:29b:: with SMTP id c27mr29205969jaq.112.1557956379848;
        Wed, 15 May 2019 14:39:39 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id p132sm1332175ita.2.2019.05.15.14.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 14:39:39 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Date:   Wed, 15 May 2019 21:39:36 +0000
Message-Id: <20190515213936.3454-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424111913.1386-1-vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for pointing this out. I think the ideal fix would be to
> correctly initialize/cleanup the coresched attributes in the cpu
> hotplug code path so that lock could be taken successfully if the
> sibling is offlined/onlined after coresched was enabled. We are
> working on another bug related to hotplugpath and shall introduce
> the fix in v3.
>
A possible fix for handling the runqueues during cpu offline/online
is attached here with.

Thanks,
Vineeth

---
 kernel/sched/core.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e8e5f26db052..1a809849a1e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -253,7 +253,7 @@ static int __sched_core_stopper(void *data)
 	bool enabled = !!(unsigned long)data;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_online_cpu(cpu)
 		cpu_rq(cpu)->core_enabled = enabled;
 
 	return 0;
@@ -3764,6 +3764,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			struct rq *rq_i = cpu_rq(i);
 			struct task_struct *p;
 
+			if (cpu_is_offline(i))
+				continue;
+
 			if (rq_i->core_pick)
 				continue;
 
@@ -3866,6 +3869,9 @@ next_class:;
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
+		if (cpu_is_offline(i))
+			continue;
+
 		WARN_ON_ONCE(!rq_i->core_pick);
 
 		rq_i->core_pick->core_occupation = occ;
@@ -6410,8 +6416,14 @@ int sched_cpu_activate(unsigned int cpu)
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
 		static_branch_inc_cpuslocked(&sched_smt_present);
+#ifdef CONFIG_SCHED_CORE
+		if (static_branch_unlikely(&__sched_core_enabled)) {
+			rq->core_enabled = true;
+		}
+#endif
+	}
 #endif
 	set_cpu_active(cpu, true);
 
@@ -6459,8 +6471,15 @@ int sched_cpu_deactivate(unsigned int cpu)
 	/*
 	 * When going down, decrement the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
+#ifdef CONFIG_SCHED_CORE
+		struct rq *rq = cpu_rq(cpu);
+		if (static_branch_unlikely(&__sched_core_enabled)) {
+			rq->core_enabled = false;
+		}
+#endif
 		static_branch_dec_cpuslocked(&sched_smt_present);
+	}
 #endif
 
 	if (!sched_smp_initialized)
@@ -6537,6 +6556,9 @@ int sched_cpu_dying(unsigned int cpu)
 	update_max_interval();
 	nohz_balance_exit_idle(rq);
 	hrtick_clear(rq);
+#ifdef CONFIG_SCHED_CORE
+	rq->core = NULL;
+#endif
 	return 0;
 }
 #endif
-- 
2.17.1
