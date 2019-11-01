Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62CACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B10521734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572630915;
	bh=3Xm0g5bLJT6AlbiJKa7sggY6JRT1YNzhQMPcX5fIqcg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OWu3TP5wrIPuqiJilc4Gg8iRCmrgqwkDYULH+Ua0xoowGQ/aW26gdSwMhV5epVCx4
	 HXDb8MVr77MmS2BJ8kCnyGkA9SfFiWpnzikotXri9aCvp/YaEG5iNKVJh5GdlJdVCQ
	 7jL4TjFQ2cRzxD+49PhhtCj8qEgzXp6mJVMPALFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfKARzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:55:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45584 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKARzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:55:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so10405711wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ES+LHpjXtfCoOvIzCh6qL8zNso7DXWydpdGJ10lggoc=;
        b=gLneO5kf9GxBEj/Nap7QfVzPfxobMkznpdmYSVnMhr0zKEPaMIfr2PvjztDeWBHZ1L
         IL+WbGXw16zcmua/tVfNKdV9sMIhtmtlyf5p2XMgoXpQXOqu6vLhdXi+P7Y/05MaNKNo
         /ztPeGOQ6+0RPHKLhpeJhLRvC9bSaPfX38r+TJZ1B2dfLiiKLeNfs2ObV2iIlx6YS/Qz
         rKi6Xiu9x4TZ+j+XLIBxIJBcnif8GL57WLXaXJSPjUOxwgWTrNdBmBiIAW724D+1cEpL
         tt9vsj4ix1ToUREU4fs1XaA8ii3z/RMhQE/Qbl2i0iP/nswgg6LJMtitNBtqgExUSngn
         3g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ES+LHpjXtfCoOvIzCh6qL8zNso7DXWydpdGJ10lggoc=;
        b=OdUaUcDc538hiAxD+9fyqWBUYS49CKw6ttnEQpnCytwDSxJmSMRaRDeeGNn8neoB4J
         jD+GDY2c/HWJn5S+BubxKlwToQdurgPKLenY2/OFiwX9WD1mf3qKOl8JrOl7yIdmflqw
         4TMnNsPM6a9/4kSr8b7rKcZRPg0AHkm9rVbM+hwquk25dI72l+1nirw38Uc4y81N/rm5
         lJEoCecB0AULvY5J24brB6KSSTZygIudZKaMVsndcdcurK5UX/BAnzX6LIzp8//JrBgp
         Zny4RTz3vEnPfM1YrfRKzNNxkjxOpmxv/kx/2Gbe73Cq/Hlf79sueUzzG7j92XzdAluQ
         NMzA==
X-Gm-Message-State: APjAAAV2VOQsevj7XjNjdjwMv5WQ27Y3dMu4u3mQkVQheneopoenQRWC
        vcyl6IMMtV3tTSEb5kGWAIV+Lgu+
X-Google-Smtp-Source: APXvYqwND//TTZ9F4wZcAXUyHlatBJxCiNHmzv9Q5Lmm8b+QXLMZNIlwPtpgO5MKeXj4oCoaU2NyoQ==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr12269333wrp.185.1572630911295;
        Fri, 01 Nov 2019 10:55:11 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o189sm11605258wmo.23.2019.11.01.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 10:55:10 -0700 (PDT)
Date:   Fri, 1 Nov 2019 18:55:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20191101175508.GA125660@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: e284df705cf1eeedb5ec3a66ed82d17a64659150 sched/topology: Allow sched_asym_cpucapacity to be disabled

Fix two scheduler topology bugs/oversights on Juno r0 2+4 big.LITTLE 
systems.

 Thanks,

	Ingo

------------------>
Valentin Schneider (2):
      sched/topology: Don't try to build empty sched domains
      sched/topology: Allow sched_asym_cpucapacity to be disabled


 kernel/cgroup/cpuset.c  |  3 ++-
 kernel/sched/topology.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c52bc91f882b..c87ee6412b36 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -798,7 +798,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
 		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
 			continue;
 
-		if (is_sched_load_balance(cp))
+		if (is_sched_load_balance(cp) &&
+		    !cpumask_empty(cp->effective_cpus))
 			csa[csn++] = cp;
 
 		/* skip @cp's subtree if not a partition root */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b5667a273bf6..49b835f1305f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1948,7 +1948,7 @@ static struct sched_domain_topology_level
 static int
 build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *attr)
 {
-	enum s_alloc alloc_state;
+	enum s_alloc alloc_state = sa_none;
 	struct sched_domain *sd;
 	struct s_data d;
 	struct rq *rq = NULL;
@@ -1956,6 +1956,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct sched_domain_topology_level *tl_asym;
 	bool has_asym = false;
 
+	if (WARN_ON(cpumask_empty(cpu_map)))
+		goto error;
+
 	alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
 	if (alloc_state != sa_rootdomain)
 		goto error;
@@ -2026,7 +2029,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	rcu_read_unlock();
 
 	if (has_asym)
-		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
+		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
 	if (rq && sched_debug_enabled) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
@@ -2121,8 +2124,12 @@ int sched_init_domains(const struct cpumask *cpu_map)
  */
 static void detach_destroy_domains(const struct cpumask *cpu_map)
 {
+	unsigned int cpu = cpumask_any(cpu_map);
 	int i;
 
+	if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
+		static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
+
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map)
 		cpu_attach_domain(NULL, &def_root_domain, i);
