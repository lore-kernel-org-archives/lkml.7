Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC65C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A3A217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nRZjXbIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfCONqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:46:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37002 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfCONqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:46:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so5506181qkk.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myuJuMT8jXulyiohD4TOazdut0wSNPVRVo1COeLFqD0=;
        b=nRZjXbIZxOJXSI2M0xN3gE/1UHXY1nMEZfpnK6KxjCghOKotiBhhMVk5yqncaYTyGb
         S3b6OioMXSIWSfwWD8Mz9munhWqRYikg6+WuZcX+j8po92el8mkpHLHmupAnxjX1hSA9
         JDrZDpDiobMoBoLivxs5q7iXAkCvFRWuOUToI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myuJuMT8jXulyiohD4TOazdut0wSNPVRVo1COeLFqD0=;
        b=OW66eWU5G5hg+mysn/0Ukcfys4uBuw4KXkL6oQJSg6ibzqaWu6mNH/b0wNWu/qFkpV
         OFOxg3rQ7m9yfiis9D0dMjrK9y5lxEfSu1Ni0xV5X+sk3nLqIDcRXyXHlFVTWTgc12Zr
         DXHf6zoho1PpLSfACMnKDO0Le0VbB6TYdapF4LlDjfWd1I9a5W8rTX7eUPswfbCLchgP
         wNT93cxxfCsh1D6B7mobFJeNri0YJguXTLWuvG5sD5b8rgtWt6vcToerkvdaP9UaBrjy
         4rqh8ngURwLi95csRQfNYSnYO0OR3YW+70gdd/hgr2GA2k9MYvdZC/PzruHgbrydD4xV
         bUuQ==
X-Gm-Message-State: APjAAAWLegS79t9dHxHz40Xt77NMxL2NNJdT0WIs2rd2z85fxBEOAO/e
        CKngSjvsw0emhyyHG2Yq3iLeJQ==
X-Google-Smtp-Source: APXvYqw9MVQPgk5tRQnlFtZLK4Jy2ItxEuYPtKoLDPi4+IgRfN1ouODbbMDdwfRG2l7jDSm183JMpA==
X-Received: by 2002:a37:bd81:: with SMTP id n123mr2819816qkf.249.1552657581979;
        Fri, 15 Mar 2019 06:46:21 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d51sm1452962qta.31.2019.03.15.06.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 06:46:20 -0700 (PDT)
Date:   Fri, 15 Mar 2019 09:46:20 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        rostedt@goodmis.org, luto@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH tip/core/rcu 06/19] rcu: Add warning to detect
 half-interrupts
Message-ID: <20190315134620.GE3378@google.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-6-paulmck@linux.vnet.ibm.com>
 <20190311133939.GA29747@google.com>
 <20190315073138.GB15148@X58A-UD3R>
 <eea72fb5-c25d-746a-fa48-6d04c8d5d1af@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea72fb5-c25d-746a-fa48-6d04c8d5d1af@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 04:44:52PM +0900, Byungchul Park wrote:
> On 03/15/2019 04:31 PM, Byungchul Park wrote:
> > On Mon, Mar 11, 2019 at 09:39:39AM -0400, Joel Fernandes wrote:
> > > On Wed, Aug 29, 2018 at 03:20:34PM -0700, Paul E. McKenney wrote:
> > > > RCU's dyntick-idle code is written to tolerate half-interrupts, that it,
> > > > either an interrupt that invokes rcu_irq_enter() but never invokes the
> > > > corresponding rcu_irq_exit() on the one hand, or an interrupt that never
> > > > invokes rcu_irq_enter() but does invoke the "corresponding" rcu_irq_exit()
> > > > on the other.  These things really did happen at one time, as evidenced
> > > > by this ca-2011 LKML post:
> > > > 
> > > > http://lkml.kernel.org/r/20111014170019.GE2428@linux.vnet.ibm.com
> > > > 
> > > > The reason why RCU tolerates half-interrupts is that usermode helpers
> > > > used exceptions to invoke a system call from within the kernel such that
> > > > the system call did a normal return (not a return from exception) to
> > > > the calling context.  This caused rcu_irq_enter() to be invoked without
> > > > a matching rcu_irq_exit().  However, usermode helpers have since been
> > > > rewritten to make much more housebroken use of workqueues, kernel threads,
> > > > and do_execve(), and therefore should no longer produce half-interrupts.
> > > > No one knows of any other source of half-interrupts, but then again,
> > > > no one seems insane enough to go audit the entire kernel to verify that
> > > > half-interrupts really are a relic of the past.
> > > > 
> > > > This commit therefore adds a pair of WARN_ON_ONCE() calls that will
> > > > trigger in the presence of half interrupts, which the code will continue
> > > > to handle correctly.  If neither of these WARN_ON_ONCE() trigger by
> > > > mid-2021, then perhaps RCU can stop handling half-interrupts, which
> > > > would be a considerable simplification.
> > > Hi Paul and everyone,
> > > I was thinking some more about this patch and whether we can simplify this code
> > > much in 2021. Since 2021 is a bit far away, I thought working on it in again to
> > > keep it fresh in memory is a good idea ;-)
> > > 
> > > To me it seems we cannot easily combine the counters (dynticks_nesting and
> > > dynticks_nmi_nesting) even if we confirmed that there is no possibility of a
> > > half-interrupt scenario (assuming simplication means counter combining like
> > > Byungchul tried to do in https://goo.gl/X1U77X). The reason is because these
> > > 2 counters need to be tracked separately as they are used differently in the
> > > following function:
> > Hi Joel and Paul,
> > 
> > I always love the way to logically approach problems so I'm a fan of
> > all your works :) But I'm JUST curious about something here. Why can't
> > we combine them the way I tried even if we confirm no possibility of
> > half-interrupt? IMHO, the only thing we want to know through calling
> > rcu_is_cpu_rrupt_from_idle() is whether the interrupt comes from
> > RCU-idle or not - of course assuming the caller context always be an
> > well-defined interrupt context like e.g. the tick handler.
> > 
> > So the function can return true if the caller is within a RCU-idle
> > region except a well-known single interrupt nested.
> > 
> > Of course, now that we cannot confirm it yet, the crowbar is necessary.
> > But does it still have a problem even after confirming it? Why? What am
> > I missing? Could you explain why for me? :(
> 
> 
> Did you also want to consider the case the function is called from others
> than
> well-known interrupt contexts? If yes, then I agree with you, there doesn't
> seem to be the kind of code and it's not a good idea to let the function be
> called generally though.

We were discussing exactly this on the thread. I am going to be adding a
lockdep check to make sure the function isn't called from anywhere but an
interrupt context. Then once we can confirm that there are no more
half-interrupts in the future, we can apply your counter combining approach.

Based on the comments on the rrupt_from_idle() function, it wasn't clear to
me if the function was intended to be called from any context. That's why I
thought the counter combing approach would not work, but you are right - it
should work.

I will CC you on the lockdep check patch. Also hope you are subscribed to
the new shiny rcu@vger.kernel.org list as well :-)

thanks,

 - Joel

