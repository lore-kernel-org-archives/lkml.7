Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67FDC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA69213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rct59tpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfFXOnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:43:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38301 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfFXOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:43:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190624144310euoutp0180b0a974c27f5f25241be2563823e4ec~rKY8PH_TD0561705617euoutp01Z
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:43:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190624144310euoutp0180b0a974c27f5f25241be2563823e4ec~rKY8PH_TD0561705617euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561387390;
        bh=S9RCnb2EVI6dRCJRJYmUfdHCAyIzmct1AhV9SunnKk0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rct59tpOa5d4WE7YUzWSyZP2IUdvnCGW9tJzc2cxSuqgDx89a19ygpjJ8zTuNl+Wf
         VN0z4hSeU3pOki2eRQBrTAnmq8bvENKSb+dtPEWYHRaiEgmofBAUl4kuOHwZYki7oU
         4/y+kzMvFx0u5Nt7g6RAHYtQ5EoM92oCpZpC/rFg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190624144309eucas1p147e0e2e352967d2c14d71328663aa099~rKY7Z0__f0229402294eucas1p1c;
        Mon, 24 Jun 2019 14:43:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7B.97.04298.C71E01D5; Mon, 24
        Jun 2019 15:43:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190624144308eucas1p118fe74e266dd911ab02c2c47011e7db0~rKY6WWa1E0229902299eucas1p1t;
        Mon, 24 Jun 2019 14:43:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190624144307eusmtrp26434c8a6912fa4bf1339ac9d5114b1b1~rKY6ILf-e3216732167eusmtrp2Q;
        Mon, 24 Jun 2019 14:43:07 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-3f-5d10e17cf279
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BB.7E.04140.B71E01D5; Mon, 24
        Jun 2019 15:43:07 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190624144307eusmtip176915b64526e17b7dd8bb86f57086396~rKY5lnUDV1498914989eusmtip1A;
        Mon, 24 Jun 2019 14:43:07 +0000 (GMT)
Subject: Re: [PATCH 2/4] drm/rockchip: Enable DRM InfoFrame support on
 RK3328 and RK3399
To:     Jonas Karlman <jonas@kwiboo.se>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>
Cc:     "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <9fb2998c-dc8f-6ec1-2a87-ce7298fa966e@samsung.com>
Date:   Mon, 24 Jun 2019 16:43:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <VI1PR03MB42062F51FD88AEB6DADD8734AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRj13b3brsvJ67T2sNJoEFSWSwi6fSAJ/bg/JIQgLBNdeVPLTdnS
        MpMCv7VsalLNnFMcaWrKcpaCGEsyTTEtc7NIS6HMtEhnaJh5vUr+O8855znveeClCNlboYKK
        015kdVp1vFIkIZtfzPftSfuEI/baUum3rh8ieunzpJAuK0qjB39PEHTX90GSns9uEtC5hVVi
        +k3rfRE9OtGOaHtBOD1v7xPQDRmqIx7MD0emmDHVpTKNn2uFTGnOPSHz0jAgYEbyOwXMorGd
        ZJ7dLCaZJ+9MBDNj9QuVnJIcjmbj45JZnSooShJb4fpCJhokl/OyesTXUQuVh9wpwPtgvKQe
        5SEJJcPVCEatk0J+mEXwKGdOxA8zCAx2m2htZbrsI8kLDxAsmWfEnCDDUwjGRpYFivLGp6Ci
        dTtH+2AtlC+aViwENpBQMxfCYRHeCYuPnSuZUhwEfbVZBLdK4u3QWLeDozfiMJhtsSLe4gVd
        98ZJDrvjCLBULRB85FZIt5WuYjkMj5cLuGqAXWJ41GtDXCbgo9A/rOHre8O3ziYxj7fAUgvn
        5/A1GKnOIPjdHAS2xhaCFw7B885+IZdDLHduaFXxdDBk/J4j+HhPcEx58RU8oaj5ziothZws
        Ge/eBiO9ttVAOVheu0QGpDSuO8y47hjjumOM/981I/IhkrNJek0Mqw/UspcC9GqNPkkbE3A2
        QWNFy3/t1d/OX0+Ra+CMHWEKKT2k5g4cIROqk/UpGjsCilD6SC3qZUoarU65wuoSInVJ8aze
        jjZTpFIuTXUbDZfhGPVF9gLLJrK6NVVAuSuuI6l7Sb/zbpeyPNFpREmnVTVBm/x7TkYd72qL
        fp/84Vh3bemC7/mhjman753M+hCTs7UoN78+/WrRLfPsXN8QjFWO3o48HvJ1b+FJy8E63w24
        6dz0nxu6sND7PgpFqMnR4Iiq/MmGuNmDD6QXJ4dmm/1UQ/77C4Z2p1w70TbcbZMoSX2sOnAX
        odOr/wFFEgb5ZwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7rVDwViDU48M7W48vU9m8X/R69Z
        LeZOqrW4+v0ls8XJN1dZLH62b2Gy6Jy4hN3i8q45bBYPXu5ntDjUF23x89B5Jov1LfoOPB7v
        b7Sye8xbU+2x4dFqVo/ZHTNZPU5MuMTkcb/7OJPH31n7WTwO9E5m8dh+bR6zx+dNcgFcUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZC78+ZymY
        wFXR1XaGvYFxJ0cXIyeHhICJxLu591i6GLk4hASWMkqc7JnPApEQl9g9/y0zhC0s8edaFxtE
        0WtGiddn77KBJIQFoiQ23t/FCmKLCORJzLo9B6yIWWACi8S+vU+gOpqZJB7vaGACqWIT0JT4
        u/kmWDevgJ3E+dVtQCs4OFgEVCU2rNEACYsKREjM3tXAAlEiKHFy5hMwm1MgVmLpkl9gFzEL
        qEv8mXcJypaXaN46G8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoT
        c4tL89L1kvNzNzECY3rbsZ9bdjB2vQs+xCjAwajEw7vgiECsEGtiWXFl7iFGCQ5mJRHepYlA
        Id6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYSTc4Hppu8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC
        6YklqdmpqQWpRTB9TBycUg2M9bLKPVF8clPYuK/svtgiZrqC49LpR5mVcfolh+4L+pmoz03i
        mpDaue4kd+Dmb3rrebbG9lulV7zo8DLMmp4+R0hAYt7paZOseA6HPXqcPauu+fAznvOXGCXc
        nD+eV36YFbxTZ8Fjc4/WzwcarVdf05tYo8cvxLPajO9A1YzJofGsgozNMaxKLMUZiYZazEXF
        iQC3tcyY/wIAAA==
X-CMS-MailID: 20190624144308eucas1p118fe74e266dd911ab02c2c47011e7db0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190526212010epcas2p4c6d5ea6f812959585fcc55d2bf04ad3c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190526212010epcas2p4c6d5ea6f812959585fcc55d2bf04ad3c
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
        <CGME20190526212010epcas2p4c6d5ea6f812959585fcc55d2bf04ad3c@epcas2p4.samsung.com>
        <VI1PR03MB42062F51FD88AEB6DADD8734AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.2019 23:20, Jonas Karlman wrote:
> This patch enables Dynamic Range and Mastering InfoFrame on RK3328 and RK3399.
>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 4cdc9f86c2e5..1f31f3726f04 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -405,6 +405,7 @@ static const struct dw_hdmi_plat_data rk3328_hdmi_drv_data = {
>  	.phy_ops = &rk3328_hdmi_phy_ops,
>  	.phy_name = "inno_dw_hdmi_phy2",
>  	.phy_force_vendor = true,
> +	.drm_infoframe = true,
>  };
>  
>  static struct rockchip_hdmi_chip_data rk3399_chip_data = {
> @@ -419,6 +420,7 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
>  	.cur_ctr    = rockchip_cur_ctr,
>  	.phy_config = rockchip_phy_config,
>  	.phy_data = &rk3399_chip_data,
> +	.drm_infoframe = true,
>  };
>  
>  static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {


