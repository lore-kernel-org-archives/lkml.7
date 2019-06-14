Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39923C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE03208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfFNLWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:22:49 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:2408 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfFNLWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:22:49 -0400
Received: from anisse-station (unknown [213.36.7.13])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id 517A013F84C;
        Fri, 14 Jun 2019 13:22:23 +0200 (CEST)
Date:   Fri, 14 Jun 2019 13:22:22 +0200
From:   Anisse Astier <aastier@freebox.fr>
To:     Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Rich Felker <dalias@aerifal.cx>, linux-kernel@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Ricardo Salveti <ricardo@foundries.io>
Subject: Re: [PATCH] arm64/sve: <uapi/asm/ptrace.h> should not depend on
 <uapi/linux/prctl.h>
Message-ID: <20190614112222.GA47082@anisse-station>
References: <20190613163801.21949-1-aastier@freebox.fr>
 <20190613171432.GA2790@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613171432.GA2790@e103592.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Thanks for taking the time to review this patch,

On Thu, Jun 13, 2019 at 06:14:44PM +0100, Dave Martin wrote:
> On Thu, Jun 13, 2019 at 06:38:01PM +0200, Anisse Astier wrote:
> > Otherwise this will create userspace build issues for any program
> > (strace, qemu) that includes both <sys/prctl.h> (with musl libc) and
> > <linux/ptrace.h> (which then includes <asm/ptrace.h>), like this:
> > 
> > 	error: redefinition of 'struct prctl_mm_map'
> > 	 struct prctl_mm_map {
> > 
> > See https://github.com/foundriesio/meta-lmp/commit/6d4a106e191b5d79c41b9ac78fd321316d3013c0
> > for a public example of people working around this issue.
> > 
> > This fixes an UAPI regression introduced in commit 43d4da2c45b2
> > ("arm64/sve: ptrace and ELF coredump support").
> > 
> > Cc: stable@vger.kernel.org
> 
> Consider adding a Fixes: tag.

Will do in v2.

> 
> > Signed-off-by: Anisse Astier <aastier@freebox.fr>
> > ---
> >  arch/arm64/include/uapi/asm/ptrace.h | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> > index d78623acb649..03b6d6f029fc 100644
> > --- a/arch/arm64/include/uapi/asm/ptrace.h
> > +++ b/arch/arm64/include/uapi/asm/ptrace.h
> > @@ -65,8 +65,6 @@
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > -#include <linux/prctl.h>
> > -
> >  /*
> >   * User structures for general purpose, floating point and debug registers.
> >   */
> > @@ -113,10 +111,10 @@ struct user_sve_header {
> >  
> >  /*
> >   * Common SVE_PT_* flags:
> > - * These must be kept in sync with prctl interface in <linux/ptrace.h>
> > + * These must be kept in sync with prctl interface in <linux/prctl.h>
> 
> Ack
> 
> >   */
> > -#define SVE_PT_VL_INHERIT		(PR_SVE_VL_INHERIT >> 16)
> > -#define SVE_PT_VL_ONEXEC		(PR_SVE_SET_VL_ONEXEC >> 16)
> > +#define SVE_PT_VL_INHERIT		(1 << 1) /* PR_SVE_VL_INHERIT */
> > +#define SVE_PT_VL_ONEXEC		(1 << 2) /* PR_SVE_SET_VL_ONEXEC */
> 
> Makes sense, but...
> 
> Since sve_context.h was already introduced to solve a closely related
> problem, I wonder whether we can provide shadow definitions there,
> similarly to way the arm64/include/uapi/asm/ptrace.h definitions are
> derived.  Although it's a slight abuse of that header, I think that
> would be my preferred approach.


Yes I saw this, and I considered doing something similar. But, those
defines are in uapi/linux/prctl.h, which does not include any asm/*.h
header. This would have then required adding a full infrastructure for
asm/prctl.h (that could then include sve_context.h for example), which
does not exist yet, instead of copying these two values.

Since this is part of the kernel-userspace ABI, I don't see this values
changing anytime soon, which is why I thought copying them shouldn't be
a big issue.

A simple solution would be to to include sve_context.h or a third
header, maybe linux/prctl_arm64_sve.h (with only these two/five
defines), in linux/prctl.h, and reuse it in uapi/asm/ptrace.h; but this
would break the self-contained nature of linux/prctl.h.

> 
> Otherwise, at least make the required relationship between ptrace.h and
> prctl.h constants a bit more obvious, say,
> 
> 	#define SVE_PT_VL_INHERIT ((1 << 17) /* PR_SVE_SET_VL_INHERIT */ >> 16)

This one is much simpler and closer to what I had in mind with this
patch.

Will, what do you think of this second approach Dave proposed ?

Regards,

Anisse
