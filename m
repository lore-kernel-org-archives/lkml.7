Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60605C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0E62175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfCTLcW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:32:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35311 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:32:22 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h6ZSF-0002CF-K5; Wed, 20 Mar 2019 12:32:19 +0100
Date:   Wed, 20 Mar 2019 12:32:19 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v2] rcu: Allow to eliminate softirq processing from
 rcutree
Message-ID: <20190320113219.d6c3gouqbnsnl5nj@linutronix.de>
References: <20190315111130.4902-1-bigeasy@linutronix.de>
 <20190318022434.GE4102@linux.ibm.com>
 <20190319114419.qlsw3i5bmndoyvao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190319114419.qlsw3i5bmndoyvao@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-19 12:44:19 [+0100], To Paul E. McKenney wrote:
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0f31b79eb6761..0a719f726e149 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
…
> +/*
> + * Spawn per-CPU RCU core processing kthreads.
> + */
> +static int __init rcu_spawn_core_kthreads(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
> +	if (!IS_ENABLED(CONFIG_RCU_BOOST) && !rcu_softirq_enabled)

and this needs to become
-       if (!IS_ENABLED(CONFIG_RCU_BOOST) && !rcu_softirq_enabled)
+       if (!IS_ENABLED(CONFIG_RCU_BOOST) && rcu_softirq_enabled)

With this change and hunk that I just sent to Joel I get thee three RCU
modes with and without BOOST booted.

Unless there is something (and Paul agrees that the Joel hunk is
correct) I would post a v3 with those changes included.

> +		return 0;
> +	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__);
> +	return 0;
> +}
> +early_initcall(rcu_spawn_core_kthreads);

Sebastian
