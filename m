Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9C3C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199692133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfJCQAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:00:49 -0400
Received: from foss.arm.com ([217.140.110.172]:47794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbfJCQAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:00:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DDCA337;
        Thu,  3 Oct 2019 09:00:45 -0700 (PDT)
Received: from arrakis.emea.arm.com (unknown [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E40B13F739;
        Thu,  3 Oct 2019 09:00:43 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:00:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de, luto@kernel.org
Subject: Re: [PATCH v4 1/6] arm64: vdso32: Fix syncconfig errors.
Message-ID: <20191003160041.GI21629@arrakis.emea.arm.com>
References: <20191002144156.2174-1-vincenzo.frascino@arm.com>
 <20191002144156.2174-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002144156.2174-2-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 03:41:51PM +0100, Vincenzo Frascino wrote:
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Catalin Marinas <catalin.marinas@arm.com>

If you changed the patch, please drop my reviewed/tested-by.

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 84a3d502c5a5..dfa6a5cb99e4 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -53,20 +53,12 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>    endif
>  endif
>  
> +COMPATCC ?= $(CROSS_COMPILE_COMPAT)gcc
> +export COMPATCC
> +
>  ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
> -  CROSS_COMPILE_COMPAT ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
> -
> -  ifeq ($(CONFIG_CC_IS_CLANG), y)
> -    $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
> -  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
> -    $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
> -  else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
> -    $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
> -  else
> -    export CROSS_COMPILE_COMPAT
> -    export CONFIG_COMPAT_VDSO := y
> -    compat_vdso := -DCONFIG_COMPAT_VDSO=1
> -  endif
> +  export CONFIG_COMPAT_VDSO := y
> +  compat_vdso := -DCONFIG_COMPAT_VDSO=1
>  endif

With this change, if I don't have any CROSS_COMPILE_COMPAT in my
environment, the kernel fails to build because COMPATCC becomes gcc
which cannot build the vdso32. What I really want is not to warn me, nor
fail to build the kernel when I don't care about the compat vDSO (e.g. I
have a 64-bit only machine).

What saved us before was the COMPATCC_IS_ARM_GCC check and a selection
of the GENERIC_COMPAT_VDSO dependent on this check. This was now dropped
from the previous version of the patch. We could add something like
COMPATCC_CAN_LINK.

-- 
Catalin
