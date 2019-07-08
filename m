Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3981AC606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EC621670
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gyN0YHNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbfGHOQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:16:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40542 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfGHOQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:16:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so8367913pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u9RL5HLIh6yezhONARBvRLsllF5O+Vu+bd50FG8GPeY=;
        b=gyN0YHNczYaqbKMNxfVnPIHqbb7Poo5eHmBPxPyR7UH18iDMNfNqvvwfAp0LudnpgN
         9drB30RY6sopMAGb/+PSDNk7s1iGnLv43LKlFHK/2ebtEIRMJ7kDg70BHPh67z9ka0xI
         KjS0xw64uJQ9BPCf05c0u6GMwWzhF7ZIGCFbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u9RL5HLIh6yezhONARBvRLsllF5O+Vu+bd50FG8GPeY=;
        b=qC3yi3eQlqwfuGVUWAQ5RIJA/hMzrPejt7KHpfxmbcD3aUsHblsBBD/8rhaG7QTjxT
         XaCq7HCN+hIS3LjQxspbDUs1/eMCeEyIWSTeidZf1TUV2OLa+X7D8ahcJxJKmRdH6hV8
         33wlq23Qougdo0YfLw5FGbo/DpbBpzJwjfUpnqhwXvEUD7Eqo7LQFiM23aw9rci2zX8J
         F2/MhR42m1OVSXVa8JHvc1pprNm9oLWaOzhk7TDhTeRH9phuxiNUH8wOcSNKWaxorGkF
         mTphRW9/ysdRdHqPYxnCEwzWB85kU12WVFJqn75WPRSSeQyZR3LW3xBLY1bUyxtHcT7Z
         +cOA==
X-Gm-Message-State: APjAAAX5rJZQCXYzstQYUkw0rFqKcKhGTjIPcBexfLnEgFyd3wqhPCGS
        uBUeakEJEEIqRTRHF1wzx2KhEw==
X-Google-Smtp-Source: APXvYqxb6IizE0wC0he65Sm98Lu2XGHoXIXCLk+iD3+4L4dS8QzFXvI2oZXifbXVO6KE2sewejXoKw==
X-Received: by 2002:a17:902:6a87:: with SMTP id n7mr24899181plk.336.1562595361294;
        Mon, 08 Jul 2019 07:16:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h2sm15169663pgs.17.2019.07.08.07.16.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 07:16:00 -0700 (PDT)
Date:   Mon, 8 Jul 2019 10:15:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190708141559.GA62060@google.com>
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190708131942.GH26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708131942.GH26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 06:19:42AM -0700, Paul E. McKenney wrote:
[snip]
> > > Actually, the intent was to only allow this to be changed at boot time.
> > > Of course, if there is now a good reason to adjust it, it needs
> > > to be adjustable.  So what situation is making you want to change
> > > jiffies_till_sched_qs at runtime?  To what values is it proving useful
> > > to adjust it?  What (if any) relationships between this timeout and the
> > > various other RCU timeouts need to be maintained?  What changes to
> > > rcutorture should be applied in order to test the ability to change
> > > this at runtime?
> > 
> > I am also interested in the context, are you changing it at runtime for
> > experimentation? I recently was doing some performance experiments and it is
> > quite interesting how reducing this value can shorten grace period times :)
> 
> If you -really- want to reduce grace-period latencies, you can always
> boot with rcupdate.rcu_expedited=1.  ;-)
> 
> If you want to reduce grace-period latencies, but without all the IPIs
> that expedited grace periods give you, the rcutree.jiffies_till_first_fqs
> and rcutree.jiffies_till_next_fqs kernel boot parameters might be better
> places to start than rcutree.jiffies_till_sched_qs.  For one thing,
> adjusting these two affects the value of jiffies_till_sched_qs.

Yes, agreed ;)

 Joel

> > 
> > > 							Thanx, Paul
> > > 
> > > > The function for setting jiffies_to_sched_qs,
> > > > adjust_jiffies_till_sched_qs() will be called only if
> > > > the value from sysfs != ULONG_MAX. And the value won't be adjusted
> > > > unlike first/next fqs jiffies.
> > > > 
> > > > While at it, changed the positions of two module_param()s downward.
> > > > 
> > > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > > ---
> > > >  kernel/rcu/tree.c | 22 ++++++++++++++++++++--
> > > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index a2f8ba2..a28e2fe 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -422,9 +422,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > > >   * quiescent-state help from rcu_note_context_switch().
> > > >   */
> > > >  static ulong jiffies_till_sched_qs = ULONG_MAX;
> > > > -module_param(jiffies_till_sched_qs, ulong, 0444);
> > > >  static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
> > > > -module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > > >  
> > > >  /*
> > > >   * Make sure that we give the grace-period kthread time to detect any
> > > > @@ -450,6 +448,18 @@ static void adjust_jiffies_till_sched_qs(void)
> > > >  	WRITE_ONCE(jiffies_to_sched_qs, j);
> > > >  }
> > > >  
> > > > +static int param_set_sched_qs_jiffies(const char *val, const struct kernel_param *kp)
> > > > +{
> > > > +	ulong j;
> > > > +	int ret = kstrtoul(val, 0, &j);
> > > > +
> > > > +	if (!ret && j != ULONG_MAX) {
> > > > +		WRITE_ONCE(*(ulong *)kp->arg, j);
> > > > +		adjust_jiffies_till_sched_qs();
> > > > +	}
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> > > >  {
> > > >  	ulong j;
> > > > @@ -474,6 +484,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static struct kernel_param_ops sched_qs_jiffies_ops = {
> > > > +	.set = param_set_sched_qs_jiffies,
> > > > +	.get = param_get_ulong,
> > > > +};
> > > > +
> > > >  static struct kernel_param_ops first_fqs_jiffies_ops = {
> > > >  	.set = param_set_first_fqs_jiffies,
> > > >  	.get = param_get_ulong,
> > > > @@ -484,8 +499,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> > > >  	.get = param_get_ulong,
> > > >  };
> > > >  
> > > > +module_param_cb(jiffies_till_sched_qs, &sched_qs_jiffies_ops, &jiffies_till_sched_qs, 0644);
> > > >  module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
> > > >  module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
> > > > +
> > > > +module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > > >  module_param(rcu_kick_kthreads, bool, 0644);
> > > >  
> > > >  static void force_qs_rnp(int (*f)(struct rcu_data *rdp));
> > > > -- 
> > > > 1.9.1
> > > > 
> > > 
> > 
> 
