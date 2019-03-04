Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6CEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A7920823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCDKmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:42:12 -0500
Received: from foss.arm.com ([217.140.101.70]:59896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfCDKmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:42:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D26FEBD;
        Mon,  4 Mar 2019 02:42:11 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9DA3F703;
        Mon,  4 Mar 2019 02:42:08 -0800 (PST)
Date:   Mon, 4 Mar 2019 10:42:06 +0000
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
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Message-ID: <20190304104206.GB1504@e107155-lin>
References: <247371ae-3360-95e2-bf1d-21eb9332c31c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247371ae-3360-95e2-bf1d-21eb9332c31c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 09:36:27AM +0000, Haibo Xu (Arm Technology China) wrote:
> On 2019/3/1 2:32, Sudeep Holla wrote:
> > Now that we have a new hook ptrace_syscall_enter that can be called from
> > syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> > can do some cleanup using the same in do_syscall_trace_enter.
> >
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  arch/powerpc/kernel/ptrace.c | 50 ++++++++++++++++--------------------
> >  1 file changed, 22 insertions(+), 28 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> > index cb7e1439cafb..978cd2aac29e 100644
> > --- a/arch/powerpc/kernel/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace.c
> > @@ -3264,37 +3264,31 @@ long do_syscall_trace_enter(struct pt_regs *regs)
> >  {
> >  	u32 flags;
> >
> > -	user_exit();
>
> We'd better keep the user_exit() at here in case both context tracking and
> SYSCALL_EMU are enabled.
>

Ah right, spurious change will fix it.

--
Regards,
Sudeep
