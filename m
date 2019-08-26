Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC21C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3058E21848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfHZPvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:51:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41043 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:51:48 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i2HHW-0007Po-QI; Mon, 26 Aug 2019 17:51:46 +0200
Message-ID: <1566834704.3842.7.camel@pengutronix.de>
Subject: Re: [PATCHv5] drivers/amba: add reset control to amba bus probe
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh@kernel.org, linux@armlinux.org.uk,
        frowand.list@gmail.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        daniel.thompson@linaro.org, linus.walleij@linaro.org,
        manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 26 Aug 2019 17:51:44 +0200
In-Reply-To: <20190826154252.22952-1-dinguyen@kernel.org>
References: <20190826154252.22952-1-dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-26 at 10:42 -0500, Dinh Nguyen wrote:
> The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
> default. Until recently, the DMA controller was brought out of reset by the
> bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals
> that are not used are held in reset and are left to Linux to bring them
> out of reset.
> 
> Add a mechanism for getting the reset property and de-assert the primecell
> module from reset if found. This is a not a hard fail if the reset properti
> is not present in the device tree node, so the driver will continue to
> probe.
> 
> Because there are different variants of the controller that may have
> multiple reset signals, the code will find all reset(s) specified and
> de-assert them.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v5: use of_reset_control_array_get_optional_shared()
> v4: cleaned up indentation in loop
>     fix up a few checkpatch warnings
>     add Reviewed-by:
> v3: add a reset_control_put()
>     add error handling
> v2: move reset control to bus code
>     find all reset properties and de-assert them
> ---
>  drivers/amba/bus.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 100e798a5c82..f8a7cb74c3cf 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -18,6 +18,7 @@
>  #include <linux/limits.h>
>  #include <linux/clk/clk-conf.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  
>  #include <asm/irq.h>
>  
> @@ -401,6 +402,24 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  	ret = amba_get_enable_pclk(dev);
>  	if (ret == 0) {
>  		u32 pid, cid;
> +		int count;
> +		struct reset_control *rstc;
> +
> +		/*
> +		 * Find reset control(s) of the amba bus and de-assert them.
> +		 */
> +		count = reset_control_get_count(&dev->dev);
> +		while (count > 0) {
> +			rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);

You can drop the loop, the rstc returned by of_reset_control_array_get()
already controls all resets together.

regards
Philipp
