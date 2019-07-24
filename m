Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6093DC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4F7229F3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563950125;
	bh=Pi+VKac//YeSaPe2w+Iospd+tpAQMymBglU3stnrNHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kuwmEDymrpUDPNC/VnXgLlEZimGvIpyDz7o2EQwgEq9eeO9YjAfLr+9zYeNl+TXO+
	 7npcanyCMb4KdhD6CDUDv3Jjqv+HU+aNhsvfdA9/nCokeiBwraXVC7gwpwn5yrEpbR
	 WCNMTKpKhf6JcR5Dq2aLrcI773OgFHzhvsdMa5MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfGXGfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfGXGfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:35:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67554229ED;
        Wed, 24 Jul 2019 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563950122;
        bh=Pi+VKac//YeSaPe2w+Iospd+tpAQMymBglU3stnrNHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IENQEMwTMB+Mw7Lh7xPyHgf5dE8Doq4/+aJujiWGsLEHA5WsZAV8QV3WYfSgHu8Mp
         oxn2nUQXVGTq3Rzy2ihldV36K1eRZArX6pN4Isz55RT2+F9xj6m+dzjDUQ/vBngwPh
         y5uvNDy/60OC9Rm3ipRRGkSe+1TP5yxYCrm7r6ao=
Date:   Wed, 24 Jul 2019 08:35:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/3] treewide: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190724063520.GA21280@kroah.com>
References: <20190723181624.203864-1-swboyd@chromium.org>
 <20190723181624.203864-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723181624.203864-3-swboyd@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 11:16:23AM -0700, Stephen Boyd wrote:
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 9b2232908b65..40e4e8e03428 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -1088,7 +1088,6 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "Can't retrieve our interrupt\n");
>  		return irq;
>  	}
>  

Just one example here, but you really want to remove those { } now as
well.

That's in this patch a lot, so as-is, I don't think this is ok, sorry.

greg k-h
