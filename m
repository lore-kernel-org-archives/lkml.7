Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C83FC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7163F20675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NFtayL5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbfFTMiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:38:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41944 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFTMiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nhMjxd6N8mK25viTPAAh63lL47/8sCvIH5Vzfve53Yc=; b=NFtayL5a54p7l3+J44kKoVSNW
        mV+j67fyZa9KTLu5My3VFvHZDabw8oN7W/ML1KeL1nBn6QcSCMBUjxzZttvjEcoPtULCAs4X5Ojaq
        QmyIGJhmK+iuWOnZ769ndf4LqKpfvHjXctxeuFUQIndUWDbkA+sOJZRn6r3a7DlZeD3NFQfmKKWSG
        Xh6bl78ZxNRwZUCcj8D2/0DNz72xvGmln60AoWOMivWGiHVDi/28oA0ceY+sSz9QpnNQXJp33JIf/
        z+TkqF6ZSP1mI57TqS/407rr8iqSgdk7tmeuo/lrqhI7gPg9o7OBsMYc5Dkn1bhDXx94Wqlwi26g4
        hncVdrNww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdwKP-00078l-7d; Thu, 20 Jun 2019 12:38:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 033F92021B5AC; Thu, 20 Jun 2019 14:38:07 +0200 (CEST)
Date:   Thu, 20 Jun 2019 14:38:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched/isolation: Prefer housekeeping cpu in local node
Message-ID: <20190620123807.GX3436@hirez.programming.kicks-ass.net>
References: <1561030614-17026-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561030614-17026-1-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 07:36:54PM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> In real product setup, there will be houseeking cpus in each nodes, it 
> is prefer to do housekeeping from local node, fallback to global online 
> cpumask if failed to find houseeking cpu from local node.
> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  kernel/sched/isolation.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 123ea07..9eb6805 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -16,9 +16,16 @@ static unsigned int housekeeping_flags;
>  
>  int housekeeping_any_cpu(enum hk_flags flags)
>  {
> +	int cpu;
> +
>  	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping_flags & flags)
> -			return cpumask_any_and(housekeeping_mask, cpu_online_mask);
> +		if (housekeeping_flags & flags) {
> +			cpu = cpumask_any_and(housekeeping_mask, cpu_cpu_mask(smp_processor_id()));
> +			if (cpu < nr_cpu_ids)
> +				return cpu;
> +			else
> +				return cpumask_any_and(housekeeping_mask, cpu_online_mask);
> +		}
>  	return smp_processor_id();
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_any_cpu);

Why not something like so? IIRC there's more places that want this, but
I can't seem to remember quite where.

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 123ea07a3f3b..1cceab5f094c 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -16,9 +16,15 @@ static unsigned int housekeeping_flags;
 
 int housekeeping_any_cpu(enum hk_flags flags)
 {
-	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & flags)
+	if (static_branch_unlikely(&housekeeping_overridden)) {
+		if (housekeeping_flags & flags) {
+			cpu = sched_numa_find_closest(housekeeping_mask, smp_processor_id());
+			if (cpu < nr_cpu_ids)
+				return cpu;
+
 			return cpumask_any_and(housekeeping_mask, cpu_online_mask);
+		}
+	}
 	return smp_processor_id();
 }
 EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b08dee29ef5e..0db7431c7207 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1212,9 +1212,6 @@ enum numa_topology_type {
 extern enum numa_topology_type sched_numa_topology_type;
 extern int sched_max_numa_distance;
 extern bool find_numa_distance(int distance);
-#endif
-
-#ifdef CONFIG_NUMA
 extern void sched_init_numa(void);
 extern void sched_domains_numa_masks_set(unsigned int cpu);
 extern void sched_domains_numa_masks_clear(unsigned int cpu);
@@ -1224,6 +1221,8 @@ static inline void sched_domains_numa_masks_set(unsigned int cpu) { }
 static inline void sched_domains_numa_masks_clear(unsigned int cpu) { }
 #endif
 
+extern int sched_numa_find_closest(const struct cpumask *cpus, int cpu);
+
 #ifdef CONFIG_NUMA_BALANCING
 /* The regions in numa_faults array from task_struct */
 enum numa_faults_stats {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 63184cf0d0d7..408e94a6637c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1726,6 +1726,20 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
 
 #endif /* CONFIG_NUMA */
 
+int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
+{
+#ifdef CONFIG_NUMA
+	int i, j = cpu_to_node(cpu);
+
+	for (i = 0; i < sched_domains_numa_levels; ++) {
+		cpu = cpumask_any_and(cpus, sched_domains_numa_mask[i][j]);
+		if (cpu < nr_cpu_ids)
+			return cpu;
+	}
+#endif
+	return nr_cpu_ids;
+}
+
 static int __sdt_alloc(const struct cpumask *cpu_map)
 {
 	struct sched_domain_topology_level *tl;
