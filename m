Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A11C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D2A205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfHNLcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:32:39 -0400
Received: from foss.arm.com ([217.140.110.172]:53170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfHNLch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:32:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F53F28;
        Wed, 14 Aug 2019 04:32:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B17ED3F706;
        Wed, 14 Aug 2019 04:32:34 -0700 (PDT)
Date:   Wed, 14 Aug 2019 12:32:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>, kan.liang@intel.com,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/9] sched/core: add is_kthread() helper
Message-ID: <20190814113232.GE17931@lakrids.cambridge.arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-2-mark.rutland@arm.com>
 <CAMuHMdV_hZ-uMmKdqEutLL5+XkhhcKdSaurMUS2N46AhZwDNKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV_hZ-uMmKdqEutLL5+XkhhcKdSaurMUS2N46AhZwDNKQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:26:43PM +0200, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Wed, Aug 14, 2019 at 12:43 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > Code checking whether a task is a kthread isn't very consistent. Some
> > code correctly tests task->flags & PF_THREAD, while other code checks
> > task->mm (which can be true for a kthread which calls use_mm()).
> >
> > So that we can clean this up and keep the code easy to follow, let's add
> > an obvious helper function to test whether a task is a kthread.
> > Subsequent patches will use this as part of cleaning up and correcting
> > open-coded tests.
> >
> > At the same time, let's fix up the kerneldoc for is_idle_task() for
> > consistency with the new helper, using true/false rather than 0/1, given
> > the functions return bool.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks for your patch!
> 
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1621,13 +1621,24 @@ extern struct task_struct *idle_task(int cpu);
> >   * is_idle_task - is the specified task an idle task?
> >   * @p: the task in question.
> >   *
> > - * Return: 1 if @p is an idle task. 0 otherwise.
> > + * Return: true if @p is an idle task, false otherwise.
> >   */
> >  static inline bool is_idle_task(const struct task_struct *p)
> >  {
> >         return !!(p->flags & PF_IDLE);
> >  }
> >
> > +/**
> > + * is_kthread - is the specified task a kthread
> > + * @p: the task in question.
> > + *
> > + * Return: true if @p is a kthread, false otherwise.
> > + */
> > +static inline bool is_kthread(const struct task_struct *p)
> > +{
> > +       return !!(p->flags & PF_KTHREAD);
> 
> The !! is not really needed.
> Probably you followed is_idle_task() above (where it's also not needed).

Indeed! I'm aware of the implicit bool conversion, but kept that for
consistency.

Peter, Ingo, do you have a preference?

Thanks,
Mark.
