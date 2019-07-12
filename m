Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92240C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB6E20665
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LRehi/Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGLMvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:51:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38532 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfGLMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:51:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so4743546plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gFlgmydi1nQgjqczBTKm5/22cWDPzABXL1VL2o7TqMg=;
        b=LRehi/CwV/zFgLZZ8FeGbYXGhXHPixhNEI1CAvU22L3YZZXmUrordq0fvMqsmXfo9g
         c0XV+B8kmaCfjh2sXDbqolNl8tfdSU/gzAUKhKQU3SBGTUyufYai6LVx3tvVKTJfpNHm
         Lmn35zGInAot53Sx/qvFWwMnvO7Opk9WC5mi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gFlgmydi1nQgjqczBTKm5/22cWDPzABXL1VL2o7TqMg=;
        b=dpbU0UCrmNc9EqC8X9HR/izQ+jOoz52Bdh714zhqfxXGwQ4waha+w8a39mIvNnAWn2
         1aLXbEXaOmnfruph5sbLEAfurkQQu0DOsFZT3zPcjppJDfRW16SIth4PNXUELo8uxXbE
         0PPpsGncs8s87iBMzfhfm/pB5h7OARx79yLL6uGBAiUu78mf3pUEQqsA1r2HTjTHT9mc
         9gMxvVDxHO6+VR8Oe0HUNgsDtFclxsP6Vhd7fyn6ObXw2sfWPzsMpG46FiJm4ud/Nfd7
         Tma0m4+APNiA37l9f61hxIgvrLJ3Ulhlnr6Lqry0GZK0m1nKJ+/VOWT0M67Ypsr0Z7tw
         Sp8w==
X-Gm-Message-State: APjAAAU3cK4GVKbMkIhlhMmtCT/bTIitqGgkmecWdz5CE7PgAr0Ol+pr
        D1rVl+W/jv72ZHSje5KWqME=
X-Google-Smtp-Source: APXvYqzz+LhsCnsDqeZHjTnmsAPR8biwBS4oCVNY2mhAus6k4miEE048HuYeqWQC3XXhO3VAnEBlZw==
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr11376163pll.321.1562935878250;
        Fri, 12 Jul 2019 05:51:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t10sm8084829pjr.13.2019.07.12.05.51.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 05:51:17 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:51:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190712125116.GB92297@google.com>
References: <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712063240.GD7702@X58A-UD3R>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 03:32:40PM +0900, Byungchul Park wrote:
> On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > period ever is recorded in rcu_state.gp_max. However it is not read from
> > anywhere.
> > 
> > Any idea why it was added but not used?
> > 
> > I am interested in dumping this value just for fun, and seeing what I get.
> > 
> > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > look like.
> 
> Hi,
> 
> 	commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> 	rcu: Remove debugfs tracing
> 
> removed all debugfs tracing, gp_max also included.
> 
> And you sounds great. And even looks not that hard to add it like,
> 
> :)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ad9dc86..86095ff 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
>  	raw_spin_lock_irq_rcu_node(rnp);
>  	rcu_state.gp_end = jiffies;
>  	gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> -	if (gp_duration > rcu_state.gp_max)
> +	if (gp_duration > rcu_state.gp_max) {
>  		rcu_state.gp_max = gp_duration;
> +		trace_rcu_grace_period(something something);
> +	}

Yes, that makes sense. But I think it is much better off as a readable value
from a virtual fs. The drawback of tracing for this sort of thing are:
 - Tracing will only catch it if tracing is on
 - Tracing data can be lost if too many events, then no one has a clue what
   the max gp time is.
 - The data is already available in rcu_state::gp_max so copying it into the
   trace buffer seems a bit pointless IMHO
 - It is a lot easier on ones eyes to process a single counter than process
   heaps of traces.

I think a minimal set of RCU counters exposed to /proc or /sys should not
hurt and could do more good than not. The scheduler already does this for
scheduler statistics. I have seen Peter complain a lot about new tracepoints
but not much (or never) about new statistics.

Tracing has its strengths but may not apply well here IMO. I think a counter
like this could be useful for tuning of things like the jiffies_*_sched_qs,
the stall timeouts and also any other RCU knobs. What do you think?

- Joel


