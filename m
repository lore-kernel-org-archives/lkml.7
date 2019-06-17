Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B268C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12113208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfFQRcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:32:46 -0400
Received: from foss.arm.com ([217.140.110.172]:57454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQRcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:32:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CADFE28;
        Mon, 17 Jun 2019 10:32:44 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6A293F246;
        Mon, 17 Jun 2019 10:32:43 -0700 (PDT)
Date:   Mon, 17 Jun 2019 18:32:41 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@Broadcom.com, ard.biesheuvel@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Allow user selection of ARM64_MODULE_PLTS
Message-ID: <20190617173241.GM30800@fuggles.cambridge.arm.com>
References: <20190614025932.533-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614025932.533-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 07:59:32PM -0700, Florian Fainelli wrote:
> Make ARM64_MODULE_PLTS a selectable Kconfig symbol, since some people
> might have very big modules spilling out of the dedicated module area
> into vmalloc. Help text is copied from the ARM 32-bit counterpart.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/Kconfig | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 697ea0510729..36befe987b73 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1418,8 +1418,20 @@ config ARM64_SVE
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
> +	  exhausted. The modules will use slightly more memory, but after
> +	  rounding up to page size, the actual memory footprint is usually
> +	  the same.

Isn't the worry really about the runtime performance overhead introduced
by the veneers, as opposed to the memory usage of the module?

> +	  Disabling this is usually safe for small single-platform
> +	  configurations. If unsure, say y.

So should this be on by default?

Will
