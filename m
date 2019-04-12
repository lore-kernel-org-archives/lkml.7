Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77D4C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798DD20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555052951;
	bh=Pf7+gyZ39c+PkXV9tRRywJTmbZCMqUbyk11byT/AgBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tjy0HF5bTYYkpEYkIiSYfULvO6OTPXgsHRnXOBNyju0mN8MZZIMlCtj67LCn3OF8i
	 KJBxiZzubiXRQQtCZZfXVqBu5gPMDEcDSCqSBM3ViufmqOROZIIeCWrYsLWL6Ppjmd
	 8oOR9MPS3zQ83W+f3y+D00bmHBrAVfYvMPNqKSmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDLHJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:09:10 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40393 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLHJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:09:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id z24so9707340wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IifnkIML+lEP3xBwXwpR4+htxzzJUPsgjJqPal9qDO4=;
        b=J/eGh4oM1tIwSzI3lSRHfF5nQgLOet//9u1mRp5SsHUZ19gBSi4UCIY9ma3wGiuLLq
         Lqkgrv6fJHsRrVzhA3hzUr4eV19w8NKm/TQRP8Bg7TEYNUnb0rXri0HwNflNh5nvfevU
         ZXEmFyd1Qv0zre03QIJXhjKjVuPbOfW+0l42a5LQvNHAZnReKL7wGLDCGrQyPY1dlG/6
         XYc1gFcCW7iYpPrCGm/NRiUiFpA3o8vq2oSyRS7QQ1DussTRFV71ddJBMRECNBfZvoPB
         avIF63wI5TRwRbeibTQ47nCa0OHOTfUn4RdRQKc8tZ867K7k22Mm5ZA+ezKYX8T1FJhC
         HDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IifnkIML+lEP3xBwXwpR4+htxzzJUPsgjJqPal9qDO4=;
        b=EA3PCixc6vBG+5qUUzwUfjXQkw86U6qD+5fhBAvmaT81pyaPBPgNbFZiw38eLOi2ch
         Rj2hWkc693f0elYO2Dm7583OV0vHk99KIM9MmitpXMeuexr1fHORY7gzIGu6ryB2JYwH
         ZT+xM6yQ/LuxSY07kbgok1C2IrwtoDcF8UFzOePLeHE9sim4edXUbCMENfuPSXoe6EOZ
         s4XU+1VJbBWoPEOO/JVEew6JB8sqY9SDvD7mWS/zv0RQR+VDcY2EvleG3aWbEHGv726V
         v5IHR6l5ChHWbBvAixI8jr6T8W0uWFoxoxUwzsEpOYcdNM1Arv+FXzEWiIBc/XC6Xsz7
         jlIA==
X-Gm-Message-State: APjAAAWWhhKxahPUnA1lu74eTwPieUHHqNisk0B2SYhS7t/FyAITtJHa
        PjT9JuGQxJpcoJiFx2PfYI4=
X-Google-Smtp-Source: APXvYqwLgPmdbKpWIIH6yI1lqbhGeDlUMscaheYNgDKGugnEvF/l3YeS9D57BJCofH6FWle2LMra0Q==
X-Received: by 2002:a1c:a64d:: with SMTP id p74mr10214283wme.89.1555052947782;
        Fri, 12 Apr 2019 00:09:07 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g10sm33326723wrq.2.2019.04.12.00.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 00:09:06 -0700 (PDT)
Date:   Fri, 12 Apr 2019 09:09:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v3 02/14] locking/rwsem: Make owner available even if
 !CONFIG_RWSEM_SPIN_ON_OWNER
Message-ID: <20190412070904.GA45214@gmail.com>
References: <20190410184231.6748-1-longman@redhat.com>
 <20190410184231.6748-3-longman@redhat.com>
 <20190411081224.GB4038@hirez.programming.kicks-ass.net>
 <29aca54a-536e-6e46-7e18-658914c34548@redhat.com>
 <20190412070209.GC129493@gmail.com>
 <20190412070545.GF11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412070545.GF11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Apr 12, 2019 at 09:02:09AM +0200, Ingo Molnar wrote:
> > 
> > * Waiman Long <longman@redhat.com> wrote:
> > 
> > > On 04/11/2019 04:12 AM, Peter Zijlstra wrote:
> > > > On Wed, Apr 10, 2019 at 02:42:19PM -0400, Waiman Long wrote:
> > > >> The owner field in the rw_semaphore structure is used primarily for
> > > >> optimistic spinning. However, identifying the rwsem owner can also be
> > > >> helpful in debugging as well as tracing locking related issues when
> > > >> analyzing crash dump. The owner field may also store state information
> > > >> that can be important to the operation of the rwsem.
> > > >>
> > > >> So the owner field is now made a permanent member of the rw_semaphore
> > > >> structure irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.
> > > > sem->owner is still initialized under CONFIG_RWSEM_SPIN_ON_OWNER.
> > > 
> > > Oh, you are right. I missed that part. I will fix it in the next version.
> > 
> > Could you please post the next series against tip:WIP.locking/core, which 
> > is already being dogfood-ed in -tip and which I'm running on my desktop? 
> > I'll backmerge any fixes as needed/requested.
> 
> Urgh, please no, that's going to be hell to review :/

Ok - full patches then. I'll handle the fallout.

Thanks,

	Ingo
