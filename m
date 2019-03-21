Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF27C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08E920835
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="b2m+E2rB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCUAez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:34:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46292 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfCUAey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:34:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so3799323qts.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 17:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DYNvRjo/HuWAfPzKwiaae98YACyxnfggO4JrZh0pqc=;
        b=b2m+E2rBIWrjAEK7ksC+kUdda6i79l+OAnqTq4Nh+wMfEJZEL78oIKpbExSGNTsbjS
         QgODnchgWoidxWeW7gCR6+pyoOPVkGgcqBYXflx61USkvWOpf2mw30X6HA2uqNuUja6N
         zBbTar2Vbof5pPo/Ul2SVXB1PoWCvUgckJ0U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DYNvRjo/HuWAfPzKwiaae98YACyxnfggO4JrZh0pqc=;
        b=LOf9pdzHuQ+evQBcL7KIVUsvhUZoaX28tvwKooelMWPqI6RpNyF2C95iETWYeg9HAh
         u2uruj8VfQmq2flibcaYECcWlWrUjvmSY8heLBhcQklKBUyuNzlCQyeUb1vvMY87sE06
         x6eXoiu4gG8VLcMVmmtIXTxf5YNtqQKwxY0ynObcH2wRAQ71V9z3arDabmsuDGpCDJfr
         7HX+vMRmST+BVqQ+8j1BdhJKA7x3gaWZ6spzJRJ8xDSLQoGR9/RwSew2XD4U+N5DyyG5
         9OaeQthCSRMGwFV2w4GA/rbwZe2E6ewTN9TFsslDv8/BKpGbT6ZZA6JtARFjjlkLRQxa
         2J6g==
X-Gm-Message-State: APjAAAW1YJQ45vWgJqe1k14tu1aPoTBq7qG2pNJvYb+mT93NUfID3mfl
        iOAEJb1aeXp3mEjLaSgdyrqEKOk53/0=
X-Google-Smtp-Source: APXvYqxHYc6IcQHMWIULRulGndrlcJYc90PK4ZArKF2CW4dAOuOnIN93yfvj1vApt5VMlyPuYm41gw==
X-Received: by 2002:a0c:94d0:: with SMTP id k16mr813759qvk.158.1553128492678;
        Wed, 20 Mar 2019 17:34:52 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id u15sm2908475qth.54.2019.03.20.17.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:34:51 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/4] sched_domain: Annotate RCU pointers properly
Date:   Wed, 20 Mar 2019 20:34:24 -0400
Message-Id: <20190321003426.160260-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190321003426.160260-1-joel@joelfernandes.org>
References: <20190321003426.160260-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler uses RCU API in various places to access sched_domain
pointers. These cause sparse errors as below.

Many new errors show up because of an annotation check I added to
rcu_assign_pointer(). Let us annotate the pointers correctly which also
will help sparse catch any potential future bugs.

This fixes the following sparse errors:

rt.c:1681:9: error: incompatible types in comparison expression
deadline.c:1904:9: error: incompatible types in comparison expression
core.c:519:9: error: incompatible types in comparison expression
core.c:1634:17: error: incompatible types in comparison expression
fair.c:6193:14: error: incompatible types in comparison expression
fair.c:9883:22: error: incompatible types in comparison expression
fair.c:9897:9: error: incompatible types in comparison expression
sched.h:1287:9: error: incompatible types in comparison expression
topology.c:612:9: error: incompatible types in comparison expression
topology.c:615:9: error: incompatible types in comparison expression
sched.h:1300:9: error: incompatible types in comparison expression
topology.c:618:9: error: incompatible types in comparison expression
sched.h:1287:9: error: incompatible types in comparison expression
topology.c:621:9: error: incompatible types in comparison expression
sched.h:1300:9: error: incompatible types in comparison expression
topology.c:624:9: error: incompatible types in comparison expression
topology.c:671:9: error: incompatible types in comparison expression
stats.c:45:17: error: incompatible types in comparison expression
fair.c:5998:15: error: incompatible types in comparison expression
fair.c:5989:15: error: incompatible types in comparison expression
fair.c:5998:15: error: incompatible types in comparison expression
fair.c:5989:15: error: incompatible types in comparison expression
fair.c:6120:19: error: incompatible types in comparison expression
fair.c:6506:14: error: incompatible types in comparison expression
fair.c:6515:14: error: incompatible types in comparison expression
fair.c:6623:9: error: incompatible types in comparison expression
fair.c:5970:17: error: incompatible types in comparison expression
fair.c:8642:21: error: incompatible types in comparison expression
fair.c:9253:9: error: incompatible types in comparison expression
fair.c:9331:9: error: incompatible types in comparison expression
fair.c:9519:15: error: incompatible types in comparison expression
fair.c:9533:14: error: incompatible types in comparison expression
fair.c:9542:14: error: incompatible types in comparison expression
fair.c:9567:14: error: incompatible types in comparison expression
fair.c:9597:14: error: incompatible types in comparison expression
fair.c:9421:16: error: incompatible types in comparison expression
fair.c:9421:16: error: incompatible types in comparison expression

[From an RCU perspective]
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched/topology.h |  4 ++--
 kernel/sched/sched.h           | 14 +++++++-------
 kernel/sched/topology.c        | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 57c7ed3fe465..cfc0a89a7159 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -76,8 +76,8 @@ struct sched_domain_shared {
 
 struct sched_domain {
 	/* These fields must be setup */
-	struct sched_domain *parent;	/* top domain must be null terminated */
-	struct sched_domain *child;	/* bottom domain must be null terminated */
+	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
+	struct sched_domain __rcu *child;	/* bottom domain must be null terminated */
 	struct sched_group *groups;	/* the balancing groups of the domain */
 	unsigned long min_interval;	/* Minimum balance interval ms */
 	unsigned long max_interval;	/* Maximum balance interval ms */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 713715dd00cf..2b452d68ab2e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -869,8 +869,8 @@ struct rq {
 	atomic_t		nr_iowait;
 
 #ifdef CONFIG_SMP
-	struct root_domain	*rd;
-	struct sched_domain	*sd;
+	struct root_domain		*rd;
+	struct sched_domain __rcu	*sd;
 
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
@@ -1324,13 +1324,13 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 	return sd;
 }
 
-DECLARE_PER_CPU(struct sched_domain *, sd_llc);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
-DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
-DECLARE_PER_CPU(struct sched_domain *, sd_numa);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym_packing);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
+DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ab7f371a3a17..64bec54ded3e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -615,13 +615,13 @@ static void destroy_sched_domains(struct sched_domain *sd)
  * the cpumask of the domain), this allows us to quickly tell if
  * two CPUs are in the same cache domain, see cpus_share_cache().
  */
-DEFINE_PER_CPU(struct sched_domain *, sd_llc);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
-DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
-DEFINE_PER_CPU(struct sched_domain *, sd_numa);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym_packing);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
+DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
-- 
2.21.0.225.g810b269d1ac-goog

