Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C415FC74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9444720872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aP9fcROT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfGKQsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 12:48:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45812 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfGKQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:48:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so3199550pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xGECtkxoUl4GOrQ26ziP7oyhzIusONlIIryVdBod/QY=;
        b=aP9fcROTjiN2IJfZmZzuBsGM12I3H6tFUrBAikEAZD21lCz8X+LiytHDBh/mpGPyU1
         DYD7l+zGbwfNjH1LWVsnzCtOktcGQY0aa/L6ThmxelmZWECGMeYrtg1KPDGwSyN57hvK
         4rJzpxCfo1sKkL6yO/igmXezYRgUUUV3x/WJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xGECtkxoUl4GOrQ26ziP7oyhzIusONlIIryVdBod/QY=;
        b=Da6g6GNU4OFXVstqVrUd6gE315zDnePpRNde2Xsu8cEbJEjJOd2dXdHFYyDeUnLd/D
         i75gPZm0iEWQl+cEFXSClifuNtYVvacL4Itpkyh8nibrSqnGPLgRmZ143CIfa/W+kfeA
         lACd/LIWCbAhkLJfLwkQTK3po2AiaeoHzIhqIjToJOccg9uv0g/6b2IMqEfxR/wrqZQY
         y9cMgM4GCDRJ/w61Xsh5P4b4C3tS7fUHkZv9LPe1fuSZKlkUSegn5I9caXrq0sjGEk6v
         BpZSgdXOzBNIZy1KxSyPGuBa3xccPl23CXqqwjFWQLAKv0QS25MjP9BoVEwcfPbkBK0s
         MAEw==
X-Gm-Message-State: APjAAAX/yC8uUVwJLmCtA7v5t0kanuRUGI/c+MvkVALnsXnNRrPNZA+m
        +R6ziC2WF8i1MF7g39VRuVQ=
X-Google-Smtp-Source: APXvYqwUayYFk+vYQj4MfgAHgKfLDmrapBpSYpci6eIAhb/mQGIGFfzpo7naCLfbNiVx3UakhW2cWw==
X-Received: by 2002:a17:90a:b312:: with SMTP id d18mr5765234pjr.35.1562863700566;
        Thu, 11 Jul 2019 09:48:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i7sm4998289pjk.24.2019.07.11.09.48.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:48:19 -0700 (PDT)
Date:   Thu, 11 Jul 2019 12:48:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190711164818.GA260447@google.com>
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711150215.GK26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 08:02:15AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 11, 2019 at 09:08:49AM -0400, Joel Fernandes wrote:
> > On Thu, Jul 11, 2019 at 05:30:52AM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 10, 2019 at 10:20:25AM +0900, Byungchul Park wrote:
> > > > On Tue, Jul 09, 2019 at 05:41:02AM -0700, Paul E. McKenney wrote:
> > > > > > Hi Paul,
> > > > > > 
> > > > > > IMHO, as much as we want to tune the time for fqs to be initiated, we
> > > > > > can also want to tune the time for the help from scheduler to start.
> > > > > > I thought only difference between them is a level of urgency. I might be
> > > > > > wrong. It would be appreciated if you let me know if I miss something.
> > > > > 
> > > > > Hello, Byungchul,
> > > > > 
> > > > > I understand that one hypothetically might want to tune this at runtime,
> > > > > but have you had need to tune this at runtime on a real production
> > > > > workload?  If so, what problem was happening that caused you to want to
> > > > > do this tuning?
> > > > 
> > > > Not actually.
> > > > 
> > > > > > And it's ok even if the patch is turned down based on your criteria. :)
> > > > > 
> > > > > If there is a real need, something needs to be provided to meet that
> > > > > need.  But in the absence of a real need, past experience has shown
> > > > > that speculative tuning knobs usually do more harm than good.  ;-)
> > > > 
> > > > It makes sense, "A speculative tuning knobs do more harm than good".
> > > > 
> > > > Then, it would be better to leave jiffies_till_{first,next}_fqs tunnable
> > > > but jiffies_till_sched_qs until we need it.
> > > > 
> > > > However,
> > > > 
> > > > (1) In case that jiffies_till_sched_qs is tunnable:
> > > > 
> > > > 	We might need all of jiffies_till_{first,next}_qs,
> > > > 	jiffies_till_sched_qs and jiffies_to_sched_qs because
> > > > 	jiffies_to_sched_qs can be affected by any of them. So we
> > > > 	should be able to read each value at any time.
> > > > 
> > > > (2) In case that jiffies_till_sched_qs is not tunnable:
> > > > 
> > > > 	I think we don't have to keep the jiffies_till_sched_qs any
> > > > 	longer since that's only for setting jiffies_to_sched_qs at
> > > > 	*booting time*, which can be done with jiffies_to_sched_qs too.
> > > > 	It's meaningless to keep all of tree variables.
> > > > 
> > > > The simpler and less knobs that we really need we have, the better.
> > > > 
> > > > what do you think about it?
> > > > 
> > > > In the following patch, I (1) removed jiffies_till_sched_qs and then
> > > > (2) renamed jiffies_*to*_sched_qs to jiffies_*till*_sched_qs because I
> > > > think jiffies_till_sched_qs is a much better name for the purpose. I
> > > > will resend it with a commit msg after knowing your opinion on it.
> > > 
> > > I will give you a definite "maybe".
> > > 
> > > Here are the two reasons for changing RCU's embarrassingly large array
> > > of tuning parameters:
> > > 
> > > 1.	They are causing a problem in production.  This would represent a
> > > 	bug that clearly must be fixed.  As you say, this change is not
> > > 	in this category.
> > > 
> > > 2.	The change simplifies either RCU's code or the process of tuning
> > > 	RCU, but without degrading RCU's ability to run everywhere and
> > > 	without removing debugging tools.
> > > 
> > > The change below clearly simplifies things by removing a few lines of
> > > code, and it does not change RCU's default self-configuration.  But are
> > > we sure about the debugging aspect?  (Please keep in mind that many more
> > > sites are willing to change boot parameters than are willing to patch
> > > their kernels.)
> > > 
> > > What do you think?
> > 
> > Just to add that independent of whether the runtime tunable make sense or
> > not, may be it is still worth correcting the 0444 to be 0644 to be a separate
> > patch?
> 
> You lost me on this one.  Doesn't changing from 0444 to 0644 make it be
> a runtime tunable?

I was going by our earlier discussion that the parameter is still writable at
boot time. You mentioned something like the following:
---
In Byungchul's defense, the current module_param() permissions are
0444, which really is read-only.  Although I do agree that they can
be written at boot, one could use this same line of reasoning to argue
that const variables can be written at compile time (or, for on-stack
const variables, at function-invocation time).  But we still call them
"const".
---

Sorry if I got confused. You are right that we could leave it as read-only.

> > > Finally, I urge you to join with Joel Fernandes and go through these
> > > grace-period-duration tuning parameters.  Once you guys get your heads
> > > completely around all of them and how they interact across the different
> > > possible RCU configurations, I bet that the two of you will have excellent
> > > ideas for improvement.
> >
> > Yes, I am quite happy to join forces. Byungchul, let me know what about this
> > or other things you had in mind. I have some other RCU topics too I am trying
> > to get my head around and planning to work on more patches.
> >
> > Paul, in case you had any other specific tunables or experiments in mind, let
> > me know. I am quite happy to try out new experiments and learn something
> > based on tuning something.
>
> These would be the tunables controlling how quickly RCU takes its
> various actions to encourage the current grace period to end quickly.
> I would be happy to give you the exact list if you wish, but most of
> them have appeared in this thread.
>
> The experiments should be designed to work out whether the current
> default settings have configurations where they act badly.  This might
> also come up with advice for people attempting hand-tuning, or proposed
> parameter-checking code to avoid bad combinations.
>
> For one example, setting the RCU CPU stall timeout too low will definitely
> cause some unwanted splats.  (Yes, one could argue that other things in
> the kernel should change to allow this value to decrease, but things
> like latency tracer and friends are probably more useful and important.)

Ok, thank you for the hints. I will try to poke around with these as well. I
am currently also thinking of spending my time on RCU with reviving the list
API patches:
https://lore.kernel.org/patchwork/project/lkml/list/?series=396464

I noticed the occasional splat even with my preempt-disable test. But that
was just when trace dumping was interfering which we discussed at length last
week.

- Joel

