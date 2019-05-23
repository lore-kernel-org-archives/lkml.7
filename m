Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC4DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC4C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfEWO6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:58:45 -0400
Received: from foss.arm.com ([217.140.101.70]:48230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730709AbfEWO6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:58:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78F4E80D;
        Thu, 23 May 2019 07:58:44 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6134F3F690;
        Thu, 23 May 2019 07:58:42 -0700 (PDT)
Date:   Thu, 23 May 2019 15:58:39 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] locking/lock_events: Use this_cpu_add() when necessary
Message-ID: <20190523145839.GB31896@fuggles.cambridge.arm.com>
References: <20190522153953.30341-1-longman@redhat.com>
 <CAHk-=wjit1=wf-JxUebS4_9WUCKbnfGPt0QF13-LijmumMEB-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjit1=wf-JxUebS4_9WUCKbnfGPt0QF13-LijmumMEB-Q@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:54:13PM -0700, Linus Torvalds wrote:
> On Wed, May 22, 2019 at 8:40 AM Waiman Long <longman@redhat.com> wrote:
> >
> > +#if defined(CONFIG_PREEMPT) && \
> > +   (defined(CONFIG_DEBUG_PREEMPT) || !defined(CONFIG_X86))
> > +#define lockevent_percpu_inc(x)                this_cpu_inc(x)
> > +#define lockevent_percpu_add(x, v)     this_cpu_add(x, v)
> 
> Why that CONFIG_X86 special case?
> 
> On x86, the regular non-underscore versionm is perfectly fine, and the
> underscore is no faster or simpler.
> 
> So just make it be
> 
>    #if defined(CONFIG_PREEMPT)
>      .. non-underscore versions..
>    #else
>      .. underscore versions ..
>    #endif
> 
> and realize that x86 simply doesn't _care_. On x86, it will be one
> single instruction regardless.
> 
> Non-x86 may prefer the underscore versions for the non-preempt case.

To be honest, given this depends on LOCK_EVENT_COUNTS, I'd be inclined to
keep things simple and drop the underscore versions entirely. Saves having
to worry about things like "could I take an interrupt during the add?".

Will
