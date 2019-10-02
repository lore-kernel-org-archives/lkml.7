Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70731C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3597521D81
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zgTnof+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfJBRcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:32:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58220 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBRcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mQqIhWQifybwkhXFJbITg6B075lNi1C6ZO3XIQgSSq4=; b=zgTnof+ptMi/+RkZlGYDebb2H
        2W5q/lEjU73zjxRbkd282fuRX21gXxqlC7/VZYH4/pH8DSrE8wzw3Vx7Dhpr0/DXBhXDVXRdCvIH7
        Nc6ZbQo56fAVCWhU0DIXHlbNVuOZBEL1FFx0bvmZTTjUYBS1UbZEPcUBRuXjGKyqPImPVNSkCBLVX
        f1JbJxlbnx4EQ0yFpUsoK0PbgM65n+XA3s7MTJ+y3NTU3skzF73EaG7R1ErXKgokrj46cnifQVekw
        M0nGMVHiGNcUpYCCtU3o3o5fuLvgaz25o5ExQJ+dLv61qvsEArDz+N0cR+OkRU58KGHHSwgprXuWW
        6gLv3K3QQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:39248)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iFiU0-0001XK-QP; Wed, 02 Oct 2019 18:32:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iFiTy-0000uk-07; Wed, 02 Oct 2019 18:32:10 +0100
Date:   Wed, 2 Oct 2019 18:32:09 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        thor.thayer@linux.intel.com
Subject: Re: [PATCHv3] ARM: drivers/amba: release and cleanup the resource to
 allow for deferred probe
Message-ID: <20191002173209.GT25745@shell.armlinux.org.uk>
References: <20191002143551.32288-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002143551.32288-1-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 09:35:51AM -0500, Dinh Nguyen wrote:
> With commit "79bdcb202a35 ARM: 8906/1: drivers/amba: add reset control to
> amba bus probe", the amba bus driver needs to be deferred probe because the
> reset driver is probed later. However with a deferred probe, the call to
> request_resource() in the driver returns -EBUSY. The reason is the driver
> has not released the resource from the previous probe attempt.
> 
> This patch fixes how we handle the condition of EPROBE_DEFER that is returned
> from getting the reset controls. For this condition, the patch will jump
> to defer_probe, which will iounmap, dev_pm_domain_detach, and release the
> resource.
> 
> Fixes: 79bdcb202a35 ("ARM: 8906/1: drivers/amba: add reset control to
> amba bus probe")
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v3: jump to defer_probe where the driver will unmap and pm_detach the
>     driver resource for the next probe attempt
> v2: release the resource when of_reset_control_array_get_optional_shared()
>     returns EPROBE_DEFER
> ---
>  drivers/amba/bus.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index f39f075abff9..4a021b1dab3d 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -409,9 +409,12 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  		 */
>  		rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
>  		if (IS_ERR(rstc)) {
> -			if (PTR_ERR(rstc) != -EPROBE_DEFER)
> +			ret = PTR_ERR(rstc);
> +			if (ret == -EPROBE_DEFER)
> +				goto defer_probe;
> +			else
>  				dev_err(&dev->dev, "Can't get amba reset!\n");
> -			return PTR_ERR(rstc);
> +			return ret;

So, if of_reset_control_array_get_optional_shared() returns an error,
we end up leaking the ioremap(), the resource claim, the pclk enable
and pm domain?  If it returns -EPROBE_DEFER, we end up leaking the
pclk enable?

I think this is going to be quicker if I write the patch - I haven't
build-tested this yet though.  Please check whether this works for
you.

Thanks.

8<=====
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] drivers/amba: fix reset control error handling

With commit 79bdcb202a35 ("ARM: 8906/1: drivers/amba: add reset control
to amba bus probe") it is possible for the the amba bus driver to defer
probing the device for its IDs because the reset driver may be probed
later.

However when a subsequent probe occurs, the call to request_resource()
in the driver returns -EBUSY as the driver has not released the resource
from the initial probe attempt - or cleaned up any of the preceding
actions.

Fix this both for the deferred probe case as well as a failure to get
the reset.

Fixes: 79bdcb202a35 ("ARM: 8906/1: drivers/amba: add reset control to amba bus probe")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/amba/bus.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f39f075abff9..fe1523664816 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -409,9 +409,11 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 		 */
 		rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
 		if (IS_ERR(rstc)) {
-			if (PTR_ERR(rstc) != -EPROBE_DEFER)
-				dev_err(&dev->dev, "Can't get amba reset!\n");
-			return PTR_ERR(rstc);
+			ret = PTR_ERR(rstc);
+			if (ret != -EPROBE_DEFER)
+				dev_err(&dev->dev, "can't get reset: %d\n",
+					ret);
+			goto err_reset;
 		}
 		reset_control_deassert(rstc);
 		reset_control_put(rstc);
@@ -472,6 +474,12 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	release_resource(&dev->res);
  err_out:
 	return ret;
+
+ err_reset:
+	amba_put_disable_pclk(dev);
+	iounmap(tmp);
+	dev_pm_domain_detach(&dev->dev, true);
+	goto err_release;
 }
 
 /*
-- 
2.7.4


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
