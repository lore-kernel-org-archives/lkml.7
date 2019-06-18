Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF841C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B333F2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfFRJ3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:29:51 -0400
Received: from foss.arm.com ([217.140.110.172]:59424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbfFRJ3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:29:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613AA344;
        Tue, 18 Jun 2019 02:29:50 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 764523F246;
        Tue, 18 Jun 2019 02:29:49 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:29:47 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, ard.biesheuvel@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: Allow user selection of ARM64_MODULE_PLTS
Message-ID: <20190618092947.GB30899@fuggles.cambridge.arm.com>
References: <20190617223000.11403-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617223000.11403-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 03:29:59PM -0700, Florian Fainelli wrote:
> Make ARM64_MODULE_PLTS a selectable Kconfig symbol, since some people
> might have very big modules spilling out of the dedicated module area
> into vmalloc. Help text is copied from the ARM 32-bit counterpart and
> modified to a mention of KASLR and specific ARM errata workaround(s).
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v3:
> - take out the part about "The modules will use slightly more memory, but after
>   rounding up to page size, the actual memory footprint is usually the same.
> - take out the "If unusure say Y", since we would really prefer this to
>   be off by default for maximum performance
> 
> Changes in v2:
> 
> - added Ard's paragraph about KASLR
> - added a paragraph about specific workarounds also requiring
>   ARM64_MODULE_PLTS
> 
>  arch/arm64/Kconfig | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 697ea0510729..9206feaeff07 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1418,8 +1418,26 @@ config ARM64_SVE
>  	  KVM in the same kernel image.
>  
>  config ARM64_MODULE_PLTS
> -	bool
> +	bool "Use PLTs to allow module memory to spill over into vmalloc area"
>  	select HAVE_MOD_ARCH_SPECIFIC
> +	help
> +	  Allocate PLTs when loading modules so that jumps and calls whose
> +	  targets are too far away for their relative offsets to be encoded
> +	  in the instructions themselves can be bounced via veneers in the
> +	  module's PLT. This allows modules to be allocated in the generic
> +	  vmalloc area after the dedicated module memory area has been
> +	  exhausted.
> +
> +	  When running with address space randomization (KASLR), the module
> +	  region itself may be too far away for ordinary relative jumps and
> +	  calls, and so in that case, module PLTs are required and cannot be
> +	  disabled.
> +
> +	  Specific errata workaround(s) might also force module PLTs to be
> +	  enabled (ARM64_ERRATUM_843419).
> +
> +	  Disabling this is usually safe for small single-platform
> +	  configurations.

I think I'd still drop this last sentence, because labelling a kernel
"usually safe" without this option is a bit OTT. We'll just reject large
modules, nothing unsafe about that.

Assuming Catalin can do that when he applies, so:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
