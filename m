Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF49214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfCLBuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfCLBuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:50:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080BE214AE;
        Tue, 12 Mar 2019 01:50:30 +0000 (UTC)
Date:   Mon, 11 Mar 2019 21:50:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Fix self wakeups for grace period kthread
Message-ID: <20190311215027.2f3458a1@oasis.local.home>
In-Reply-To: <1552038378-11166-1-git-send-email-neeraju@codeaurora.org>
References: <1552038378-11166-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 15:16:18 +0530
Neeraj Upadhyay <neeraju@codeaurora.org> wrote:

> Update the code to match the comment that self wakeup of
> grace period kthread is allowed from interrupt handler, and
> softirq handler, running in the grace period kthread's
> context. Present code allows self wakeups from all
> interrupt contexts - nmi, softirq and hardirq contexts.

That's not actually the issue. But it appears that we return if we
simply have BH disabled, which I don't think we want, and we don't care
about NMI as NMI should never call this code.

I think your patch is correct, but the change log is not.

-- Steve


> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index acd6ccf..57cac6d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1585,7 +1585,7 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
>  static void rcu_gp_kthread_wake(void)
>  {
>  	if ((current == rcu_state.gp_kthread &&
> -	     !in_interrupt() && !in_serving_softirq()) ||
> +	     !in_irq() && !in_serving_softirq()) ||
>  	    !READ_ONCE(rcu_state.gp_flags) ||
>  	    !rcu_state.gp_kthread)
>  		return;

