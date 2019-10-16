Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590C6C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31380217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571197636;
	bh=1/BRSuGd20H8z4UWP9evd28hs3MmIqOFX4BuM/kPxEM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aLR63j7f/g01yR4LHaquF6IjCikntZxrahwM5SitxYmN+od+SENfKVgeabFi1DcBj
	 hshlmBDbvFo5gsxD9k9b2W1Kk6KpmKeoZQEKLfWSlp8s3xFgnx0ViBst5pKpwAzGyI
	 KCDb4VUgv/XEHWQOcuFtHc7odoe0piZMQSmbMBV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbfJPDrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfJPDrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:47:14 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF6E20854;
        Wed, 16 Oct 2019 03:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571197633;
        bh=1/BRSuGd20H8z4UWP9evd28hs3MmIqOFX4BuM/kPxEM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AEoe7zhHviWvmPVe5ELG/IJg2edZuV7JWXS6Npd9mX8C2tRse3PusAVc69CXFyymC
         +TYfLmgeP85oMqkqe2y+3TvWncZV74o5dHr3eKSDqyqS7D8c6nAO+iuK9fhzhjTACJ
         e9+34Q5dmByvE06EMBEc6Go138p80lWKhSbkyYIs=
Date:   Tue, 15 Oct 2019 20:47:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     20191015102402.1978-1-laijs@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/7] rcu: remove the declaration of call_rcu() in tree.h
Message-ID: <20191016034711.GZ2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015102850.2079-1-laijs@linux.alibaba.com>
 <20191015102850.2079-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015102850.2079-2-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:28:46AM +0000, Lai Jiangshan wrote:
> call_rcu() is external RCU API declared in include/linux/,
> and doesn't need to be (re-)declared in internal files again.
> 
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

Good catch!

Queued for testing and review, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index f8e6c70cceef..823f475c5e35 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -412,7 +412,6 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
>  static int rcu_print_task_exp_stall(struct rcu_node *rnp);
>  static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
>  static void rcu_flavor_sched_clock_irq(int user);
> -void call_rcu(struct rcu_head *head, rcu_callback_t func);
>  static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
>  static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
>  static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
> -- 
> 2.20.1
> 
