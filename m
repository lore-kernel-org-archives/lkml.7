Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15890C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF3D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RDwyiStr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDLG0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:26:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53418 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfDLG0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:26:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190412062615euoutp02821fc1f4d7d987b6a1bacb6302782436~UphPF3Hi_1889918899euoutp02W
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:26:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190412062615euoutp02821fc1f4d7d987b6a1bacb6302782436~UphPF3Hi_1889918899euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555050375;
        bh=xJNcVyE7+3LQ/0Nckz5ctnnp/njXQUikJeMFtNihWrY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RDwyiStrGNYCRcP9M5cPfkzEsiqzloQMu51g8HDdyU24FMx1dw9Yru/94R4L1V+LD
         ttgN/4xIwhaJqBVLuzOE3u2EAXZDFNKrguXqqBLVymMcNDfzalK+ggh7OR4wHs0IYu
         44DPBQc8nz/HmFGKCRpCP/XU9C0Rhbv7IcWCgkdQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190412062614eucas1p2cb2d08a478564686fd9eb9e01ab0c188~UphOXv9Hz1420214202eucas1p2y;
        Fri, 12 Apr 2019 06:26:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7E.3C.04377.68F20BC5; Fri, 12
        Apr 2019 07:26:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190412062613eucas1p20ca17b20a0b1d9420efa85358f1a08e5~UphNYqIiZ0624806248eucas1p2e;
        Fri, 12 Apr 2019 06:26:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190412062613eusmtrp22816ffee6ef8e15ff280b1f4bcc535a4~UphNKcst12228122281eusmtrp2O;
        Fri, 12 Apr 2019 06:26:13 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-10-5cb02f86427a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CD.26.04146.58F20BC5; Fri, 12
        Apr 2019 07:26:13 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190412062612eusmtip13e620b70d20b9af2dd2660a9649bad55~UphMsC5n22006420064eusmtip1d;
        Fri, 12 Apr 2019 06:26:12 +0000 (GMT)
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Fix overflow workaround for
 Rockchip SoCs
To:     Jonas Karlman <jonas@kwiboo.se>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <36fa1dc0-dc58-8941-840f-d56a29b8c654@samsung.com>
Date:   Fri, 12 Apr 2019 08:26:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <AM3PR03MB0966818FAAAE6192FF4ED11AAC7D0@AM3PR03MB0966.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeUiTYRzu/Y7tczr7nIY/VIwGQQY6S4OvyxIUvvpHiQ5xRq38mpIz3dzK
        DhwdsizFLq8OhcyjQ4fXdCXBAucyzZqtFYZ2RzWkTLPUlvMz8r/neX7P8/4OXgqXDJJBVHpm
        DqfOVGRIBSKiretXX3i+zJgSaawRMYV9Now5bnCRjLvtHM4MjI0IGPebLyRj+/qMYE6fqxYy
        dvMVAfN92I0zliI588rYizZ6syPOU0L2sv4JwdqLCjG2c7yKYC8bykm2u/gpxprGh0l26IwV
        Y5ur81iT4xrOjjaFJnoni9alchnpOk4ti9ktSivrLsGzCr0P1Q04hHr0kypAFAV0NNwrDSlA
        IkpC1yGYKLmD8+QHgvd3x0mejCIYGexDBchrNvHQOIn4Qi2C2j+1c8SFQP/2l8Dj8qe3g13f
        MRsPoE0Iim0nhR6C004M2ts+Cj0uAR0G080vZhNiOgZMj12zOkEvBeeFesyDF9FJMNRlJHmP
        H9jK3xEe7EXvhG9fX+MejNOLweS6MocD4eW7SszTDOhpIdy6dH9u8DhwuqsJHvvDZ2uLkMch
        4O6oxHicB0N1J3E+bEDQauzA+cJaeGB9Qnpuhs9M3WiW8XIsPJo8jfGn9AWny4+fwRfOt5Xi
        vCwGQ76Edy+Bod7WuQcD4Ub/mKAYSSvmbVYxb5uKedtU/O9bhYibKJDTalRKTrMykzsYoVGo
        NNpMZcTeA6omNPPnev5Yf7Qj89QeC6IpJPURJ8U2pkhIhU6Tq7IgoHBpgHgrMSOJUxW5hzn1
        gV1qbQansaBgipAGio8sGJZLaKUih9vPcVmc+l8Vo7yC9Chm1br6sc0X40e3WHujohJqwtdE
        jDeUtTqCrq9piG+dyg5bv3KhvC7B3p/bucOwffVv+b7S/bpCTpR+3BCcpu1u+NRikJSH9sQn
        Hzz7ufHwsmPW7Hqzj+7qBoeSLLjd9TzJEanvry+KjtInHt0U1G6cSDjRE6qL8/8gq3Fs67Sx
        3lJCk6ZYsRxXaxR/AVxkQydvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7qt+htiDCZ3sVr0njvJZNHU8ZbV
        4v+2icwWV76+Z7P4/+g1q8XJN1dZLDonLmG3uLxrDpvFpwf/mS0O9UVb3N1wltGB2+P9jVZ2
        j9kNF1k8Lvf1Mnns/baAxWN2x0xWjxMTLjF5bP/2gNXjfvdxJo/NS+o9tl+bx+zxeZNcAHeU
        nk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaME9OY
        C3q5K1ZcucbewPido4uRk0NCwETi1IbfjF2MXBxCAksZJc7P62OESIhL7J7/lhnCFpb4c62L
        DaLoNaPE/j2zwIqEBcIkLjfsZAVJiAhsZ5RY9vgzE4jDLHCLSWLNzGesEC0bGCUa93awgrSw
        CWhK/N18kw3E5hWwk9h+/i07iM0ioCpxY/JKJhBbVCBC4sz7FSwQNYISJ2c+AbM5BWIlPr55
        CHYTs4C6xJ95l6BseYntb+dA2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpu
        saFecWJucWleul5yfu4mRmBsbzv2c/MOxksbgw8xCnAwKvHwBlitjxFiTSwrrsw9xCjBwawk
        whvCAhTiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGDaySuJNzQ1NLewNDQ3Njc2s1AS5z1v
        UBklJJCeWJKanZpakFoE08fEwSnVwBhW3hd37d9zZttHhhFXJ2flp70RWdI6Q/7SkbyS8K4/
        VjuSK7eqtz7OeKcs+3rdHY67ptbbGmvjrj38P2+HP6vhDZa4eX9T5/u8z1TL+rsp7WhrWV2E
        ibNare+/p8dzjC7l7JuftT/b48vjQIsqzheMBkkXdt+SF1rI3L328ppL109dWXb3aawSS3FG
        oqEWc1FxIgCyYru5AwMAAA==
X-CMS-MailID: 20190412062613eucas1p20ca17b20a0b1d9420efa85358f1a08e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190220075334epcas3p16f66503f11d0bacdcf316b232f441fd0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190220075334epcas3p16f66503f11d0bacdcf316b232f441fd0
References: <CGME20190220075334epcas3p16f66503f11d0bacdcf316b232f441fd0@epcas3p1.samsung.com>
        <AM3PR03MB0966818FAAAE6192FF4ED11AAC7D0@AM3PR03MB0966.eurprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.2019 08:52, Jonas Karlman wrote:
> The Rockchip RK3288 SoC (v2.00a) and RK3328/RK3399 SoCs (v2.11a) have
> also been identified as needing this workaround with a single iteration.
>
> Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>


Queued to drm-misc-fixes.

--
Regards
Andrzej


> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 64c3cf027518..14223c0ee784 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1655,6 +1655,8 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>  	 * iteration for others.
>  	 * The Amlogic Meson GX SoCs (v2.01a) have been identified as needing
>  	 * the workaround with a single iteration.
> +	 * The Rockchip RK3288 SoC (v2.00a) and RK3328/RK3399 SoCs (v2.11a) have
> +	 * been identified as needing the workaround with a single iteration.
>  	 */
>  
>  	switch (hdmi->version) {
> @@ -1663,7 +1665,9 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>  		break;
>  	case 0x131a:
>  	case 0x132a:
> +	case 0x200a:
>  	case 0x201a:
> +	case 0x211a:
>  	case 0x212a:
>  		count = 1;
>  		break;


