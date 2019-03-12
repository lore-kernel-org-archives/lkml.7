Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A9920883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCLMJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:09:51 -0400
Received: from foss.arm.com ([217.140.101.70]:41326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLMJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:09:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3310374;
        Tue, 12 Mar 2019 05:09:49 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFA633F59C;
        Tue, 12 Mar 2019 05:09:46 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:09:44 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Message-ID: <20190312120944.GB13825@e107155-lin>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
 <20190304101205.GA1504@e107155-lin>
 <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com>
 <20190311183403.GA31062@e107155-lin>
 <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
 <CALCETrWiF5FKUTmt4jOZJxJr6B_66NFj9TaA3Tnv1uorfkwTMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWiF5FKUTmt4jOZJxJr6B_66NFj9TaA3Tnv1uorfkwTMg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 08:04:39PM -0700, Andy Lutomirski wrote:
> On Mon, Mar 11, 2019 at 6:35 PM Haibo Xu (Arm Technology China)
> <Haibo.Xu@arm.com> wrote:
> >

[...]

> > For the PTRACE_SYSEMU_SINGLESTEP request, ptrace only need to report(send
> > SIGTRAP) at the entry of a system call, no need to report at the exit of a
> > system call.That's why the old logic-{step = ((flags & (_TIF_SINGLESTEP |
> > _TIF_SYSCALL_EMU)) == _TIF_SINGLESTEP)} here try to filter out the special
> > case(PTRACE_SYSEMU_SINGLESTEP).
> >
> > Another way to make sure the logic is fine, you can run some tests with
> > respect to both logic, and to check whether they have the same behavior.
>
> tools/testing/selftests/x86/ptrace_syscall.c has a test intended to
> exercise this.  Can one of you either confirm that it does exercise it
> and that it still passes or can you improve the test?
>
I did run the tests which didn't flag anything. I haven't looked at the
details of test implementation, but seem to miss this case. I will see
what can be improved(if it's possible). Also I think single_step_syscall
is the one I need to look for this particular one. Both single_step_syscall
ptrace_syscall reported no errors.

--
Regards,
Sudeep
