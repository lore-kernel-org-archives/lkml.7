Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5ADC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD0620880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="E8zdaRTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfDPXuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:50:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46006 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbfDPXuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:50:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so12867854lfl.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7NtOh2YQ200r1ojeHYL/m5sDfY33OFOTXckXQvl4Duo=;
        b=E8zdaRTduW34zkGLdgm9tOpQ8CpxKVCo62jm/CiawRy9Ly9bV0qtWc2AR3Jyw+YN1i
         yANZSwEqZFF9NFR2H6aC4DRbrojLKp6qLU2XL6xPGs9gfTlB9oYB5PVUhFJ6RFP9lppu
         +X8xN4W2T/ttynP1T+R/08699/7vs3srxaY/koHPoKXyaiD3r90kKRUNnRT/xUJtSgrH
         80qJoXYr1DlX8sh6I2+enKe/OKR+KLWAbdqPr4R/BdAPUKK4tCJQbnCjNCiPeHeXmVQL
         Fq9be68UE0wEUuc5rHtTUZaUboJKJkjbEdsBHFzVd0ZsvrfI0Mxl0VsCTC02jDnLkD04
         zeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7NtOh2YQ200r1ojeHYL/m5sDfY33OFOTXckXQvl4Duo=;
        b=Qse4j/I9MqQSw349cF+0MLNUb6RlYtt3BFfmyqud2eezuFprkUh0wXnNEFNGQOpQqs
         TAseLP/uzEyuUQLR/qrAAQaqND1u/potK8SCX1b6caHDd9lx3pKxG7eYh9dzGJt94RLF
         qD3+dGvtPS5uqpf82Yd9qAGDljyMbijbXd18w4ttU895tvJ3WR/IQu5obIXgYO0yI9Il
         7wDC/DVHxLN1Uccg3bfAtJWSzONivMCC6ergPfEaQ2nwbTwlQqfTGdWSyquGyQFMtvb3
         IkFj/g4smwKnvfJnd+jmmKrm+y1A6JmoFTlxciu0sQmtFGL72vGTh4fzO+U1yC50uAEM
         IS8w==
X-Gm-Message-State: APjAAAXS/HsfaJk47JcnNRnci/saCuA3PHSlr1xCtGG/XeBd0i0myBlr
        Au10n0dotTxwqVX1XkUaoVbptg==
X-Google-Smtp-Source: APXvYqyFM7Q5kCppSAApVT1FvqNtmZ9gzpjzfKm+vrZM/WXjBdheLQvCBaFJVR0tBthv/vBLDOdEcA==
X-Received: by 2002:a19:751a:: with SMTP id y26mr4350068lfe.47.1555458619772;
        Tue, 16 Apr 2019 16:50:19 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id c7sm11378311lja.90.2019.04.16.16.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 16:50:18 -0700 (PDT)
Date:   Wed, 17 Apr 2019 01:50:18 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - VIN" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: rcar-csi2: Fix field detection
Message-ID: <20190416235018.GJ28515@bigcity.dyn.berto.se>
References: <20190416233807.20213-1-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416233807.20213-1-slongerbeam@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Thanks for your work.

I upported most rcar-csi2 patches but a few of them are still pending, 
an alternating version based on this BSP patch is already on its way.

https://patchwork.linuxtv.org/patch/55623/

As a general feedback calling v4l2_subdev_call() for g_std is not the 
best way to handle this problem in a MC centric driver. There is a 
discussion about in in earlier versions of the patch mentioned above.

On 2019-04-16 16:38:07 -0700, Steve Longerbeam wrote:
> The RCAR Gen3 hardware manual doesn't mention that the "Word Count" field
> in the MIPI CSI-2 Frame Start packet is really the frame number. FS packets
> are short packets, and short packets do not have a WC but rather a 16-bit
> data field, and for Frame synchronization packets (FS/FE) the 16-bit data
> field contains a frame number.
> 
> Here is a reprinting from the MIPI CSI-2 specification, version 2
> (section 9.1.2 Low Level Protocol Short Packet Format):
> 
> "Figure 42 and Figure 43 show the Low Level Protocol Short Packet
> structures for the D-PHY and C-PHY physical layer options, respectively.
> For each option, the Short Packet structure matches the Packet Header of
> the corresponding Low Level Protocol Long Packet structure with the
> exception that the Packet Header Word Count (WC) field shall be replaced
> by the Short Packet Data Field...For Frame Synchronization Data Types
> the Short Packet Data Field shall be the frame number..."
> 
> Also in section 9.8.1 Frame Synchronization Packets, the CSI-2 spec reads:
> 
> "The behavior of the 16-bit frame number shall be as one of the following
> - Frame number is always zero – frame number is inoperative.
> - Frame number increments by 1 for every FS packet with the same Virtual
>   Channel and is periodically reset to one e.g. 1, 2, 1, 2, 1, 2, 1, 2 or
>   1, 2, 3, 4, 1, 2, 3, 4"
> 
> So from the above, FLD_NUM in the FLD register matches against the
> frame number transmitted by the CSI-2 source in the Frame Start Packet,
> and goes as "1,2,1,2,1,2" or "1,2,3,4,...,1,2,3,4". If there is a match,
> the RCAR CSI-2 receiver declares the field as the even, e.g. the BOTTOM,
> field.
> 
> NTSC transmits bottom/even field first, and PAL and HD transmit top/odd
> field first. So fields with a frame number 1 in the CSI-2 Frame Start
> Packet are bottom/even fields for NTSC, and frame number 2 are bottom/even
> fields for PAL/HD.
> 
> But the above assumes the transmitting CSI-2 sensor is sending frame
> numbers in the sequence "1,2,1,2,...". But according to the CSI-2 spec,
> sensors are also allowed to send frame numbers that simply increment as
> in "1,2,3,4,...". To generalize to catch those cases, set FLD_DET_SEL
> to 0x01, which according to the RCAR Gen3 hardware manual means "the
> field is detected as the EVEN field when FLD_NUM[0] matches WC[0]".
> Then, the even/bottom fields have odd frame numbers for NTSC, and even
> frame numbers for PAL (this patch assumes HDMI sources will not
> implement .g_std(), so std will be 0 in that case).
> 
> Finally, set the FLD register to non-zero value only if trnsmitter is
> sending ALTERNATE fields.
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> ---
>  drivers/media/platform/rcar-vin/rcar-csi2.c | 37 ++++++++++++++++++---
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index a438ec2c218f..c5bee20d7907 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -67,6 +67,7 @@ struct rcar_csi2;
>  /* Field Detection Control */
>  #define FLD_REG				0x1c
>  #define FLD_FLD_NUM(n)			(((n) & 0xff) << 16)
> +#define FLD_FLD_DET_SEL(n)		(((n) & 0x3) << 4)
>  #define FLD_FLD_EN4			BIT(3)
>  #define FLD_FLD_EN3			BIT(2)
>  #define FLD_FLD_EN2			BIT(1)
> @@ -462,10 +463,11 @@ static int rcsi2_calc_mbps(struct rcar_csi2 *priv, unsigned int bpp)
>  	return mbps;
>  }
>  
> -static int rcsi2_start(struct rcar_csi2 *priv)
> +static int rcsi2_start(struct rcar_csi2 *priv, struct v4l2_subdev *nextsd)
>  {
>  	const struct rcar_csi2_format *format;
> -	u32 phycnt, vcdt = 0, vcdt2 = 0;
> +	u32 phycnt, vcdt = 0, vcdt2 = 0, fld = 0;
> +	v4l2_std_id std = 0;
>  	unsigned int i;
>  	int mbps, ret;
>  
> @@ -476,6 +478,10 @@ static int rcsi2_start(struct rcar_csi2 *priv)
>  	/* Code is validated in set_fmt. */
>  	format = rcsi2_code_to_fmt(priv->mf.code);
>  
> +	ret = v4l2_subdev_call(nextsd, video, g_std, &std);
> +	if (ret < 0 && ret != -ENOIOCTLCMD && ret != -ENODEV)
> +		return ret;
> +
>  	/*
>  	 * Enable all supported CSI-2 channels with virtual channel and
>  	 * data type matching.
> @@ -509,9 +515,30 @@ static int rcsi2_start(struct rcar_csi2 *priv)
>  	rcsi2_reset(priv);
>  	rcsi2_write(priv, PHTC_REG, 0);
>  
> +	/*
> +	 * NTSC standard transmits even/bottom field first, then odd/top.
> +	 * PAL standard and interlaced HD transmit odd/top field first,
> +	 * then even/bottom.
> +	 *
> +	 * For CSI-2 sensors that transmit frame numbers (in the CSI-2
> +	 * Frame Start packet) as "1,2,1,2,..." or "1,2,3,4,5,...", then:
> +	 *
> +	 * - for NTSC, the even/bottom fields have odd frame numbers.
> +	 * - for PAL and HD, the even/bottom fields have even frame numbers.
> +	 */
> +	if (priv->mf.field == V4L2_FIELD_ALTERNATE) {
> +		fld = FLD_FLD_DET_SEL(1) | FLD_FLD_EN4 | FLD_FLD_EN3 |
> +			FLD_FLD_EN2 | FLD_FLD_EN;
> +
> +		if (std & V4L2_STD_525_60)
> +			fld |= FLD_FLD_NUM(1); /* NTSC */
> +		else
> +			fld |= FLD_FLD_NUM(0); /* PAL or HD */
> +	}
> +
>  	/* Configure */
> -	rcsi2_write(priv, FLD_REG, FLD_FLD_NUM(2) | FLD_FLD_EN4 |
> -		    FLD_FLD_EN3 | FLD_FLD_EN2 | FLD_FLD_EN);
> +	rcsi2_write(priv, FLD_REG, fld);
> +
>  	rcsi2_write(priv, VCDT_REG, vcdt);
>  	if (vcdt2)
>  		rcsi2_write(priv, VCDT2_REG, vcdt2);
> @@ -591,7 +618,7 @@ static int rcsi2_s_stream(struct v4l2_subdev *sd, int enable)
>  	if (enable && priv->stream_count == 0) {
>  		pm_runtime_get_sync(priv->dev);
>  
> -		ret = rcsi2_start(priv);
> +		ret = rcsi2_start(priv, nextsd);
>  		if (ret) {
>  			pm_runtime_put(priv->dev);
>  			goto out;
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
