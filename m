Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA4FC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BDF2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tv9AfZHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfFYQHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:07:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51332 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfFYQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:07:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190625160752euoutp024090e78b21cbe32337a41c130fd67977~rfML_wPBN0341303413euoutp021
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 16:07:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190625160752euoutp024090e78b21cbe32337a41c130fd67977~rfML_wPBN0341303413euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561478872;
        bh=fre5zIWNZHt31JozVg5a9l18ipF4snQePDt6EgEKEes=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Tv9AfZHnnOPBa/4Ubpa+kj/nq1VixztsSuB9xc/442AguGbaQ31npEpicT6mvY0iH
         1hLRpW4wyA8Z2F3ys3mJVsW4Fst04gHXcyjcV8BKUviTVwBLJO659LK86YXfceEFhz
         NBjDa1K0+/1BiYsDQOcXNMuADQ2XT9yjZhsAZbhI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190625160751eucas1p14b0561a6ac0cbd25c69e238d7d1de358~rfMK2Q0Wb0882608826eucas1p1F;
        Tue, 25 Jun 2019 16:07:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D1.4E.04377.7D6421D5; Tue, 25
        Jun 2019 17:07:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190625160750eucas1p1d8c9f283ac7d7d843d6ec8900d894bbe~rfMJmns_W0882608826eucas1p1E;
        Tue, 25 Jun 2019 16:07:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190625160749eusmtrp168f275b3af637f17a4dfc60b8e87b6f1~rfMJYa5gf1029110291eusmtrp1S;
        Tue, 25 Jun 2019 16:07:49 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-a5-5d1246d7e2d9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FA.C3.04140.5D6421D5; Tue, 25
        Jun 2019 17:07:49 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190625160749eusmtip2210172925376a7599d9f78026677b5ca~rfMIpXUre2973029730eusmtip2q;
        Tue, 25 Jun 2019 16:07:49 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] drm/bridge/synopsys: dw-hdmi: Handle audio for
 more clock rates
To:     Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        seanpaul@chromium.org
Cc:     jernej.skrabec@siol.net, heiko@sntech.de, jonas@kwiboo.se,
        maxime.ripard@bootlin.com, narmstrong@baylibre.com,
        linux-rockchip@lists.infradead.org, dgreid@chromium.org,
        cychiang@chromium.org, jbrunet@baylibre.com,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <bec87373-48cc-0c55-9662-a74a7d2a47a0@samsung.com>
Date:   Tue, 25 Jun 2019 18:07:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619210718.134951-1-dianders@chromium.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju23d2PJNWn8diLxVFg35Y5I2Ij5Kh0eX0LyoiMquVJw11xeYl
        k3A/rEwzssTKTC00hwiZ5ryVl2Xq0JXLLDPCaYZUDiHnat2s7Rj573nf533e93k+Pg7zRnYZ
        d0KXLOp12kQ168+YuzzP17/ezseEPhteTPOeWWU0z/xARmfN+ZiW9gyz1Havg6UvZ6ZYOjv2
        WU4nxzoxHfz6EVPr5CBDL+aX+9GB5mKWfnHMYur42Iao5XI0NXnqEX1XY0ORAcLU0Dk/oaQ6
        Q7hltDPCY3cZI9zKvikXeq68kAkNbodcGMntlgl15ZlCeeEgK7TnXWOEhlclWJiuXblLecA/
        IlZMPJEq6kM0R/zjnd92nJrdd7rVbGWMyBOVgzgOyAYYvnMoB/lzPDEhMBVPyqXCheDCL4dM
        KqYRZOfV+OUghU9hbMvHElGJwPO5FUmFE8Hk05cy71QgiQFbjwt78RKSAW8/zPhWYXIOQ1fd
        cx/BkiD4VfeG9WIl0cCLu9N+XlMMWQNdnRu97aVkP7iaapE0EgDWm+OMFytIBEyU2n1STFZB
        g7MYS1gFw+OlvltAGjn43luCJNtboSXfPYcD4VP3w7k4K6D32iVGwpkwYsrCkjgbQX1NE5aI
        zfCk2y73msN/Td9vDpHaUdA3VC2XHnIRDDkDJA+L4Kr5OpbaSsg+z0vTq2HEVj+3UAUV/TPs
        FaQumpesaF6aonlpiv7fLUNMFVKJKYakONEQrhPTgg3aJEOKLi742MmkWvT3X/b+7nY1ouaf
        Ry2IcEi9UGlcxcfwcm2qIT3JgoDD6iXKCi2J4ZWx2vQzov7kYX1KomiwoOUco1YpMxY4onkS
        p00WE0TxlKj/x8o4xTIjivzUPrC4Lz3U7j5rjU8YICh39EeVfWPB9fPHT7sVIe9GTOWVodsK
        HrWHr9trTtkZ6grSHbytGU9lBtN2KyNW81W97ytzOx4X9q8ptRy98f2u2Nbpac5NLqjf0iKz
        kyBFcllHxfr+AadmYp8t8ep+DRvWqtqzKYxeGFVvyMya2KpmDPHasLVYb9D+AeaBy26TAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsVy+t/xe7pX3YRiDeb1Wlr0njvJZNG7bSOT
        xf9tE5kt5p+4xWZxdtlBNosrX9+zWfx/9JrV4s2jI8wWV7+/ZLY4+eYqi0XnxCXsFpd3zWGz
        +PTgP7PFg5f7GS0O9UVbrPi5ldHi7oazjA6CHu9vtLJ7zFtT7TG74SKLx95vC1g8ZnfMZPU4
        MeESk8f2bw9YPe53H2fy2Lyk3mPJtKtsHgd6J7N4bL82j9nj8ya5AN4oPZui/NKSVIWM/OIS
        W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYy3P9wL/odV7Nt2kqWB8adj
        FyMnh4SAiUTD/onMXYxcHEICSxklNpyaygqREJfYPf8tM4QtLPHnWhcbRNFrRon+9vtMIAlh
        gViJsye+gBWJCFRL/P17jhWkiFmglVni2OnrLCAJIYF+RonXByNAbDYBTYm/m2+ygdi8AnYS
        lxZ9Zu9i5OBgEVCVOHbEDCQsKhAhMXtXAwtEiaDEyZlPwGxOARuJ5/MvgrUyC6hL/Jl3iRnC
        lpfY/nYOlC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl
        5+duYgQmiG3Hfm7Zwdj1LvgQowAHoxIPb4O8UKwQa2JZcWXuIUYJDmYlEd6liQKxQrwpiZVV
        qUX58UWlOanFhxhNgX6byCwlmpwPTF55JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNT
        UwtSi2D6mDg4pRoYr6ra3bM7qhYqEBuz4wz3JKvnM5gu8+2N6i5l3JRk+SX5xbFKprKatu7i
        4/8+dB7WUfyy2W/rrz+7p5RUbBC7+4lVYfG0PT9F9I9vagqQFr9hULCtor7e54G55c4LxqJL
        cmYdlrNn/lCeeXmXaYD+pZdLFD6+fl0W4HZiNjfzdp+jwTzHtZvrlFiKMxINtZiLihMBiHVv
        4SYDAAA=
X-CMS-MailID: 20190625160750eucas1p1d8c9f283ac7d7d843d6ec8900d894bbe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190619211151epcas3p4dbb163c034afa4063869c761b93e24b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190619211151epcas3p4dbb163c034afa4063869c761b93e24b1
References: <CGME20190619211151epcas3p4dbb163c034afa4063869c761b93e24b1@epcas3p4.samsung.com>
        <20190619210718.134951-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.2019 23:07, Douglas Anderson wrote:
> Let's add some better support for HDMI audio to dw_hdmi.
> Specifically:
>
> 1. For 44.1 kHz audio the old code made the assumption that an N of
> 6272 was right most of the time.  That wasn't true and the new table
> should pick a more ideal value.


Why? I ask because it is against recommendation from HDMI specs.



>
> 2. The new table has values from the HDMI spec for 297 MHz and 594
> MHz.
>
> 3. There is now code to try to come up with a more idea N/CTS for
> clock rates that aren't in the table.  This code is a bit slow because
> it iterates over every possible value of N and picks the best one, but
> it should make a good fallback.
>
> NOTES:
> - The oddest part of this patch comes about because computing the
>   ideal N/CTS means knowing the _exact_ clock rate, not a rounded
>   version of it.  The drm framework makes this harder by rounding
>   rates to kHz, but even if it didn't there might be cases where the
>   ideal rate could only be calculated if we knew the real
>   (non-integral) rate.  This means that in cases where we know (or
>   believe) that the true rate is something other than the rate we are
>   told by drm.
> - This patch makes much less of a difference after the patch
>   ("drm/bridge: dw-hdmi: Use automatic CTS generation mode when using
>   non-AHB audio"), at least if you're using I2S audio.  The main goal
>   of picking a good N is to make it possible to get a nice integral
>   CTS value, but if CTS is automatic then that's much less critical.


As I said above HDMI recommendations are different from those from your
patch. Please elaborate why?

Btw I've seen your old patches introducing recommended N/CTS calculation
helpers in HDMI framework, unfortunately abandoned due to lack of interest.

Maybe resurrecting them would be a good idea, with assumption there will
be users :)


Regards

Andrzej


>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Atop ("drm/bridge: dw-hdmi: Use automatic CTS generation mode when
>   using non-AHB audio").
> - Split out the ability of a platform to provide custom tables.
>
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 203 +++++++++++++++++-----
>  1 file changed, 162 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index de4c3669c83f..7cdffebcc7cb 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -60,6 +60,82 @@ enum hdmi_datamap {
>  	YCbCr422_12B = 0x12,
>  };
>  
> +struct dw_hdmi_audio_tmds_n {
> +	unsigned long tmds;
> +	unsigned int n_32k;
> +	unsigned int n_44k1;
> +	unsigned int n_48k;
> +};
> +
> +/*
> + * Unless otherwise noted, entries in this table are 100% optimization.
> + * Values can be obtained from hdmi_compute_n() but that function is
> + * slow so we pre-compute values we expect to see.
> + *
> + * All 32k and 48k values are expected to be the same (due to the way
> + * the math works) for any rate that's an exact kHz.
> + *
> + * If a particular platform knows that it makes a rate slightly
> + * differently then it should add a platform-specific match.
> + */
> +static const struct dw_hdmi_audio_tmds_n common_tmds_n_table[] = {
> +	/* Doesn't match computations, assumes real clock = 25.2 MHz / 1.001 */
> +	{ .tmds = 25175000, .n_32k = 4576, .n_44k1 = 7007, .n_48k = 6864, },
> +
> +	{ .tmds = 25200000, .n_32k = 4096, .n_44k1 = 5656, .n_48k = 6144, },
> +	{ .tmds = 27000000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
> +	{ .tmds = 27027000, .n_32k = 4096, .n_44k1 = 6272, .n_48k = 6144, },
> +	{ .tmds = 28320000, .n_32k = 4096, .n_44k1 = 5586, .n_48k = 6144, },
> +	{ .tmds = 30240000, .n_32k = 4096, .n_44k1 = 5642, .n_48k = 6144, },
> +	{ .tmds = 31500000, .n_32k = 4096, .n_44k1 = 5600, .n_48k = 6144, },
> +	{ .tmds = 32000000, .n_32k = 4096, .n_44k1 = 5733, .n_48k = 6144, },
> +	{ .tmds = 33750000, .n_32k = 4096, .n_44k1 = 6272, .n_48k = 6144, },
> +	{ .tmds = 36000000, .n_32k = 4096, .n_44k1 = 5684, .n_48k = 6144, },
> +	{ .tmds = 40000000, .n_32k = 4096, .n_44k1 = 5733, .n_48k = 6144, },
> +	{ .tmds = 49500000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
> +	{ .tmds = 50000000, .n_32k = 4096, .n_44k1 = 5292, .n_48k = 6144, },
> +	{ .tmds = 54000000, .n_32k = 4096, .n_44k1 = 5684, .n_48k = 6144, },
> +	{ .tmds = 65000000, .n_32k = 4096, .n_44k1 = 7056, .n_48k = 6144, },
> +	{ .tmds = 68250000, .n_32k = 4096, .n_44k1 = 5376, .n_48k = 6144, },
> +	{ .tmds = 71000000, .n_32k = 4096, .n_44k1 = 7056, .n_48k = 6144, },
> +	{ .tmds = 72000000, .n_32k = 4096, .n_44k1 = 5635, .n_48k = 6144, },
> +	{ .tmds = 73250000, .n_32k = 4096, .n_44k1 = 14112, .n_48k = 6144, },
> +
> +	/* Doesn't match computations, assumes real clock = 74.25 MHz / 1.001 */
> +	{ .tmds = 74176000, .n_32k = 11648, .n_44k1 = 17836, .n_48k = 11648, },
> +
> +	{ .tmds = 74250000, .n_32k = 4096, .n_44k1 = 6272, .n_48k = 6144, },
> +	{ .tmds = 75000000, .n_32k = 4096, .n_44k1 = 5880, .n_48k = 6144, },
> +	{ .tmds = 78750000, .n_32k = 4096, .n_44k1 = 5600, .n_48k = 6144, },
> +	{ .tmds = 78800000, .n_32k = 4096, .n_44k1 = 5292, .n_48k = 6144, },
> +	{ .tmds = 79500000, .n_32k = 4096, .n_44k1 = 4704, .n_48k = 6144, },
> +	{ .tmds = 83500000, .n_32k = 4096, .n_44k1 = 7056, .n_48k = 6144, },
> +	{ .tmds = 85500000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
> +	{ .tmds = 88750000, .n_32k = 4096, .n_44k1 = 14112, .n_48k = 6144, },
> +	{ .tmds = 97750000, .n_32k = 4096, .n_44k1 = 14112, .n_48k = 6144, },
> +	{ .tmds = 101000000, .n_32k = 4096, .n_44k1 = 7056, .n_48k = 6144, },
> +	{ .tmds = 106500000, .n_32k = 4096, .n_44k1 = 4704, .n_48k = 6144, },
> +	{ .tmds = 108000000, .n_32k = 4096, .n_44k1 = 5684, .n_48k = 6144, },
> +	{ .tmds = 115500000, .n_32k = 4096, .n_44k1 = 5712, .n_48k = 6144, },
> +	{ .tmds = 119000000, .n_32k = 4096, .n_44k1 = 5544, .n_48k = 6144, },
> +	{ .tmds = 135000000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
> +	{ .tmds = 146250000, .n_32k = 4096, .n_44k1 = 6272, .n_48k = 6144, },
> +
> +	/* Doesn't match computations, assumes real clock = 148.5 MHz / 1.001 */
> +	{ .tmds = 148352000, .n_32k = 11648, .n_44k1 = 8918, .n_48k = 5824, },
> +
> +	{ .tmds = 148500000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
> +	{ .tmds = 154000000, .n_32k = 4096, .n_44k1 = 5544, .n_48k = 6144, },
> +	{ .tmds = 162000000, .n_32k = 4096, .n_44k1 = 5684, .n_48k = 6144, },
> +
> +	/* For 297 MHz+ HDMI spec has some other rule for setting N */
> +	{ .tmds = 297000000, .n_32k = 3073, .n_44k1 = 4704, .n_48k = 5120, },
> +	{ .tmds = 594000000, .n_32k = 3073, .n_44k1 = 9408, .n_48k = 10240, },
> +
> +	/* End of table */
> +	{ .tmds = 0,         .n_32k = 0,    .n_44k1 = 0,    .n_48k = 0, },
> +};
> +
>  static const u16 csc_coeff_default[3][4] = {
>  	{ 0x2000, 0x0000, 0x0000, 0x0000 },
>  	{ 0x0000, 0x2000, 0x0000, 0x0000 },
> @@ -524,60 +600,105 @@ static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
>  	hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
>  }
>  
> -static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
> +static int hdmi_match_tmds_n_table(struct dw_hdmi *hdmi, unsigned int freq,
> +				   unsigned long pixel_clk)
>  {
> -	unsigned int n = (128 * freq) / 1000;
> -	unsigned int mult = 1;
> +	const struct dw_hdmi_audio_tmds_n *tmds_n = NULL;
> +	int mult = 1;
> +	int i;
>  
>  	while (freq > 48000) {
>  		mult *= 2;
>  		freq /= 2;
>  	}
>  
> +	for (i = 0; common_tmds_n_table[i].tmds != 0; i++) {
> +		if (pixel_clk == common_tmds_n_table[i].tmds) {
> +			tmds_n = &common_tmds_n_table[i];
> +			break;
> +		}
> +	}
> +
> +	if (tmds_n == NULL)
> +		return -ENOENT;
> +
>  	switch (freq) {
>  	case 32000:
> -		if (pixel_clk == 25175000)
> -			n = 4576;
> -		else if (pixel_clk == 27027000)
> -			n = 4096;
> -		else if (pixel_clk == 74176000 || pixel_clk == 148352000)
> -			n = 11648;
> -		else
> -			n = 4096;
> -		n *= mult;
> -		break;
> -
> +		return tmds_n->n_32k * mult;
>  	case 44100:
> -		if (pixel_clk == 25175000)
> -			n = 7007;
> -		else if (pixel_clk == 74176000)
> -			n = 17836;
> -		else if (pixel_clk == 148352000)
> -			n = 8918;
> -		else
> -			n = 6272;
> -		n *= mult;
> -		break;
> -
> +		return tmds_n->n_44k1 * mult;
>  	case 48000:
> -		if (pixel_clk == 25175000)
> -			n = 6864;
> -		else if (pixel_clk == 27027000)
> -			n = 6144;
> -		else if (pixel_clk == 74176000)
> -			n = 11648;
> -		else if (pixel_clk == 148352000)
> -			n = 5824;
> -		else
> -			n = 6144;
> -		n *= mult;
> -		break;
> -
> +		return tmds_n->n_48k * mult;
>  	default:
> -		break;
> +		return -ENOENT;
> +	}
> +}
> +
> +static u64 hdmi_audio_math_diff(unsigned int freq, unsigned int n,
> +				unsigned int pixel_clk)
> +{
> +	u64 final, diff;
> +	u64 cts;
> +
> +	final = (u64)pixel_clk * n;
> +
> +	cts = final;
> +	do_div(cts, 128 * freq);
> +
> +	diff = final - (u64)cts * (128 * freq);
> +
> +	return diff;
> +}
> +
> +static unsigned int hdmi_compute_n(struct dw_hdmi *hdmi, unsigned int freq,
> +				   unsigned long pixel_clk)
> +{
> +	unsigned int min_n = DIV_ROUND_UP((128 * freq), 1500);
> +	unsigned int max_n = (128 * freq) / 300;
> +	unsigned int ideal_n = (128 * freq) / 1000;
> +	unsigned int best_n_distance = ideal_n;
> +	unsigned int best_n = 0;
> +	u64 best_diff = U64_MAX;
> +	int n;
> +
> +	/* If the ideal N could satisfy the audio math, then just take it */
> +	if (hdmi_audio_math_diff(freq, ideal_n, pixel_clk) == 0)
> +		return ideal_n;
> +
> +	for (n = min_n; n <= max_n; n++) {
> +		u64 diff = hdmi_audio_math_diff(freq, n, pixel_clk);
> +
> +		if (diff < best_diff || (diff == best_diff &&
> +		    abs(n - ideal_n) < best_n_distance)) {
> +			best_n = n;
> +			best_diff = diff;
> +			best_n_distance = abs(best_n - ideal_n);
> +		}
> +
> +		/*
> +		 * The best N already satisfy the audio math, and also be
> +		 * the closest value to ideal N, so just cut the loop.
> +		 */
> +		if ((best_diff == 0) && (abs(n - ideal_n) > best_n_distance))
> +			break;
>  	}
>  
> -	return n;
> +	return best_n;
> +}
> +
> +static unsigned int hdmi_find_n(struct dw_hdmi *hdmi, unsigned int freq,
> +				unsigned long pixel_clk)
> +{
> +	int n;
> +
> +	n = hdmi_match_tmds_n_table(hdmi, freq, pixel_clk);
> +	if (n > 0)
> +		return n;
> +
> +	dev_warn(hdmi->dev, "Rate %lu missing; compute N dynamically\n",
> +		 pixel_clk);
> +
> +	return hdmi_compute_n(hdmi, freq, pixel_clk);
>  }
>  
>  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
> @@ -588,7 +709,7 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>  	u8 config3;
>  	u64 tmp;
>  
> -	n = hdmi_compute_n(sample_rate, pixel_clk);
> +	n = hdmi_find_n(hdmi, sample_rate, pixel_clk);
>  
>  	config3 = hdmi_readb(hdmi, HDMI_CONFIG3_ID);
>  


