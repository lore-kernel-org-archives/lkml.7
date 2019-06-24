Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BE7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF75205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TNri982p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfFXPDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:03:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37549 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfFXPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:03:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190624150335euoutp02e2e10f72ce1c256992f47779f9ada640~rKqxVr-oI2157721577euoutp02K
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:03:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190624150335euoutp02e2e10f72ce1c256992f47779f9ada640~rKqxVr-oI2157721577euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561388615;
        bh=2+pLevGrACjiUH04K+YKyfHiLgCyj4l8NbaFNMUoUWM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TNri982ph4RzHQGwnQMJvuX8PoXmhjTN3i61wAmVJGR9TDgmqrtRW1kcfUwJ7Nhsg
         QhBxXKdyIaufSIjfUMNWdvZP+mgSZ7L2bB9XylWFzg1SY7B8B38vf/FvKDd1UA1wpg
         Rs0HMTthRLMr/X2gUTWVPUWYxqGekbCD80YWcQCs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190624150334eucas1p132fa34b63af3ea4044a94643ee251a46~rKqwqktSe0902209022eucas1p1O;
        Mon, 24 Jun 2019 15:03:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CC.97.04325.646E01D5; Mon, 24
        Jun 2019 16:03:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190624150333eucas1p1ccc9310b2d018948c7c6185087bdebd6~rKqvuhq1d1097710977eucas1p18;
        Mon, 24 Jun 2019 15:03:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190624150333eusmtrp24cf115b5b5b4274179d824f3eaea9010~rKqvgZcTw1169511695eusmtrp2e;
        Mon, 24 Jun 2019 15:03:33 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-5a-5d10e6469899
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.47.04146.546E01D5; Mon, 24
        Jun 2019 16:03:33 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190624150332eusmtip11a9f4cd4c213020104b8a72b63886e0c~rKquxfSIg2618826188eusmtip1O;
        Mon, 24 Jun 2019 15:03:32 +0000 (GMT)
Subject: Re: [PATCH 4/4] drm/sun4i: Enable DRM InfoFrame support on H6
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
Message-ID: <baf95e6b-bfcf-27e7-1a00-ca877ae6f82d@samsung.com>
Date:   Mon, 24 Jun 2019 17:03:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <VI1PR03MB4206740285A775280063E303AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUYRjG+3Zmd2cX18bV2BcVo4GIArUTxgNJLBmzwIqgA8mtJjV1jR3P
        pBLUUssyS7I1VztEK00zrWxDZZU2j8oOK/MPrxK8Ulo1xWNzdoz87/c97/E9z8dHYMqvYkci
        XBPDajXqSEoix5+9nnnn6j9ABm/MvepMf54ck9CWvmExXZBzlu74M4jRzSMdOD1zsVpEZ1y7
        L6U/vbwtoXsG6xFtvHKEnjG+F9EVqe7bbZixb2lSRl+WxFT2PRIz+em3xMyb7I8ipvuSScTM
        6+pxpiHrOs48/6LHGHOVS5D8sNz7BBsZHsdq3X1C5GH9Xfew041kgqXFgJLRsCITyQggt4K5
        ohDnWUmWIkj/eSATyRd5AkFu3WUkHMwICj6nSTMRYZ0oqo4V9BIEWSU6qXAYRVCe0obxq+xJ
        f3jysFjKswOpgcJ5vZUxMhuHB1O7eZaQ62H+aaeEZwXpA8O/eq2Mk2sha95o7V9FHoSJ2iok
        9NhB860fVqsyMhi6M7LEws7VkFKTjwmsgu8/CkW8ISBnpKArv4sLOXdA6eNUJLA9DJmqpQI7
        g6WWH+D5PHSXpmLCcDqCmspaTCh4QaPpg5iPjy26rnjpLsi+8MHQv/QqtvBt1E7wYAs5z25i
        gqyA9AtKoXsNdL+tWVqoguL2SUk2onTLkumWpdEtS6P7f28Rwh8iFRvLRYWy3BYNG+/GqaO4
        WE2o2/HoqCq0+N1aF0yTL1Dd3DEjIglE2SiKmshgpVgdxyVGGREQGOWgKFYvSooT6sQzrDb6
        qDY2kuWMyInAKZUiaUXPESUZqo5hI1j2NKv9VxURMsdk5BlY/z1hz/5tEr8Ql70d06555/rq
        Fk62ebRqWp7k1vTnD8cPHBi1jBiGUntLZGNeC0QMZXEN8psL7Ly869Q7/NV0e8Eotdlj3MNz
        H0Q4deXdSLlTODueETAyZY6WxTRQqp3cykO9k271+rIgg/dFk8O632UQ0FuV622c9S1q0lM4
        F6betAHTcuq/1eAPEWoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xu7quzwRiDfbvkrS48vU9m8X/R69Z
        LeZOqrW4+v0ls8XJN1dZLH62b2Gy6Jy4hN3i8q45bBYPXu5ntDjUF23x89B5Jov1LfoOPB7v
        b7Sye8xbU+2x4dFqVo/ZHTNZPU5MuMTkcb/7OJPH31n7WTwO9E5m8dh+bR6zx+dNcgFcUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZj28vZi44
        LFDx/9RuxgbG17xdjBwcEgImEgu2lHYxcnEICSxllFi0ZiNrFyMnUFxcYvf8t8wQtrDEn2td
        bBBFrxklrmxeDFYkLOAmsXHVUnYQW0QgT2LW7TlgRcwCE1gk9u19wgaSEBJoZpL489MexGYT
        0JT4u/kmWJxXwE7i9buHYDaLgKpE799DYINEBSIkZu9qYIGoEZQ4OfMJmM0pECtxv7MXbDGz
        gLrEn3mXmCFseYnmrbOhbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCv
        ODG3uDQvXS85P3cTIzCitx37uXkH46WNwYcYBTgYlXh4FxwRiBViTSwrrsw9xCjBwawkwrs0
        ESjEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cBkk1cSb2hqaG5haWhubG5sZqEkztshcDBG
        SCA9sSQ1OzW1ILUIpo+Jg1OqgVE+7+6r7TteWLG0np/FkH+5wUyCLfbvtNrfC61v8QUv6/eX
        YPik5Oq3v2Fa8GJmgzWKU84bq4gdkHIL+Vb0MFNn7WTvONkDFyy1S03LVnh/ap1bdUNDdOkj
        nWXZZq+8P8/gDNjqPif3/On3DqoLvWObJdymx9ev2TLB12fJdft7h7rc403eWCmxFGckGmox
        FxUnAgAXHjmx/gIAAA==
X-CMS-MailID: 20190624150333eucas1p1ccc9310b2d018948c7c6185087bdebd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190526212047epcas3p10101ea244192dd106f55002bb66d79b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190526212047epcas3p10101ea244192dd106f55002bb66d79b0
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
        <CGME20190526212047epcas3p10101ea244192dd106f55002bb66d79b0@epcas3p1.samsung.com>
        <VI1PR03MB4206740285A775280063E303AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.2019 23:20, Jonas Karlman wrote:
> This patch enables Dynamic Range and Mastering InfoFrame on H6.
>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 2 ++
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> index 39d8509d96a0..b80164dd8ad8 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> @@ -189,6 +189,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
>  	sun8i_hdmi_phy_init(hdmi->phy);
>  
>  	plat_data->mode_valid = hdmi->quirks->mode_valid;
> +	plat_data->drm_infoframe = hdmi->quirks->drm_infoframe;
>  	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
>  
>  	platform_set_drvdata(pdev, hdmi);
> @@ -255,6 +256,7 @@ static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
>  
>  static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks = {
>  	.mode_valid = sun8i_dw_hdmi_mode_valid_h6,
> +	.drm_infoframe = true,
>  };
>  
>  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> index 720c5aa8adc1..2a0ec08ee236 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> @@ -178,6 +178,7 @@ struct sun8i_dw_hdmi_quirks {
>  	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
>  					   const struct drm_display_mode *mode);
>  	unsigned int set_rate : 1;
> +	unsigned int drm_infoframe : 1;


Again, drm_infoframe suggests it contains inforframe, but in fact it
just informs infoframe can be used, so again my suggestion
use_drm_infoframe.

Moreover bool type seems more appropriate here.

Beside this:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>  };
>  
>  struct sun8i_dw_hdmi {


