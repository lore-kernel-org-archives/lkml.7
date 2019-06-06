Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1CDC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E043D20657
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Am2F6jyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfFFKeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:34:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52614 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfFFKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:34:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190606103403euoutp0115622b228ff84b5dc7182d4d2f32683e~llYTf_hwo2073020730euoutp01v
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 10:34:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190606103403euoutp0115622b228ff84b5dc7182d4d2f32683e~llYTf_hwo2073020730euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559817243;
        bh=8hyDbT+pBQKVY9kyqtb9LRUX+7hkEets4cDL1V/PA/w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Am2F6jyn8n3bTkiLleF7hQHYtPNXR73lXe/Lh1W6o+mGNy2Q/sds5EthCHiG7Sl9X
         DiDxPv1vZ+afDdTzNf9qgpLoP4EGBuolXATY27pX8V8FG9J+7lsmYckTuQMXwRpQ/y
         xt0JlJ0l7+PvVaKUEGupDiL7g5yWOuWrA2gW/krc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606103403eucas1p2105e6d63465e69885e58073ac03414d2~llYS06txI2040320403eucas1p2I;
        Thu,  6 Jun 2019 10:34:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 58.85.04298.A1CE8FC5; Thu,  6
        Jun 2019 11:34:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190606103402eucas1p1f7f0cbe27a3ec848d2c9589dafa43171~llYR5SGdg3162431624eucas1p1x;
        Thu,  6 Jun 2019 10:34:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190606103402eusmtrp173992f04b1fccbe318a6d6533a942ae2~llYR4r1Pv1163411634eusmtrp1V;
        Thu,  6 Jun 2019 10:34:02 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-e7-5cf8ec1ae0ef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.56.04140.A1CE8FC5; Thu,  6
        Jun 2019 11:34:02 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190606103401eusmtip2148dba44c6397b58fa4a3a815dff9bba~llYQ2jyMn1703017030eusmtip2O;
        Thu,  6 Jun 2019 10:34:00 +0000 (GMT)
Subject: Re: [PATCH v3 05/15] drm/bridge: tc358767: Drop custom
 tc_write()/tc_read() accessors
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <9f847830-7bc6-c377-5cd7-b3cff783cbb3@samsung.com>
Date:   Thu, 6 Jun 2019 12:33:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605070507.11417-6-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjtvR/zzpreprUHk6IRRpJToeJSGRVRF3+E+SOitFx5Mz+2yZbm
        R5DMkJnVrNByq9RKkiI0dX7MopzkFPFzGiotjawoUkmdLsvKeSf57zzvOc9zzoGXwsW9pB8V
        rzzPqZXyJKnAk6ht+dkV5PfdGRViLtvOZOvCGK0li2S0ujGScfY1E0zTCyvG9DkmBMzIvUGM
        yb3xyIOxme8KGPv7VoKpKB4S7F3J2q5fw9iRgr8Y22Cwe7BGXRHJDudZMVY/H8JaB+owdqpq
        PdtZ0IFFCI977o7lkuJTOXXwnhjPc+NTVix51IzSsg0tWBaq06MrSEgBvQ0mCsvxK8iTEtPl
        CIqr7xP8MI2g0V7oZqYQDNlLPZZWOrW1JE88RjDe2ugexhDk9mcvHvahY+Cro0fgwr50BExq
        GwQuEU47MHjdewNzEQJ6C8xXDy6KRPQeqJwpWTCnKILeBB+/kK7nNfQxGG6pJHnJamgrGiVc
        WLggN9pHFr1wegNkm4w4jyUwNFqMubyA/uEBjbZpjI99ACby29wVfOCbtcaN/aH91lWCx5dg
        uPwyzi/rEJgqG3Ce2AXN1h7SFQ5fCF1hDnZBoPdBf1cCD71gYGw1H8ELbtbexvlnEehyxPyN
        jTDcYXLfk0BZt0OQj6SGZcUMy8oYlpUx/LctQcQTJOFSNIo4ThOq5C7INHKFJkUZJzujUlSh
        hZ/W/sc6WY8cvactiKaQdJUIns9GiUl5qiZdYUFA4VJfUWq3M0osipWnZ3Bq1Sl1ShKnsaB1
        FCGViDJXjJwQ03Hy81wixyVz6iUWo4R+WUgym8hEmhr943Z81h0JDM57kaHXBs3og+4c3PoB
        M3qrkt94yfJtn8Iffr78IKdk4PfLX++iQVGBRdZXVdefvcCE/UkyZorn0sIOvQ14drI5VLZf
        OL7Z5OhZ29W0f2fpUelsUZbkWo0K8gIm38zFhytfhXvZvKP9hbd3OA8zF58mSAnNOXloIK7W
        yP8B9/nFJmUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7pSb37EGOw+wmLR3GFr0XSogdWi
        qeMtq8WPK4dZLA7uOc5kceXrezaLB3NvMll0TlzCbnF51xw2i7v3TrBYrJ9/i82B2+NyXy+T
        x4Op/5k8ds66y+4xu2Mmq8f97uNMHv1/DTyO39jO5PF5k5zHualnmQI4o/RsivJLS1IVMvKL
        S2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy3n0+zlTwZBdjRfOsY0wN
        jNv7GbsYOTkkBEwkzjVtY+1i5OIQEljKKPH0wD0miIS4xO75b5khbGGJP9e62CCKXjNKfDqx
        mA0kISyQIPHy60UwW0TAT6Jr3gEmkCJmge9MEhOX72UBSQgJHGWUeNwYAmKzCWhK/N18E6yB
        V8BOYsO3BUA1HBwsAioSj5+zgoRFBSIkzrxfwQJRIihxcuYTMJsTqHz23QdgVzMLqEv8mXeJ
        GcKWl2jeOhvKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS
        9ZLzczcxAqN427GfW3Ywdr0LPsQowMGoxMMrsfF7jBBrYllxZe4hRgkOZiUR3rILP2KEeFMS
        K6tSi/Lji0pzUosPMZoC/TaRWUo0OR+YYPJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5ak
        ZqemFqQWwfQxcXBKNTCyLOC9mtrjN+H0yx1/lgtd/rDqevrV7Txf450upt95WG7CtfWg5Y8p
        ubzpLpmGuo320rIvb+99xjRl1+dPu9bGNmfNXx2zoZTzbczJHrkLWx0SA+Z/aTWJnqq7bN3E
        4zxP6rYr2p6P/zP5x6vgbVMOxXJN+TK5Iy9P4pKhP1vM1RMecuk9K7yClViKMxINtZiLihMB
        pSVcRfgCAAA=
X-CMS-MailID: 20190606103402eucas1p1f7f0cbe27a3ec848d2c9589dafa43171
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605070532epcas2p2154c96c417cca1c1fc3c149c66447560
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605070532epcas2p2154c96c417cca1c1fc3c149c66447560
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
        <CGME20190605070532epcas2p2154c96c417cca1c1fc3c149c66447560@epcas2p2.samsung.com>
        <20190605070507.11417-6-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2019 09:04, Andrey Smirnov wrote:
> A very unfortunate aspect of tc_write()/tc_read() macro helpers is
> that they capture quite a bit of context around them and thus require
> the caller to have magic variables 'ret' and 'tc' as well as label
> 'err'. That makes a number of code paths rather counterintuitive and
> somewhat clunky, for example tc_stream_clock_calc() ends up being like
> this:
>
> 	int ret;
>
> 	tc_write(DP0_VIDMNGEN1, 32768);
>
> 	return 0;
> err:
> 	return ret;
>
> which is rather surprising when you read the code for the first
> time. Since those helpers arguably aren't really saving that much code
> and there's no way of fixing them without making them too verbose to
> be worth it change the driver code to not use them at all.


On the other side, error checking after every registry access is very
annoying and significantly augments the code, makes it redundant and
less readable. To avoid it one can cache error state, and do not perform
real work until the error is clear. For example with following accessor:

void tc_write(struct tc_data *tc, u32 reg, u32 val){

    int ret;

    if (tc->error) //This check is IMPORTANT

        return;

    ret =regmap_write(...);

    if (ret >= 0)

        return;

    tc->error = ret;

    dev_err(tc->dev, "Error writing register %#x\n", reg);

}

You can safely write code like:

    tc_write(tc, DP_PHY_CTRL, BGREN | PWR_SW_EN | PHY_A0_EN);

    tc_write(tc, DP0_PLLCTRL, PLLUPDATE | PLLEN);

    tc_write(tc, DP1_PLLCTRL, PLLUPDATE | PLLEN);

    if (tc->error) {

        tc->error = 0;

        goto err;

    }

This is of course loose suggestion.

Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej



>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 381 ++++++++++++++++++------------
>  1 file changed, 229 insertions(+), 152 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index c0fc686ce5ec..e197ce0fb166 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -280,20 +280,6 @@ static inline struct tc_data *connector_to_tc(struct drm_connector *c)
>  	return container_of(c, struct tc_data, connector);
>  }
>  
> -/* Simple macros to avoid repeated error checks */
> -#define tc_write(reg, var)					\
> -	do {							\
> -		ret = regmap_write(tc->regmap, reg, var);	\
> -		if (ret)					\
> -			goto err;				\
> -	} while (0)
> -#define tc_read(reg, var)					\
> -	do {							\
> -		ret = regmap_read(tc->regmap, reg, var);	\
> -		if (ret)					\
> -			goto err;				\
> -	} while (0)
> -
>  static inline int tc_poll_timeout(struct tc_data *tc, unsigned int addr,
>  				  unsigned int cond_mask,
>  				  unsigned int cond_value,
> @@ -351,7 +337,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  
>  	ret = tc_aux_wait_busy(tc, 100);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	if (request == DP_AUX_I2C_WRITE || request == DP_AUX_NATIVE_WRITE) {
>  		/* Store data */
> @@ -362,7 +348,11 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  				tmp = (tmp << 8) | buf[i];
>  			i++;
>  			if (((i % 4) == 0) || (i == size)) {
> -				tc_write(DP0_AUXWDATA((i - 1) >> 2), tmp);
> +				ret = regmap_write(tc->regmap,
> +						   DP0_AUXWDATA((i - 1) >> 2),
> +						   tmp);
> +				if (ret)
> +					return ret;
>  				tmp = 0;
>  			}
>  		}
> @@ -372,23 +362,32 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	}
>  
>  	/* Store address */
> -	tc_write(DP0_AUXADDR, msg->address);
> +	ret = regmap_write(tc->regmap, DP0_AUXADDR, msg->address);
> +	if (ret)
> +		return ret;
>  	/* Start transfer */
> -	tc_write(DP0_AUXCFG0, ((size - 1) << 8) | request);
> +	ret = regmap_write(tc->regmap, DP0_AUXCFG0,
> +			   ((size - 1) << 8) | request);
> +	if (ret)
> +		return ret;
>  
>  	ret = tc_aux_wait_busy(tc, 100);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	ret = tc_aux_get_status(tc, &msg->reply);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	if (request == DP_AUX_I2C_READ || request == DP_AUX_NATIVE_READ) {
>  		/* Read data */
>  		while (i < size) {
> -			if ((i % 4) == 0)
> -				tc_read(DP0_AUXRDATA(i >> 2), &tmp);
> +			if ((i % 4) == 0) {
> +				ret = regmap_read(tc->regmap,
> +						  DP0_AUXRDATA(i >> 2), &tmp);
> +				if (ret)
> +					return ret;
> +			}
>  			buf[i] = tmp & 0xff;
>  			tmp = tmp >> 8;
>  			i++;
> @@ -396,8 +395,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	}
>  
>  	return size;
> -err:
> -	return ret;
>  }
>  
>  static const char * const training_pattern1_errors[] = {
> @@ -454,6 +451,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
>  	int ext_div[] = {1, 2, 3, 5, 7};
>  	int best_pixelclock = 0;
>  	int vco_hi = 0;
> +	u32 pxl_pllparam;
>  
>  	dev_dbg(tc->dev, "PLL: requested %d pixelclock, ref %d\n", pixelclock,
>  		refclk);
> @@ -523,24 +521,29 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
>  		best_mul = 0;
>  
>  	/* Power up PLL and switch to bypass */
> -	tc_write(PXL_PLLCTRL, PLLBYP | PLLEN);
> +	ret = regmap_write(tc->regmap, PXL_PLLCTRL, PLLBYP | PLLEN);
> +	if (ret)
> +		return ret;
> +
> +	pxl_pllparam  = vco_hi << 24; /* For PLL VCO >= 300 MHz = 1 */
> +	pxl_pllparam |= ext_div[best_pre] << 20; /* External Pre-divider */
> +	pxl_pllparam |= ext_div[best_post] << 16; /* External Post-divider */
> +	pxl_pllparam |= IN_SEL_REFCLK; /* Use RefClk as PLL input */
> +	pxl_pllparam |= best_div << 8; /* Divider for PLL RefClk */
> +	pxl_pllparam |= best_mul; /* Multiplier for PLL */
>  
> -	tc_write(PXL_PLLPARAM,
> -		 (vco_hi << 24) |		/* For PLL VCO >= 300 MHz = 1 */
> -		 (ext_div[best_pre] << 20) |	/* External Pre-divider */
> -		 (ext_div[best_post] << 16) |	/* External Post-divider */
> -		 IN_SEL_REFCLK |		/* Use RefClk as PLL input */
> -		 (best_div << 8) |		/* Divider for PLL RefClk */
> -		 (best_mul << 0));		/* Multiplier for PLL */
> +	ret = regmap_write(tc->regmap, PXL_PLLPARAM, pxl_pllparam);
> +	if (ret)
> +		return ret;
>  
>  	/* Force PLL parameter update and disable bypass */
> -	tc_write(PXL_PLLCTRL, PLLUPDATE | PLLEN);
> +	ret = regmap_write(tc->regmap, PXL_PLLCTRL, PLLUPDATE | PLLEN);
> +	if (ret)
> +		return ret;
>  
>  	tc_wait_pll_lock(tc);
>  
>  	return 0;
> -err:
> -	return ret;
>  }
>  
>  static int tc_pxl_pll_dis(struct tc_data *tc)
> @@ -551,7 +554,6 @@ static int tc_pxl_pll_dis(struct tc_data *tc)
>  
>  static int tc_stream_clock_calc(struct tc_data *tc)
>  {
> -	int ret;
>  	/*
>  	 * If the Stream clock and Link Symbol clock are
>  	 * asynchronous with each other, the value of M changes over
> @@ -567,16 +569,13 @@ static int tc_stream_clock_calc(struct tc_data *tc)
>  	 * M/N = f_STRMCLK / f_LSCLK
>  	 *
>  	 */
> -	tc_write(DP0_VIDMNGEN1, 32768);
> -
> -	return 0;
> -err:
> -	return ret;
> +	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
>  }
>  
>  static int tc_aux_link_setup(struct tc_data *tc)
>  {
>  	unsigned long rate;
> +	u32 dp0_auxcfg1;
>  	u32 value;
>  	int ret;
>  
> @@ -601,18 +600,25 @@ static int tc_aux_link_setup(struct tc_data *tc)
>  
>  	/* Setup DP-PHY / PLL */
>  	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
> -	tc_write(SYS_PLLPARAM, value);
> -
> -	tc_write(DP_PHY_CTRL, BGREN | PWR_SW_EN | PHY_A0_EN);
> +	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
> +	if (ret)
> +		goto err;
>  
> +	ret = regmap_write(tc->regmap, DP_PHY_CTRL, BGREN | PWR_SW_EN | PHY_A0_EN);
> +	if (ret)
> +		goto err;
>  	/*
>  	 * Initially PLLs are in bypass. Force PLL parameter update,
>  	 * disable PLL bypass, enable PLL
>  	 */
> -	tc_write(DP0_PLLCTRL, PLLUPDATE | PLLEN);
> +	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
> +	if (ret)
> +		goto err;
>  	tc_wait_pll_lock(tc);
>  
> -	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
> +	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
> +	if (ret)
> +		goto err;
>  	tc_wait_pll_lock(tc);
>  
>  	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
> @@ -624,9 +630,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
>  	}
>  
>  	/* Setup AUX link */
> -	tc_write(DP0_AUXCFG1, AUX_RX_FILTER_EN |
> -		 (0x06 << 8) |	/* Aux Bit Period Calculator Threshold */
> -		 (0x3f << 0));	/* Aux Response Timeout Timer */
> +	dp0_auxcfg1  = AUX_RX_FILTER_EN;
> +	dp0_auxcfg1 |= 0x06 << 8; /* Aux Bit Period Calculator Threshold */
> +	dp0_auxcfg1 |= 0x3f << 0; /* Aux Response Timeout Timer */
> +
> +	ret = regmap_write(tc->regmap, DP0_AUXCFG1, dp0_auxcfg1);
> +	if (ret)
> +		goto err;
>  
>  	return 0;
>  err:
> @@ -727,48 +737,73 @@ static int tc_set_video_mode(struct tc_data *tc,
>  	 * assume we do not need any delay when DPI is a source of
>  	 * sync signals
>  	 */
> -	tc_write(VPCTRL0,
> -		 FIELD_PREP(VSDELAY, 0) |
> -		 OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
> -	tc_write(HTIM01,
> -		 FIELD_PREP(HBPR, ALIGN(left_margin, 2)) |
> -		 FIELD_PREP(HPW, ALIGN(hsync_len, 2)));
> -	tc_write(HTIM02,
> -		 FIELD_PREP(HDISPR, ALIGN(mode->hdisplay, 2)) |
> -		 FIELD_PREP(HFPR, ALIGN(right_margin, 2)));
> -	tc_write(VTIM01,
> -		 FIELD_PREP(VBPR, upper_margin) |
> -		 FIELD_PREP(VSPR, vsync_len));
> -	tc_write(VTIM02,
> -		 FIELD_PREP(VFPR, lower_margin) |
> -		 FIELD_PREP(VDISPR, mode->vdisplay));
> -	tc_write(VFUEN0, VFUEN);		/* update settings */
> +	ret = regmap_write(tc->regmap, VPCTRL0,
> +			   FIELD_PREP(VSDELAY, 0) |
> +			   OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(tc->regmap, HTIM01,
> +			   FIELD_PREP(HBPR, ALIGN(left_margin, 2)) |
> +			   FIELD_PREP(HPW, ALIGN(hsync_len, 2)));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(tc->regmap, HTIM02,
> +			   FIELD_PREP(HDISPR, ALIGN(mode->hdisplay, 2)) |
> +			   FIELD_PREP(HFPR, ALIGN(right_margin, 2)));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(tc->regmap, VTIM01,
> +			   FIELD_PREP(VBPR, upper_margin) |
> +			   FIELD_PREP(VSPR, vsync_len));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(tc->regmap, VTIM02,
> +			   FIELD_PREP(VFPR, lower_margin) |
> +			   FIELD_PREP(VDISPR, mode->vdisplay));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(tc->regmap, VFUEN0, VFUEN); /* update settings */
> +	if (ret)
> +		return ret;
>  
>  	/* Test pattern settings */
> -	tc_write(TSTCTL,
> -		 FIELD_PREP(COLOR_R, 120) |
> -		 FIELD_PREP(COLOR_G, 20) |
> -		 FIELD_PREP(COLOR_B, 99) |
> -		 ENI2CFILTER |
> -		 FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS));
> +	ret = regmap_write(tc->regmap, TSTCTL,
> +			   FIELD_PREP(COLOR_R, 120) |
> +			   FIELD_PREP(COLOR_G, 20) |
> +			   FIELD_PREP(COLOR_B, 99) |
> +			   ENI2CFILTER |
> +			   FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS));
> +	if (ret)
> +		return ret;
>  
>  	/* DP Main Stream Attributes */
>  	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
> -	tc_write(DP0_VIDSYNCDELAY,
> +	ret = regmap_write(tc->regmap, DP0_VIDSYNCDELAY,
>  		 FIELD_PREP(THRESH_DLY, max_tu_symbol) |
>  		 FIELD_PREP(VID_SYNC_DLY, vid_sync_dly));
>  
> -	tc_write(DP0_TOTALVAL,
> -		 FIELD_PREP(H_TOTAL, mode->htotal) |
> -		 FIELD_PREP(V_TOTAL, mode->vtotal));
> +	ret = regmap_write(tc->regmap, DP0_TOTALVAL,
> +			   FIELD_PREP(H_TOTAL, mode->htotal) |
> +			   FIELD_PREP(V_TOTAL, mode->vtotal));
> +	if (ret)
> +		return ret;
>  
> -	tc_write(DP0_STARTVAL,
> -		 FIELD_PREP(H_START, left_margin + hsync_len) |
> -		 FIELD_PREP(V_START, upper_margin + vsync_len));
> +	ret = regmap_write(tc->regmap, DP0_STARTVAL,
> +			   FIELD_PREP(H_START, left_margin + hsync_len) |
> +			   FIELD_PREP(V_START, upper_margin + vsync_len));
> +	if (ret)
> +		return ret;
>  
> -	tc_write(DP0_ACTIVEVAL,
> -		 FIELD_PREP(V_ACT, mode->vdisplay) |
> -		 FIELD_PREP(H_ACT, mode->hdisplay));
> +	ret = regmap_write(tc->regmap, DP0_ACTIVEVAL,
> +			   FIELD_PREP(V_ACT, mode->vdisplay) |
> +			   FIELD_PREP(H_ACT, mode->hdisplay));
> +	if (ret)
> +		return ret;
>  
>  	dp0_syncval = FIELD_PREP(VS_WIDTH, vsync_len) |
>  		      FIELD_PREP(HS_WIDTH, hsync_len);
> @@ -779,21 +814,25 @@ static int tc_set_video_mode(struct tc_data *tc,
>  	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
>  		dp0_syncval |= SYNCVAL_HS_POL_ACTIVE_LOW;
>  
> -	tc_write(DP0_SYNCVAL, dp0_syncval);
> +	ret = regmap_write(tc->regmap, DP0_SYNCVAL, dp0_syncval);
> +	if (ret)
> +		return ret;
>  
> -	tc_write(DPIPXLFMT,
> -		 VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
> -		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 |
> -		 DPI_BPP_RGB888);
> +	ret = regmap_write(tc->regmap, DPIPXLFMT,
> +			   VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
> +			   DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 |
> +			   DPI_BPP_RGB888);
> +	if (ret)
> +		return ret;
>  
> -	tc_write(DP0_MISC,
> -		 FIELD_PREP(MAX_TU_SYMBOL, max_tu_symbol) |
> -		 FIELD_PREP(TU_SIZE, TU_SIZE_RECOMMENDED) |
> -		 BPC_8);
> +	ret = regmap_write(tc->regmap, DP0_MISC,
> +			   FIELD_PREP(MAX_TU_SYMBOL, max_tu_symbol) |
> +			   FIELD_PREP(TU_SIZE, TU_SIZE_RECOMMENDED) |
> +			   BPC_8);
> +	if (ret)
> +		return ret;
>  
>  	return 0;
> -err:
> -	return ret;
>  }
>  
>  static int tc_wait_link_training(struct tc_data *tc)
> @@ -808,11 +847,11 @@ static int tc_wait_link_training(struct tc_data *tc)
>  		return ret;
>  	}
>  
> -	tc_read(DP0_LTSTAT, &value);
> +	ret = regmap_read(tc->regmap, DP0_LTSTAT, &value);
> +	if (ret)
> +		return ret;
>  
>  	return (value >> 8) & 0x7;
> -err:
> -	return ret;
>  }
>  
>  static int tc_main_link_enable(struct tc_data *tc)
> @@ -827,15 +866,25 @@ static int tc_main_link_enable(struct tc_data *tc)
>  
>  	dev_dbg(tc->dev, "link enable\n");
>  
> -	tc_read(DP0CTL, &value);
> -	if (WARN_ON(value & DP_EN))
> -		tc_write(DP0CTL, 0);
> +	ret = regmap_read(tc->regmap, DP0CTL, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (WARN_ON(value & DP_EN)) {
> +		ret = regmap_write(tc->regmap, DP0CTL, 0);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	tc_write(DP0_SRCCTRL, tc_srcctrl(tc));
> +	ret = regmap_write(tc->regmap, DP0_SRCCTRL, tc_srcctrl(tc));
> +	if (ret)
> +		return ret;
>  	/* SSCG and BW27 on DP1 must be set to the same as on DP0 */
> -	tc_write(DP1_SRCCTRL,
> +	ret = regmap_write(tc->regmap, DP1_SRCCTRL,
>  		 (tc->link.spread ? DP0_SRCCTRL_SSCG : 0) |
>  		 ((tc->link.base.rate != 162000) ? DP0_SRCCTRL_BW27 : 0));
> +	if (ret)
> +		return ret;
>  
>  	rate = clk_get_rate(tc->refclk);
>  	switch (rate) {
> @@ -855,27 +904,36 @@ static int tc_main_link_enable(struct tc_data *tc)
>  		return -EINVAL;
>  	}
>  	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
> -	tc_write(SYS_PLLPARAM, value);
> +	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
> +	if (ret)
> +		return ret;
>  
>  	/* Setup Main Link */
>  	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN | PHY_M0_EN;
>  	if (tc->link.base.num_lanes == 2)
>  		dp_phy_ctrl |= PHY_2LANE;
> -	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
> +
> +	ret = regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
> +	if (ret)
> +		return ret;
>  
>  	/* PLL setup */
> -	tc_write(DP0_PLLCTRL, PLLUPDATE | PLLEN);
> +	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
> +	if (ret)
> +		return ret;
>  	tc_wait_pll_lock(tc);
>  
> -	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
> +	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
> +	if (ret)
> +		return ret;
>  	tc_wait_pll_lock(tc);
>  
>  	/* Reset/Enable Main Links */
>  	dp_phy_ctrl |= DP_PHY_RST | PHY_M1_RST | PHY_M0_RST;
> -	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
> +	ret = regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
>  	usleep_range(100, 200);
>  	dp_phy_ctrl &= ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
> -	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
> +	ret = regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
>  
>  	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
>  	if (ret) {
> @@ -887,7 +945,7 @@ static int tc_main_link_enable(struct tc_data *tc)
>  	/* Set misc: 8 bits per color */
>  	ret = regmap_update_bits(tc->regmap, DP0_MISC, BPC_8, BPC_8);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	/*
>  	 * ASSR mode
> @@ -940,53 +998,71 @@ static int tc_main_link_enable(struct tc_data *tc)
>  	/* Clock-Recovery */
>  
>  	/* Set DPCD 0x102 for Training Pattern 1 */
> -	tc_write(DP0_SNKLTCTRL, DP_LINK_SCRAMBLING_DISABLE |
> -		 DP_TRAINING_PATTERN_1);
> +	ret = regmap_write(tc->regmap, DP0_SNKLTCTRL,
> +			   DP_LINK_SCRAMBLING_DISABLE |
> +			   DP_TRAINING_PATTERN_1);
> +	if (ret)
> +		return ret;
>  
> -	tc_write(DP0_LTLOOPCTRL,
> -		 (15 << 28) |	/* Defer Iteration Count */
> -		 (15 << 24) |	/* Loop Iteration Count */
> -		 (0xd << 0));	/* Loop Timer Delay */
> +	ret = regmap_write(tc->regmap, DP0_LTLOOPCTRL,
> +			   (15 << 28) |	/* Defer Iteration Count */
> +			   (15 << 24) |	/* Loop Iteration Count */
> +			   (0xd << 0));	/* Loop Timer Delay */
> +	if (ret)
> +		return ret;
>  
> -	tc_write(DP0_SRCCTRL, tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS |
> -		 DP0_SRCCTRL_AUTOCORRECT | DP0_SRCCTRL_TP1);
> +	ret = regmap_write(tc->regmap, DP0_SRCCTRL,
> +			   tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS |
> +			   DP0_SRCCTRL_AUTOCORRECT |
> +			   DP0_SRCCTRL_TP1);
> +	if (ret)
> +		return ret;
>  
>  	/* Enable DP0 to start Link Training */
> -	tc_write(DP0CTL,
> -		 ((tc->link.base.capabilities & DP_LINK_CAP_ENHANCED_FRAMING) ? EF_EN : 0) |
> -		 DP_EN);
> +	ret = regmap_write(tc->regmap, DP0CTL,
> +			   ((tc->link.base.capabilities &
> +			     DP_LINK_CAP_ENHANCED_FRAMING) ? EF_EN : 0) |
> +			   DP_EN);
> +	if (ret)
> +		return ret;
>  
>  	/* wait */
> +
>  	ret = tc_wait_link_training(tc);
>  	if (ret < 0)
> -		goto err;
> +		return ret;
>  
>  	if (ret) {
>  		dev_err(tc->dev, "Link training phase 1 failed: %s\n",
>  			training_pattern1_errors[ret]);
> -		ret = -ENODEV;
> -		goto err;
> +		return -ENODEV;
>  	}
>  
>  	/* Channel Equalization */
>  
>  	/* Set DPCD 0x102 for Training Pattern 2 */
> -	tc_write(DP0_SNKLTCTRL, DP_LINK_SCRAMBLING_DISABLE |
> -		 DP_TRAINING_PATTERN_2);
> +	ret = regmap_write(tc->regmap, DP0_SNKLTCTRL,
> +			   DP_LINK_SCRAMBLING_DISABLE |
> +			   DP_TRAINING_PATTERN_2);
> +	if (ret)
> +		return ret;
>  
> -	tc_write(DP0_SRCCTRL, tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS |
> -		 DP0_SRCCTRL_AUTOCORRECT | DP0_SRCCTRL_TP2);
> +	ret = regmap_write(tc->regmap, DP0_SRCCTRL,
> +			   tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS |
> +			   DP0_SRCCTRL_AUTOCORRECT |
> +			   DP0_SRCCTRL_TP2);
> +	if (ret)
> +		return ret;
>  
>  	/* wait */
>  	ret = tc_wait_link_training(tc);
>  	if (ret < 0)
> -		goto err;
> +		return ret;
>  
>  	if (ret) {
>  		dev_err(tc->dev, "Link training phase 2 failed: %s\n",
>  			training_pattern2_errors[ret]);
> -		ret = -ENODEV;
> -		goto err;
> +		return -ENODEV;
>  	}
>  
>  	/*
> @@ -999,7 +1075,10 @@ static int tc_main_link_enable(struct tc_data *tc)
>  	 */
>  
>  	/* Clear Training Pattern, set AutoCorrect Mode = 1 */
> -	tc_write(DP0_SRCCTRL, tc_srcctrl(tc) | DP0_SRCCTRL_AUTOCORRECT);
> +	ret = regmap_write(tc->regmap, DP0_SRCCTRL, tc_srcctrl(tc) |
> +			   DP0_SRCCTRL_AUTOCORRECT);
> +	if (ret)
> +		return ret;
>  
>  	/* Clear DPCD 0x102 */
>  	/* Note: Can Not use DP0_SNKLTCTRL (0x06E4) short cut */
> @@ -1043,7 +1122,7 @@ static int tc_main_link_enable(struct tc_data *tc)
>  		dev_err(dev, "0x0205 SINK_STATUS:               0x%02x\n", tmp[3]);
>  		dev_err(dev, "0x0206 ADJUST_REQUEST_LANE0_1:    0x%02x\n", tmp[4]);
>  		dev_err(dev, "0x0207 ADJUST_REQUEST_LANE2_3:    0x%02x\n", tmp[5]);
> -		goto err;
> +		return ret;
>  	}
>  
>  	return 0;
> @@ -1052,7 +1131,6 @@ static int tc_main_link_enable(struct tc_data *tc)
>  	return ret;
>  err_dpcd_write:
>  	dev_err(tc->dev, "Failed to write DPCD: %d\n", ret);
> -err:
>  	return ret;
>  }
>  
> @@ -1062,12 +1140,11 @@ static int tc_main_link_disable(struct tc_data *tc)
>  
>  	dev_dbg(tc->dev, "link disable\n");
>  
> -	tc_write(DP0_SRCCTRL, 0);
> -	tc_write(DP0CTL, 0);
> +	ret = regmap_write(tc->regmap, DP0_SRCCTRL, 0);
> +	if (ret)
> +		return ret;
>  
> -	return 0;
> -err:
> -	return ret;
> +	return regmap_write(tc->regmap, DP0CTL, 0);
>  }
>  
>  static int tc_stream_enable(struct tc_data *tc)
> @@ -1082,7 +1159,7 @@ static int tc_stream_enable(struct tc_data *tc)
>  		ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
>  				    1000 * tc->mode.clock);
>  		if (ret)
> -			goto err;
> +			return ret;
>  	}
>  
>  	ret = tc_set_video_mode(tc, &tc->mode);
> @@ -1097,7 +1174,9 @@ static int tc_stream_enable(struct tc_data *tc)
>  	value = VID_MN_GEN | DP_EN;
>  	if (tc->link.base.capabilities & DP_LINK_CAP_ENHANCED_FRAMING)
>  		value |= EF_EN;
> -	tc_write(DP0CTL, value);
> +	ret = regmap_write(tc->regmap, DP0CTL, value);
> +	if (ret)
> +		return ret;
>  	/*
>  	 * VID_EN assertion should be delayed by at least N * LSCLK
>  	 * cycles from the time VID_MN_GEN is enabled in order to
> @@ -1107,36 +1186,35 @@ static int tc_stream_enable(struct tc_data *tc)
>  	 */
>  	usleep_range(500, 1000);
>  	value |= VID_EN;
> -	tc_write(DP0CTL, value);
> +	ret = regmap_write(tc->regmap, DP0CTL, value);
> +	if (ret)
> +		return ret;
>  	/* Set input interface */
>  	value = DP0_AUDSRC_NO_INPUT;
>  	if (tc_test_pattern)
>  		value |= DP0_VIDSRC_COLOR_BAR;
>  	else
>  		value |= DP0_VIDSRC_DPI_RX;
> -	tc_write(SYSCTRL, value);
> +	ret = regmap_write(tc->regmap, SYSCTRL, value);
> +	if (ret)
> +		return ret;
>  
>  	return 0;
> -err:
> -	return ret;
>  }
>  
>  static int tc_stream_disable(struct tc_data *tc)
>  {
>  	int ret;
> -	u32 val;
>  
>  	dev_dbg(tc->dev, "disable video stream\n");
>  
> -	tc_read(DP0CTL, &val);
> -	val &= ~VID_EN;
> -	tc_write(DP0CTL, val);
> +	ret = regmap_update_bits(tc->regmap, DP0CTL, VID_EN, 0);
> +	if (ret)
> +		return ret;
>  
>  	tc_pxl_pll_dis(tc);
>  
>  	return 0;
> -err:
> -	return ret;
>  }
>  
>  static void tc_bridge_pre_enable(struct drm_bridge *bridge)
> @@ -1328,7 +1406,9 @@ static enum drm_connector_status tc_connector_detect(struct drm_connector *conne
>  			return connector_status_unknown;
>  	}
>  
> -	tc_read(GPIOI, &val);
> +	ret = regmap_read(tc->regmap, GPIOI, &val);
> +	if (ret)
> +		return connector_status_unknown;
>  
>  	conn = val & BIT(tc->hpd_pin);
>  
> @@ -1336,9 +1416,6 @@ static enum drm_connector_status tc_connector_detect(struct drm_connector *conne
>  		return connector_status_connected;
>  	else
>  		return connector_status_disconnected;
> -
> -err:
> -	return connector_status_unknown;
>  }
>  
>  static const struct drm_connector_funcs tc_connector_funcs = {


