Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60739C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AE72082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394342AbfIFORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:17:55 -0400
Received: from foss.arm.com ([217.140.110.172]:56966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392868AbfIFORy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:17:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA26E28;
        Fri,  6 Sep 2019 07:17:53 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E5F33F718;
        Fri,  6 Sep 2019 07:17:53 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 33851682951; Fri,  6 Sep 2019 15:17:52 +0100 (BST)
Date:   Fri, 6 Sep 2019 15:17:52 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-devel@linux.nxdi.nxp.com,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com
Subject: Re: [v4 2/2] drm/arm/mali-dp: Add display QoS interface
 configuration for Mali DP500
Message-ID: <20190906141751.unabowxoglygg4kp@e110455-lin.cambridge.arm.com>
References: <20190822021135.10288-1-wen.he_1@nxp.com>
 <20190822021135.10288-2-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822021135.10288-2-wen.he_1@nxp.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

On Thu, Aug 22, 2019 at 10:11:35AM +0800, Wen He wrote:
> Configure the display Quality of service (QoS) levels priority if the
> optional property node "arm,malidp-aqros-value" is defined in DTS file.
> 
> QoS signaling using AQROS and AWQOS AXI interface signals, the AQROS is
> driven from the "RQOS" register, so needed to program the RQOS register
> to avoid the high resolutions flicker issue on the LS1028A platform.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
>  drivers/gpu/drm/arm/malidp_drv.c  |  6 ++++++
>  drivers/gpu/drm/arm/malidp_hw.c   | 13 +++++++++++++
>  drivers/gpu/drm/arm/malidp_hw.h   |  3 +++
>  drivers/gpu/drm/arm/malidp_regs.h | 10 ++++++++++
>  4 files changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index c27ff456eddc..80e8d15760ac 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -815,6 +815,12 @@ static int malidp_bind(struct device *dev)
>  
>  	malidp->core_id = version;
>  
> +	ret = of_property_read_u32(dev->of_node,
> +					"arm,malidp-arqos-value",
> +					&hwdev->arqos_value);
> +	if (ret)
> +		hwdev->arqos_value = 0x0;
> +
>  	/* set the number of lines used for output of RGB data */
>  	ret = of_property_read_u8_array(dev->of_node,
>  					"arm,malidp-output-port-lines",
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 380be66d4c6e..f90a367a5bc9 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -374,6 +374,19 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
>  		malidp_hw_setbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
>  	else
>  		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
> +
> +	/*
> +	 * Program the RQoS register to avoid high resolutions flicker
> +	 * issue on the LS1028A.
> +	 */
> +	if (hwdev->arqos_value) {
> +		val = hwdev->arqos_value;
> +
> +		if (mode->pixelclock > 148500000)
> +			malidp_hw_setbits(hwdev, val, MALIDP500_RQOS_QUALITY);
> +		else
> +			malidp_hw_clearbits(hwdev, val, MALIDP500_RQOS_QUALITY);
> +	}

This application of the arqos_value based on a pixel clock value bothers me,
because it has two problems:

1. Some other user of the Mali DP driver can't apply a system QoS value that they can
now specify in the DT, unless the requested pixel clock is bigger than 145MHz. :(

2. (A guess) The flickering issue shows up on a combination of pixelclock and
resolution (i.e. it is a bandwidth problem), but you only address one of the
variables. Haven't tested on the LS1028A yet, but do you know if (theoretically) it
would have a flicker problem doing 640x480@200MHz without the QoS value?

How about this instead?

--8<---------------------------------------------------------------------
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 380be66d4c6eb..e2f96dce13850 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -374,6 +374,22 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 		malidp_hw_setbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
 	else
 		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
+
+	/*
+	 * Program the RQoS register. LS1028A has an issue where screen will
+	 * flicker on pixelclocks higher than 148.5MHz but otherwise doesn't
+	 * want an RQoS value, so special case it for them.
+	 */
+	if (hwdev->arqos_value) {
+		val = hwdev->arqos_value;
+
+#ifdef MALIDP_LS1028A
+		if (mode->pixelclock <= 148500000)
+			malidp_hw_clearbits(hwdev, val, MALIDP500_RQOS_QUALITY);
+		else
+#endif
+			malidp_hw_setbits(hwdev, val, MALIDP500_RQOS_QUALITY);
+	}
 }
 
 int malidp_format_get_bpp(u32 fmt)
--8<---------------------------------------------------------------------

And then you need to define a MALIDP_LS1028A in a vendor patch on top of the kernel
source code.

Best regards,
Liviu


>  }
>  
>  int malidp_format_get_bpp(u32 fmt)
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index 968a65eed371..e4c36bc90bda 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -251,6 +251,9 @@ struct malidp_hw_device {
>  
>  	/* size of memory used for rotating layers, up to two banks available */
>  	u32 rotation_memory[2];
> +
> +	/* priority level of RQOS register used for driven the ARQOS signal */
> +	u32 arqos_value;
>  };
>  
>  static inline u32 malidp_hw_read(struct malidp_hw_device *hwdev, u32 reg)
> diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> index 993031542fa1..514c50dcb74d 100644
> --- a/drivers/gpu/drm/arm/malidp_regs.h
> +++ b/drivers/gpu/drm/arm/malidp_regs.h
> @@ -210,6 +210,16 @@
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
