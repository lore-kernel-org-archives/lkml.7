Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E04C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592C3222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfIZVPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:15:52 -0400
Received: from foss.arm.com ([217.140.110.172]:60172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfIZVPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 17:15:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92ED9337;
        Thu, 26 Sep 2019 14:15:51 -0700 (PDT)
Received: from [10.37.12.151] (unknown [10.37.12.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62C0F3F739;
        Thu, 26 Sep 2019 14:15:48 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] arm64: vdso32: Detect binutils support for dmb
 ishld
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
References: <20190926133805.52348-1-vincenzo.frascino@arm.com>
 <20190926133805.52348-3-vincenzo.frascino@arm.com>
 <20190926155938.GM9689@arrakis.emea.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <2e1e562c-ff9d-9cd4-afd5-e5e8d813f0fc@arm.com>
Date:   Thu, 26 Sep 2019 22:17:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926155938.GM9689@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/19 4:59 PM, Catalin Marinas wrote:
> On Thu, Sep 26, 2019 at 02:38:03PM +0100, Vincenzo Frascino wrote:
>>  arch/arm64/kernel/vdso32/Makefile            | 9 +++++++++
> 
> Could you please also remove the unnecessary gcc-goto.sh check in this
> file? We don't use jump labels in the vdso (can't run-time patch them).
> I found it while forcing COMPATCC=clang with my additional diff and I
> get the warning on 'make clean'.
>

I will do it in a separate cleanup patch, I want to keep this only for the error
reported by Will.

> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 22f0d31ea528..038357a1e835 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -40,9 +38,6 @@ VDSO_CAFLAGS += $(call cc32-option,-fno-PIE)
>  ifdef CONFIG_DEBUG_INFO
>  VDSO_CAFLAGS += -g
>  endif
> -ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(COMPATCC)), y)
> -VDSO_CAFLAGS += -DCC_HAVE_ASM_GOTO
> -endif
>  
>  # From arm Makefile
>  VDSO_CAFLAGS += $(call cc32-option,-fno-dwarf2-cfi-asm)
> 

-- 
Regards,
Vincenzo
