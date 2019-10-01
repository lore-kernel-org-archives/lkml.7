Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1132EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DA92133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCWeuwoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfJAKO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:14:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36944 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfJAKOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:14:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so14773171wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TqnRymZHVB3nETq43Yyx3kDj0Su1WqRmQVreGP9eeAM=;
        b=SCWeuwojpC5yiuVk+b45PdbihMNriak/36ZsCE0jmeSduzCjq/s51e80vXGAJkh3DO
         qOHqQtqPLCXcoR4SCjvUPn8599enHuL8DaInPPRnMJAbE2OX+R0at2cRImMnVa8lvkz6
         jJLXpTtZ+/tu1Jrrb9ZyWKHK4a5AWtizXLSU8Lo7W8GJOifGv04j8JitEpzXburg3asJ
         H8BysylFgjcP+/1rpYynNTj+oSnqnD5KCDSpcibbNkz+BvguDi/xyTPScY0gm2itHv4+
         Z/d/4nB2wk4CLERLmyyDDWuXNXMBDhYOSOJug9IVfhrxKJoEn+AqHdio2hy9ClO0BK1b
         p40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TqnRymZHVB3nETq43Yyx3kDj0Su1WqRmQVreGP9eeAM=;
        b=m8aevu/Oeustdc6M5yWh2vXGQsGOyQdPmLO9cpDX2QWLde8U1H3/JfnS1YCH/w1qvH
         xYGv6MID4ImbiuH+gYpKjvzuDjQYczOg2yS3ihV/Io9BJV/8qBuM/BXkae1rtwYqMfB+
         dH0+qkdRw+VdmS5fhk392yXfs4RyEUgk1RQ8sgHzFqybepWGKg69yUsaUEOjPOVKbaSR
         GqegHSrS5WJpRMsww6HWB2EoPa0yeurAKFAwJFnH5N9qptEssU2pjmx9IwZ8cDKwsI5X
         X6PRXPCQCO2kNeiSw50oj09CJQ1Lnkt/XlDm+tR1uR8s/fy+rj7mUqov1YfYSV428bJD
         2snQ==
X-Gm-Message-State: APjAAAVRrLgg0xsAb6KeN5V5t3TmsUe367F7t7YOiuUG+KbCrA/sSQB/
        7q+Mmq3PutjXbSO2pAR5JJuOnA473CE=
X-Google-Smtp-Source: APXvYqzF+PTKz9urDrKppbUD/aENMJ4pxtaMLYaIAnlz/3ezqaTV4JEnelkNmPMCMeGl5wJhux3KWw==
X-Received: by 2002:a05:6000:162e:: with SMTP id v14mr17736905wrb.112.1569924892368;
        Tue, 01 Oct 2019 03:14:52 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t13sm33081133wra.70.2019.10.01.03.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 03:14:51 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] nvmem: imx: scu: support hole region check
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
References: <1569550913-10176-1-git-send-email-peng.fan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <48bc66d5-684a-cfdb-67dd-722dbf80edbf@linaro.org>
Date:   Tue, 1 Oct 2019 11:14:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569550913-10176-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/09/2019 03:23, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Introduce HOLE/ECC_REGION flag and in_hole helper to ease the check
> of hole region. The ECC_REGION is also introduced here which is
> preparing for programming support. ECC_REGION could only be programmed
> once, so need take care.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>   Rebased on latest linux-next
> 
>   drivers/nvmem/imx-ocotp-scu.c | 47 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 5 deletions(-)

thanks, applied both.

--srini
> 
> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
> index 61a17f943f47..030e27ba4dfb 100644
> --- a/drivers/nvmem/imx-ocotp-scu.c
> +++ b/drivers/nvmem/imx-ocotp-scu.c
> @@ -19,9 +19,20 @@ enum ocotp_devtype {
>   	IMX8QM,
>   };
>   
> +#define ECC_REGION	BIT(0)
> +#define HOLE_REGION	BIT(1)
> +
> +struct ocotp_region {
> +	u32 start;
> +	u32 end;
> +	u32 flag;
> +};
> +
>   struct ocotp_devtype_data {
>   	int devtype;
>   	int nregs;
> +	u32 num_region;
> +	struct ocotp_region region[];
>   };
>   
>   struct ocotp_priv {
> @@ -38,13 +49,41 @@ struct imx_sc_msg_misc_fuse_read {
>   static struct ocotp_devtype_data imx8qxp_data = {
>   	.devtype = IMX8QXP,
>   	.nregs = 800,
> +	.num_region = 3,
> +	.region = {
> +		{0x10, 0x10f, ECC_REGION},
> +		{0x110, 0x21F, HOLE_REGION},
> +		{0x220, 0x31F, ECC_REGION},
> +	},
>   };
>   
>   static struct ocotp_devtype_data imx8qm_data = {
>   	.devtype = IMX8QM,
>   	.nregs = 800,
> +	.num_region = 2,
> +	.region = {
> +		{0x10, 0x10f, ECC_REGION},
> +		{0x1a0, 0x1ff, ECC_REGION},
> +	},
>   };
>   
> +static bool in_hole(void *context, u32 index)
> +{
> +	struct ocotp_priv *priv = context;
> +	const struct ocotp_devtype_data *data = priv->data;
> +	int i;
> +
> +	for (i = 0; i < data->num_region; i++) {
> +		if (data->region[i].flag & HOLE_REGION) {
> +			if ((index >= data->region[i].start) &&
> +			    (index <= data->region[i].end))
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>   static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
>   				     u32 *val)
>   {
> @@ -91,11 +130,9 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
>   	buf = p;
>   
>   	for (i = index; i < (index + count); i++) {
> -		if (priv->data->devtype == IMX8QXP) {
> -			if ((i > 271) && (i < 544)) {
> -				*buf++ = 0;
> -				continue;
> -			}
> +		if (in_hole(context, i)) {
> +			*buf++ = 0;
> +			continue;
>   		}
>   
>   		ret = imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
> 
