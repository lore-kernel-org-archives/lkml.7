Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2134C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5780A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i7b7uX5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfDPH3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:29:34 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11684 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfDPH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:29:33 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190416072930epoutp02054b682965fe78251cc1c8908076a906~V49nKpXMt2076520765epoutp02g
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:29:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190416072930epoutp02054b682965fe78251cc1c8908076a906~V49nKpXMt2076520765epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555399770;
        bh=rZd7iJLvzMqLfKW+NTEQTfGdsOY73ccAHFh/yrike5g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=i7b7uX5vZPoOkTYeHsRO+HrnPK7friV7i4k4fwgHL0zQbErn0GdE0sj1U0+w0deVm
         eBY4Q5nVxMk0LP+PGNAwRbo1jtMIeAIDhUAyayK1xg9f2hG1+X8Zac63UB/gledz0C
         +KWWDKx5JdSpQfCh+69690rGWQOtN2QU/fPbz2CU=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190416072926epcas1p33846b75961f27381400ad0f6f1a9bbfa~V49i21bVR0636006360epcas1p3T;
        Tue, 16 Apr 2019 07:29:26 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.8C.04108.05485BC5; Tue, 16 Apr 2019 16:29:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190416072919epcas1p1b8ac12e3d699ed1b9f7ce9715a0251f1~V49c6U1KM2095620956epcas1p1R;
        Tue, 16 Apr 2019 07:29:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190416072919epsmtrp17326f03be3765043005d24e3c5ee8fef~V49c5nJ1R1836518365epsmtrp15;
        Tue, 16 Apr 2019 07:29:19 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-81-5cb5845009b1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.4F.03662.F4485BC5; Tue, 16 Apr 2019 16:29:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416072919epsmtip1f2bc297026df8e4424c494e3aec41edc~V49cpnKg92485524855epsmtip1M;
        Tue, 16 Apr 2019 07:29:19 +0000 (GMT)
Subject: Re: [PATCH v2 14/19] PM / devfreq: tegra: Move governor
 registration to driver's probe
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
Message-ID: <cb398910-1137-dc6a-2609-0ac0ba580a6e@samsung.com>
Date:   Tue, 16 Apr 2019 16:30:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-15-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN6zIMhuJYQa5otA76QbXYoVQHA4hiTFU+mvjhEhKc0BcgXe0U
        3H5UiLIvGrdR2ZSAKCIGFasEQQNBI1GJxiVFEzERdwsuVWJsOxj5O/eec3Puee+SUmU7EU3m
        2lzYaeMsNDFNdvV2bJzGWHglQ1tzUcGe//oasYVCg4y9v/9DCDvkPkWwY+V3EFs8LhDsi33N
        BOtz18jYitZHRGqoodNzFhmuC54QQ3nBJ8JQ0dGCDGOX5xnlW81JOZgzYacK27LsplxbdjK9
        YWNmWqZ+mZbRMInsclpl46w4mV6TbtSszbX4F6JV+Zwlz98ycjxPL01JctrzXFiVY+ddyTR2
        mCyOREccz1n5PFt2XJbduoLRauP1fuE2c85QVYnEcWP2zrc/vWgv+h5RgkJJoBKgrLJAXoKm
        kUqqE4HH1ysVCy+CmxeqQsTiO4J+oVjyb+TecJVEJLoQtE58JMTiM4KWY4PSgGomxcH4yydB
        IoL6g8DrPi4PEFJqC3zraQyKCEoN3W+fEgE8nVoAj3++RgGsoFLg691DQb2MWgRNJc+C+khq
        M7zsuyQXNTNg4MSILIBDqeUwMC4aS6koeD5SKxHxfCi4cjIYCKjfBAinywkxwxq4tu/YZJ6Z
        8K6/I0TE0TBaeWAS74FzA3cIcbgIQUf3A7lI6KC78bB/mPQ7xEKbe6loFg6fvpXJA22gFFB0
        QCmqY2DolWfSajacOVg8uYIBThTeklehBcKUOMKUCMKUCMJ/szoka0GzsIO3ZmOecein/vdl
        FDxXdWIn6htM70UUiegwBVnWkaGUc/n8LmsvAlJKRyhWmfwthYnbtRs77ZnOPAvme5He/9rV
        0ujILLv/+G2uTEYfr9Pp2ARmmZ5h6ChFW2pahpLK5lzYjLEDO//NScjQ6L3I7NnU+hy7a3aa
        fU2S+op7vypVDZLBqKOR89WjnSnbJhp84Tu81/Hpm7vVhuqVN7pqm13ak6Vco/H9+5SzEw+/
        tB+55N0+J2bEe1hz160vKo15U/hjuGx0Yemq9WGLy7uGfUv+rIu3zNXUu+vaS+v7mdVPhbDp
        b2Kv6Xr6lrjSDj6jZXwOx6ilTp77C6yiOj3EAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnK5/y9YYg8cTdC1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyLk/oYirYLVnx4scnxgbGbyJdjJwcEgImEqfv
        TWDqYuTiEBLYzSjxcv5/RoiEpMS0i0eZuxg5gGxhicOHiyFq3jJK3D//ixWkRlggUWLOuWXM
        IAkRgSYmic8PW5hAEswCkRL9j7pZITq2MUrsPD8TbCqbgJbE/hc32EBsfgFFias/HoPFeQXs
        JD6emgQ2lUVAVWJ5101mEFtUIELizPsVLBA1ghInZz4BszkFzCVOfjnHDLFMXeLPvEtQtrjE
        rSfzoY6Ql2jeOpt5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV5
        6XrJ+bmbGMFRpqW1g/HEifhDjAIcjEo8vAl9W2KEWBPLiitzDzFKcDArifA6pgCFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MDqH8MfxBuQYz3BccyL/
        0ZPT/yfyrOh/PfXb0QxdT6bZzzNTmlrityRMeOgt5hfVwcgqf3fJ2+gvgQUTtni3psyuE5qa
        c87qoPpZ/Qc1Jq/Zn09yd/Use3wqpOPzk7htbC5pvHObcl23LktNcVr586iz9tMfTuxxjg+W
        cT/56XGk+VdxypUT25VYijMSDbWYi4oTAZNrsuyuAgAA
X-CMS-MailID: 20190416072919epcas1p1b8ac12e3d699ed1b9f7ce9715a0251f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145727epcas1p4c97da1fb3e264bca828e982ef43c3fdf
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145727epcas1p4c97da1fb3e264bca828e982ef43c3fdf@epcas1p4.samsung.com>
        <20190415145505.18397-15-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
> There is no need to register the ACTMON's governor separately from
> the driver, hence let's move the registration into the driver's probe
> function for consistency and to make code cleaner a tad.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 44 +++++++++------------------------
>  1 file changed, 12 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 832e4f5aa11b..46c61af8ca33 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -673,6 +673,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> +	err = devfreq_add_governor(&tegra_devfreq_governor);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
> +		goto remove_opps;
> +	}
> +
>  	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
>  	tegra->devfreq = devfreq_add_device(&pdev->dev,
>  					    &tegra_devfreq_profile,
> @@ -680,7 +686,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  					    NULL);
>  	if (IS_ERR(tegra->devfreq)) {
>  		err = PTR_ERR(tegra->devfreq);
> -		goto remove_opps;
> +		goto remove_governor;
>  	}
>  
>  	err = request_threaded_irq(irq, NULL, actmon_thread_isr, IRQF_ONESHOT,
> @@ -706,6 +712,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  remove_devfreq:
>  	devfreq_remove_device(tegra->devfreq);
>  
> +remove_governor:
> +	devfreq_remove_governor(&tegra_devfreq_governor);
> +
>  remove_opps:
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
> @@ -729,7 +738,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>  	reset_control_reset(tegra->reset);
>  	clk_disable_unprepare(tegra->clock);
>  
> -	return 0;
> +	return devfreq_remove_governor(&tegra_devfreq_governor);
>  }
>  
>  static const struct of_device_id tegra_devfreq_of_match[] = {
> @@ -747,36 +756,7 @@ static struct platform_driver tegra_devfreq_driver = {
>  		.of_match_table = tegra_devfreq_of_match,
>  	},
>  };
> -
> -static int __init tegra_devfreq_init(void)
> -{
> -	int ret = 0;
> -
> -	ret = devfreq_add_governor(&tegra_devfreq_governor);
> -	if (ret) {
> -		pr_err("%s: failed to add governor: %d\n", __func__, ret);
> -		return ret;
> -	}
> -
> -	ret = platform_driver_register(&tegra_devfreq_driver);
> -	if (ret)
> -		devfreq_remove_governor(&tegra_devfreq_governor);
> -
> -	return ret;
> -}
> -module_init(tegra_devfreq_init)
> -
> -static void __exit tegra_devfreq_exit(void)
> -{
> -	int ret = 0;
> -
> -	platform_driver_unregister(&tegra_devfreq_driver);
> -
> -	ret = devfreq_remove_governor(&tegra_devfreq_governor);
> -	if (ret)
> -		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
> -}
> -module_exit(tegra_devfreq_exit)
> +module_platform_driver(tegra_devfreq_driver);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Tegra devfreq driver");
> 

Looks good to me.
Reviewed-by : Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
