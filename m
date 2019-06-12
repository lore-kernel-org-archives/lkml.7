Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3468EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED16208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YVwHWRA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408167AbfFLHnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:43:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51392 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407988AbfFLHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:43:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190612074341euoutp02e1fa109c4604816a83895a5ce415c2a5~nY7QlQQTH1758617586euoutp02B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:43:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190612074341euoutp02e1fa109c4604816a83895a5ce415c2a5~nY7QlQQTH1758617586euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560325421;
        bh=BflzyiBYm085cEE1kffZhowCXmhBFQyDftFupG8Lb/8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YVwHWRA7sEWsmeL0EniVGD1xNrRhlxZOcqsmhFUJiRV/7umoHNuZlHKTyo46sCzeP
         ZK11UhAEjraGzwwbVIhs7/zRSoSocfS5mDy2vMs9/onWD5byiboQsOo70D44z5B3RR
         2YuCBa/1yK+XHQYLHveAMv7jrhjDmzgMt1rvA4ZY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190612074340eucas1p1f7982446a026bd20f2f5bc9135ce2b4f~nY7PoPk5E0774807748eucas1p1j;
        Wed, 12 Jun 2019 07:43:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1D.C2.04325.B2DA00D5; Wed, 12
        Jun 2019 08:43:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190612074339eucas1p1301c7549d46f4f58be9b31a17b149df8~nY7O0ylZv0737807378eucas1p1g;
        Wed, 12 Jun 2019 07:43:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190612074339eusmtrp28f3f709953fc6beeb6215b44fd7766d0~nY7Ols0EE1016810168eusmtrp2P;
        Wed, 12 Jun 2019 07:43:39 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-aa-5d00ad2b5b8f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.F8.04140.B2DA00D5; Wed, 12
        Jun 2019 08:43:39 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190612074338eusmtip1abafa004f82171b60a13298663e44d33~nY7N1AFru0249202492eusmtip1K;
        Wed, 12 Jun 2019 07:43:38 +0000 (GMT)
Subject: Re: [PATCH v2 4/7] drm/bridge: Prepare Analogix anx6345 support
To:     Torsten Duwe <duwe@lst.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3533d7ba-5d07-89c7-a86d-8f66660413a8@samsung.com>
Date:   Wed, 12 Jun 2019 09:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604122258.664D468BFE@newverein.lst.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O7cdV6vjNPy6UDkSyrB78IUhBUUfRJZQdFHJlSeLvLWjdvGH
        5qVsEWpU1tG84CqxibY5y4mXNFpa07SV3Te0jAoLMq1FaW5nkf/e53mf9/2e5+VjSWUJM4s9
        lJDMaxLUcSpGTtXfd3YHL672ilpmKA5B57o6CJRzfxCg8foCEpXe66KRbeQrg0ZtnQTKqqhh
        UJ3ZSqPh8rcEOlOgkyHDwDMaPTEXM+haXw+BHB9bAMppuidDb2qtABkNF0nkNJdQyNnWTazz
        xRXOMQLrS/QAl+jT8Pv2zzJclNFD4dr+mzRuGi2jcIP4ZoLLvUJjQ9UZBn/p6pLh26MOGrdc
        1cuw/ayFwEZdOm58kcFs89kjXxvDxx1K5TVLQ6PlB8V8O5Ekzjx2Mr+fyACjflrAspBbBW1i
        uBbIWSVXCWD2ndeEBL4DaHowIpPAMIC6W09JLfB2T4gFpxipcQPAoc4aSgJDAPZXVwOXypfD
        8HpPBelq+HHtFLyQ10m7AMnlAFhmHKZcKoZbBP8YXzCuWsGFwkyt2c1TXCBs/fDcvWkGtwt+
        bzAASeMDO668c2u8uTWwsPyZ2xPJzYNZpiJP7Q9fvit1p4CcjYU12eO0ZHwDtOQ1ElLtCz9Z
        6mRSPQeON5R6+HRor8wmpeHciRPUNnhSh8B2Sw/tuhk54brGvFSi18O8R42kdMpp8PmQj+Rh
        GjxfX+ihFTD3lFJSB0C71eRZ6A+vPR5h8oFKnJRMnJRGnJRG/P9uGaCqgD+fIsTH8sLKBP7o
        EkEdL6QkxC7ZnxhvABO/9uGYZeQOaP69rw1wLFBNVbQWjkcqaXWqcDy+DUCWVPkpVhz2ilIq
        YtTHT/CaxL2alDheaAOzWUrlr0jzckQouVh1Mn+Y55N4zb8uwXrPygDltuY1czf3hjsGtzT/
        Smpp0ldiOd0XuSDQEqQ+XW/KHQhbPWX/77w5oX3f5vfW7j4RmXV3YLnjsa4709p4idgZU23c
        nniEi07L6ohwatOFrQHJr3p/vCXWT/mWaX+tCzt3wJm9afrCzhWGkIc/lT/N9Mf0seDLYa8S
        d2ysuK494B2hooSD6uVBpEZQ/wX8plBOsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURjHO+9tWzR6mwtPfrAYRVT02ma2MzGTijzSFfpipdSoNw3dZnun
        ZEWtzNKZ4ZAwp6nhKlhKNa1sIpVFXsJbiZm0Ft1ETE20wci0zRn47XfO///jPAceMSlz0mHi
        E3oTb9Rr0xXMQurNdIt7/braBckb2j5SqLCzjUC5r38ANPPYSqLKV5006v09xiBvbzuBcqrv
        M6je1UGjiVufCJRvtYuQ82sfjd65yhl0+30PgT4PPQMot+mVCLkfdABU57xOIp+rgkK+5i4i
        LgRX+6YJXFNRA3BFzRn8/eWwCJeZeyj84Ms9Gjd5qyj81Ob23+WV0tjpyGfwaGenCD/xfqbx
        s5s1IuwpaCFwnf08bvxgZvYtOcjFGA2ZJn5FqkEwbVYcUiIVp9QgTrVRwykj1cnRqihFRGzM
        MT79RBZvjIg9wqXaijxEhm3ZqQtFXwgz8MotQCKG7EZos15mLGChWMbeBvDCYDkVDEJhY+UI
        GeQQONVnmSsNAzgy+UgUCEJYDO/0VJOBQM62UNAydoMIHEg2F8Cpq0OioNII4JXyUhBQGHYN
        /Fv3gQmwlI2FFy2u2fcodhV8Ptg/21nKJsIyl5kKdpbAttJvsyxhNbDkVt/sTCS7Gk5VvJ3j
        5TDnUdkch8KBb5VEEZDZ5um2eYptnmKbp1QBygHkfKagS9EJKk7Q6oRMfQp31KBzAv++PH7t
        q28AltH9zYAVA8Ui6fOSmSQZrc0SsnXNAIpJhVyqSluQLJMe02af5o2Gw8bMdF5oBlH+z1nJ
        sKVHDf7t05sOK6OUaqRRqiPVkZuQIlSax75IkrEpWhOfxvMZvPG/R4glYWbQMJnXnr9NsrZ1
        gChhTuZKcDEZVVCwq85RyP089Ke26eyW6D318vjw41aP++VgiLb4zabwroSEvY0T3epLdJLa
        6/CFJ8Q3FBZ1t3J/7vJpKx2Ljck9vGfcwv06V7kjiR6vX7/Tcy1ut/vd0Ha7eme3pLdptP/h
        AX1i2OgQ2GpXUEKqVrmWNAraf/GMe89FAwAA
X-CMS-MailID: 20190612074339eucas1p1301c7549d46f4f58be9b31a17b149df8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190604122327epcas3p40004116ce83af448b156583d0fc7b37f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190604122327epcas3p40004116ce83af448b156583d0fc7b37f
References: <20190604122150.29D6468B05@newverein.lst.de>
        <CGME20190604122327epcas3p40004116ce83af448b156583d0fc7b37f@epcas3p4.samsung.com>
        <20190604122258.664D468BFE@newverein.lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.2019 14:22, Torsten Duwe wrote:
> Add bit definitions required for the anx6345 and add a
> sanity check in anx_dp_aux_transfer.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej



> ---
>  drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c     | 2 +-
>  drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h     | 8 ++++++++
>  drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h | 3 +++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> index d6016f789d80..e9d2ed4d410d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> @@ -124,7 +124,7 @@ ssize_t anx_dp_aux_transfer(struct regmap *map_dptx,
>  	else	/* For non-zero-sized set the length field. */
>  		ctrl1 |= (msg->size - 1) << SP_AUX_LENGTH_SHIFT;
>  
> -	if ((msg->request & DP_AUX_I2C_READ) == 0) {
> +	if ((msg->size > 0) && ((msg->request & DP_AUX_I2C_READ) == 0)) {
>  		/* When WRITE | MOT write values to data buffer */
>  		err = regmap_bulk_write(map_dptx,
>  					SP_DP_BUF_DATA0_REG, buffer,
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
> index 30436c88f181..95ab89eecc60 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
> @@ -83,7 +83,11 @@
>  #define SP_CHA_STA			BIT(2)
>  /* Bits for DP System Control Register 3 */
>  #define SP_HPD_STATUS			BIT(6)
> +#define SP_HPD_FORCE			BIT(5)
> +#define SP_HPD_CTRL			BIT(4)
>  #define SP_STRM_VALID			BIT(2)
> +#define SP_STRM_FORCE			BIT(1)
> +#define SP_STRM_CTRL			BIT(0)
>  /* Bits for DP System Control Register 4 */
>  #define SP_ENHANCED_MODE		BIT(3)
>  
> @@ -128,6 +132,9 @@
>  #define SP_LINK_BW_SET_MASK		0x1f
>  #define SP_INITIAL_SLIM_M_AUD_SEL	BIT(5)
>  
> +/* DP Lane Count Setting Register */
> +#define SP_DP_LANE_COUNT_SET_REG	0xa1
> +
>  /* DP Training Pattern Set Register */
>  #define SP_DP_TRAINING_PATTERN_SET_REG	0xa2
>  
> @@ -141,6 +148,7 @@
>  
>  /* DP Link Training Control Register */
>  #define SP_DP_LT_CTRL_REG		0xa8
> +#define SP_DP_LT_INPROGRESS		0x80
>  #define SP_LT_ERROR_TYPE_MASK		0x70
>  #  define SP_LT_NO_ERROR		0x00
>  #  define SP_LT_AUX_WRITE_ERROR		0x01
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h b/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
> index f48293f86f9d..e3391a50b5d1 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
> @@ -188,6 +188,9 @@
>  #define SP_VBIT				BIT(1)
>  #define SP_AUDIO_LAYOUT			BIT(0)
>  
> +/* Analog Debug Register 1 */
> +#define SP_ANALOG_DEBUG1_REG		0xdc
> +
>  /* Analog Debug Register 2 */
>  #define SP_ANALOG_DEBUG2_REG		0xdd
>  #define SP_FORCE_SW_OFF_BYPASS		0x20


