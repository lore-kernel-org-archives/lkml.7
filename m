Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD9EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D1B208CB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEBQpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:45:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49234 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfEBQpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:45:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C6AA78;
        Thu,  2 May 2019 09:45:19 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA8073F5AF;
        Thu,  2 May 2019 09:45:16 -0700 (PDT)
Date:   Thu, 2 May 2019 17:45:12 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 1/4] ptrace: move clearing of TIF_SYSCALL_EMU flag to
 core
Message-ID: <20190502164512.GA10635@fuggles.cambridge.arm.com>
References: <20190430170520.29470-1-sudeep.holla@arm.com>
 <20190430170520.29470-2-sudeep.holla@arm.com>
 <20190501161330.GD30235@redhat.com>
 <20190501161752.GA12498@e107155-lin>
 <20190502161329.GE7323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502161329.GE7323@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 06:13:30PM +0200, Oleg Nesterov wrote:
> On 05/01, Sudeep Holla wrote:
> >
> > On Wed, May 01, 2019 at 06:13:30PM +0200, Oleg Nesterov wrote:
> > > On 04/30, Sudeep Holla wrote:
> > > >
> > > > While the TIF_SYSCALL_EMU is set in ptrace_resume independent of any
> > > > architecture, currently only powerpc and x86 unset the TIF_SYSCALL_EMU
> > > > flag in ptrace_disable which gets called from ptrace_detach.
> > > >
> > > > Let's move the clearing of TIF_SYSCALL_EMU flag to __ptrace_unlink
> > > > which gets executed from ptrace_detach and also keep it along with
> > > > or close to clearing of TIF_SYSCALL_TRACE.
> > > >
> > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > Cc: Paul Mackerras <paulus@samba.org>
> > > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > >
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > >
> >
> > Since 1/4 and 2/4 are completely independent of arm64 changes in 3&4/4,
> > I prefer you take these via your tree.
> 
> Sorry Sudeep, I can't do this, I need to reanimate my account on kernel.org.

Ok, if you're happy for us to take them via arm64 with your ack, then we can
do that as well. Just don't want to step on anybody's toes!

Will
