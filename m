Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A5FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6C72245B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573641222;
	bh=JxJFayWcgdtF1EVaUH4pD+skHU9gsn9dqUwJZvSS4n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xggDeMes4y8VJTAiCjbcds/PMHZVpeKcq4gi9oPiIfqf11AToA62frQIdl9KA/qp/
	 ShogitL8Eon00/06D5NKW1+LeV3nlY3sPPWAZdlraPA+Fa5Im6zK2hFluPqGi+y1Gy
	 2wrurCrowbywpnvO224HRcj4OO04KpbAXq/V2XsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKMKdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKMKdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:33:40 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CF1222CD;
        Wed, 13 Nov 2019 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573641220;
        bh=JxJFayWcgdtF1EVaUH4pD+skHU9gsn9dqUwJZvSS4n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+jHpRMnT9LNK+fA4mE2FP5qjkZLBmgSxP4z2FJZD2bVEfioD1Hvefspeckc0F8mK
         av2ZIlqtGw9gBFlGaDXLZhCww7RFAmnr7bvyf10+OSFODKAHTf5I1L9LFNcyitvYWj
         1o+E6WO8ej9mIpRSXVZxry8sLC/0+CvM9PfQ37SA=
Date:   Wed, 13 Nov 2019 10:33:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     catalin.marinas@arm.com, john.garry@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Kconfig: add a choice for endianness
Message-ID: <20191113103335.GB25900@willie-the-truck>
References: <20191113092652.28201-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113092652.28201-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:26:52AM +0100, Anders Roxell wrote:
> When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
> CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
> people want. Another concern that has come up is that ACPI isn't built
> for an allmodconfig kernel today since that also depends on !CPU_BIG_ENDIAN.
> 
> Rework so that we introduce a 'choice' and default the choice to
> CPU_LITTLE_ENDIAN. That means that when we build an allmodconfig kernel
> it will default to CPU_LITTLE_ENDIAN that most people tends to want.
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/Kconfig | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 64764ca92fca..c599b6b288be 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -877,10 +877,26 @@ config ARM64_PA_BITS
>  	default 48 if ARM64_PA_BITS_48
>  	default 52 if ARM64_PA_BITS_52
>  
> +choice
> +	prompt "Endianness"
> +	default CPU_LITTLE_ENDIAN
> +	help
> +	  Select the endianness of data accesses performed by the CPU. Userspace
> +	  applications will need to be compiled and linked for the endianness
> +	  that is selected here.
> +
>  config CPU_BIG_ENDIAN
>         bool "Build big-endian kernel"
>         help
> -         Say Y if you plan on running a kernel in big-endian mode.
> +	  Say Y if you plan on running a kernel with a big-endian userspace.
> +
> +config CPU_LITTLE_ENDIAN
> +	bool "Build little-endian kernel"
> +	help
> +	  Say Y if you plan on running a kernel with a little-endian userspace.
> +	  This is usually the case for distributions targetting arm64.

Bah, my typo here: targetting -> targeting

Catalin, could you take this with the above fixed, please?

Acked-by: Will Deacon <will@kernel.org>

Will
