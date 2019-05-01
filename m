Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50E1C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B007120644
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfEAQv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:51:58 -0400
Received: from foss.arm.com ([217.140.101.70]:33974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfEAQv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:51:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48B2880D;
        Wed,  1 May 2019 09:51:57 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35DD13F719;
        Wed,  1 May 2019 09:51:54 -0700 (PDT)
Date:   Wed, 1 May 2019 17:51:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Message-ID: <20190501165151.GB12498@e107155-lin>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-4-sudeep.holla@arm.com>
 <20190318153321.GA23521@redhat.com>
 <20190430164413.GA18913@e107155-lin>
 <20190501155711.GB30235@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501155711.GB30235@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 05:57:11PM +0200, Oleg Nesterov wrote:
> On 04/30, Sudeep Holla wrote:
> >
> > On Mon, Mar 18, 2019 at 04:33:22PM +0100, Oleg Nesterov wrote:
> > >
> > > And it seems that _TIF_WORK_SYSCALL_ENTRY needs some cleanups too... We don't need
> > > "& _TIF_WORK_SYSCALL_ENTRY" in syscall_trace_enter, and _TIF_WORK_SYSCALL_ENTRY
> > > should not include _TIF_NOHZ?
> > >
> >
> > I was about to post the updated version and checked this to make sure I have
> > covered everything or not. I had missed the above comment. All architectures
> > have _TIF_NOHZ in their mask that they check to do work. And from x86, I read
> > "...syscall_trace_enter(). Also includes TIF_NOHZ for enter_from_user_mode()"
> > So I don't understand why _TIF_NOHZ needs to be dropped.
>
> I have already forgot this discussion... But after I glanced at this code again
> I still think the same, and I don't understand why do you disagree.
>

Sorry, but I didn't have any disagreement, I just said I don't understand
the usage on all architectures at that moment.

> > Also if we need to drop, we can address that separately examining all archs.
>
> Sure, and I was only talking about x86. We can keep TIF_NOHZ and even
> set_tsk_thread_flag(TIF_NOHZ) in context_tracking_cpu_set() if some arch needs
> this but remove TIF_NOHZ from TIF_WORK_SYSCALL_ENTRY in arch/x86/include/asm/thread_info.h,
> afaics this shouldn't make any difference.
>

OK, it's just x86, then I understand your point. I was looking at all
the architectures, sorry for the confusion.

> And I see no reason why x86 needs to use TIF_WORK_SYSCALL_ENTRY in
> syscall_trace_enter().
>

Agreed

--
Regards,
Sudeep
