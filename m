Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC4AC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9123208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jib87QJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfFGGPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:15:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36205 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFGGPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:15:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607061535euoutp013f648157d0df9f7face771df33017426~l1f6oJ_pJ3086130861euoutp01o
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 06:15:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607061535euoutp013f648157d0df9f7face771df33017426~l1f6oJ_pJ3086130861euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559888135;
        bh=JTIdOf4q9i6u6iRJTmQCDtCZM0ySuHwp5IeDLfRv2Fc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Jib87QJk+oc3rAu0B0hNKp2g51Pgntv5hbypFoq4YKrXFPAU+fgZw3TYYRsLzetAp
         hDYJao2FCiId7oiYTAWRFcNK/kTGN75YFuaK5ZAIpETJZxNbDGpsz1zQb7oPHgby+q
         H70PxS6QONKonZYCbUY3XllXk1RDTWACHyzqO4iE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607061534eucas1p2a29e9a90c9ca901cf15fd11e28a06ed6~l1f57fI4z0190001900eucas1p2S;
        Fri,  7 Jun 2019 06:15:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 73.68.04298.6010AFC5; Fri,  7
        Jun 2019 07:15:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607061534eucas1p1bd90a699e88649a5af1b3f0da2ea8587~l1f5ONAKc1393713937eucas1p1A;
        Fri,  7 Jun 2019 06:15:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607061533eusmtrp2248c764b08636df309bb68015e3c1825~l1f4_lz1t2024820248eusmtrp2V;
        Fri,  7 Jun 2019 06:15:33 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-96-5cfa0106b510
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.DA.04146.5010AFC5; Fri,  7
        Jun 2019 07:15:33 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190607061532eusmtip2e494029b58080ebdcedcd6aadea5278e~l1f32ltaD0058200582eusmtip2S;
        Fri,  7 Jun 2019 06:15:32 +0000 (GMT)
Subject: Re: [PATCH v4 11/15] drm/bridge: tc358767: Introduce
 tc_set_syspllparam()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <ec583c9f-2d67-0168-12b8-18050b4b429d@samsung.com>
Date:   Fri, 7 Jun 2019 08:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607044550.13361-12-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTcRTt9772Zk2ey9jNPqQlQYFaEPWg0gKpVxBYBEUqtfJp5TZlT1cZ
        4ZgW09LSHOFUFEsSSxyW5ab0MasVlq4alUFOSzKMJVijXJn5fIv879xz7rnnXrg0rvSQUfRR
        fS5v0Gu0aiqMuP14oi+WQsHU1R3WFWyhZRNrdplI1mzxk+xPbzfBPuhyY6w3MEaxg7X9GFtc
        flXGvnLWUOz7gScE21r3jto8l3tVVopxg9YpjHPY3su4aksVyfnOuTHuwuRqzv32DsZ9a1vK
        9VqfY8ny/WEb03ntUSNviE84GHbk+v1RlGNfdMJZfgs3oZEFJUhOA7MWJoor8RIURiuZJgTV
        LjslFd8RNHaZQ8o3BLaWAPHP8nDUTkjCNQQVpmekVPgR+Mo+Tvtpej6zBz6bUkRDJJMM42bH
        zFicCWBw9tFnJAoUsxImb/ZTIlYwCdDrcc4kEEwMVHZ/ncELmH3ge2wnpZ4IeFo1TIjz5Uwi
        OKcMIo0z0VDYXo1LWAXvhuswMQsYvwx+jXzBpa2ToM53N4Tnw6j7lkzCi2HKIRpEXAC+piJc
        MlsQtNsdIcMG6Ha/IMVgfHrpVme8RG+Bns4yJNLAhMNbf4S0QzhU3L6MS7QCLGeVUvcy8D1v
        Dw1UQaMnQF1Eatusw2yzrrHNusb2P7ceEc1IxecJukxeWKPnj8cJGp2Qp8+MO5yta0PTf9bz
        xz3egQIvD7kQQyP1PAUnm0hVkhqjcFLnQkDj6kiF0fMzValI15zM5w3ZBwx5Wl5woUU0oVYp
        Ts0ZTFEymZpcPovnc3jDPxWj5VEmdHz3ztNpI7WfKhpPl15piL0xZK1Pwlq2OcaNjvI3Oce8
        2dv7o2uyFhrpGnfGvcmWJeb4SwO20rTg1XV7UIy5aGyDJyXrWHD507UpO4r2Ert+NFDDvefX
        n+kr1Ob8BoelPWOr19AcGdxW18l3FfQMESUfPo20+rRvXg/kFyb26U+oCeGIZs0q3CBo/gJT
        84pdYwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xe7qsjL9iDE43mVg0d9haNB1qYLVo
        6njLavHjymEWi4N7jjNZXPn6ns3iwdybTBadE5ewW1zeNYfN4u69EywW6+ffYnPg9rjc18vk
        8WDqfyaPnbPusnvM7pjJ6nG/+ziTR/9fA4/jN7YzeXzeJOdxbupZpgDOKD2bovzSklSFjPzi
        ElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M1QdeMRZskK7YNXELcwPj
        c9EuRk4OCQETiSOvNrB0MXJxCAksZZQ4/egtC0RCXGL3/LfMELawxJ9rXWwQRa8ZJZoOzGDq
        YuTgEBYIkXjREA1SIyLgJ9E17wATSA2zwHcmif8Xz0NNPcYo0d+xhg2kik1AU+Lv5ptgNq+A
        ncS5C7vAtrEIqEhMOfwOzBYViJA4834FC0SNoMTJmU9YQJZxCthL7PpfBBJmFlCX+DPvEjOE
        LS/RvHU2lC0ucevJfKYJjEKzkHTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl
        5+duYgRG8LZjPzfvYLy0MfgQowAHoxIPrwPDzxgh1sSy4srcQ4wSHMxKIrxlF37ECPGmJFZW
        pRblxxeV5qQWH2I0BfptIrOUaHI+MLnklcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1O
        TS1ILYLpY+LglGpgDEwLnpt/tmjS3df87BHy5ipy5SFdv7dlruiaxDj5+CVHe1Ex5iIbUx4W
        tU7hsuPCW4/Psen/IPl/ceHchY4s+woPfRRIvZBulvfjoYFkl0fBvYrG3faHJHNEnKYvnJx/
        tflWmGH+M/agr7PEfqprv/xVt/Bfy30/gUzvM2o3GbqdjxY1uV9UYinOSDTUYi4qTgQA6GoI
        oPYCAAA=
X-CMS-MailID: 20190607061534eucas1p1bd90a699e88649a5af1b3f0da2ea8587
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607044646epcas1p29293d79cf80db6b15cc97336ebcc8d4e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607044646epcas1p29293d79cf80db6b15cc97336ebcc8d4e
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
        <CGME20190607044646epcas1p29293d79cf80db6b15cc97336ebcc8d4e@epcas1p2.samsung.com>
        <20190607044550.13361-12-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2019 06:45, Andrey Smirnov wrote:
> Move common code converting clock rate to an appropriate constant and
> configuring SYS_PLLPARAM register into a separate routine and convert
> the rest of the code to use it. No functional change intended.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 46 +++++++++++--------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 4bb9b15e1324..ac55b59249e3 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -581,35 +581,40 @@ static int tc_stream_clock_calc(struct tc_data *tc)
>  	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
>  }
>  
> -static int tc_aux_link_setup(struct tc_data *tc)
> +static int tc_set_syspllparam(struct tc_data *tc)
>  {
>  	unsigned long rate;
> -	u32 dp0_auxcfg1;
> -	u32 value;
> -	int ret;
> +	u32 pllparam = SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
>  
>  	rate = clk_get_rate(tc->refclk);
>  	switch (rate) {
>  	case 38400000:
> -		value = REF_FREQ_38M4;
> +		pllparam |= REF_FREQ_38M4;
>  		break;
>  	case 26000000:
> -		value = REF_FREQ_26M;
> +		pllparam |= REF_FREQ_26M;
>  		break;
>  	case 19200000:
> -		value = REF_FREQ_19M2;
> +		pllparam |= REF_FREQ_19M2;
>  		break;
>  	case 13000000:
> -		value = REF_FREQ_13M;
> +		pllparam |= REF_FREQ_13M;
>  		break;
>  	default:
>  		dev_err(tc->dev, "Invalid refclk rate: %lu Hz\n", rate);
>  		return -EINVAL;
>  	}
>  
> +	return regmap_write(tc->regmap, SYS_PLLPARAM, pllparam);
> +}
> +
> +static int tc_aux_link_setup(struct tc_data *tc)
> +{
> +	int ret;
> +	u32 dp0_auxcfg1;
> +
>  	/* Setup DP-PHY / PLL */
> -	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
> -	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
> +	ret = tc_set_syspllparam(tc);
>  	if (ret)
>  		goto err;
>  
> @@ -868,7 +873,6 @@ static int tc_main_link_enable(struct tc_data *tc)
>  {
>  	struct drm_dp_aux *aux = &tc->aux;
>  	struct device *dev = tc->dev;
> -	unsigned int rate;
>  	u32 dp_phy_ctrl;
>  	u32 value;
>  	int ret;
> @@ -896,25 +900,7 @@ static int tc_main_link_enable(struct tc_data *tc)
>  	if (ret)
>  		return ret;
>  
> -	rate = clk_get_rate(tc->refclk);
> -	switch (rate) {
> -	case 38400000:
> -		value = REF_FREQ_38M4;
> -		break;
> -	case 26000000:
> -		value = REF_FREQ_26M;
> -		break;
> -	case 19200000:
> -		value = REF_FREQ_19M2;
> -		break;
> -	case 13000000:
> -		value = REF_FREQ_13M;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
> -	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
> +	ret = tc_set_syspllparam(tc);
>  	if (ret)
>  		return ret;
>  


