Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C5FC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF572089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FDCrKwTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfFGGlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:41:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60772 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFGGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:41:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190607064129euoutp020eb5ee278f6a39f8db3066872f207ec0~l12h3gt0J1166211662euoutp02o
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 06:41:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190607064129euoutp020eb5ee278f6a39f8db3066872f207ec0~l12h3gt0J1166211662euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559889689;
        bh=Hlws9M7BqFCoD+GZJisbwaAGPzTVT29fKD3S29duRF0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FDCrKwTk9+cODhpdJvj0IqfnYz1BEXyHjSM7p5/zZVlSgJyCfFXJdLtmTftxNb5Io
         pDJUxcZDjb7msFOl2hPAVo8BP8keTBKWrltbpoe834+UCDcsredbxhCbODEDCvLZOO
         tCyaC4eFmCRhzEZwnYv0NysKN1v3D2Z0v0GEqy74=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607064128eucas1p299dc8c1ac78f8ec9b41f1bdd66a0df79~l12hM9b7G0356303563eucas1p2l;
        Fri,  7 Jun 2019 06:41:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.C7.04325.8170AFC5; Fri,  7
        Jun 2019 07:41:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607064127eucas1p2d170e0a8df77d5385beadf5cd79a6869~l12gUzWI90152201522eucas1p2y;
        Fri,  7 Jun 2019 06:41:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607064127eusmtrp2a71e31dcb22996583f8be1ea81a1fcc5~l12gFGCnY0254702547eusmtrp2k;
        Fri,  7 Jun 2019 06:41:27 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-bc-5cfa0718cafa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.AC.04146.7170AFC5; Fri,  7
        Jun 2019 07:41:27 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607064126eusmtip1cc7d169d7ca14470ccf7d036d20bd6a6~l12fUDf171602416024eusmtip1Q;
        Fri,  7 Jun 2019 06:41:26 +0000 (GMT)
Subject: Re: [PATCH v4 14/15] drm/bridge: tc358767: Drop unnecessary 8 byte
 buffer
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <34b09b98-0770-dec0-94cf-33138c3fb9ec@samsung.com>
Date:   Fri, 7 Jun 2019 08:41:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607044550.13361-15-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeyyVcRjH+7238zrr1OsgT0XNydaSa0rvVtHtj7d/zNRak8WR12Uc7Lwo
        1ZbRXGqRxppTjQ11hIjQwbKOzalEbuFoOph0NZYUjeR4Wf77PM/3+/yey340LjeQW+jImHhe
        HaOMVlBSoq517q0LSP4Eun8f3sGmZhxiU/TJJDvb20KwL5oMGNs7M0mxw/eNGJuZUyxhexru
        UezQh5cEW1kwSB2WcsN5ixin0wxJuLsZ+SRnumHAuOwFd84wUI9x09XbuI68dsyPDpAeDOWj
        IxN5tZt3sDRitOYeHvfb6qKuthglIwNzHdE0MHvhXWnAdSSl5YwWwc30IiQGPxHkmKZIMZhG
        8Kmsb0mxWK7Qfn694nqIoMNYSYjBBIK+/i6J2WXFnIIRYwVmZmvGD36k6CizCWfaMEhveI+b
        BYrZBQs1RsrMMsYbcsf1yy0IxhG0mc3LxTbMGTC1VpGixxJe5Y8RZrZgfKDwS8My48x2SK29
        i4tsC4NjBZi5GTCDEhiZeioR5z4Ojd9KSZGt4KthNW8Hi7oCTOSrYNJew8XiDAS1VTpcFA5A
        i6GLNJ8MX5q6ssFNTB+BX93lEvGSG2BgwlKcYQPcrruDi2kZZKTJRbcDmNprVx60hZLOGeoW
        UmjWbKZZs41mzTaa/30LEfEI2fIJgiqcFzxj+AuuglIlJMSEu56PVVWjpe/V9tcw8ww9nw/R
        I4ZGivUyTjIXKCeViUKSSo+AxhXWssTO2UC5LFSZdIlXxwapE6J5QY+20oTCVnZ53fBZOROu
        jOejeD6OV6+qGG2xJRnJoyZM8/7eXlk+abfs8tXlp1WyYz7hg46LqeVOPUfV8/zuPN8rbecy
        nZ9UhPWHtHbe2OMf3ayl6IrHZQvdo9lverqdHYiZ+vFNk9uLHpCUx8E0Ksxo31glbFSSlt42
        o/Xl6ONJh6bQHK96+b7coNDNwSdcfLMKxsBz/06VvWuJghAilB5OuFpQ/gMcL9cDWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7ri7L9iDCY1aVg0d9haNB1qYLX4
        ceUwi8XBPceZLK58fc9m8WDuTSaLzolL2C0u75rDZnH33gkWi/Xzb7E5cHk8mPqfyWPnrLvs
        HrM7ZrJ63O8+zuTR/9fA4/iN7UwenzfJeZybepYpgCNKz6Yov7QkVSEjv7jEVina0MJIz9DS
        Qs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PR5jnMBd+FK3ZuXcLYwHhcoIuRk0NCwERi
        xYtTjF2MXBxCAksZJaaeOs4EkRCX2D3/LTOELSzx51oXG4gtJPCaUeLoa7C4sECIxMOba8Hq
        RQT8JLrmHWACGcQscJZJ4vfunWwQU48xSrzoXMsIUsUmoCnxd/NNsEm8AnYSU54dAouzCKhI
        rOjcDzZJVCBC4sz7FSwQNYISJ2c+AbM5BewlFrzcBWYzC6hL/Jl3iRnClpdo3jobyhaXuPVk
        PtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjdduxn5t3
        MF7aGHyIUYCDUYmH14HhZ4wQa2JZcWXuIUYJDmYlEd6yCz9ihHhTEiurUovy44tKc1KLDzGa
        Aj03kVlKNDkfmErySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUw
        GsdvKdi+MXBWpeUJleQdU5PyHlp0fXAN1mBew2ih61PF026tu3WN8J5HE+PFD1n2XmNM6zAO
        i73mdPPQXyuFPj7/eK2++gXHitf49ltEfFhgaNvN+9HhxKmVk+defJq4LsN18o9zs4tePNyt
        Jl56f+EUnjd9STKPmjaumv9lVuCFPb+5DgqkKbEUZyQaajEXFScCAGcw1F7tAgAA
X-CMS-MailID: 20190607064127eucas1p2d170e0a8df77d5385beadf5cd79a6869
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607044652epcas1p1b357013f14ae5bebe6300d35c0abe891
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607044652epcas1p1b357013f14ae5bebe6300d35c0abe891
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
        <CGME20190607044652epcas1p1b357013f14ae5bebe6300d35c0abe891@epcas1p1.samsung.com>
        <20190607044550.13361-15-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2019 06:45, Andrey Smirnov wrote:
> tc_get_display_props() never reads more than a byte via AUX, so
> there's no need to reserve 8 for that purpose. No function change
> intended.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
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
>  drivers/gpu/drm/bridge/tc358767.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index e747f10021e3..4a245144aa83 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -661,8 +661,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
>  static int tc_get_display_props(struct tc_data *tc)
>  {
>  	int ret;
> -	/* temp buffer */
> -	u8 tmp[8];
> +	u8 reg;
>  
>  	/* Read DP Rx Link Capability */
>  	ret = drm_dp_link_probe(&tc->aux, &tc->link.base);
> @@ -678,21 +677,21 @@ static int tc_get_display_props(struct tc_data *tc)
>  		tc->link.base.num_lanes = 2;
>  	}
>  
> -	ret = drm_dp_dpcd_readb(&tc->aux, DP_MAX_DOWNSPREAD, tmp);
> +	ret = drm_dp_dpcd_readb(&tc->aux, DP_MAX_DOWNSPREAD, &reg);
>  	if (ret < 0)
>  		goto err_dpcd_read;
> -	tc->link.spread = tmp[0] & DP_MAX_DOWNSPREAD_0_5;
> +	tc->link.spread = reg & DP_MAX_DOWNSPREAD_0_5;
>  
> -	ret = drm_dp_dpcd_readb(&tc->aux, DP_MAIN_LINK_CHANNEL_CODING, tmp);
> +	ret = drm_dp_dpcd_readb(&tc->aux, DP_MAIN_LINK_CHANNEL_CODING, &reg);
>  	if (ret < 0)
>  		goto err_dpcd_read;
>  
>  	tc->link.scrambler_dis = false;
>  	/* read assr */
> -	ret = drm_dp_dpcd_readb(&tc->aux, DP_EDP_CONFIGURATION_SET, tmp);
> +	ret = drm_dp_dpcd_readb(&tc->aux, DP_EDP_CONFIGURATION_SET, &reg);
>  	if (ret < 0)
>  		goto err_dpcd_read;
> -	tc->link.assr = tmp[0] & DP_ALTERNATE_SCRAMBLER_RESET_ENABLE;
> +	tc->link.assr = reg & DP_ALTERNATE_SCRAMBLER_RESET_ENABLE;
>  
>  	dev_dbg(tc->dev, "DPCD rev: %d.%d, rate: %s, lanes: %d, framing: %s\n",
>  		tc->link.base.revision >> 4, tc->link.base.revision & 0x0f,


