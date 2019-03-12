Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05507C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA5F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCLMFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:05:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41218 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLMFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:05:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EB62374;
        Tue, 12 Mar 2019 05:05:38 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59EDC3F59C;
        Tue, 12 Mar 2019 05:05:35 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:05:29 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        Steve Capper <Steve.Capper@arm.com>,
        "Bin Lu (Arm Technology China)" <Bin.Lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Message-ID: <20190312120529.GA13825@e107155-lin>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
 <20190304101205.GA1504@e107155-lin>
 <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com>
 <20190311183403.GA31062@e107155-lin>
 <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 01:34:44AM +0000, Haibo Xu (Arm Technology China) wrote:
> On 2019/3/12 2:34, Sudeep Holla wrote:
> > (I thought I had sent this email, last Tuesday itself, but saw this in my
> > draft today, something went wrong, sorry for the delay)
> > 
> > On Tue, Mar 05, 2019 at 02:14:47AM +0000, Haibo Xu (Arm Technology China) wrote:
> >> On 2019/3/4 18:12, Sudeep Holla wrote:
> >>> On Mon, Mar 04, 2019 at 08:25:28AM +0000, Haibo Xu (Arm Technology China) wrote:
> >>>> On 2019/3/1 2:32, Sudeep Holla wrote:
> >>>>> Now that we have a new hook ptrace_syscall_enter that can be called from
> >>>>> syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> >>>>> can do some cleanup using the same in syscall_trace_enter.
> >>>>>
> >>>>> Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
> >>>>> in syscall_slow_exit_work seems unnecessary. Let's remove the same.
> >>>>
> >>>> I think we should not change the logic here. Is so, it will double the report of syscall
> >>>> when PTRACE_SYSEMU_SINGLESTEP is enabled.
> >>>>
> >>>
> >>> I don't think that should happen, but I may be missing something.
> >>> Can you explain how ?
> >>>
> >>
> >> When PTRACE_SYSEMU_SINGLESTEP is enabled, both the _TIF_SYSCALL_EMU and
> >> _TIF_SINGLESTEP flags are set, but ptrace only need to report(send SIGTRAP)
> >> at the entry of a system call, no need to report at the exit of a system
> >> call.
> >>
> > Sorry, but I still not get it, we have:
> > 
> > 	step = ((flags & (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)) == _TIF_SINGLESTEP);
> > 
> > For me, this is same as:
> > 	step = ((flags & _TIF_SINGLESTEP) == _TIF_SINGLESTEP)
> > 	or
> > 	if (flags & _TIF_SINGLESTEP)
> > 		step = true;
> > 
> 
> I don't think so! As I mentioned in the last email loop, when
> PTRACE_SYSEMU_SINGLESTE is enabled, both the _TIF_SYSCALL_EMU and
> _TIF_SINGLESTEP flags are set, in which case the step should be "false" for
> the old logic. But with the new logic, the step is "true".
> 

Ah right, sorry I missed that.

> > So when PTRACE_SYSEMU_SINGLESTEP, _TIF_SYSCALL_EMU and _TIF_SINGLESTEP
> > are set and step evaluates to true.
> > 
> > So dropping _TIF_SYSCALL_EMU here should be fine. Am I still missing
> > something ?
> > 
> > --
> > Regards,
> > Sudeep
> > 
> 
> For the PTRACE_SYSEMU_SINGLESTEP request, ptrace only need to report(send
> SIGTRAP) at the entry of a system call, no need to report at the exit of a
> system call.That's why the old logic-{step = ((flags & (_TIF_SINGLESTEP |
> _TIF_SYSCALL_EMU)) == _TIF_SINGLESTEP)} here try to filter out the special
> case(PTRACE_SYSEMU_SINGLESTEP).
> 

Understood

> Another way to make sure the logic is fine, you can run some tests with
> respect to both logic, and to check whether they have the same behavior.
>

I did run selftests after Andy Lutomirski pointed out. Nothing got flagged,
I haven't looked at the tests themselves yet, but it clearly misses this
case.

--
Regards,
Sudeep
