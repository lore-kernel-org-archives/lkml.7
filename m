Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCCDC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF462082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hmyPH1l+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634026AbfIYIJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:09:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51496 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442722AbfIYIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:09:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190925080938euoutp026cb1a2feccdbd60f8d95ff6f333d21a6~HoA5h3O2A2989029890euoutp02R
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:09:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190925080938euoutp026cb1a2feccdbd60f8d95ff6f333d21a6~HoA5h3O2A2989029890euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569398978;
        bh=lpAo3uu4Dyg/OQ5zC5Dglqf5pwQWN26o/2EDT3w2wuw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hmyPH1l+FoJgzs2L2RuEnGzZzCBDyqDI6+UxrLBIXQXTvFk9lYziiZfwY4iFVqvMg
         ZoW3ugGtCBNf7HyczynUUgWAxTthJxEVH8FBbTkNamj07TL6wxCivTgzELGQJ1GAdH
         I9NfkZDk6QQ6+/3bxWUGX8F9MWGkkNbUMEJLma04=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190925080938eucas1p2f852704ff9bfa6c14598d9b6a3d784a6~HoA5PyGmn0821508215eucas1p2v;
        Wed, 25 Sep 2019 08:09:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 98.94.04469.2C02B8D5; Wed, 25
        Sep 2019 09:09:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190925080938eucas1p137dd40d454d0d502efb5d8c04701f70a~HoA48swcA0500405004eucas1p1o;
        Wed, 25 Sep 2019 08:09:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925080938eusmtrp1dbec5f9fd41ca67829c62c2973abee2e~HoA47XYC_0496404964eusmtrp1B;
        Wed, 25 Sep 2019 08:09:38 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-dd-5d8b20c2cf82
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 17.9F.04166.2C02B8D5; Wed, 25
        Sep 2019 09:09:38 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925080937eusmtip2a02839a3701b1772c5f3873977ac4399~HoA4RBOLm1383813838eusmtip2t;
        Wed, 25 Sep 2019 08:09:37 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Use
 devm_platform_ioremap_resource() in __dw_mipi_dsi_probe()
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <475b8bc5-b7da-bf20-c322-e15e74d19378@samsung.com>
Date:   Wed, 25 Sep 2019 10:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <59343c81-3dd8-023c-6440-d48c8d74e05e@st.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O7edDSfHVezTpHIhdrcbdbALChHnV4QQWCa58qSRTtnUsiAN
        s7wlLqFwThNSG2Uq6i4JK5nlcmYXzdKsttRaKy9UTpultu0Y+e95n+d93vd9Pj4SFeUQgeQp
        WRorl0mTJIQA03W4nm80rSqM3dzcEEBffdaJ0PM6JUq/ck4Q9PzQN5zum3agdOdoH0Zr3y6n
        85XVPLq3Ve0WVXacbrVWIbSpOIau+T0OaNulLzitcWkBfSU/l4igmIn+XB5jnKrCmPK8Mpx5
        UtKDMPopG85YC80IU329j2BmVQ8xpu1qKcboX1eizKdfRpQpLx3CmZ9NK5jBzzrsoN8Rwe54
        NulUBisP2xsnSCyyGdDUbuqs66MeyQYWYQHgk5DaDts7O3gFQECKKA2ABuc04IpJAK/MTCwU
        PwFsqba720iv5cMsxfG3AdTbTQRXjAHYk2NHPHOXUDJo6dBgHmEpNYzBR9pBzCOgbqFC/caL
        CWotnG0eIDxYSO2FjslCL8aoEKgevOvFy6ho+MPWjnM9/rCzbMTr5VPhcGbCiHMzV8IcbTnK
        YTF8O3IT8SyGVAsJHaNDKJd0H6xvaMQ5vAR+NbfwOBwEu0qLMA5nQavmEsqZ8wDUNt5fMO+C
        7eaXuCc/6r66oTWMoyPhQJsO4Z7FD/aP+XM3+MFruhsoRwth3mUR1x0Mrd3ahYFiWPPCSZQA
        iWpRMtWiNKpFaVT/91YB7A4Qs+mK5ARWsUXGntmkkCYr0mUJm06kJDcB99fsmjP/MABnz3ET
        oEgg8RVG4AWxIlyaochMNgFIopKlQlWQmxLGSzPPsfKUY/L0JFZhAstJTCIWnvexxYioBGka
        e5plU1n5PxUh+YHZoH4gIFYZMv4xfWj/xV+rJ8886YveExn1eCvWbdLjtVOW88Kdt9/7Bq/J
        P/DQmGAo8omrbBt5F/P6VtM2QWj4OP+itftCL7hXxT+tfhWFxReHHl1/93DFyewdT3XNjpq0
        LOX6P+vqIgLvP6jd5ZoxDmyYtoV8mYvM+S62fApPOTRct0yCKRKlW9ahcoX0L8P+WjyWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xe7qHFLpjDW6fYLXoPXeSyeL/tonM
        Fle+vmez+P/oNavF1e8vmS1OvrnKYrH1lrRF58Ql7BaXd80BSs56zmqx6/4CJotDfdEWS3+/
        Y7R40PKC1WLFz62MFu2drWwOAh7vb7Sye+z9toDFY3bHTFaPExMuMXls//aA1eN+93EmjyXT
        rrJ5/J21n8XjQO9kFo/t1+Yxezz9sZfZY/bkR6wenzfJedx+to0lgC9Kz6Yov7QkVSEjv7jE
        Vina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL6PnwQ7mgrMCFT8fbmdqYDzF
        28XIwSEhYCJx769AFyMXh5DAUkaJM+9WM3UxcgLFxSV2z3/LDGELS/y51sUGUfSaUeLShn4W
        kISwQJ7EqWMrWEASIgLPWSQeTf7OCpJgBkqcvdTPDtGxl1Hi+o+TjCAJNgFNib+bb7KB2LwC
        dhIvv3SD2SwCqhJzbq8Gs0UFIiQO75jFCFEjKHFy5hOwbZwCVhK/3u+FWqAu8WfeJWYIW16i
        eetsKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/d
        xAhME9uO/dy8g/HSxuBDjAIcjEo8vA6sXbFCrIllxZW5hxglOJiVRHhnyQCFeFMSK6tSi/Lj
        i0pzUosPMZoCPTeRWUo0OR+YwvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQW
        wfQxcXBKNTDa/9t8RMXG45G3D3+jh61FvPDU4ELuq21f1Wb9f92R/Ff/iK0qy/RVpplntbaV
        TZv7keMkc/uctQkctcvfykRWRHvOWrPNTVCwzE94H4/o8+n3+aZOYO9T02dw6srUV2lcrHBn
        Qeu/250fM1/anJs8K3bpk7TGwKefs7dLT5MSZw3YOS38c7ISS3FGoqEWc1FxIgC40rnJKQMA
        AA==
X-CMS-MailID: 20190925080938eucas1p137dd40d454d0d502efb5d8c04701f70a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190923090614epcas5p215731e8359c634f7ed76759f68622e4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190923090614epcas5p215731e8359c634f7ed76759f68622e4f
References: <e0d7b7d7-3e89-8b3f-04ed-0b14806e66f7@web.de>
        <CGME20190923090614epcas5p215731e8359c634f7ed76759f68622e4f@epcas5p2.samsung.com>
        <59343c81-3dd8-023c-6440-d48c8d74e05e@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick, Markus.

On 23.09.2019 11:05, Yannick FERTRE wrote:
> Reviewed-by: Yannick Fertré <yannick.fertre@st.com> 
> Tested-by: Yannick Fertré <yannick.fertre@st.com> 


Yannick, next time could you put your tags after tags of the patch,
otherwise patchwork is confused and creates incorrect patches [1].

[1]: https://patchwork.freedesktop.org/patch/332360/


> Best regards
>
> -- 
> Yannick Fertré | TINA: 166 7152 | Tel: +33 244027152 | Mobile: +33
> 620600270
> Microcontrollers and Digital ICs Group | Microcontrolleurs Division
>
>
> On 9/21/19 8:20 PM, Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sat, 21 Sep 2019 20:04:08 +0200
>>
>> Simplify this function implementation by using a known wrapper function.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>


I meant here :)


Anyway, patch queued.


Regards

Andrzej



>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index 675442bfc1bd..6ada149af9ef 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -981,7 +981,6 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>>  	struct device *dev = &pdev->dev;
>>  	struct reset_control *apb_rst;
>>  	struct dw_mipi_dsi *dsi;
>> -	struct resource *res;
>>  	int ret;
>>
>>  	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
>> @@ -997,11 +996,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>>  	}
>>
>>  	if (!plat_data->base) {
>> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -		if (!res)
>> -			return ERR_PTR(-ENODEV);
>> -
>> -		dsi->base = devm_ioremap_resource(dev, res);
>> +		dsi->base = devm_platform_ioremap_resource(pdev, 0);
>>  		if (IS_ERR(dsi->base))
>>  			return ERR_PTR(-ENODEV);
>>
>> --
>> 2.23.0
>>
>

