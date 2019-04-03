Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07EAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88E92075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDCQux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:50:53 -0400
Received: from foss.arm.com ([217.140.101.70]:44944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCQux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:50:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9501EBD;
        Wed,  3 Apr 2019 09:50:52 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7B9E3F68F;
        Wed,  3 Apr 2019 09:50:49 -0700 (PDT)
Date:   Wed, 3 Apr 2019 17:50:42 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Message-ID: <20190403165042.GB17500@fuggles.cambridge.arm.com>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-5-sudeep.holla@arm.com>
 <20190318172024.GB23521@redhat.com>
 <20190318172457.GD18196@e107155-lin>
 <20190318173341.GD23521@redhat.com>
 <20190318174028.GE18196@e107155-lin>
 <20190319170804.GA11525@redhat.com>
 <20190319173233.GB11525@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319173233.GB11525@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Tue, Mar 19, 2019 at 06:32:33PM +0100, Oleg Nesterov wrote:
> On 03/19, Oleg Nesterov wrote:
> >
> > Well, personally I see no point... Again, after the trivial simplification
> > x86 does
> >
> > 	if (work & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> > 		ret = tracehook_report_syscall_entry(regs);
> > 		if (ret || (work & _TIF_SYSCALL_EMU))
> > 			return -1L;
> > 	}
> >
> > this looks simple enough for copy-and-paste.
> >
> > > If there's a better way to achieve the same
> >
> > I can only say that if we add a common helper, I think it should absorb
> > tracehook_report_syscall_entry() and handle both TIF's just like the code
> > above does. Not sure this makes any sense.
> 
> this won't work, looking at 6/6 I see that arm64 needs to distinguish
> _TRACE and _EMU ... I don't understand this code, but it looks suspicious.
> If tracehook_report_syscall_entry() returns nonzero the tracee was killed,
> syscall_trace_enter() should just return.
> 
> To me this is another indication that consolidation makes no sense ;)

The reason I'm pushing for consolidation here is because I think it's the
only sane way to maintain the tracing and debug hooks on the syscall
entry/exit paths. Having to look at all the different arch implementations
and distil the portable semantics is a nightmare and encourages gradual
divergence over time. Given that we don't support this SYSCALL_EMU stuff
on arm64 today, we have the opportunity to make this generic and allow other
architectures (e.g. riscv) to hook in the same way that we do. It clearly
shouldn't affect the behaviour of existing architectures which already
support the functionality.

However, I also agree that this patch series looks dodgy as it stands -- we
shouldn't have code paths that can result in calling
tracehook_report_syscall_entry() twice.

Will
