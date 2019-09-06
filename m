Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746B1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F942081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567744755;
	bh=WnaNo7a02OqVu6NIqH9DB42Dvl60OZUq73g617FYboQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fa853QyVM509rPtWjljmBT5Mls2jGbnfIQiiVVZCpO5j1fAEjO7BfPMMC1K1cHfYc
	 Pz91HGnLfsdzDcZBSCIoA5p7waSSEVGxw81QDUJVdzhKDyuAiSDehB66Z2BfHXJnzN
	 wHrE4z8VFVz/9X+lnumKl35pp42mwOkvg3NEuUGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfIFEjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 00:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbfIFEjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 00:39:14 -0400
Received: from localhost (unknown [223.226.32.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A683C2075C;
        Fri,  6 Sep 2019 04:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567744753;
        bh=WnaNo7a02OqVu6NIqH9DB42Dvl60OZUq73g617FYboQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vwwGBNqTbLExFqJXqUY/XKpIX5FhpFyRq+X2og3jTsO61MUZJOaD0bAZbwYTR5l6t
         iXs41ACqEsQwB93ZGOfw3ZKL7rB+PkTHQMqF6Quwl6W72bhW9UWyyd6xBK014m4EUA
         3UNbC5rdlwVt1DxzyqbrAQxkgyDL43bANP9MzdnY=
Date:   Fri, 6 Sep 2019 10:08:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: add back ACPI dependency
Message-ID: <20190906043805.GE2672@vkoul-mobl>
References: <20190905203527.1478314-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905203527.1478314-1-arnd@arndb.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-09-19, 22:35, Arnd Bergmann wrote:
> Soundwire gained a warning for randconfig builds without
> CONFIG_ACPI during the linux-5.3-rc cycle:
> 
> drivers/soundwire/slave.c:16:12: error: unused function 'sdw_slave_add' [-Werror,-Wunused-function]
> 
> Add the CONFIG_ACPI dependency at the top level now.

Did you run this yesterday or today. I have applied Srini's patches to
add DT support for Soundwire couple of days back so we should not see
this warning anymore

> Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soundwire/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index f518273cfbe3..c73bfbaa2659 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -5,6 +5,7 @@
>  
>  menuconfig SOUNDWIRE
>  	tristate "SoundWire support"
> +	depends on ACPI
>  	help
>  	  SoundWire is a 2-Pin interface with data and clock line ratified
>  	  by the MIPI Alliance. SoundWire is used for transporting data
> -- 
> 2.20.0

-- 
~Vinod
