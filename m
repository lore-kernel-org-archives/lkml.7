Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D890AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7D120989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfCRRkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:40:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfCRRke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:40:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A34BEBD;
        Mon, 18 Mar 2019 10:40:34 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696373F614;
        Mon, 18 Mar 2019 10:40:31 -0700 (PDT)
Date:   Mon, 18 Mar 2019 17:40:28 +0000
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
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Message-ID: <20190318174028.GE18196@e107155-lin>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-5-sudeep.holla@arm.com>
 <20190318172024.GB23521@redhat.com>
 <20190318172457.GD18196@e107155-lin>
 <20190318173341.GD23521@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318173341.GD23521@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 06:33:41PM +0100, Oleg Nesterov wrote:
> On 03/18, Sudeep Holla wrote:
> >
> > On Mon, Mar 18, 2019 at 06:20:24PM +0100, Oleg Nesterov wrote:
> > >
> > > Again, to me this patch just makes the code look worse. Honestly, I don't
> > > think that the new (badly named) ptrace_syscall_enter() hook makes any sense.
> > >
> >
> > Worse because we end up reading current_thread_info->flags twice ?
>
> Mostly because in my opinion ptrace_syscall_enter() buys nothing but makes
> the caller's code less readable/understandable.
>
> Sure, this is subjective.
>

Based on what we have in that function today, I tend to agree. Will and
Richard were in the opinion to consolidate SYSEMU handling(in the threads
pointed in my cover letter). If there's a better way to achieve the same
I am in for it. I have just tried to put something together based on
what I could think of.

--
Regards,
Sudeep
