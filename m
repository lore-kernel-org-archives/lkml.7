Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF04C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FC720652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J4dVqirl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfFFIBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:01:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45550 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:01:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190606080114euoutp0278f89e0afc47fcfbd5c7875b22280497~ljS4I-VZg0297502975euoutp024
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 08:01:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190606080114euoutp0278f89e0afc47fcfbd5c7875b22280497~ljS4I-VZg0297502975euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559808074;
        bh=MAN58sTDz07tsLX8C4vgD27ti2cafy/nMvtO+uKybQw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=J4dVqirl/Wr/Fh/zjEuv+l0vKC17E4O/vtvvE5hx9/WXHmA7m8gnxOMghjZ0r3vv4
         h9CUAfMPXzr8ZcsYFqb4WPKuL+TZdKsq9KfWf6jkxYUm6eR2T0UQQsLEmwuz+d9hRd
         Oq8k6FwBtmtD6IHP470DbJSFSS+FAtN1VnF9tft8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606080114eucas1p240801a4725f31c59eb76659d8820b91e~ljS3fcY9F0719807198eucas1p2L;
        Thu,  6 Jun 2019 08:01:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 43.75.04377.948C8FC5; Thu,  6
        Jun 2019 09:01:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190606080113eucas1p13327c9bf0596dd2c744f776097153856~ljS2qt3t21310413104eucas1p1x;
        Thu,  6 Jun 2019 08:01:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190606080112eusmtrp149b65493e76b2ab5da42abc6b123dc11~ljS2a-qkd1821018210eusmtrp1e;
        Thu,  6 Jun 2019 08:01:12 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-b7-5cf8c84957ac
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.B1.04140.848C8FC5; Thu,  6
        Jun 2019 09:01:12 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190606080112eusmtip140c235a6cb15654cc48c0e0e95a858bc~ljS1oYSpx2518925189eusmtip1f;
        Thu,  6 Jun 2019 08:01:11 +0000 (GMT)
Subject: Re: [PATCH v3 02/15] drm/bridge: tc358767: Simplify polling in
 tc_main_link_setup()
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
Message-ID: <90e382a9-6613-64e8-1916-30000ef7654a@samsung.com>
Date:   Thu, 6 Jun 2019 10:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605070507.11417-3-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7qeJ37EGLx6b2TR3GFr0XSogdWi
        qeMtq8WPK4dZLA7uOc5kceXrezaLB3NvMll0TlzCbnF51xw2i7v3TrBYrJ9/i82B2+NyXy+T
        x4Op/5k8ds66y+4xu2Mmq8f97uNMHv1/DTyO39jO5PF5k5zHualnmQI4o7hsUlJzMstSi/Tt
        ErgyDrUkFjQJVLy/Gt/A2MPbxcjJISFgInH3RAdzFyMXh5DACkaJAz9eskE4Xxgl7jQcZwap
        EhL4zCjx8FMyTMfeRe2sEEXLGSXufX7NDuG8ZZR4v/8vC0iVsECcxOmb+9hBbBGBAIlPTTvB
        xjILfGWSOHBpIhNIgk1AU+Lv5ptsIDavgJ3E9YWLwOIsAioS614sBLNFBSIk7h/bwApRIyhx
        cuYTsAWcQPXN39eCnccsIC/RvHU2lC0ucevJfCaQZRICj9gl9n25yQxxt4vEi45HbBC2sMSr
        41vYIWwZidOTe1gg7HqJ+ytamCGaOxgltm7YCdVsLXH4+EWgKziANmhKrN+lD2JKCDhKbH/K
        DWHySdx4KwhxAp/EpG3TmSHCvBIdbUIQMxQl7p/dCjVPXGLpha9sExiVZiF5bBaSZ2YheWYW
        wtoFjCyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAlPZ6X/Hv+xg3PUn6RCjAAejEg+v
        xMbvMUKsiWXFlbmHGCU4mJVEeBNvf4kR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9
        sSQ1OzW1ILUIJsvEwSnVwFj895DV0fzm3IIHuyNCLUuC7pQyZ/84/PeS2ASXQ2GnVtfME+zl
        qDrGdv+v9seqUzsjDvf1XEjYYut4pG3L+/ptJVbVgQ3PpM9v8+I33Z7WNyusMnnx22VHj30N
        iIxM0z03kXfpilAhjTWeIVU1v2yWr9xY9fVvtZPmG/vZ+aXvdLeq7l0YMkuJpTgj0VCLuag4
        EQDboClrYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7oeJ37EGDzeY2bR3GFr0XSogdWi
        qeMtq8WPK4dZLA7uOc5kceXrezaLB3NvMll0TlzCbnF51xw2i7v3TrBYrJ9/i82B2+NyXy+T
        x4Op/5k8ds66y+4xu2Mmq8f97uNMHv1/DTyO39jO5PF5k5zHualnmQI4o/RsivJLS1IVMvKL
        S2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyDrUkFjQJVLy/Gt/A2MPb
        xcjJISFgIrF3UTtrFyMXh5DAUkaJhf9+MEEkxCV2z3/LDGELS/y51sUGUfSaUWLG6WUsIAlh
        gTiJ0zf3sYPYIgJ+El3zDjCBFDELfGeSmLh8LwtEx1FGiWPLZoFVsQloSvzdfJMNxOYVsJO4
        vnAR2DoWARWJdS8WgtmiAhESZ96vYIGoEZQ4OfMJmM0JVN/8fS3YScwC6hJ/5l2CsuUlmrfO
        hrLFJW49mc80gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA
        CN527OeWHYxd74IPMQpwMCrx8Eps/B4jxJpYVlyZe4hRgoNZSYQ38faXGCHelMTKqtSi/Pii
        0pzU4kOMpkDPTWSWEk3OByaXvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUw
        fUwcnFINjKU3OxlSWI43F1478PaZjunbUrUpVkEVf3YGP84V0rzhzGzry6ou/zCeb2JbqH6r
        6r6tcftLY+b3iShy8QbmFd/zCD8kYPgstoA71LMtQWal3JqiA0+m5HhwHX940G5XhsTqO0Iv
        87fUxRVeU/duiHtkErS4a+vRL6rVL3jUDNpVTs4/X66gxFKckWioxVxUnAgAPUXuD/YCAAA=
X-CMS-MailID: 20190606080113eucas1p13327c9bf0596dd2c744f776097153856
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605070527epcas1p36d630a4be138dd07791047c4d45a716f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605070527epcas1p36d630a4be138dd07791047c4d45a716f
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
        <CGME20190605070527epcas1p36d630a4be138dd07791047c4d45a716f@epcas1p3.samsung.com>
        <20190605070507.11417-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2019 09:04, Andrey Smirnov wrote:
> Replace explicit polling loop with equivalent call to
> tc_poll_timeout() for brevity. No functional change intended.
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
>  drivers/gpu/drm/bridge/tc358767.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index fb8a1942ec54..5e1e73a91696 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -774,7 +774,6 @@ static int tc_main_link_enable(struct tc_data *tc)
>  	struct device *dev = tc->dev;
>  	unsigned int rate;
>  	u32 dp_phy_ctrl;
> -	int timeout;
>  	u32 value;
>  	int ret;
>  	u8 tmp[8];
> @@ -831,15 +830,11 @@ static int tc_main_link_enable(struct tc_data *tc)
>  	dp_phy_ctrl &= ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
>  	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
>  
> -	timeout = 1000;
> -	do {
> -		tc_read(DP_PHY_CTRL, &value);
> -		udelay(1);
> -	} while ((!(value & PHY_RDY)) && (--timeout));
> -
> -	if (timeout == 0) {
> -		dev_err(dev, "timeout waiting for phy become ready");
> -		return -ETIMEDOUT;
> +	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
> +	if (ret) {
> +		if (ret == -ETIMEDOUT)
> +			dev_err(dev, "timeout waiting for phy become ready");
> +		return ret;


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>  	}
>  
>  	/* Set misc: 8 bits per color */


