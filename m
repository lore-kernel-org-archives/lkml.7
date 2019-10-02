Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD424C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A380B2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JPJGdfbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfJBMky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:40:54 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54580 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbfJBMkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FqquIHC5oxBy8CfQu3Yph9eJsUVp9ZgWjyWHgpTSvkU=; b=JPJGdfbHXvOiVSxMPvS6nxMLB
        Wm6y7QlzB1iqVkXS0nqPlswbkaPjuAcZHOVasrZff8Z9COb4i53czP8CqWb/7uzGyt83bDGymojER
        Dm7l8DOwlJ4Pu8RYOOVMUh4B2zUMAyClkZsJsK4DFUTu9EYgYFOd8VXRo0OF5ChUy4WQTItrnNNfh
        /GrijJ1hKrd3B+7CJvM67b8JAIFIZkrBT2OOwId8GWq6E3Xf2Rjy5R+2C2hetdWNkoOvM5HIxdrA/
        CMDKNmG/kWrgBrrnaxl25jGOsISEPhGkrduob+M0pfdDYvPURjy0H0CcGkylR06lXgW7q5tgirT4J
        r+vQFBsRw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46680)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iFdvx-0000FD-EC; Wed, 02 Oct 2019 13:40:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iFdvv-0000fy-Hs; Wed, 02 Oct 2019 13:40:43 +0100
Date:   Wed, 2 Oct 2019 13:40:43 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        thor.thayer@linux.intel.com
Subject: Re: [PATCHv2] ARM: drivers/amba: release the resource to allow for
 deferred probe
Message-ID: <20191002124043.GR25745@shell.armlinux.org.uk>
References: <20191002123349.23771-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002123349.23771-1-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 07:33:49AM -0500, Dinh Nguyen wrote:
> With commit "79bdcb202a35 ARM: 8906/1: drivers/amba: add reset control to
> amba bus probe", the amba bus driver needs to be deferred probe because the
> reset driver is probed later. However with a deferred probe, the call to
> request_resource() in the driver returns -EBUSY. The reason is the driver
> has not released the resource from the previous probe attempt.
> 
> This patch fixes how we handle the condition of EPROBE_DEFER that is returned
> from getting the reset controls. For this condition, the patch will jump
> to err_release, which will release the resource.
> 
> Fixes: 79bdcb202a35 ("ARM: 8906/1: drivers/amba: add reset control to
> amba bus probe")
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: release the resource when of_reset_control_array_get_optional_shared()
>     returns EPROBE_DEFER
> ---
>  drivers/amba/bus.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index f39f075abff9..1109437815eb 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -409,9 +409,12 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  		 */
>  		rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
>  		if (IS_ERR(rstc)) {
> -			if (PTR_ERR(rstc) != -EPROBE_DEFER)
> +			ret = PTR_ERR(rstc);
> +			if (ret == -EPROBE_DEFER)
> +				goto err_release;
> +			else
>  				dev_err(&dev->dev, "Can't get amba reset!\n");
> -			return PTR_ERR(rstc);
> +			return ret;

Still a negative.

Remember in the comments to the previous patch I talked about ioremap().

Please read the code that you are modifying and carefully consider what
needs to happen at this site to properly clean up on failure.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
