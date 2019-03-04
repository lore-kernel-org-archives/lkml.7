Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5519420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfCDKrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:47:14 -0500
Received: from foss.arm.com ([217.140.101.70]:59982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfCDKrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:47:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5DB9EBD;
        Mon,  4 Mar 2019 02:47:13 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 145873F703;
        Mon,  4 Mar 2019 02:47:10 -0800 (PST)
Date:   Mon, 4 Mar 2019 10:46:43 +0000
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
        "Bin Lu (Arm Technology China)" <Bin.Lu@arm.com>
Subject: Re: [PATCH 2/6] ptrace: introduce ptrace_syscall_enter to
 consolidate PTRACE_SYSEMU handling
Message-ID: <20190304104643.GA28643@e107155-lin>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-3-sudeep.holla@arm.com>
 <f3441e63-c54d-3b9d-2919-8a3955cbee69@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3441e63-c54d-3b9d-2919-8a3955cbee69@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 08:03:47AM +0000, Haibo Xu (Arm Technology China) wrote:
> On 2019/3/1 2:32, Sudeep Holla wrote:
> > Currently each architecture handles PTRACE_SYSEMU in very similar way.
> > It's completely arch independent and can be handled in the code helping
> > to consolidate PTRACE_SYSEMU handling.
> > 
> > Let's introduce a hook 'ptrace_syscall_enter' that arch specific syscall
> > entry code can call.
> > 
> 
> The 'ptrace_syscall_enter' is dedicated for PTRACE_SYSEMU flag,
> So I suggest to rename the function to something like 'ptrace_syscall_emu_enter".
> 

I am fine to rename.

> > +/*
> > + * Hook to check and report for PTRACE_SYSEMU, can be called from arch
> > + * arch syscall entry code
> > + */
> > +long ptrace_syscall_enter(struct pt_regs *regs)
> > +{
> > +#ifdef TIF_SYSCALL_EMU
> > +	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> > +		if (tracehook_report_syscall_entry(regs));
> 
> Shall we remove the semi-colon at end of the above line?
> 

Added intentionally to keep GCC happy.

--
Regards,
Sudeep
