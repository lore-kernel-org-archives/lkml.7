Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB87EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988DC20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfFNOWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:22:41 -0400
Received: from foss.arm.com ([217.140.110.172]:35154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbfFNOWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:22:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FA17344;
        Fri, 14 Jun 2019 07:22:40 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BF923F246;
        Fri, 14 Jun 2019 07:22:38 -0700 (PDT)
Date:   Fri, 14 Jun 2019 15:22:31 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Anisse Astier <aastier@freebox.fr>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Rich Felker <dalias@aerifal.cx>, linux-kernel@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Ricardo Salveti <ricardo@foundries.io>
Subject: Re: [PATCH] arm64/sve: <uapi/asm/ptrace.h> should not depend on
 <uapi/linux/prctl.h>
Message-ID: <20190614142231.GA29231@fuggles.cambridge.arm.com>
References: <20190613163801.21949-1-aastier@freebox.fr>
 <20190613171432.GA2790@e103592.cambridge.arm.com>
 <20190614112222.GA47082@anisse-station>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614112222.GA47082@anisse-station>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anisse, Dave,

On Fri, Jun 14, 2019 at 01:22:22PM +0200, Anisse Astier wrote:
> On Thu, Jun 13, 2019 at 06:14:44PM +0100, Dave Martin wrote:
> > On Thu, Jun 13, 2019 at 06:38:01PM +0200, Anisse Astier wrote:
> > > -#define SVE_PT_VL_INHERIT		(PR_SVE_VL_INHERIT >> 16)
> > > -#define SVE_PT_VL_ONEXEC		(PR_SVE_SET_VL_ONEXEC >> 16)
> > > +#define SVE_PT_VL_INHERIT		(1 << 1) /* PR_SVE_VL_INHERIT */
> > > +#define SVE_PT_VL_ONEXEC		(1 << 2) /* PR_SVE_SET_VL_ONEXEC */
> > 
> > Makes sense, but...
> > 
> > Since sve_context.h was already introduced to solve a closely related
> > problem, I wonder whether we can provide shadow definitions there,
> > similarly to way the arm64/include/uapi/asm/ptrace.h definitions are
> > derived.  Although it's a slight abuse of that header, I think that
> > would be my preferred approach.
> 
> Yes I saw this, and I considered doing something similar. But, those
> defines are in uapi/linux/prctl.h, which does not include any asm/*.h
> header. This would have then required adding a full infrastructure for
> asm/prctl.h (that could then include sve_context.h for example), which
> does not exist yet, instead of copying these two values.

x86 appears to have an asm/prctl.h implementation, but it's not included
by anybody so I guess that doesn't really help us here.

> Since this is part of the kernel-userspace ABI, I don't see this values
> changing anytime soon, which is why I thought copying them shouldn't be
> a big issue.

Certainly not a big issue, just that the harder we make this to change
the better.

> A simple solution would be to to include sve_context.h or a third
> header, maybe linux/prctl_arm64_sve.h (with only these two/five
> defines), in linux/prctl.h, and reuse it in uapi/asm/ptrace.h; but this
> would break the self-contained nature of linux/prctl.h.
> > 
> > Otherwise, at least make the required relationship between ptrace.h and
> > prctl.h constants a bit more obvious, say,
> > 
> > 	#define SVE_PT_VL_INHERIT ((1 << 17) /* PR_SVE_SET_VL_INHERIT */ >> 16)
> 
> This one is much simpler and closer to what I had in mind with this
> patch.
> 
> Will, what do you think of this second approach Dave proposed ?

Duplication is grotty, but it does the job so I'm ok with it. I don't have
any better ideas.

Thanks,

Will
