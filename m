Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFA8C742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78EE21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JJ0qoo9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfGLKpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:45:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38133 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfGLKpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:45:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190712104550euoutp014a9cb8b513e3fc57c1c2a071ae979e7c~wow23flGA3130931309euoutp01n
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:45:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190712104550euoutp014a9cb8b513e3fc57c1c2a071ae979e7c~wow23flGA3130931309euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562928350;
        bh=aCo4dkE6rEOyv2yvT87ApQTTuybWLW9vtX/jlJ54q9g=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=JJ0qoo9kiqYtf19WJN9IkLeKdaWCN9oavREgULfG8L1J1I+wdeJ0hqbA0YBCalS/5
         WHs50IrMt/rbgQrzjyUxZB6FcGB7VZOr9VmR98rp7PW2jaO/3qqlMLdJRteq0udbHM
         zgB2Ni3vJb8RqllMfu//5l0yfYJI0QntyhTfuD4Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190712104548eucas1p116308d1f3328809effaf08d7718ed583~wow1s_joc2269022690eucas1p1J;
        Fri, 12 Jul 2019 10:45:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 29.93.04377.CD4682D5; Fri, 12
        Jul 2019 11:45:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190712104547eucas1p145220086debe94a8605502a235450e4d~wow02UqiW2083120831eucas1p1G;
        Fri, 12 Jul 2019 10:45:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190712104547eusmtrp1bd1ba82f311f3346eb57a2dbed5f63e0~wow0oDhAS2846228462eusmtrp12;
        Fri, 12 Jul 2019 10:45:47 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-1b-5d2864dc2612
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.C4.04140.BD4682D5; Fri, 12
        Jul 2019 11:45:47 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190712104546eusmtip105110336ffc7dc8226bfe3c32e7d0337~wowz7tU-b2407824078eusmtip1L;
        Fri, 12 Jul 2019 10:45:46 +0000 (GMT)
Subject: Re: [PATCH 3/3] drm/bridge: sii902x: make audio mclk optional
To:     Olivier Moysan <olivier.moysan@st.com>, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        benjamin.gaignard@st.com, alexandre.torgue@st.com,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, jsarha@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <beef9917-1e8b-1ddb-740b-5b2ca8cd379c@samsung.com>
Date:   Fri, 12 Jul 2019 12:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1562082426-14876-4-git-send-email-olivier.moysan@st.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGe/eeczwuJ8dl+ZQf0SisIK3wxxuGfRBxog+iH0GF1SkPa+RH
        bVlZiFFpc2Z+YTYXaaBpy9BmaplGW9GSlWSlzig1nIjZ8IdmCpltnkX+u9/7ee6H64aXxcos
        ZgmrST4japOFRBUjpxpfT7Wv+ZKwMn7t795QktveJiOPXA5EbpS5aDLTWIBJ2at2mnz6OcqQ
        zl/DmLT96KRITraeJtkFFX7EMtBFk4/Ntxli6PIkKrs7ZMR24xApajExJLP1ld/mIL7mTg3i
        R52ZfnzrRDnFm/RGmreYsxn+Tf4HGd800U/zfTl2GV9fkcG/yC2ieOvzdfzgZCvm7c4mGT9m
        idgbeFC+MUFM1JwVtdFxR+UnCkvK8al7Yec7fvVRl9DoIgPyZ4GLgboH7xgDkrNKrhpBxYQD
        S49xBGbjE1p6jCEoLuxl/kVqO01IGlQhGH445dtyI6gdqZAZEMsu4LbD28ZwbyCY68JQ4ua9
        muFWwXR9z+whBRcHTr0VezXFrYAW5xTl1Qu5/TBVnu3bCYI2o2vW9/ecHB/pnvUxtxSuNJiw
        pEPgs6tM5mUA7j4LP6wfkES6DYbMIz7qBfDd/thP0mHgKLpOSToD+qqvYimsR9BQ9xRLg1h4
        ae+gvWWwh7q2OVqyt4D77SPKawMXCE53kMQQCIWNJViyFaDPUkrby6DvXYPvYAhUvv/po+Hh
        Vvcok4+Wlc5pWTqnWemcZqX/GcoRZUYhYqouSS3q1ieL56J0QpIuNVkddTwlyYI8v9Pxxz7+
        BDX/PmZDHItUAQrnhsh4JS2c1aUl2RCwWBWsMM94LEWCkHZB1KYc0aYmijobCmUpVYji4rz+
        Q0pOLZwRT4riKVH7bypj/ZdcQjGawxm21ysFLFxYcS1sYKe1ekzdEqCJykvpmewduDl0qyq+
        LDhvMryq0Lr52dfEkcg9GsO3x8un04vYO9WB+4lm/qJiuBtxX6CbrbvqHxTsWxiUtmswZ+n6
        gHb3jmddJ9vk0Qm711rUxkjX5cVqh/pAf1zsaWNTZIRpa2XPpnRGRelOCOtWY61O+AvWDzUk
        mQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42I5/e/4Xd3bKRqxBh/aFSx6z51kstj45DSj
        Rd/8J6wW/7dNZLaYf+Qcq8WVr+/ZLK5+f8lscfLNVRaL7s4OVovOiUvYLTY9vsZqcXnXHDaL
        rmtAHUuvX2SyONQXbTF5z2w2i9a9R9gdBD3WzFvD6PH+Riu7x95vC1g8ZnfMZPXYtKqTzePE
        hEtMHtu/PWD1uN99nMlj85J6jwO9k1k8Du4z9Hj6Yy+zx/Eb25k8Pm+SC+CL0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuYNH0Bc8EymYqL3++z
        NDC+F+ti5OSQEDCRWH91NmMXIxeHkMBSRok5W+4yQiTEJXbPf8sMYQtL/LnWxQZR9JpRYllv
        I3sXIweHsICbxJltsiBxEYFrzBK/dnaxQBRdZZT4suYCWDebgKbE38032UBsXgE7iRsdB8Hi
        LAKqEntu/GQBGSQqECZx9EQeRImgxMmZT1hAbE6g+V9eXwdrZRZQl/gz7xIzhC0v0bx1NpQt
        LnHryXymCYyCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEJoVt
        x35u2cHY9S74EKMAB6MSD+8NS/VYIdbEsuLK3EOMEhzMSiK8q/4DhXhTEiurUovy44tKc1KL
        DzGaAv02kVlKNDkfmLDySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFw
        SjUwMs9WytnMlb5UQ3G+zLZFjBdrTYs2Jv1LdJvrkmU15dkL26jEl9+9WPaxbnwVGb+cZbX6
        uxzmWhv+j8f0hBZf4Vq+i/fXL5ckmdbce8v+PplyNnC2jaPigQfb9useeK8n/sf4oEqJl5Dz
        nl/2MUlZjbo7n8jH57Lrza48OMd5WsLW8MgJn9IvKbEUZyQaajEXFScCAFW8Xj8gAwAA
X-CMS-MailID: 20190712104547eucas1p145220086debe94a8605502a235450e4d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190702154808epcas2p263688e1a3f29a656a86f5feda73aa6ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190702154808epcas2p263688e1a3f29a656a86f5feda73aa6ab
References: <1562082426-14876-1-git-send-email-olivier.moysan@st.com>
        <CGME20190702154808epcas2p263688e1a3f29a656a86f5feda73aa6ab@epcas2p2.samsung.com>
        <1562082426-14876-4-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.2019 17:47, Olivier Moysan wrote:
> The master clock on i2s bus is not mandatory,
> as sii902X internal PLL can be used instead.
> Make use of mclk optional.
>
> Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")
>
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 36acc256e67e..a08bd9fdc046 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -562,19 +562,21 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
>  		}
>  	}
>  
> -	ret = clk_prepare_enable(sii902x->audio.mclk);
> -	if (ret) {
> -		dev_err(dev, "Enabling mclk failed: %d\n", ret);
> -		return ret;
> -	}
> +	if (sii902x->audio.mclk) {
> +		ret = clk_prepare_enable(sii902x->audio.mclk);
> +		if (ret) {
> +			dev_err(dev, "Enabling mclk failed: %d\n", ret);
> +			return ret;
> +		}
>  
> -	mclk_rate = clk_get_rate(sii902x->audio.mclk);
> +		mclk_rate = clk_get_rate(sii902x->audio.mclk);
>  
> -	ret = sii902x_select_mclk_div(&i2s_config_reg, params->sample_rate,
> -				      mclk_rate);
> -	if (mclk_rate != ret * params->sample_rate)
> -		dev_dbg(dev, "Inaccurate reference clock (%ld/%d != %u)\n",
> -			mclk_rate, ret, params->sample_rate);
> +		ret = sii902x_select_mclk_div(&i2s_config_reg,
> +					      params->sample_rate, mclk_rate);
> +		if (mclk_rate != ret * params->sample_rate)
> +			dev_dbg(dev, "Inaccurate reference clock (%ld/%d != %u)\n",
> +				mclk_rate, ret, params->sample_rate);
> +	}
>  
>  	mutex_lock(&sii902x->mutex);
>  
> @@ -640,7 +642,8 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
>  	mutex_unlock(&sii902x->mutex);
>  
>  	if (ret) {
> -		clk_disable_unprepare(sii902x->audio.mclk);
> +		if (sii902x->audio.mclk)
> +			clk_disable_unprepare(sii902x->audio.mclk);


"if" clause is not necessary


>  		dev_err(dev, "%s: hdmi audio enable failed: %d\n", __func__,
>  			ret);
>  	}
> @@ -659,7 +662,8 @@ static void sii902x_audio_shutdown(struct device *dev, void *data)
>  
>  	mutex_unlock(&sii902x->mutex);
>  
> -	clk_disable_unprepare(sii902x->audio.mclk);
> +	if (sii902x->audio.mclk)

ditto

> +		clk_disable_unprepare(sii902x->audio.mclk);
>  }
>  
>  int sii902x_audio_digital_mute(struct device *dev, void *data, bool enable)
> @@ -752,9 +756,12 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
>  
>  	sii902x->audio.mclk = devm_clk_get(dev, "mclk");
>  	if (IS_ERR(sii902x->audio.mclk)) {
> -		dev_err(dev, "%s: No clock (audio mclk) found: %ld\n",
> -			__func__, PTR_ERR(sii902x->audio.mclk));
> -		return 0;
> +		if (PTR_ERR(sii902x->audio.mclk) != -ENOENT) {
> +			dev_err(dev, "%s: No clock (audio mclk) found: %ld\n",
> +				__func__, PTR_ERR(sii902x->audio.mclk));
> +			return PTR_ERR(sii902x->audio.mclk);
> +		}
> +		sii902x->audio.mclk = NULL;


devm_clk_get_optional should be used here.

Summarizing, clk framework supports NULL clocks so you can adjust code
to benefit from it: no need to checks "if (sii902x->audio.mclk)". The
only place you should care is near clk_get_rate, for null clock it will
return 0, so you should react appropriately.

With that changed:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>  	}
>  
>  	sii902x->audio.pdev = platform_device_register_data(


