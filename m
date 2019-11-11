Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B914AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFAD21E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573486947;
	bh=xWJusHKlqUpcCYqCdxZNGlxfR/CEgHC15PppEgpoPpQ=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=IfyPKzBh5Gk6lyNiZ/9X7iBlyAtlDVsZOI+3pSvO0/P9w31ev4DQwMcDMA0GDeF94
	 abAr3gC0bZ/1+eptpTKWC7YhUMRDeN4d19imEkdTeDhaJfqU58WayboTkpLNf5UzQu
	 ua8yO3DSf46GoTnqTsltNJ39dNII/Hvub6Zk0wGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKKPm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:42:26 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:37865 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbfKKPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:42:26 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iUBpc-0004LY-Pn; Mon, 11 Nov 2019 16:42:20 +0100
To:     Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 1/2] arm64: Rename =?UTF-8?Q?WORKAROUND=5F=31=31=36=35?=  =?UTF-8?Q?=35=32=32=20to=20SPECULATIVE=5FAT?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Nov 2019 16:51:41 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20191111141157.55062-2-steven.price@arm.com>
References: <20191111141157.55062-1-steven.price@arm.com>
 <20191111141157.55062-2-steven.price@arm.com>
Message-ID: <160a852027f4481cc63aed72c4f4a409@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2019-11-11 15:21, Steven Price wrote:
> Cortex-A55 is affected by a similar erratum, so rename the existing
> workaround for errarum 1165522 so it can be used for both errata.

nit: erratum

>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/Kconfig                |  4 ++++
>  arch/arm64/include/asm/cpucaps.h  |  2 +-
>  arch/arm64/include/asm/kvm_host.h |  2 +-
>  arch/arm64/include/asm/kvm_hyp.h  |  3 +--
>  arch/arm64/kernel/cpu_errata.c    | 17 +++++++++++++----
>  arch/arm64/kvm/hyp/switch.c       |  2 +-
>  arch/arm64/kvm/hyp/tlb.c          |  4 ++--
>  7 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3f047afb982c..6cb4eff602c6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -510,9 +510,13 @@ config ARM64_ERRATUM_1418040
>
>  	  If unsure, say Y.
>
> +config ARM64_WORKAROUND_SPECULATIVE_AT
> +	bool
> +
>  config ARM64_ERRATUM_1165522
>  	bool "Cortex-A76: Speculative AT instruction using out-of-context
> translation regime could cause subsequent request to generate an
> incorrect translation"
>  	default y
> +	select ARM64_WORKAROUND_SPECULATIVE_AT

I'd object that ARM64_ERRATUM_1319367 (and its big brother 1319537)
are also related to speculative AT execution, and yet are not covered
by this configuration symbol.

I can see three solutions to this:

- Either you call it SPECULATIVE_AT_VHE and introduce 
SPECULATIVE_AT_NVHE
   for symmetry

- Or you make SPECULATIVE_AT cover all the speculative AT errata, which
   may or may not work...

- Or even better, you just ammend the documentation to say that 1165522
   also covers the newly found A55 one (just like we have for A57/A72)

What do you think?

         M.
-- 
Jazz is not dead. It just smells funny...
