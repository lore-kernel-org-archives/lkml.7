Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF6EC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C4320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F4iuljgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFMPSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:18:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42111 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732160AbfFMNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:09:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190613130941euoutp02d2d516f8c8bef435edc4a2c90831ccd4~nxBLqvZFJ0204202042euoutp02C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:09:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190613130941euoutp02d2d516f8c8bef435edc4a2c90831ccd4~nxBLqvZFJ0204202042euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560431381;
        bh=zdLA4Nojr9jC09RQ/AblHRjiDN2CeTU+kemvaSieWYY=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=F4iuljgsd4Uj4r83qlWWsZPsixnbRMiKrVvHWX01wccNEj1hDuUM0IKT8XlBqloPT
         BR6hZ4OXMIxHyt+XeADVO+0T3cAYflilSrPaywWbk46tK3zT7tRG+XZR7+P0iBH7Tj
         KPrCgOrXTZNrQgzbN/SoTQmhUIx3GHTQZ6EpeWt4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190613130940eucas1p1164d9e64a164b45b79386a13c1970a31~nxBK_qeAQ1623716237eucas1p1U;
        Thu, 13 Jun 2019 13:09:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.9F.04377.41B420D5; Thu, 13
        Jun 2019 14:09:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190613130939eucas1p2ed39eed5de6719ced11b82668a10132a~nxBKFxUg31943819438eucas1p2r;
        Thu, 13 Jun 2019 13:09:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190613130939eusmtrp2038b72b76541c3637832e737ded0e8ff~nxBJ2G8PA2146321463eusmtrp2e;
        Thu, 13 Jun 2019 13:09:39 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-bf-5d024b14a433
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.FD.04140.31B420D5; Thu, 13
        Jun 2019 14:09:39 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190613130938eusmtip2da5be16d87b60a3331e3e3ecf6b15459~nxBJJ2l-y2891228912eusmtip2J;
        Thu, 13 Jun 2019 13:09:38 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: analogix_dp: possible condition with no
 effect (if == else)
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <9bcf16dd-c064-27eb-3749-c3933b4b605f@samsung.com>
Date:   Thu, 13 Jun 2019 15:09:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190525175937.GA29368@hari-Inspiron-1545>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUgUYRjHfWdmd2e1lXFVfLSLFvpgkFqIDJqiGDEYdhOhWE06qKW7suOR
        GWQHsVmWhlhu4iopmqwH1ponhIKLlMd6ZmlrqB0eaXmg4ZHrKPnt9/yf6/+8vCQuHxS5kNHK
        eE6tZGMUYmuiumWp46DDcSzMYzjDmU5vb8XotepMnO6ZnxbT+s9NiDZNLGP05N8+jH6QWSih
        u+tyxXTBbwNBrwyuiumSJQPyt2H0eXrE1AwVIqZxIZ9garVDEuaFJkfEvGz4iTFvF4ZFTF7r
        acb80Igxhdm9Yma2as8pmxDrIxFcTHQip3b3u2wdVaEzobhO6fXyX5mSVJRFpiEpCZQnPDY9
        F6cha1JOlSDomtHhQjCHoN3UTgjBLILujizxVktXea9ESBQjGCvPQEIwhSBv6A1hqbKnLkJR
        hR6zsAPVi4Oh4ayFxZQrrLwe2Jgko/xgTdMssjBB7YeJ+j8bvY7UBZirrUJCjR205oxu6FKK
        htHxOxIL49ReuGt4gQvsBJ9GdZjFBFBTEhi+XYwEq0dhRbsgEdgexo1vNnkXrNXqMIFvgbnk
        Hi40axAYKmtxIeEDzUbTujtyfYMrVNS5C3IAFGg0EosMlC18nLITPNjC0+pnuCDLQHNfLlTv
        A3ObYXOgExR1zm8+IgNPsnNQBtqn3Xaldttl2m2Xaf97yEdEKXLiEvjYSI4/rOSS3Hg2lk9Q
        RrqFq2Kr0Pqfe79qnKtBdctXmhBFIsUO2TtvLEwuYhP55NgmBCSucJAtWq1Lsgg2+QanVl1S
        J8RwfBPaSRIKJ1mK1XConIpk47lrHBfHqbeyGCl1SUU3l5rzThzLxYt0wfVly6E+pkUV5qE6
        E9KvOn8uPnA6yf5Sz6vJwtIe1i7B03yV3e2V1lH+JTozPT7AMJ+qPOmZqCNzpLPGNHbMvT/4
        6zdpX0jLXEpgWG69sbHGPr3N2extGzDg6xUU/oMvM1X6nhl5NDPywfF7kHdrl1436b+qIPgo
        9tABXM2z/wDJlQURbwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7rC3kyxBmueiVn0njvJZPF/20Rm
        iytf37NZrLl9iNHi4us/TBZvfl1jsuicuITd4vKuOWwWCz9uZbH4e+cfm8WKn1sZHbg91sxb
        w+ix4+4SRo+93xaweOycdZfdY3bHTFaPxXteMnls//aA1WPeyUCP+93HmTyWTLvK5vF5k1wA
        d5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvr5
        FxkLLnBWrHs3kb2BcQpHFyMnh4SAicSldVfZQWwhgaWMEi8u5EDExSV2z3/LDGELS/y51sXW
        xcgFVPOaUWLew89sIAlhgTiJpevXMIEkRARuMkv0n//ECDGpm1Hi0IFEEJtNQFPi7+abYA28
        AnYS/zsOs4LYLAKqEq93f2IBsUUFIiRm72pggagRlDg58wmYzSlgIfHkVRPYdcwC6hJ/5l1i
        hrDlJZq3zoayxSVuPZnPNIFRcBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0
        veT83E2MwPjdduznlh2MXe+CDzEKcDAq8fAesGKKFWJNLCuuzD3EKMHBrCTC+4MBKMSbklhZ
        lVqUH19UmpNafIjRFOi5icxSosn5wNSSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBcU+oUu3ZKesb7kSoNEk2KjAIqMv1NWfMucQftW1SbdcpoW3zP0Wt2TX5
        9bo1NZO/8CZ9aVidEFRW+V5BWlQ7XPWk0K0DMzXrdR/5C+ke0f24Svzj8shXhh9LnOccPZF6
        /8G5HOt3301nVs54bfFCXcq9gDHrX+Hn3RejV0pXV7Wo/ndzXrXhshJLcUaioRZzUXEiAHCr
        YWv1AgAA
X-CMS-MailID: 20190613130939eucas1p2ed39eed5de6719ced11b82668a10132a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190525175948epcas2p31156b3ec2ee712634558e04faa42b342
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190525175948epcas2p31156b3ec2ee712634558e04faa42b342
References: <CGME20190525175948epcas2p31156b3ec2ee712634558e04faa42b342@epcas2p3.samsung.com>
        <20190525175937.GA29368@hari-Inspiron-1545>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.2019 19:59, Hariprasad Kelam wrote:
> fix below warning reported by coccicheck
>
> ./drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1414:6-8: WARNING:
> possible condition with no effect (if == else)
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>


Mixed feelings about it, but:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


I will queue it to drm-misc-next.
 --
Regards
Andrzej


> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 257d69b..cfcd159 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1411,8 +1411,6 @@ static void analogix_dp_bridge_mode_set(struct drm_bridge *bridge,
>  		video->color_space = COLOR_YCBCR444;
>  	else if (display_info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
>  		video->color_space = COLOR_YCBCR422;
> -	else if (display_info->color_formats & DRM_COLOR_FORMAT_RGB444)
> -		video->color_space = COLOR_RGB;
>  	else
>  		video->color_space = COLOR_RGB;
>  


