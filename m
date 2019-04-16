Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91797C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574F020854
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tDsZ1KoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfDPBpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:45:11 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:47738 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfDPBpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:45:10 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190416014505epoutp0257f126e4773eec84bfada5348a98e49b~V0Q5VupLX2521925219epoutp02C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:45:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190416014505epoutp0257f126e4773eec84bfada5348a98e49b~V0Q5VupLX2521925219epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555379105;
        bh=8EcbpDCs9xcL2YICnAwcP5pdE5fA//OburzmSKvtNx8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tDsZ1KoYb8QZHflt2frHqEwmRZoEyyzRoV30GYggfnfy/pLTxjnCII1SnPWla0uN5
         zxHfcIcKivWvXTrBTaOJwDdXXedp6huhlU24W4gbS+3PuaPcOetrN+m3LnFFIUBCfY
         rQ/CFyWNjqS+0DqYFgR6sS1YzBgYuX4lsMDhAGHo=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190416014502epcas1p4c9e0ba707e90ffbdf4bed9c2ae9a6279~V0Q2U5Ecy1138011380epcas1p4O;
        Tue, 16 Apr 2019 01:45:02 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.F4.04108.D9335BC5; Tue, 16 Apr 2019 10:45:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190416014500epcas1p18102d45555ff24edff5f402c39322c10~V0Q0sovmD0573705737epcas1p1H;
        Tue, 16 Apr 2019 01:45:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416014500epsmtrp2dc3b4b5c6d1c7a16975f709563fa4c74~V0Q0rizYa2418824188epsmtrp2b;
        Tue, 16 Apr 2019 01:45:00 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-0c-5cb5339d4158
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.7E.03692.C9335BC5; Tue, 16 Apr 2019 10:45:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416014500epsmtip15ee5dd9ddd37574e8c9c381797f50205~V0Q0ggANT3031930319epsmtip1_;
        Tue, 16 Apr 2019 01:45:00 +0000 (GMT)
Subject: Re: [PATCH v2 01/19] PM / devfreq: tegra: Fix kHz to Hz conversion
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a7cacb6c-1097-6d16-f6dc-7470f487c5b8@samsung.com>
Date:   Tue, 16 Apr 2019 10:45:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-2-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTURj2uLvjVZpdZ+rbirIbURnLXdf0KimaIwYFSf3JENbFXaa5r3Zn
        VP7RLEvRvgyqlRWlUVZUusUUzLLok8wyQZ3DvoiS1NLKCrS2XSP/Pe/7vM95znPOS0rkN7GC
        LLQ4eLuFM9E4grh1b3misk7tzlNN9S1hr3x9h9i9zvME+2zP5zC2u/U0Zsdr7iO28psTs96y
        S5j91XqGYA9ee4kzw3UeXz3StTh9Ybqa8hGsO+hqRLrxpgU50i1Fqwt4zsDb43lLvtVQaDGm
        0+s26bP1mmQVo2RS2RQ63sKZ+XRauz5HubbQ5L8QHb+DMxX7WzmcINCJGavt1mIHH19gFRzp
        NG8zmGyptpUCZxaKLcaV+VZzGqNSJWn8g1uLCtx91dj2KWZnXflvXIo8UVUonARqFVQ0VxFV
        KIKUUx4EZYd6Q8ViDMGT0W8SsfiBoHTUHfZP0nO4VioSbQh8J+umJaMI/lzqDU5FU+ug7Xk9
        DhBzqCkEY60npAFCQuXC97sNkgDGVAK0f+zFATybWgQ9P9+hAJZRGeDt8Qb7BLUEPj29GtTG
        UJth8MENqTgTBY9PvicCOJxKhkPHKrB4fhz0vz8bKuKFUO4+FcwA1B8Mb9zHkZhBC7UDH6bz
        RMPQQ9c0VsD4SBsWcQlcfnwfi+IDCFztXVKRUEN7Q63fgfQ7LIfrrYmiWSSMfK+WBtpAyeBA
        hVycXgzdr32hIp4LF/ZXTh+vgw9f9koPo0XOGXGcMyI4Z0Rw/jc7h4hGFMvbBLORFxibZuZ/
        N6HguiaketCDzvUdiCIRPUtGVrvy5FJuh7DL3IGAlNBzZFkGf0tm4Hbt5u1Wvb3YxAsdSON/
        7SMSRUy+1b/8Foee0SSp1Wp2FZOsYRg6TnY9MztPThk5B1/E8zbe/k8XSoYrStG57bc2yItC
        Numy1tKe4Y0vJ4dabnZuu6jNrR3V5w9snrVUZZws6ZrSXnFRDdEtA47EE1+iHhGK+sHcrBU1
        KWNt2n3NE53z1qStSKs8qoz2ren3/Vo2NlzyajJjSPUC25XzH00ULo3FeZJ7z5+kxIZkN2ae
        T7rzzHu729vQXt31NpImhAKOSZDYBe4vtbZwicQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO4c460xBgu/6Fqs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlbL3Zw1bwUrRibvMvtgbGHYJdjJwcEgImElcn
        TGbtYuTiEBLYzSjxrquNBSIhKTHt4lHmLkYOIFtY4vDhYoiat4wSz669BqsRFvCW2Ht+CRtI
        QkSgiUni88MWJpAEs0CkRP+jblYQW0hgK6NE3xw5EJtNQEti/4sbbCA2v4CixNUfjxlBbF4B
        O4nbV2+DxVkEVCVenl4D1isqECFx5v0KFogaQYmTM5+A2ZwCZhL9U9rYIHapS/yZd4kZwhaX
        uPVkPtQN8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0
        L10vOT93EyM4xrQ0dzBeXhJ/iFGAg1GJhzehb0uMEGtiWXFl7iFGCQ5mJRFexxSgEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYy+TZWb56zW+HHNgadX
        yXupfMOuyOcXC6+obbf5u/yLCf/pmcKOmfM73N7zzeCz87itL/69Vz5Rxv2T0rNN1eK6gccT
        suI8Pr3gzjp+x5yv4nfcUetgdiaXDqdAl4/nJj2VWf1s3wWfdaevLoi6lx2ho1n0g0O1yT5z
        pZfaca3POjGp/5TmFyqxFGckGmoxFxUnAgBvhi9ZrQIAAA==
X-CMS-MailID: 20190416014500epcas1p18102d45555ff24edff5f402c39322c10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145820epcas2p27ba84badad9cf5cf5b7853af7e908e43
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145820epcas2p27ba84badad9cf5cf5b7853af7e908e43@epcas2p2.samsung.com>
        <20190415145505.18397-2-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I add one minor comment (KHZ -> hz).

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> The kHz to Hz is incorrectly converted in a few places in the code,
> this results in a wrong frequency being calculated because devfreq core
> uses OPP frequencies that are given in Hz to clamp the rate, while
> tegra-devfreq gives to the core value in kHz and then it also expects to
> receive value in kHz from the core. In a result memory freq is always set
> to a value which is close to ULONG_MAX because of the bug. Hence the EMC
> frequency is always capped to the maximum and the driver doesn't do
> anything useful. This patch was tested on Tegra30 and Tegra124 SoC's, EMC
> frequency scaling works properly now.
> 
> Cc: <stable@vger.kernel.org> # 4.14+
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index c89ba7b834ff..02905978abe1 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -486,9 +486,9 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>  	struct dev_pm_opp *opp;
> -	unsigned long rate = *freq * KHZ;
> +	unsigned long rate;
>  
> -	opp = devfreq_recommended_opp(dev, &rate, flags);
> +	opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(opp)) {
>  		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);

Need to change it as following:
- KHz -> Hz


>  		return PTR_ERR(opp);
> @@ -499,8 +499,6 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	clk_set_min_rate(tegra->emc_clock, rate);
>  	clk_set_rate(tegra->emc_clock, 0);
>  
> -	*freq = rate;
> -
>  	return 0;
>  }
>  
> @@ -510,7 +508,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>  	struct tegra_devfreq_device *actmon_dev;
>  
> -	stat->current_frequency = tegra->cur_freq;
> +	stat->current_frequency = tegra->cur_freq * KHZ;
>  
>  	/* To be used by the tegra governor */
>  	stat->private_data = tegra;
> @@ -565,7 +563,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>  		target_freq = max(target_freq, dev->target_freq);
>  	}
>  
> -	*freq = target_freq;
> +	*freq = target_freq * KHZ;
>  
>  	return 0;
>  }
> 

It looks good to me if modify it in accordance with my comment.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Regards,
Chanwoo Choi



-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
