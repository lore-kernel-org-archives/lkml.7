Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B2C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F181520652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfEBQNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEBQNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:13:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32A6D3151C4C;
        Thu,  2 May 2019 16:13:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3C23F60BFC;
        Thu,  2 May 2019 16:13:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  2 May 2019 18:13:36 +0200 (CEST)
Date:   Thu, 2 May 2019 18:13:30 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20190502161329.GE7323@redhat.com>
References: <20190430170520.29470-1-sudeep.holla@arm.com>
 <20190430170520.29470-2-sudeep.holla@arm.com>
 <20190501161330.GD30235@redhat.com>
 <20190501161752.GA12498@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501161752.GA12498@e107155-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 02 May 2019 16:13:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01, Sudeep Holla wrote:
>
> On Wed, May 01, 2019 at 06:13:30PM +0200, Oleg Nesterov wrote:
> > On 04/30, Sudeep Holla wrote:
> > >
> > > While the TIF_SYSCALL_EMU is set in ptrace_resume independent of any
> > > architecture, currently only powerpc and x86 unset the TIF_SYSCALL_EMU
> > > flag in ptrace_disable which gets called from ptrace_detach.
> > >
> > > Let's move the clearing of TIF_SYSCALL_EMU flag to __ptrace_unlink
> > > which gets executed from ptrace_detach and also keep it along with
> > > or close to clearing of TIF_SYSCALL_TRACE.
> > >
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
>
> Since 1/4 and 2/4 are completely independent of arm64 changes in 3&4/4,
> I prefer you take these via your tree.

Sorry Sudeep, I can't do this, I need to reanimate my account on kernel.org.

Oleg.

