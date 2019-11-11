Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2319EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC82D214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573467971;
	bh=2z8hwJsgg/ju8i4+eMGguE3rZCyoHUgwt0bw+ZYB8KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U59bIY6nSc1WgU/E0Em8PG2o1wgGIme0aTy1zD/bEREm/IFpa0N78RhauRxsdRZWT
	 j9UiGhujJuUXNVlCIbpe6khFV69cNS8VOZEuFSApzmFv9g+7QjySV23yxtaQi49AiM
	 BYGMzftWJodCqQjTXsnGBJXtvzp2XD7Qak1cudjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKKK0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:26:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKK0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:26:09 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 335BC214DB;
        Mon, 11 Nov 2019 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573467969;
        bh=2z8hwJsgg/ju8i4+eMGguE3rZCyoHUgwt0bw+ZYB8KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smvBKhhcHads27xPsXAticFXTQpqu1E/0aHowUyGC3JnKrDgqgeEkR7czO3TbqemG
         29V7Ppi88wdSIU+L06wHCS9JvtnwH8KxL+2J2ZVxE8SYvrHy0FIISOGAl5QYORsnVz
         GHVuztMhZkFiWVmjk6hnTnUAozhD9GcDfhSvl59c=
Date:   Mon, 11 Nov 2019 10:26:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     catalin.marinas@arm.com, john.garry@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Kconfig: make CMDLINE_FORCE depend on CMDLINE
Message-ID: <20191111102603.GA8903@willie-the-truck>
References: <20191111085956.6158-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111085956.6158-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:59:56AM +0100, Anders Roxell wrote:
> When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
> CONFIG_CMDLINE_FORCE gets enabled. Which forces the user to pass the
> full cmdline to CONFIG_CMDLINE="...".
> 
> Rework so that CONFIG_CMDLINE_FORCE gets set only if CONFIG_CMDLINE is
> set to something except an empty string.
> 
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 50df79d4aa3b..64764ca92fca 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1629,6 +1629,7 @@ config CMDLINE
>  
>  config CMDLINE_FORCE
>  	bool "Always use the default kernel command string"
> +	depends on CMDLINE != ""
>  	help
>  	  Always use the default kernel command string, even if the boot
>  	  loader passes other arguments to the kernel.

Acked-by: Will Deacon <will@kernel.org>

Will
