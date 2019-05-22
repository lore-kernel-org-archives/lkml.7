Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0036EC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A232173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WqnD/2NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfEVGH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:07:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51531 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfEVGH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:07:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190522060754euoutp02582977e5fdc737cb0ab78b3b56fc1955~g7Eoca2X42230422304euoutp02e
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:07:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190522060754euoutp02582977e5fdc737cb0ab78b3b56fc1955~g7Eoca2X42230422304euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558505274;
        bh=gdD8eXaR+637Q+ADEFMcqvaoMZuFCktQ0aqFc/uyg2Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WqnD/2NI7W/0fvW8myaNcnF9VEhj08YlUb8bII5YQi90iJ6xQeWTXWK9fn9//VB1b
         ZeBZyMFuMLuTSMCBrPHYF7PT12lyVKnjIE6jD9aJB75GnwVTV9lnaeGO8M5ajnmgYq
         66fdZeWdX8E5fxXgOAjeUbCbkB3oQZyoOXxBAg0M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190522060753eucas1p250b904e1ff6a144f42a71fb9d6c59254~g7En15-Al0829708297eucas1p2Q;
        Wed, 22 May 2019 06:07:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.F1.04298.937E4EC5; Wed, 22
        May 2019 07:07:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190522060752eucas1p139612543d67443cfb24b5d36125334ee~g7EnG7ieq1219712197eucas1p1L;
        Wed, 22 May 2019 06:07:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190522060752eusmtrp150dfaf2f33c5c4f9b220f6db4088650c~g7Em4y1-j2830728307eusmtrp19;
        Wed, 22 May 2019 06:07:52 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-03-5ce4e73922f8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D6.BF.04146.837E4EC5; Wed, 22
        May 2019 07:07:52 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190522060751eusmtip28f709a5be5efaba5dbf834cbef486f5f~g7EmTyhFp2960929609eusmtip2E;
        Wed, 22 May 2019 06:07:51 +0000 (GMT)
Subject: Re: [PATCH 1/5] drm/bridge: dw-hdmi: allow ycbcr420 modes for >=
 0x200a
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent.pinchart@ideasonboard.com
Cc:     jonas@kwiboo.se, hverkuil@xs4all.nl,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <020c82bc-15fd-6e23-a093-62abfa9b466d@samsung.com>
Date:   Wed, 22 May 2019 08:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520133753.23871-2-narmstrong@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djP87qWz5/EGPyfxGNx5et7Nov/j16z
        WsydVGtxavIzJour318yW5x8c5XFonPiEnaLBbO5LS7vmsNm8eDlfkaLQ33RDtwe72+0snvM
        W1PtMbtjJqvHiQmXmDzudx9n8ti8pN7j76z9LB4HeiezeGy/No/Z4/MmOY9TXz+zB3BHcdmk
        pOZklqUW6dslcGVc2P2XreAZX8WNKU/YGhjn8HQxcnJICJhI/Gz7zN7FyMUhJLCCUaJx4gIo
        5wujxPYbJxkhnM+MEp37lzHDtNyet4sRxBYSWM4ocXOPAIT9llHi636dLkYODmGBIIkF85RA
        wiICgRLHe7eBzWEWeMEo8ezzXXaQBJuApsTfzTfZQGxeATuJhv53YDNZBFQlOk98BIuLCkRI
        3D+2gRWiRlDi5MwnLCDzOQVsJZ6fiAMJMwvISzRvnc0MYYtL3Hoynwlkl4TAT3aJBTePsEPc
        7CJxf+1CNghbWOLV8S1QcRmJ05N7WCDseon7K1qYIZo7GCW2btgJ9bC1xOHjF1lBFjMDHb1+
        lz5E2FFi2r7t7CBhCQE+iRtvBSFu4JOYtG06M0SYV6KjTQiiWlHi/tmtUAPFJZZe+Mo2gVFp
        FpLHZiH5ZhaSb2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMLGd/nf80w7G
        r5eSDjEKcDAq8fBaPHwcI8SaWFZcmXuIUYKDWUmE9/SpRzFCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGHdL9U3ycuv9YXVUd6f84sCl/34d1U5TLCzl
        1nIMrsjj2DPV+9+WE9uSnvSsW+Dwdaq7ZNFesceRcvefPQw+dkV779by+RrbzQ9IhETVykRM
        ev72y3Hl4Mx1u7qO75Te8ujL3CvZfB9eM794z9rfInAn9k58UmmayQdNluObPFTYJ++Oulnp
        z6bEUpyRaKjFXFScCADhee9WaAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xe7oWz5/EGHQ9k7S48vU9m8X/R69Z
        LeZOqrU4NfkZk8XV7y+ZLU6+ucpi0TlxCbvFgtncFpd3zWGzePByP6PFob5oB26P9zda2T3m
        ran2mN0xk9XjxIRLTB73u48zeWxeUu/xd9Z+Fo8DvZNZPLZfm8fs8XmTnMepr5/ZA7ij9GyK
        8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIu7P7LVvCM
        r+LGlCdsDYxzeLoYOTkkBEwkbs/bxdjFyMUhJLCUUWLyqRYmiIS4xO75b5khbGGJP9e62CCK
        XjNKPNv2jKWLkYNDWCBIYsE8JZAaEYFAiUW9C5hBapgFXjBKLOtth2o4zCix8NEEdpAqNgFN
        ib+bb7KB2LwCdhIN/e8YQWwWAVWJzhMfweKiAhESZ96vYIGoEZQ4OfMJ2DJOAVuJ5yfiQMLM
        AuoSf+ZdYoaw5SWat86GssUlbj2ZzzSBUWgWku5ZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO9
        4sTc4tK8dL3k/NxNjMB43nbs5+YdjJc2Bh9iFOBgVOLhfXDvcYwQa2JZcWXuIUYJDmYlEd7T
        px7FCPGmJFZWpRblxxeV5qQWH2I0BfptIrOUaHI+MNXklcQbmhqaW1gamhubG5tZKInzdggc
        jBESSE8sSc1OTS1ILYLpY+LglGpgXMxWG3yG235TgUaO5aul62f/M+cWLHe7O3FZwb0Ni91l
        czd5bUm36s42DbQrMzxQ0a3aceeGf71EeXowh2Fo+rqGK1ym8ZtLt/YlbSxhnqTi80P1xey2
        Gg3bzAuGRU3nXseGfZu90DKhrVT4/6kz6w682vtk9fO/Mf9vP5wRdk/m8eFsLYtpSizFGYmG
        WsxFxYkAiqx0Jf0CAAA=
X-CMS-MailID: 20190522060752eucas1p139612543d67443cfb24b5d36125334ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190520133802epcas3p3e8d19d3c79e027362ac1e4cc3c09c10f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190520133802epcas3p3e8d19d3c79e027362ac1e4cc3c09c10f
References: <20190520133753.23871-1-narmstrong@baylibre.com>
        <CGME20190520133802epcas3p3e8d19d3c79e027362ac1e4cc3c09c10f@epcas3p3.samsung.com>
        <20190520133753.23871-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.2019 15:37, Neil Armstrong wrote:
> Now the DW-HDMI Controller supports the HDMI2.0 modes, enable support
> for these modes in the connector if the platform supports them.
> We limit these modes to DW-HDMI IP version >= 0x200a which
> are designed to support HDMI2.0 display modes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
>  include/drm/bridge/dw_hdmi.h              | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index ab7968c8f6a2..b50c49caf7ae 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2629,6 +2629,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  	if (hdmi->phy.ops->setup_hpd)
>  		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
>  
> +	if (hdmi->version >= 0x200a)
> +		hdmi->connector.ycbcr_420_allowed =
> +			hdmi->plat_data->ycbcr_420_allowed;
> +	else
> +		hdmi->connector.ycbcr_420_allowed = false;
> +


I suspect else clause can be dropped.

Beside this:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>  	memset(&pdevinfo, 0, sizeof(pdevinfo));
>  	pdevinfo.parent = dev;
>  	pdevinfo.id = PLATFORM_DEVID_AUTO;
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 66e70770cce5..0f0e82638fbe 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -130,6 +130,7 @@ struct dw_hdmi_plat_data {
>  					   const struct drm_display_mode *mode);
>  	unsigned long input_bus_format;
>  	unsigned long input_bus_encoding;
> +	bool ycbcr_420_allowed;
>  
>  	/* Vendor PHY support */
>  	const struct dw_hdmi_phy_ops *phy_ops;


