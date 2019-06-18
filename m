Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617F2C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CFF208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfFRNkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:40:35 -0400
Received: from foss.arm.com ([217.140.110.172]:41698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfFRNkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:40:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E46682B;
        Tue, 18 Jun 2019 06:40:32 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 726B63F718;
        Tue, 18 Jun 2019 06:40:31 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:40:29 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Anisse Astier <aastier@freebox.fr>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rich Felker <dalias@aerifal.cx>, linux-kernel@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Ricardo Salveti <ricardo@foundries.io>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] arm64/sve: <uapi/asm/ptrace.h> should not depend on
 <uapi/linux/prctl.h>
Message-ID: <20190618134029.GE2790@e103592.cambridge.arm.com>
References: <20190613163801.21949-1-aastier@freebox.fr>
 <20190614164600.36966-1-aastier@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614164600.36966-1-aastier@freebox.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 06:46:00PM +0200, Anisse Astier wrote:
> Otherwise this will create userspace build issues for any program
> (strace, qemu) that includes both <sys/prctl.h> (with musl libc) and
> <linux/ptrace.h> (which then includes <asm/ptrace.h>), like this:
> 
> 	error: redefinition of 'struct prctl_mm_map'
> 	 struct prctl_mm_map {
> 
> See https://github.com/foundriesio/meta-lmp/commit/6d4a106e191b5d79c41b9ac78fd321316d3013c0
> for a public example of people working around this issue.
> 
> Copying the defines is a bit imperfect here, but better than creating a
> whole other header for just two defines that would never change, as part
> of the kernel ABI.
> 
> Fixes: 43d4da2c45b2 ("arm64/sve: ptrace and ELF coredump support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anisse Astier <aastier@freebox.fr>
> ---
> Changes since v1:
>  - made a bit more explicit that we copied defined symbols, in commit
>    and code.
>  - Use Fixes: tag in commit message
> 
> Thanks to Dave Martin and Will Deacon for the review.
> 
> ---
>  arch/arm64/include/uapi/asm/ptrace.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index d78623acb649..438759e7e8a7 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -65,8 +65,6 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <linux/prctl.h>
> -
>  /*
>   * User structures for general purpose, floating point and debug registers.
>   */
> @@ -113,10 +111,10 @@ struct user_sve_header {
>  
>  /*
>   * Common SVE_PT_* flags:
> - * These must be kept in sync with prctl interface in <linux/ptrace.h>
> + * These must be kept in sync with prctl interface in <linux/prctl.h>
>   */
> -#define SVE_PT_VL_INHERIT		(PR_SVE_VL_INHERIT >> 16)
> -#define SVE_PT_VL_ONEXEC		(PR_SVE_SET_VL_ONEXEC >> 16)
> +#define SVE_PT_VL_INHERIT		((1 << 17) /* PR_SVE_VL_INHERIT */ >> 16)
> +#define SVE_PT_VL_ONEXEC		((1 << 18) /* PR_SVE_SET_VL_ONEXEC */ >> 16)

FWIW,
Acked-by: Dave Martin <Dave.Martin@arm.com>

Ideally we would create a common <uapi/asm/prctl.h> that arm64 could
specialise as appropriate, but since x86 already has a similar header
shadowing this, it may be more trouble than it's worth to generalise it.

Cheers
---Dave
