Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E5FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5812075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VU1U9PxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfCKNjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:39:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34709 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfCKNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:39:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id x20so5012467qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NyK4GfMt/DHi95NLfTJrQeYHSok+IWJ5DODJR1IX2Bc=;
        b=VU1U9PxCn/zV/FhEnOlyYpZofUcifQzq0InlYhXk1YeoG4yhOWFHaHwlxu1eHMP8fQ
         W1DGKVZmWgbkYjaZ7Z+VVXpfME5VmIPN/QtVcbHsv0uEPPj5XjfcHkQIUKkDHDstTugR
         sKxAKA7qXzMmCrFUNn5+65FAPH1sL57Owv8H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NyK4GfMt/DHi95NLfTJrQeYHSok+IWJ5DODJR1IX2Bc=;
        b=TJ4eDMiCqtobPCUQr0BwdTU89FJvT8pAjRoySHF7q+JEdVd/zDRnS9YqpxdagLcKnC
         iz98ck/F4D5Uz2yTOrgRwHf+7sMnd8yu21vxATMpyF3JKDJLfxlTOpeQhH7ph7BDrlAS
         xBXTCaAtpct+2gxxabiiOTwrMqyJs51o8ySnPVSlE7Nmvf67b1ueQ149R6D3omtuxwuo
         3y4a405fZtUuCK4dqafIKDPDFy0w9QKcZM8h0iHILjHcr6VpGo/PLxgLY7SulQRxQtLr
         xSrWhX9JVQHfGoHjppcNPFAkjpf7LbXmLW7gq7rKvCJreLX1AR+7QOt1hn6URO7AG76g
         vqCQ==
X-Gm-Message-State: APjAAAWCatvJOAiifwG7kpHLtkBB1ztZjdWBmOz7W1rdu0Dq3HPnoeVE
        13UO8J/BDHgYMwf5PFxOnovWpg==
X-Google-Smtp-Source: APXvYqy/Kd4aByMV2oD+czNPFKHJs6B6CdmpfTDXyLrFWdj8qLbADnTJJGrGR9DBuTdGu0NVVT3wbw==
X-Received: by 2002:ac8:2273:: with SMTP id p48mr25414541qtp.7.1552311581168;
        Mon, 11 Mar 2019 06:39:41 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id y53sm4527879qtj.66.2019.03.11.06.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 06:39:40 -0700 (PDT)
Date:   Mon, 11 Mar 2019 09:39:39 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        rostedt@goodmis.org, luto@kernel.org, byungchul.park@lge.com
Subject: Re: [PATCH tip/core/rcu 06/19] rcu: Add warning to detect
 half-interrupts
Message-ID: <20190311133939.GA29747@google.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-6-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829222047.319-6-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:20:34PM -0700, Paul E. McKenney wrote:
> RCU's dyntick-idle code is written to tolerate half-interrupts, that it,
> either an interrupt that invokes rcu_irq_enter() but never invokes the
> corresponding rcu_irq_exit() on the one hand, or an interrupt that never
> invokes rcu_irq_enter() but does invoke the "corresponding" rcu_irq_exit()
> on the other.  These things really did happen at one time, as evidenced
> by this ca-2011 LKML post:
> 
> http://lkml.kernel.org/r/20111014170019.GE2428@linux.vnet.ibm.com
> 
> The reason why RCU tolerates half-interrupts is that usermode helpers
> used exceptions to invoke a system call from within the kernel such that
> the system call did a normal return (not a return from exception) to
> the calling context.  This caused rcu_irq_enter() to be invoked without
> a matching rcu_irq_exit().  However, usermode helpers have since been
> rewritten to make much more housebroken use of workqueues, kernel threads,
> and do_execve(), and therefore should no longer produce half-interrupts.
> No one knows of any other source of half-interrupts, but then again,
> no one seems insane enough to go audit the entire kernel to verify that
> half-interrupts really are a relic of the past.
> 
> This commit therefore adds a pair of WARN_ON_ONCE() calls that will
> trigger in the presence of half interrupts, which the code will continue
> to handle correctly.  If neither of these WARN_ON_ONCE() trigger by
> mid-2021, then perhaps RCU can stop handling half-interrupts, which
> would be a considerable simplification.

Hi Paul and everyone,
I was thinking some more about this patch and whether we can simplify this code
much in 2021. Since 2021 is a bit far away, I thought working on it in again to
keep it fresh in memory is a good idea ;-)

To me it seems we cannot easily combine the counters (dynticks_nesting and
dynticks_nmi_nesting) even if we confirmed that there is no possibility of a
half-interrupt scenario (assuming simplication means counter combining like
Byungchul tried to do in https://goo.gl/X1U77X). The reason is because these
2 counters need to be tracked separately as they are used differently in the
following function:

static int rcu_is_cpu_rrupt_from_idle(void)
{
        return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
               __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
}

dynticks_nesting actually tracks if we entered/exited idle or user mode.

dynticks_nmi_nesting tracks if we entered/exited interrupts.

We have to do the "dynticks_nmi_nesting <= 1" check because
rcu_is_cpu_rrupt_from_idle() can possibly be called from an interrupt itself
(like timer) so we discount 1 interrupt, and, the "dynticks_nesting <= 0"
check is because the CPU MUST be in user or idle for the check to return
true. We can't really combine these two into one counter then I think because
they both convey different messages.

The only simplication we can do, is probably the "crowbar" updates to
dynticks_nmi_nesting can be removed from rcu_eqs_enter/exit once we confirm
no more half-interrupts are possible. Which might still be a worthwhile thing
to do (while still keeping both counters separate).

However, I think we could combine the counters and lead to simplying the code
in case we implement rcu_is_cpu_rrupt_from_idle differently such that it does
not need the counters but NOHZ_FULL may take issue with that since it needs
rcu_user_enter->rcu_eqs_enter to convey that the CPU is "RCU"-idle.

Actually, I had another question... rcu_user_enter() is a NOOP in !NOHZ_FULL config.
In this case I was wondering if the the warning Paul added (in the patch I'm replying to)
will really get fired for half-interrupts. The vast majority of the systems I believe are
NOHZ_IDLE not NOHZ_FULL.
This is what a half-interrupt really looks like right? Please correct me if I'm wrong:
rcu_irq_enter()   [half interrupt causes an exception and thus rcu_irq_enter]
rcu_user_enter()  [due to usermode upcall]
rcu_user_exit()
(no more rcu_irq_exit() - hence half an interrupt)

But the rcu_user_enter()/exit is a NOOP in some configs, so will the warning in
rcu_eqs_e{xit,nter} really do anything?

Or was the idea with adding the new warnings, that they would fire the next
time rcu_idle_enter/exit is called? Like for example:

rcu_irq_enter()   [This is due to half-interrupt]
rcu_idle_enter()  [Eventually we enter the idle loop at some point
		   after the half-interrupt and the rcu_eqs_enter()
		   would "crowbar" the dynticks_nmi_nesting counter to 0].

thanks!

 - Joel

> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Reported-by: Joel Fernandes <joel@joelfernandes.org>
> Reported-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index dc041c2afbcc..d2b6ade692c9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -714,6 +714,7 @@ static void rcu_eqs_enter(bool user)
>  	struct rcu_dynticks *rdtp;
>  
>  	rdtp = this_cpu_ptr(&rcu_dynticks);
> +	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
>  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>  		     rdtp->dynticks_nesting == 0);
> @@ -895,6 +896,7 @@ static void rcu_eqs_exit(bool user)
>  	trace_rcu_dyntick(TPS("End"), rdtp->dynticks_nesting, 1, rdtp->dynticks);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	WRITE_ONCE(rdtp->dynticks_nesting, 1);
> +	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting);
>  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
>  }
>  
> -- 
> 2.17.1
> 
