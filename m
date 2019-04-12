Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C30EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7707D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfDLLuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:50:54 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:53546 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfDLLuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:50:52 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Euhkh0iYANG8zEuhlhCfnb; Fri, 12 Apr 2019 13:50:50 +0200
Subject: Re: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per
 frame
To:     Eugen.Hristev@microchip.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nicolas.Ferre@microchip.com, mchehab@kernel.org,
        ksloat@aampglobal.com
References: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
 <1555064098-19310-2-git-send-email-eugen.hristev@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7978caee-9ae1-a428-af14-34bfa12ad223@xs4all.nl>
Date:   Fri, 12 Apr 2019 13:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555064098-19310-2-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfObd+IznRAxpG5y9GHT36uCPYTReQP7MFZeJlIoRs0WEHHcHg++remlLZ7i8/Jg6yGNg+LHOYO2slfHigZZApyQhunsy928mEty2rcENoLYCOa7uwscU
 ruxQvJZ1Y8SXD4+sEhL/oouNPcp5rbxNTwqgjUXTfM2/QCBOrJ0NX+fTwuG9mJqBSKMY1i8gEdNW5B5I+jk3AMvKv4HKApeytGMJ29vn0WiQiXZ5XT/qvpGZ
 67aAZp/COI3+cyIM6zPcX3vAMIGPKEKo+On8SVyvF/mEwxgyLM748/pUU4MOlerMw/0Rm94xtTakDftH/CxXHxMMQgBzKCNjQi2FhY0cV5NkCMCZOKYjAXdY
 Jiz1Hj8RCR7V9W+meu9Zjsm6bI6kPHCbb6XZyWw/th9N9dxNPTVhEzSM77+FycX8bPiJlvt9qcCQtIieOohYHHZFOA78BLlNQXfQy1OTkjoDMXBkDNyCbKbH
 VEuNFv7qARWcwBIkCh9r7DCi/LGVYKXDaEvErpeMcAlx7Kj2k+UhpoCwVOQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 12:19 PM, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> This will limit the incoming pixels per frame from the sensor.
> Currently, the ISC will stop sampling the frame only when the vsync/hsync
> are detected.
> If we misconfigure the resolution in the sensor w.r.t. resolution in the ISC,
> the buffer used for DMA in the ISC will be smaller than the number of pixels
> that the ISC DMA engine will copy.
> In this case it happens that the DMA will overwrite parts of the memory which
> should not be written, leading to memory corruption.
> To avoid this situation, use the PFE CFG1 and PFE CFG2 registers, which crop
> the incoming frame to the resolution that we configure.
> This way the DMA engine will never write more data than we expect it to.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/media/platform/atmel/atmel-isc-regs.h | 19 +++++++++++++++
>  drivers/media/platform/atmel/atmel-isc.c      | 34 +++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/media/platform/atmel/atmel-isc-regs.h b/drivers/media/platform/atmel/atmel-isc-regs.h
> index 2aadc19..768a5ad 100644
> --- a/drivers/media/platform/atmel/atmel-isc-regs.h
> +++ b/drivers/media/platform/atmel/atmel-isc-regs.h
> @@ -35,6 +35,25 @@
>  #define ISC_PFG_CFG0_BPS_TWELVE (0x0 << 28)
>  #define ISC_PFE_CFG0_BPS_MASK   GENMASK(30, 28)
>  
> +#define ISC_PFE_CFG0_COLEN	BIT(12)
> +#define ISC_PFE_CFG0_ROWEN	BIT(13)
> +
> +/* ISC Parallel Front End Configuration 1 Register */
> +#define ISC_PFE_CFG1    0x00000010
> +
> +#define ISC_PFE_CFG1_COLMIN(v)		((v))
> +#define ISC_PFE_CFG1_COLMIN_MASK	GENMASK(15, 0)
> +#define ISC_PFE_CFG1_COLMAX(v)		((v) << 16)
> +#define ISC_PFE_CFG1_COLMAX_MASK	GENMASK(31, 16)
> +
> +/* ISC Parallel Front End Configuration 2 Register */
> +#define ISC_PFE_CFG2    0x00000014
> +
> +#define ISC_PFE_CFG2_ROWMIN(v)		((v))
> +#define ISC_PFE_CFG2_ROWMIN_MASK	GENMASK(15, 0)
> +#define ISC_PFE_CFG2_ROWMAX(v)		((v) << 16)
> +#define ISC_PFE_CFG2_ROWMAX_MASK	GENMASK(31, 16)
> +
>  /* ISC Clock Enable Register */
>  #define ISC_CLKEN               0x00000018
>  
> diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
> index a10db16..ea7520a 100644
> --- a/drivers/media/platform/atmel/atmel-isc.c
> +++ b/drivers/media/platform/atmel/atmel-isc.c
> @@ -721,6 +721,40 @@ static void isc_start_dma(struct isc_device *isc)
>  	u32 sizeimage = isc->fmt.fmt.pix.sizeimage;
>  	u32 dctrl_dview;
>  	dma_addr_t addr0;
> +	u32 h, w;
> +
> +	h = isc->fmt.fmt.pix.height;
> +	w = isc->fmt.fmt.pix.width;
> +
> +	/*
> +	 * In case the sensor is not RAW, it will output a pixel (12-16 bits)
> +	 * with two samples on the ISC Data bus (which is 8-12)
> +	 * ISC will count each sample, so, we need to multiply these values
> +	 * by two, to get the real number of samples for the required pixels.
> +	 */
> +	if (!ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code)) {

The ISC_IS_FORMAT_RAW define doesn't exist?!

Something clearly went wrong...

Regards,

	Hans


> +		h <<= 1;
> +		w <<= 1;
> +	}
> +
> +	/*
> +	 * We limit the column/row count that the ISC will output according
> +	 * to the configured resolution that we want.
> +	 * This will avoid the situation where the sensor is misconfigured,
> +	 * sending more data, and the ISC will just take it and DMA to memory,
> +	 * causing corruption.
> +	 */
> +	regmap_write(regmap, ISC_PFE_CFG1,
> +		     (ISC_PFE_CFG1_COLMIN(0) & ISC_PFE_CFG1_COLMIN_MASK) |
> +		     (ISC_PFE_CFG1_COLMAX(w - 1) & ISC_PFE_CFG1_COLMAX_MASK));
> +
> +	regmap_write(regmap, ISC_PFE_CFG2,
> +		     (ISC_PFE_CFG2_ROWMIN(0) & ISC_PFE_CFG2_ROWMIN_MASK) |
> +		     (ISC_PFE_CFG2_ROWMAX(h - 1) & ISC_PFE_CFG2_ROWMAX_MASK));
> +
> +	regmap_update_bits(regmap, ISC_PFE_CFG0,
> +			   ISC_PFE_CFG0_COLEN | ISC_PFE_CFG0_ROWEN,
> +			   ISC_PFE_CFG0_COLEN | ISC_PFE_CFG0_ROWEN);
>  
>  	addr0 = vb2_dma_contig_plane_dma_addr(&isc->cur_frm->vb.vb2_buf, 0);
>  	regmap_write(regmap, ISC_DAD0, addr0);
> 

