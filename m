Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89317C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E6B208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q+taS8xQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfGKT6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:58:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45535 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfGKT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:58:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so3558919plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ht9JIkdKnsND0qRfdxvtr9JOrmvYFxMRa0bAr2nWrT8=;
        b=q+taS8xQftTPcsu718h0VpXS4k0nrAc3iWEcqUf6v5fSr4dJ2XXxIsWOSkx3b8ISS4
         UR+u0ZqbrLa6iN+GGEqoRwP/jIexCCBuYa9mZAe0NN4UuwiqJct5pSFqdU/72RZM//M4
         PDD9mnKb7UVUZWH5yvsRk0b6AwObX0/b8yxV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ht9JIkdKnsND0qRfdxvtr9JOrmvYFxMRa0bAr2nWrT8=;
        b=X63tmWLMDG5vj1uBqrOyqn0Bt3saK03u+fSnH1X0w+uSHMyOJNBwD1OP3p7V2bTXf5
         ZjJ9MpaVKWBgZorX6wh6TzJAqpmDHdtveK5daPW0ESqwu7TKh/eHexX7BYAiyzx+JbKQ
         Hpt0CN5IFuOVVnU3mRDonLLrbWjEYN06A6UmnxLESEpODglqSs+nbqdjtk8Rx3WxxQx8
         +JloNhyR/oR46B9YTmKs4+ohaHPKTDjwPbInb9pgW3gtAfKs8GSy5tlTMmUK7xIaJFD+
         /vuZ2NcRSrEJCflI3XfX2U2TdaQ2O3E7w3a9gieQwkOitxCjt5yAARjj0g4hdFXrRaRZ
         Wlew==
X-Gm-Message-State: APjAAAW3GxAv76IVzgBr2onJ6HCeZNlvLRyGWXRNn4sn5KR0Y9aNv+r7
        Ju4tqDUJmvslze7miDtEpzg=
X-Google-Smtp-Source: APXvYqwGHjCIXofIQD1MYuS6DMYCoGyPvFzy/BnOMEeKNsXK91RwKc4AOWUpMANIiyqd0XHBR+arvw==
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr6700269ple.192.1562875122087;
        Thu, 11 Jul 2019 12:58:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q144sm6337161pfc.103.2019.07.11.12.58.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 12:58:41 -0700 (PDT)
Date:   Thu, 11 Jul 2019 15:58:39 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190711195839.GA163275@google.com>
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711164818.GA260447@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 12:48:18PM -0400, Joel Fernandes wrote:
> On Thu, Jul 11, 2019 at 08:02:15AM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 11, 2019 at 09:08:49AM -0400, Joel Fernandes wrote:
> > > On Thu, Jul 11, 2019 at 05:30:52AM -0700, Paul E. McKenney wrote:
> > > > On Wed, Jul 10, 2019 at 10:20:25AM +0900, Byungchul Park wrote:
> > > > > On Tue, Jul 09, 2019 at 05:41:02AM -0700, Paul E. McKenney wrote:
> > > > > > > Hi Paul,
> > > > > > > 
> > > > > > > IMHO, as much as we want to tune the time for fqs to be initiated, we
> > > > > > > can also want to tune the time for the help from scheduler to start.
> > > > > > > I thought only difference between them is a level of urgency. I might be
> > > > > > > wrong. It would be appreciated if you let me know if I miss something.
> > > > > > 
> > > > > > Hello, Byungchul,
> > > > > > 
> > > > > > I understand that one hypothetically might want to tune this at runtime,
> > > > > > but have you had need to tune this at runtime on a real production
> > > > > > workload?  If so, what problem was happening that caused you to want to
> > > > > > do this tuning?
> > > > > 
> > > > > Not actually.
> > > > > 
> > > > > > > And it's ok even if the patch is turned down based on your criteria. :)
> > > > > > 
> > > > > > If there is a real need, something needs to be provided to meet that
> > > > > > need.  But in the absence of a real need, past experience has shown
> > > > > > that speculative tuning knobs usually do more harm than good.  ;-)
> > > > > 
> > > > > It makes sense, "A speculative tuning knobs do more harm than good".
> > > > > 
> > > > > Then, it would be better to leave jiffies_till_{first,next}_fqs tunnable
> > > > > but jiffies_till_sched_qs until we need it.
> > > > > 
> > > > > However,
> > > > > 
> > > > > (1) In case that jiffies_till_sched_qs is tunnable:
> > > > > 
> > > > > 	We might need all of jiffies_till_{first,next}_qs,
> > > > > 	jiffies_till_sched_qs and jiffies_to_sched_qs because
> > > > > 	jiffies_to_sched_qs can be affected by any of them. So we
> > > > > 	should be able to read each value at any time.
> > > > > 
> > > > > (2) In case that jiffies_till_sched_qs is not tunnable:
> > > > > 
> > > > > 	I think we don't have to keep the jiffies_till_sched_qs any
> > > > > 	longer since that's only for setting jiffies_to_sched_qs at
> > > > > 	*booting time*, which can be done with jiffies_to_sched_qs too.
> > > > > 	It's meaningless to keep all of tree variables.
> > > > > 
> > > > > The simpler and less knobs that we really need we have, the better.
> > > > > 
> > > > > what do you think about it?
> > > > > 
> > > > > In the following patch, I (1) removed jiffies_till_sched_qs and then
> > > > > (2) renamed jiffies_*to*_sched_qs to jiffies_*till*_sched_qs because I
> > > > > think jiffies_till_sched_qs is a much better name for the purpose. I
> > > > > will resend it with a commit msg after knowing your opinion on it.
> > > > 
> > > > I will give you a definite "maybe".
> > > > 
> > > > Here are the two reasons for changing RCU's embarrassingly large array
> > > > of tuning parameters:
> > > > 
> > > > 1.	They are causing a problem in production.  This would represent a
> > > > 	bug that clearly must be fixed.  As you say, this change is not
> > > > 	in this category.
> > > > 
> > > > 2.	The change simplifies either RCU's code or the process of tuning
> > > > 	RCU, but without degrading RCU's ability to run everywhere and
> > > > 	without removing debugging tools.
> > > > 
> > > > The change below clearly simplifies things by removing a few lines of
> > > > code, and it does not change RCU's default self-configuration.  But are
> > > > we sure about the debugging aspect?  (Please keep in mind that many more
> > > > sites are willing to change boot parameters than are willing to patch
> > > > their kernels.)
> > > > 
> > > > What do you think?
> > > 
> > > Just to add that independent of whether the runtime tunable make sense or
> > > not, may be it is still worth correcting the 0444 to be 0644 to be a separate
> > > patch?
> > 
> > You lost me on this one.  Doesn't changing from 0444 to 0644 make it be
> > a runtime tunable?
> 
> I was going by our earlier discussion that the parameter is still writable at
> boot time. You mentioned something like the following:
> ---
> In Byungchul's defense, the current module_param() permissions are
> 0444, which really is read-only.  Although I do agree that they can
> be written at boot, one could use this same line of reasoning to argue
> that const variables can be written at compile time (or, for on-stack
> const variables, at function-invocation time).  But we still call them
> "const".
> ---
> 
> Sorry if I got confused. You are right that we could leave it as read-only.
> 
> > > > Finally, I urge you to join with Joel Fernandes and go through these
> > > > grace-period-duration tuning parameters.  Once you guys get your heads
> > > > completely around all of them and how they interact across the different
> > > > possible RCU configurations, I bet that the two of you will have excellent
> > > > ideas for improvement.
> > >
> > > Yes, I am quite happy to join forces. Byungchul, let me know what about this
> > > or other things you had in mind. I have some other RCU topics too I am trying
> > > to get my head around and planning to work on more patches.
> > >
> > > Paul, in case you had any other specific tunables or experiments in mind, let
> > > me know. I am quite happy to try out new experiments and learn something
> > > based on tuning something.
> >
> > These would be the tunables controlling how quickly RCU takes its
> > various actions to encourage the current grace period to end quickly.
> > I would be happy to give you the exact list if you wish, but most of
> > them have appeared in this thread.
> >
> > The experiments should be designed to work out whether the current
> > default settings have configurations where they act badly.  This might
> > also come up with advice for people attempting hand-tuning, or proposed
> > parameter-checking code to avoid bad combinations.
> >
> > For one example, setting the RCU CPU stall timeout too low will definitely
> > cause some unwanted splats.  (Yes, one could argue that other things in
> > the kernel should change to allow this value to decrease, but things
> > like latency tracer and friends are probably more useful and important.)
> 
> Ok, thank you for the hints. 

Hmm, speaking of grace period durations, it seems to me the maximum grace
period ever is recorded in rcu_state.gp_max. However it is not read from
anywhere.

Any idea why it was added but not used?

I am interested in dumping this value just for fun, and seeing what I get.

I wonder also it is useful to dump it in rcutorture/rcuperf to find any
issues, or even expose it in sys/proc fs to see what worst case grace periods
look like.

 - Joel

