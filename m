Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C966C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418E620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfCDKMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:12:15 -0500
Received: from foss.arm.com ([217.140.101.70]:59284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfCDKMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:12:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0895EBD;
        Mon,  4 Mar 2019 02:12:14 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89FE63F703;
        Mon,  4 Mar 2019 02:12:11 -0800 (PST)
Date:   Mon, 4 Mar 2019 10:12:05 +0000
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Message-ID: <20190304101205.GA1504@e107155-lin>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 08:25:28AM +0000, Haibo Xu (Arm Technology China) wrote:
> On 2019/3/1 2:32, Sudeep Holla wrote:
> > Now that we have a new hook ptrace_syscall_enter that can be called from
> > syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> > can do some cleanup using the same in syscall_trace_enter.
> > 
> > Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
> > in syscall_slow_exit_work seems unnecessary. Let's remove the same.
> 
> I think we should not change the logic here. Is so, it will double the report of syscall
> when PTRACE_SYSEMU_SINGLESTEP is enabled.
>

I don't think that should happen, but I may be missing something.
Can you explain how ?

--
Regards,
Sudeep

