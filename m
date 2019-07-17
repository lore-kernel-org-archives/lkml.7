Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C96C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB1A20880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfGQLWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:22:04 -0400
Received: from foss.arm.com ([217.140.110.172]:46364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfGQLWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:22:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93EBC337;
        Wed, 17 Jul 2019 04:22:03 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585B43F71F;
        Wed, 17 Jul 2019 04:22:03 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 0876368276C; Wed, 17 Jul 2019 12:22:02 +0100 (BST)
Date:   Wed, 17 Jul 2019 12:22:01 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        brian.starkey@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        leoyang.li@nxp.com
Subject: Re: [PATCH] drm/arm/mali-dp: Add display QoS interface configuration
Message-ID: <20190717112201.GA17638@e110455-lin.cambridge.arm.com>
References: <20190717092353.43386-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190717092353.43386-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

On Wed, Jul 17, 2019 at 05:23:53PM +0800, Wen He wrote:
> Configure the display Quality of service (QoS) levels to high priority
> if the level is defined as high as in DTS. The ARQOS for DP500 is driven
> from the "RQOS" register, needed to program the RQOS register value < 7
> for the 4k resolution flicker to disappear on the LS1028A platform.

Thanks for taking time to come up with a more generic patch for your issue!

I have a question: what happens if you program the MALIDP500_RQOS_QUALITY
register to 0xd000d000 for all pixelclocks?

Also, some suggestions further down:

> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
> change in v2:
>         - add new implementation for 4k flicker issue on the LS1028A
> 
>  drivers/gpu/drm/arm/malidp_drv.c  |  5 +++++
>  drivers/gpu/drm/arm/malidp_hw.c   | 13 +++++++++++++
>  drivers/gpu/drm/arm/malidp_hw.h   |  3 +++
>  drivers/gpu/drm/arm/malidp_regs.h | 12 ++++++++++++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index f25ec4382277..d2b2cf52ac87 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -818,6 +818,11 @@ static int malidp_bind(struct device *dev)
>  
>  	malidp->core_id = version;
>  
> +	hwdev->arqos_high_level = false;

This is not needed.

> +
> +	hwdev->arqos_high_level = of_property_read_bool(dev->of_node,
> +					"arm,malidp-arqos-high-level");

I think it would be better to have this property as a u32 value, rather than a
boolean, and put the value that we want to program MALIDP_RQOS_QUALITY with in
there.

Also, you need to add the documentation for this optional property in
Documentation/devicetree/bindings/display/arm,malidp.txt.

> +
>  	/* set the number of lines used for output of RGB data */
>  	ret = of_property_read_u8_array(dev->of_node,
>  					"arm,malidp-output-port-lines",
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 50af399d7f6f..eaa1658cd86b 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -374,6 +374,19 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
>  		malidp_hw_setbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
>  	else
>  		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
> +
> +	/*
> +	 *  Program the RQoS register to increasing QoS levels for
> +	 *  the 4k resolution flicker to disappear on the LS1028A.

Looks like two sentences got smashed into one, the result is a bit hard to read.

Best regards,
Liviu

> +	 */
> +	if (hwdev->arqos_high_level) {
> +		val = RED_ARQOS_VALUE | GREEN_ARQOS_VALUE;
> +
> +		if (mode->pixelclock == 594000000)
> +			malidp_hw_setbits(hwdev, val, MALIDP500_RQOS_QUALITY);
> +		else
> +			malidp_hw_clearbits(hwdev, val, MALIDP500_RQOS_QUALITY);
> +	}
>  }
>  
>  int malidp_format_get_bpp(u32 fmt)
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index 968a65eed371..b8baba60508a 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -251,6 +251,9 @@ struct malidp_hw_device {
>  
>  	/* size of memory used for rotating layers, up to two banks available */
>  	u32 rotation_memory[2];
> +
> +	/* priority level of RQOS register used for driven the ARQOS signal */
> +	bool arqos_high_level;
>  };
>  
>  static inline u32 malidp_hw_read(struct malidp_hw_device *hwdev, u32 reg)
> diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> index 993031542fa1..08842142b3b2 100644
> --- a/drivers/gpu/drm/arm/malidp_regs.h
> +++ b/drivers/gpu/drm/arm/malidp_regs.h
> @@ -210,6 +210,18 @@
>  #define MALIDP500_CONFIG_VALID		0x00f00
>  #define MALIDP500_CONFIG_ID		0x00fd4
>  
> +/*
> + * The quality of service (QoS) register on the DP500. RQOS register values
> + * are driven by the ARQOS signal, using AXI transacations, dependent on the
> + * FIFO input level.
> + * The RQOS register can also set QoS levels for:
> + *    - RED_ARQOS   @ A 4-bit signal value for close to underflow conditions
> + *    - GREEN_ARQOS @ A 4-bit signal value for normal conditions
> + */
> +#define MALIDP500_RQOS_QUALITY          0x00500
> +#define RED_ARQOS_VALUE                 (0xd << 12)
> +#define GREEN_ARQOS_VALUE               (0xd << 28)
> +
>  /* register offsets and bits specific to DP550/DP650 */
>  #define MALIDP550_ADDR_SPACE_SIZE	0x10000
>  #define MALIDP550_DE_CONTROL		0x00010
> -- 
> 2.17.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
