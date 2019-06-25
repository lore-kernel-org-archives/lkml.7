Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D24C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DE3217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfFYI3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:29:34 -0400
Received: from foss.arm.com ([217.140.110.172]:35478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfFYI3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:29:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C9C2B;
        Tue, 25 Jun 2019 01:29:33 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F36F3F718;
        Tue, 25 Jun 2019 01:29:32 -0700 (PDT)
Date:   Tue, 25 Jun 2019 09:29:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, ard.biesheuvel@linaro.org,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: Allow user selection of ARM64_MODULE_PLTS
Message-ID: <20190625082928.GA3039@arrakis.emea.arm.com>
References: <20190617223000.11403-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617223000.11403-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 03:29:59PM -0700, Florian Fainelli wrote:
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

This needs a depends on MODULES now (it failed to build in one of my
tests where modules were disabled but this option was left enabled).

I'll add a patch on top.

-- 
Catalin
