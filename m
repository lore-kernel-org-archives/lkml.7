Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A28C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370E920896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bhlT+PPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407778AbfFLG77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:59:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36171 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404851AbfFLG76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:59:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190612065956euoutp02d720e1ed8a28cfb2f00fb59261918daf~nYVEg9IIY2562025620euoutp02f
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:59:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190612065956euoutp02d720e1ed8a28cfb2f00fb59261918daf~nYVEg9IIY2562025620euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560322797;
        bh=adIOOIL2VicBSBJGZrtq09f7Aw36EV/xU/ajnfWjQ24=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=bhlT+PPJybiUpRu0rLygtWksU0EnIJ6uTv1/oVWnwWXbRpChHJCYZOVoqQs3/u3s8
         XYxsLhvpBfpQlJxyx3PlUp1XwszyVKMCnLTwUO4Bjz08bf8bgsl3vAe4INc/Qs1TOZ
         QU62EYgdkCRe2p7PKSUoQkxPfgRleiyy7hpWw818=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190612065955eucas1p1a03daca794582331386dc0412803ad73~nYVDaq0IY0457804578eucas1p1r;
        Wed, 12 Jun 2019 06:59:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9F.E7.04377.BE2A00D5; Wed, 12
        Jun 2019 07:59:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190612065954eucas1p1f0fb1e6ba7e0dc9b379b7e64073250d2~nYVCf3Wgz0158001580eucas1p13;
        Wed, 12 Jun 2019 06:59:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190612065954eusmtrp20ca65c2769f74f278ffed1acebb36898~nYVCQ29091689216892eusmtrp2i;
        Wed, 12 Jun 2019 06:59:54 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-ac-5d00a2ebe44d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 38.88.04146.AE2A00D5; Wed, 12
        Jun 2019 07:59:54 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190612065953eusmtip23dd5a0fcc177b296ec03ace8429d3cb3~nYVBn9TCT0540905409eusmtip2U;
        Wed, 12 Jun 2019 06:59:53 +0000 (GMT)
Subject: Re: [PATCH v1 1/2] drm/bridge/synopsys: dsi: add power on/off
 optional phy ops
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <742ec787-09e3-a588-f26e-2ea35a218b32@samsung.com>
Date:   Wed, 12 Jun 2019 08:59:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1558952499-15418-2-git-send-email-yannick.fertre@st.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGuZ2l00JhLJieoBGpmghRXIJmEg3RRM345iOIBItMEISKraDA
        A4goUFREEKSsKg2gadQiq7JYE6sC7q27tFjiQl1iK4qClTIYefvO+f9zz/mTS2FSNxFIJSr3
        cyqlIllOivG2W+P3l4+e84pZaXEEMsfv3REwV+z9iMk13iUZd1sJxjz5/mWKhkcJprCkQcgY
        3loI5nFXNcloLHaCqZ3UE4zu92fEWPPeE0zTeCtiBsx9OJNfeITcQLPdY/U426l9LWSrCioJ
        9pXlOsm2j1kJdqjIJGBbGrLZhnIzyU5qe3G23VKLsTd6VrEjP7sx1mlYsE2yXbw+nktOTOdU
        KyJ2ind3nx8QpN6WHsy1NWE5qMdPg0QU0OHw7vQHXIPElJRuQnDMkY/4woXA1fKG5AsnAqej
        SPhvJG+iV8gLjQiKzY6ZkU8ITuRNEh6XPx0Fdc2HBB4hgK4m4Eb1j2mBpENgsuU56WEJHQGl
        F78KPIzTS8BerkcenktHgqvTgHjPHLhTacc9LKK3QElt27Qfo4PgcGsVxrMMXtjrppcBXUPB
        uQcdiL91E7icBoJnf/houjqTYT64O+sEPGfDUFMexg8XIGi93Inxwjq4aXo4NUxNbQiBS10r
        +PZGsDjbSU8baF949mkOf4MvnGqrwPi2BAqOSnl3MAwNts48KAPdg+8kzyxUuWzCkyhYOyul
        dlYy7axk2v831CP8ApJxaeqUBE69WskdCFMrUtRpyoSwXXtTDGjqW/b/Mbk6UNdEnBHRFJL7
        SPoq3DukhCJdnZFiREBh8gDJ6j1eMVJJvCIjk1PtjVWlJXNqI5pH4XKZJMvLGi2lExT7uT0c
        l8qp/qkCShSYg+ZnH4nVam7HLXqv+7Uu4JFfDTWyOWefbomsuSZhpWmztz7rTLvelh4ps+oo
        jca7o+xs0Fho6jfjs0FRcGZo5rKgDxlRMd5C760tBS/vbR9aY1bWY+Fu/eLheB+Xw7ywNAm3
        XdgRtlYxtmVpnBHXCLNvFhd1HfApkjxtjH59rSxJjqt3K1aFYiq14i+UZ/tHkgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Pd1XixhiDa4sULToPXeSyWLjk9OM
        Fk2HTrFZ/N82kdniytf3QNaj16wWnROXsFtsenyN1eLyrjlsFl3XnrBazPu7ltVi6e93jBYP
        Wl6wWqz4uZXR4szVAywW7Z2tbA4CHnu/LWDx2DnrLrvH7I6ZrB53ru1h89j+7QGrx/3u40we
        m5fUeyyZdpXN4++s/Swe26/NY/Y4uM/Q4+mPvcwenzfJBfBG6dkU5ZeWpCpk5BeX2CpFG1oY
        6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXsXXyGqeCEUEXTwxXMDYz7+LsYOTkk
        BEwkWv7sZwexhQSWMkq8v2IIEReX2D3/LTOELSzx51oXWxcjF1DNa6CahZfBEsICkRLzVzYy
        gSREBBawSrRd7WWEqLoKVDVrExNIFZuApsTfzTfZQGxeATuJyas/gMVZBFQlnkxbywhiiwpE
        SMze1cACUSMocXLmEzCbU8BNYuK8bWD1zALqEn/mXWKGsOUlmrfOhrLFJW49mc80gVFwFpL2
        WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAJLDt2M/NOxgvbQw+xCjA
        wajEw3tg+v8YIdbEsuLK3EOMEhzMSiK8RtkMsUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqc
        D0xQeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGGvm35zZdPdx
        7smzogcPF+3Q+OkmpR+zO0yuZt6iTp1PJ5RM/4d/Yy+ucVCoXXhd2lM6PcLuqcXHbdZacguu
        e8695Hx9yVl5td+bOxtsoo3jd5zeuqt790zzrUqWq6ojhcq7f4edOh748uO1Lwurky6WJ95f
        K7Bpy4PcvWGdS5gtvR0zi3d9O6/EUpyRaKjFXFScCABKikPjGAMAAA==
X-CMS-MailID: 20190612065954eucas1p1f0fb1e6ba7e0dc9b379b7e64073250d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190527102214epcas1p3608b43d2535a8b3ffcab61aa085a990b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190527102214epcas1p3608b43d2535a8b3ffcab61aa085a990b
References: <1558952499-15418-1-git-send-email-yannick.fertre@st.com>
        <CGME20190527102214epcas1p3608b43d2535a8b3ffcab61aa085a990b@epcas1p3.samsung.com>
        <1558952499-15418-2-git-send-email-yannick.fertre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.05.2019 12:21, Yannick Fertré wrote:
> Add power on & off optional physical operation functions, helpful to
> program specific registers of the DSI physical part.
>
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 8 ++++++++
>  include/drm/bridge/dw_mipi_dsi.h              | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index e915ae8..5bb676f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -775,6 +775,10 @@ static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
>  static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
>  {
>  	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
> +	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->plat_data->phy_ops;
> +
> +	if (phy_ops->power_off)
> +		phy_ops->power_off(dsi->plat_data->priv_data);
>  
>  	/*
>  	 * Switch to command mode before panel-bridge post_disable &
> @@ -874,11 +878,15 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  static void dw_mipi_dsi_bridge_enable(struct drm_bridge *bridge)
>  {
>  	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
> +	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->plat_data->phy_ops;
>  
>  	/* Switch to video mode for panel-bridge enable & panel enable */
>  	dw_mipi_dsi_set_mode(dsi, MIPI_DSI_MODE_VIDEO);
>  	if (dsi->slave)
>  		dw_mipi_dsi_set_mode(dsi->slave, MIPI_DSI_MODE_VIDEO);
> +
> +	if (phy_ops->power_on)
> +		phy_ops->power_on(dsi->plat_data->priv_data);
>  }
>  
>  static enum drm_mode_status
> diff --git a/include/drm/bridge/dw_mipi_dsi.h b/include/drm/bridge/dw_mipi_dsi.h
> index 7d3dd69..df6eda6 100644
> --- a/include/drm/bridge/dw_mipi_dsi.h
> +++ b/include/drm/bridge/dw_mipi_dsi.h
> @@ -14,6 +14,8 @@ struct dw_mipi_dsi;
>  
>  struct dw_mipi_dsi_phy_ops {
>  	int (*init)(void *priv_data);
> +	void (*power_on)(void *priv_data);
> +	void (*power_off)(void *priv_data);
>  	int (*get_lane_mbps)(void *priv_data,
>  			     const struct drm_display_mode *mode,
>  			     unsigned long mode_flags, u32 lanes, u32 format,


