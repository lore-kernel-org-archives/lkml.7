Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DF0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43A82075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCDMZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:25:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:46781 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfCDMZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:25:01 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x24CNZlQ031671;
        Mon, 4 Mar 2019 06:23:35 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x24CNWqJ031670;
        Mon, 4 Mar 2019 06:23:32 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 4 Mar 2019 06:23:32 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>,
        Steve Capper <Steve.Capper@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bin Lu (Arm Technology China)" <Bin.Lu@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/6] ptrace: introduce ptrace_syscall_enter to consolidate PTRACE_SYSEMU handling
Message-ID: <20190304122331.GG3969@gate.crashing.org>
References: <20190228183220.15626-1-sudeep.holla@arm.com> <20190228183220.15626-3-sudeep.holla@arm.com> <f3441e63-c54d-3b9d-2919-8a3955cbee69@arm.com> <20190304104643.GA28643@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304104643.GA28643@e107155-lin>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:46:43AM +0000, Sudeep Holla wrote:
> On Mon, Mar 04, 2019 at 08:03:47AM +0000, Haibo Xu (Arm Technology China) wrote:
> > On 2019/3/1 2:32, Sudeep Holla wrote:
> > > +long ptrace_syscall_enter(struct pt_regs *regs)
> > > +{
> > > +#ifdef TIF_SYSCALL_EMU
> > > +	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> > > +		if (tracehook_report_syscall_entry(regs));
> > 
> > Shall we remove the semi-colon at end of the above line?
> 
> Added intentionally to keep GCC happy.

GCC warns because the user explicitly asked for it, with __must_check.
If you want to do things with an "if" like this, you should write e.g.

		if (tracehook_report_syscall_entry(regs))
			/*
			 * We can ignore the return code here, because of
			 * X and Y and Z.
			 */
			;

Or it probably is nicer to use a block:

		if (tracehook_report_syscall_entry(regs)) {
			/*
			 * We can ignore the return code here, because of
			 * X and Y and Z.
			 */
		}

The point is, you *always* should have a nice fat comment if you are
ignoring the return code of a __must_check function.


Segher
