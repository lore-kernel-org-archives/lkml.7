Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E099EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8231120656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BeaLFB2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfFXO7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:59:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36073 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFXO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:59:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190624145948euoutp02d21b7cf03e48087b1dffed5b4ffc9793~rKndsMyeG1859718597euoutp02W
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:59:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190624145948euoutp02d21b7cf03e48087b1dffed5b4ffc9793~rKndsMyeG1859718597euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561388388;
        bh=P2nkvwikLfmIXL8cK+4QfrKbDbmqAb86J0Ekh6clZ7o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BeaLFB2K+TPqXGk/H7rfK/n7urmr6kbvQ8CD8NrzcPz1W2O+rxTGURWRryC9tLQSy
         Gis/x28iD1IVT2q9Xp1ABYrnuQXoYGtpnj7POjppw9pOp/KagRSKsARnJkiyRijTt1
         MUx0qTrhHnufPJxBRjO9yWXYCv4bwsubFCbNRTeU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190624145947eucas1p2d6350d93fc3b9c664abb10971f81ba12~rKndD6_rZ1017510175eucas1p26;
        Mon, 24 Jun 2019 14:59:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0A.E9.04377.365E01D5; Mon, 24
        Jun 2019 15:59:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190624145946eucas1p28bbd4bbfe65ae48ae48576c29b573800~rKncZ2JmT1017510175eucas1p25;
        Mon, 24 Jun 2019 14:59:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190624145946eusmtrp1d36d8a9448bfc31efc875b44eebfd5f8~rKncLL3Cm1696416964eusmtrp1U;
        Mon, 24 Jun 2019 14:59:46 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-8d-5d10e5632f6b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 88.D6.04146.265E01D5; Mon, 24
        Jun 2019 15:59:46 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190624145946eusmtip2e5865bd41ee117eb9ca5ce9ad548b224~rKnbq2M1j2130521305eusmtip2R;
        Mon, 24 Jun 2019 14:59:46 +0000 (GMT)
Subject: Re: [PATCH 3/4] drm/meson: Enable DRM InfoFrame support on GXL, GXM
 and G12A
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
Message-ID: <bdc1746a-5829-9991-6f1c-d66f03c95d77@samsung.com>
Date:   Mon, 24 Jun 2019 16:59:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <VI1PR03MB4206A326130A81DCBAA62CE8AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHfXbvtuty8jirnSw0FwkmaW8fbhRiEXUDiwzKSJfd7KKSLtlV
        y6Tyg5ZaytRMXDr9kKSr0Mx3KG2Kr4RZGZaSskyauiR8a6DZ5jXy2+/8/+c55/zhoQjFoNiD
        itEkcFoNG6uSyMj6DlvfzsjvWL1rYd6N/jg3LaGXzZNiuiTvJj2wYCHo7qkBkrbdrRXRmbmP
        pfSH5mIJPWppQbQpJ4y2mfpEdFVaQJALMz2YLmUMz1KYavNTMfMoo0jMdOnei5iRe50iZknf
        QjKt2fkk0/DJQDAzNZ6nZOdlBy9zsTFJnDYg8KIs+ofRiOKH110v69GJU9GMcxZypgDvg5re
        JWkWklEKXIHgQValSChm7cXbvFVnBsHEqxny35PCzH5CMJ4gmKpNX31iRVD9SbfS5Y5DwZKd
        LnXweqyB0iXDChNYR0LlfLCDJdgXll5+ljhYjgNh3FZGOJjE28G6+EHs4A34HMw21SChxw26
        i8ZW5jtjNSxbrBJhphc0WIsJgZXwZaxUJFw6J4WHQ4zAR6DUVo8EdoeJzlqpwFugN//+arLb
        MFKRtpIMcAaCuuomQjAOQFtnv/0gyr7AF6qaAwT5EBQMTUkdMmBXGLS6CSe4Ql59ISHIcsi4
        oxC6vWHkbd3qQCWUv5uT6JBKvyaYfk0Y/Zow+v97yxBpREoukY+L4vg9Gu6aP8/G8YmaKP/I
        q3E1yP7fev90zjai5sVLJoQppHKR/+7AaoWYTeKT40wIKEK1Xl7O2iX5ZTb5Bqe9GqFNjOV4
        E9pMkSqlPMVpNEyBo9gE7grHxXPaf66IcvZIRfqtwzjo+e8Op7apngNevNkvNLj9235bSM4m
        P4/2F0XZ1V0nma/qnwMFFSVsRnHEL7IgWU1ubD3h0m/2G23Un94bfcjbp69qUnT4zXCAJdyz
        wOdsSL3xzPhRp3Sl8sLuvlupX3KLMm8+MyfVLW/zDjyeaIx5/trdL6b5WIvREP6rVkXy0ezu
        HYSWZ/8Cj1feuWsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7pJTwViDf63Kllc+fqezeL/o9es
        FnMn1Vpc/f6S2eLkm6ssFj/btzBZdE5cwm5xedccNosHL/czWhzqi7b4eeg8k8X6Fn0HHo/3
        N1rZPeatqfbY8Gg1q8fsjpmsHicmXGLyuN99nMnj76z9LB4HeiezeGy/No/Z4/MmuQCuKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MF6tWMRbc
        4a5YcGoCawPjZ84uRk4OCQETiemdF5m7GLk4hASWMkrs3f+YDSIhLrF7/ltmCFtY4s+1LjaI
        oteMEpdOLGAFSQgLhEu87G1lB7FFBPIkZt2eA1bELDCBRWLf3idQHc1MEndvX2QBqWIT0JT4
        u/km2ApeATuJZz8XgK1gEVCVePvnMthUUYEIidm7GlggagQlTs58AmZzCsRK/H/5FqyXWUBd
        4s+8S8wQtrzE9rdzoGxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hQrzgx
        t7g0L10vOT93EyMwqrcd+7l5B+OljcGHGAU4GJV4eBccEYgVYk0sK67MPcQowcGsJMK7NBEo
        xJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAhJNXEm9oamhuYWlobmxubGahJM7bIXAwRkgg
        PbEkNTs1tSC1CKaPiYNTqoFxVlXc3XWvL1czzPGfrXKK9f5sYfms/h9VSZs2bvVzd1g06V1L
        t9aTT4zyPGcvpoe1fH64/3bCbO45eq/OKxsU1BiGTroht4pzAafY38nzdnxKs/156d7XRZwN
        KYYRmuEyy6Z5q7zwrjglf99yinqG47bmSZMkMx6L/UuvWsMremL3lTDlwC+sSizFGYmGWsxF
        xYkAEVYLOgADAAA=
X-CMS-MailID: 20190624145946eucas1p28bbd4bbfe65ae48ae48576c29b573800
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190526212026epcas3p3ef1bafa97e5da9dac02b26fa0a375c80
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190526212026epcas3p3ef1bafa97e5da9dac02b26fa0a375c80
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
        <CGME20190526212026epcas3p3ef1bafa97e5da9dac02b26fa0a375c80@epcas3p3.samsung.com>
        <VI1PR03MB4206A326130A81DCBAA62CE8AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.2019 23:20, Jonas Karlman wrote:
> This patch enables Dynamic Range and Mastering InfoFrame on GXL, GXM and G12A.
>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index df3f9ddd2234..f7761e698c03 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -966,6 +966,11 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>  	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
>  	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
>  
> +	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
> +	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
> +	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
> +		dw_plat_data->drm_infoframe = true;
> +


I see it follows meson_dw_hdmi.c practices, but maybe it is time to drop
it and just add flag to meson_dw_hdmi_data, IMO the whole
dw_hdmi_is_compatible function should be removed

and replaced with fields/flags in meson_dw_hdmi_data - this is what
of_device_id.data field was created for.


Regards

Andrzej


>  	platform_set_drvdata(pdev, meson_dw_hdmi);
>  
>  	meson_dw_hdmi->hdmi = dw_hdmi_bind(pdev, encoder,


