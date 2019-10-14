Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E3FECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA4D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sYTwemec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfJNRv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:51:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33904 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbfJNRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:51:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id k20so3164497pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HcvUzuJFn+RmmqNNAbiz0FxwJB/7vqfgbxYqeMhYLjg=;
        b=sYTwemecYiXkWr/trjdpTp/EtdmikXY4RSYj52oYXukGC0568QqCQA6Eg/5Xb+kUCb
         FRkGQXgnQKYwuZgn4XWT7HH3VTcqXLd9EzUmRnRDRl0UHG57E8ve/RYUnKfVdJeyKAOL
         t09d0ChGvW/6iFITFFsHGoI9EXJ5la69quBJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HcvUzuJFn+RmmqNNAbiz0FxwJB/7vqfgbxYqeMhYLjg=;
        b=MzCnjn7d0kJA7StEGfmcIA7EResizjMNP3haAE+5YR6XHfeeWvxbdaw9/5zmqIW9Z8
         0kjRd9qFQcUUCK7GThQGF3BHaflySsFllsMaCylAVTN0V2XhwCqqq0vcJvNoeT9oQwJk
         5P0XY/8raZLmrBp16KW1WamfT8d2taCZEtiFkdeQmRZ9UwCdGLLrstt6E2VqR86ob3/h
         85cwS6r1Fx7B6Jv8A9yeqE5u544f7nDgUG1aHZgAOH7jAHRXMPO1p2dDg6UM+7L/e3bq
         RZAesVomnoezmGajl1lvLwP10Ax4n4h4mWVvwndIbMFkLlj3mOioIKglFiMKZGTBo13D
         I/yA==
X-Gm-Message-State: APjAAAW/P796ke/MVfq8FCi2YF1LxwhBGd48NGsUovy/JB+A3rX3xP6+
        F5x/eoHW+CwIquQE1OoaLSrRKw==
X-Google-Smtp-Source: APXvYqzzSJUBgjGsF23tBxWXPgEWaUGuYXnkDukQ7Y6bgqbpPThvyS8bi28u5VMF3RJUTxkrvwnYHw==
X-Received: by 2002:aa7:9157:: with SMTP id 23mr34274904pfi.73.1571075485244;
        Mon, 14 Oct 2019 10:51:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o60sm29178561pje.21.2019.10.14.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:51:24 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:51:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: add declarations of undeclared items
Message-ID: <20191014175123.GC105106@google.com>
References: <20191011170824.30228-1-ben.dooks@codethink.co.uk>
 <20191012044430.GG2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012044430.GG2689@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:44:30PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 11, 2019 at 06:08:24PM +0100, Ben Dooks wrote:
> > The rcu_state, rcu_rnp_online_cpus and rcu_dynticks_curr_cpu_in_eqs
> > do not have declarations in a header. Add these to remove the
> > following sparse warnings:
> > 
> > kernel/rcu/tree.c:87:18: warning: symbol 'rcu_state' was not declared. Should it be static?
> > kernel/rcu/tree.c:191:15: warning: symbol 'rcu_rnp_online_cpus' was not declared. Should it be static?
> > kernel/rcu/tree.c:297:6: warning: symbol 'rcu_dynticks_curr_cpu_in_eqs' was not declared. Should it be static?
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Good catch!
> 
> However, these guys (plus one more) are actually used only in the
> kernel/rcu/tree.o translation unit, so they can be marked static.
> I made this change as shown below with your Reported-by.
> 
> Seem reasonable?
> 

LGTM.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 02995691aa76f3e52599d4f9d9d1ab23c3574f32
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Oct 11 21:40:09 2019 -0700
> 
>     rcu: Mark non-global functions and variables as static
>     
>     Each of rcu_state, rcu_rnp_online_cpus(), rcu_dynticks_curr_cpu_in_eqs(),
>     and rcu_dynticks_snap() are used only in the kernel/rcu/tree.o translation
>     unit, and may thus be marked static.  This commit therefore makes this
>     change.
>     
>     Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b18fa3d..278798e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -85,7 +85,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
>  	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
>  	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
>  };
> -struct rcu_state rcu_state = {
> +static struct rcu_state rcu_state = {
>  	.level = { &rcu_state.node[0] },
>  	.gp_state = RCU_GP_IDLE,
>  	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
> @@ -189,7 +189,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
>   * held, but the bit corresponding to the current CPU will be stable
>   * in most contexts.
>   */
> -unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
> +static unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
>  {
>  	return READ_ONCE(rnp->qsmaskinitnext);
>  }
> @@ -295,7 +295,7 @@ static void rcu_dynticks_eqs_online(void)
>   *
>   * No ordering, as we are sampling CPU-local information.
>   */
> -bool rcu_dynticks_curr_cpu_in_eqs(void)
> +static bool rcu_dynticks_curr_cpu_in_eqs(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> @@ -306,7 +306,7 @@ bool rcu_dynticks_curr_cpu_in_eqs(void)
>   * Snapshot the ->dynticks counter with full ordering so as to allow
>   * stable comparison of this counter with past and future snapshots.
>   */
> -int rcu_dynticks_snap(struct rcu_data *rdp)
> +static int rcu_dynticks_snap(struct rcu_data *rdp)
>  {
>  	int snap = atomic_add_return(0, &rdp->dynticks);
>  
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 1540542..f8e6c70 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -402,8 +402,6 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
>  #define RCU_NAME rcu_name
>  #endif /* #else #ifdef CONFIG_TRACING */
>  
> -int rcu_dynticks_snap(struct rcu_data *rdp);
> -
>  /* Forward declarations for tree_plugin.h */
>  static void rcu_bootup_announce(void);
>  static void rcu_qs(void);
