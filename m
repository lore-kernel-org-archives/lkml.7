Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30021C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EAE2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Iru3nkI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfGHNEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:04:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34850 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfGHNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:04:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so8248159plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xEfBrs0GhPems//ZFf52Fo4j6AMBzVKhWRp8eHZnqyk=;
        b=Iru3nkI7DdRqXxzZ+0XkeP7Rnohck3RuZS81SLlMzIsYYgLTBoTzwIvINF7hVsPs2N
         ZwzM7OEIf7qiFCssBC7h5Y92COfsEJU/Y8hza+5nefr1z4cysRWWIJqs37R6Chv25xK5
         y45rh8Yr+SnYzmyYUJfPnrszcA3W2iX8piLwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xEfBrs0GhPems//ZFf52Fo4j6AMBzVKhWRp8eHZnqyk=;
        b=lHtDqolakUbY3JaZuriaRDM0qv8m61G3BAO7cSzbgeniIhys1Rz3rQtMZZ0wkELrVf
         IVIWYQgOMK8yXBy0Dah0bGeW9+5QLQlFK1DmuNngsLQegEwOWZt6fCHXVMUfIR7twWPb
         OwzgIf8Ku/CwYObimCzZul6ouch/DV7uOJ+qjjQVuIlzinxnOSGlMjLD3tjLM7fD2O4z
         pXeosME0ryBEuS7kYTtANI/KN9QLnFSNc38BgJHdT/IIikYRovHlvCupRtzfC1EuNlgm
         IfXrhOd7oUnI6OYKUW+UGrw+OJhtVSBpkRlFbYYLeJxIzL1Ap0hr9kZM9bLy9RvUp2s1
         XW3A==
X-Gm-Message-State: APjAAAVcdrVdL5OoVR0U11Kuv45kqGzIivjYXa4kUUztCFMyaK0FKQ9f
        +gCLf0X2h3GGXzsmXPdwPA93QQ==
X-Google-Smtp-Source: APXvYqzro80AFaLxQlBJtyvkxSAPb2bSZlIgTRpiA9rxnWvI8qiQ8NPMv3tyPIJZ+H3/t4AbomZhxw==
X-Received: by 2002:a17:902:1125:: with SMTP id d34mr24723603pla.40.1562591041295;
        Mon, 08 Jul 2019 06:04:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm22941893pgs.39.2019.07.08.06.03.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 06:04:00 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:03:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190708130359.GA42888@google.com>
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708125013.GG26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning!

On Mon, Jul 08, 2019 at 05:50:13AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 08, 2019 at 03:00:09PM +0900, Byungchul Park wrote:
> > jiffies_till_sched_qs is useless if it's readonly as it is used to set
> > jiffies_to_sched_qs with its value regardless of first/next fqs jiffies.
> > And it should be applied immediately on change through sysfs.

It is interesting it can be setup at boot time, but not at runtime. I think
this can be mentioned in the change log that it is not really "read-only",
because it is something that can be dynamically changed as a kernel boot
parameter.

> Actually, the intent was to only allow this to be changed at boot time.
> Of course, if there is now a good reason to adjust it, it needs
> to be adjustable.  So what situation is making you want to change
> jiffies_till_sched_qs at runtime?  To what values is it proving useful
> to adjust it?  What (if any) relationships between this timeout and the
> various other RCU timeouts need to be maintained?  What changes to
> rcutorture should be applied in order to test the ability to change
> this at runtime?

I am also interested in the context, are you changing it at runtime for
experimentation? I recently was doing some performance experiments and it is
quite interesting how reducing this value can shorten grace period times :)

Joel


> 							Thanx, Paul
> 
> > The function for setting jiffies_to_sched_qs,
> > adjust_jiffies_till_sched_qs() will be called only if
> > the value from sysfs != ULONG_MAX. And the value won't be adjusted
> > unlike first/next fqs jiffies.
> > 
> > While at it, changed the positions of two module_param()s downward.
> > 
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > ---
> >  kernel/rcu/tree.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a2f8ba2..a28e2fe 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -422,9 +422,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> >   * quiescent-state help from rcu_note_context_switch().
> >   */
> >  static ulong jiffies_till_sched_qs = ULONG_MAX;
> > -module_param(jiffies_till_sched_qs, ulong, 0444);
> >  static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
> > -module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> >  
> >  /*
> >   * Make sure that we give the grace-period kthread time to detect any
> > @@ -450,6 +448,18 @@ static void adjust_jiffies_till_sched_qs(void)
> >  	WRITE_ONCE(jiffies_to_sched_qs, j);
> >  }
> >  
> > +static int param_set_sched_qs_jiffies(const char *val, const struct kernel_param *kp)
> > +{
> > +	ulong j;
> > +	int ret = kstrtoul(val, 0, &j);
> > +
> > +	if (!ret && j != ULONG_MAX) {
> > +		WRITE_ONCE(*(ulong *)kp->arg, j);
> > +		adjust_jiffies_till_sched_qs();
> > +	}
> > +	return ret;
> > +}
> > +
> >  static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> >  {
> >  	ulong j;
> > @@ -474,6 +484,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> >  	return ret;
> >  }
> >  
> > +static struct kernel_param_ops sched_qs_jiffies_ops = {
> > +	.set = param_set_sched_qs_jiffies,
> > +	.get = param_get_ulong,
> > +};
> > +
> >  static struct kernel_param_ops first_fqs_jiffies_ops = {
> >  	.set = param_set_first_fqs_jiffies,
> >  	.get = param_get_ulong,
> > @@ -484,8 +499,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> >  	.get = param_get_ulong,
> >  };
> >  
> > +module_param_cb(jiffies_till_sched_qs, &sched_qs_jiffies_ops, &jiffies_till_sched_qs, 0644);
> >  module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
> >  module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
> > +
> > +module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> >  module_param(rcu_kick_kthreads, bool, 0644);
> >  
> >  static void force_qs_rnp(int (*f)(struct rcu_data *rdp));
> > -- 
> > 1.9.1
> > 
> 
