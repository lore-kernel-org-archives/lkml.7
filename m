Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02DEC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C04D222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfIZO0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:26:47 -0400
Received: from foss.arm.com ([217.140.110.172]:51386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfIZO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:26:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D4228;
        Thu, 26 Sep 2019 07:26:46 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 354B03F534;
        Thu, 26 Sep 2019 07:26:45 -0700 (PDT)
Date:   Thu, 26 Sep 2019 15:26:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 2/4] arm64: vdso32: Detect binutils support for dmb
 ishld
Message-ID: <20190926142642.GF9689@arrakis.emea.arm.com>
References: <20190926133805.52348-1-vincenzo.frascino@arm.com>
 <20190926133805.52348-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926133805.52348-3-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 02:38:03PM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
> index d6465823b281..75cf8c796d0e 100644
> --- a/arch/arm64/Kbuild
> +++ b/arch/arm64/Kbuild
> @@ -4,3 +4,9 @@ obj-$(CONFIG_NET)	+= net/
>  obj-$(CONFIG_KVM)	+= kvm/
>  obj-$(CONFIG_XEN)	+= xen/
>  obj-$(CONFIG_CRYPTO)	+= crypto/
> +
> +# as-instr-compat
> +# Usage: cflags-y += $(call as-instr-compat,instr,option1,option2)
> +
> +as-instr-compat = $(call try-run,\
> +	printf "%b\n" "$(1)" | $(COMPATCC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))

This doesn't seem to be used anywhere. Was it meant to be replaced by
cc32-as-instr?

-- 
Catalin
