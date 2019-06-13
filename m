Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF4C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83422063F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393641AbfFMRPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:15:13 -0400
Received: from foss.arm.com ([217.140.110.172]:47980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393288AbfFMROx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:14:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7263F367;
        Thu, 13 Jun 2019 10:14:53 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01EA73F694;
        Thu, 13 Jun 2019 10:14:51 -0700 (PDT)
Date:   Thu, 13 Jun 2019 18:14:44 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Anisse Astier <aastier@freebox.fr>
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
Message-ID: <20190613171432.GA2790@e103592.cambridge.arm.com>
References: <20190613163801.21949-1-aastier@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613163801.21949-1-aastier@freebox.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 06:38:01PM +0200, Anisse Astier wrote:
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
> This fixes an UAPI regression introduced in commit 43d4da2c45b2
> ("arm64/sve: ptrace and ELF coredump support").
> 
> Cc: stable@vger.kernel.org

Consider adding a Fixes: tag.

> Signed-off-by: Anisse Astier <aastier@freebox.fr>
> ---
>  arch/arm64/include/uapi/asm/ptrace.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index d78623acb649..03b6d6f029fc 100644
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

Ack

>   */
> -#define SVE_PT_VL_INHERIT		(PR_SVE_VL_INHERIT >> 16)
> -#define SVE_PT_VL_ONEXEC		(PR_SVE_SET_VL_ONEXEC >> 16)
> +#define SVE_PT_VL_INHERIT		(1 << 1) /* PR_SVE_VL_INHERIT */
> +#define SVE_PT_VL_ONEXEC		(1 << 2) /* PR_SVE_SET_VL_ONEXEC */

Makes sense, but...

Since sve_context.h was already introduced to solve a closely related
problem, I wonder whether we can provide shadow definitions there,
similarly to way the arm64/include/uapi/asm/ptrace.h definitions are
derived.  Although it's a slight abuse of that header, I think that
would be my preferred approach.

Otherwise, at least make the required relationship between ptrace.h and
prctl.h constants a bit more obvious, say,

	#define SVE_PT_VL_INHERIT ((1 << 17) /* PR_SVE_SET_VL_INHERIT */ >> 16)

etc.

Cheers
---Dave
