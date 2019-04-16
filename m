Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66680C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A71320825
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OddEhTEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfDPB67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:58:59 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34267 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfDPB67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:58:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190416015856epoutp04866edd0f65c2fb65f447fc1f48c7a1c0~V0c_1pHuw3258632586epoutp04F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190416015856epoutp04866edd0f65c2fb65f447fc1f48c7a1c0~V0c_1pHuw3258632586epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555379936;
        bh=VQvSQKWxLd8Ze+bVhRt4W3U/ZQy9aMVzHYXaFnmD1h4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OddEhTEJUZwyTrQxNYz2xYPO2q5PNZYzLv9Tux0H/wPVkMwgqlDJJlEMHO/laLPR2
         QuMehQG7XRlg5/MgbbJY7vTolNNd2YQN3zLpZEGI+/DJP0sgXM7p/D1lwZWckFKQjS
         pERsqNV79XawW4IbsGu8VgHLsszGpoc2X8IHEzsE=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190416015852epcas1p18ed09be5fe5d64461585be324ecc6063~V0c7Wjg0d0443504435epcas1p1B;
        Tue, 16 Apr 2019 01:58:52 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.99.04142.CD635BC5; Tue, 16 Apr 2019 10:58:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190416015851epcas1p4254157074ae4f9dd24a90e8fb5cd7203~V0c6eiciB0159601596epcas1p4P;
        Tue, 16 Apr 2019 01:58:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190416015851epsmtrp128d88ae67e26a8dfe54b3bd8b7043f85~V0c6dw5gH0041900419epsmtrp1e;
        Tue, 16 Apr 2019 01:58:51 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-b6-5cb536dc7fe3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.3D.03662.BD635BC5; Tue, 16 Apr 2019 10:58:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190416015851epsmtip214362cf6bfd001fee0d7012c95fe92bd~V0c6Ro_O70439804398epsmtip2W;
        Tue, 16 Apr 2019 01:58:51 +0000 (GMT)
Subject: Re: [PATCH v2 04/19] PM / devfreq: tegra: Don't set EMC clock rate
 to maximum on probe
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
Message-ID: <9fa3c0c3-0ef4-2d86-b6a8-7bd0fbc131e6@samsung.com>
Date:   Tue, 16 Apr 2019 10:59:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-5-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvbSdTsXiWEWPPGgZt0BEOpSWkQBBIaRxSTA+uIQERzq2hG52
        WuMSFRUREQSCGBkXXBNBEYNVK0bQQlAeNFRDYtAGDRoR9youkagdBpW375zzn/ufc+/FJarL
        WBSeb3OxThtjIbHx0mvtMXFxT/VXczTVhdH0hU/9iC7iT0vp+7vfyulHLccw+nN5B6L3f+Ex
        +smu8xj9o+WElD7Y+BBLVxi8gbPIcIMPyA3le95jhoOeBmT43DwjW7a2IMXMMkbWqWZteXZj
        vs2USi5dmZuRq9NrqDhqIZ1Eqm2MlU0lM5dlx2XlW0IDkepNjMUdSmUzHEfGp6U47W4Xqzbb
        OVcqyTqMFsdCxwKOsXJum2lBnt2aTGk0CbqQcF2BubKiRubwKzZ7K+tQIfouL0UKHIhE+BEc
        CCtF43EV4UUw3BQcDYII+EvtmBh8RXC8v/xfS31js1ws3ELg770uFQoq4gOCw90xAk8mGLj5
        vBQJoinELwTBliMyoSAh1sDQnXMSgTEiFtoGHmMCTySioed7PxJYSaTB0CGRpcQc8PoGR/SR
        xGro67wsEzWToKv2xYixgtBDdfMAEs+fBr0v6sJEngl7rh6VCEMA8RODzq7h0RUy4fyRoFTk
        yTB41zOaj4LXFcWjvA3quzowsbkEgaetWyYWtNB2rjrkgIccYqCpJV40i4D3Q2UyIQ2EEkqK
        VaJ6Fjx6FggTeTqc2bcfE9kAwz0+WSWK5sesw49ZgR+zAv/f7CSSNqCprIOzmliOciSMfe5m
        NPJbY/VedPrBMh8icEROUOJlnhyVjNnEbbH6EOAScopykTGUUhqZLVtZpz3X6bawnA/pQrdd
        JYmKzLOH/r7NlUvpErRaLZ1I6XUURU5TNqVn5KgIE+NiC1jWwTr/9oXhiqhC1DqvwbTYMnvr
        tuTWM63bH9S2LzlWRNao527OomdfK3vl+bZ+/ctAyuHeQOyB5FPuIUtnOLl3Rat51cf48DX+
        DG/J4l/youVa47uZfPX1x8mN3VWV6p+3/R0RbZo3O+cPnlhdV5vpitzh7/v2O3D8ZV/iuI0b
        3D3r7hUleVz1FyOuzEonpZyZoWIlTo75A1cgm8/DAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvO5ts60xBkcfK1ms/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlTOifylpwkbNix4T5jA2MP9i7GDk5JARMJFau
        3QRkc3EICexmlFjy/RorREJSYtrFo8xdjBxAtrDE4cPFEDVvGSXOdO9hA4kLCyRKTJ2YBRIX
        EWhikvj8sIUJpJdZIFKi/1E3K0TDVkaJpxs6wRJsAloS+1/cYAOx+QUUJa7+eMwIYvMK2El8
        nQJhswioSuw49IoZxBYViJA4834FC0SNoMTJmU/AbE4BM4nJm14wQixTl/gz7xIzhC0ucevJ
        fKgj5CWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpe
        cn7uJkZwjGlp7WA8cSL+EKMAB6MSD29C35YYIdbEsuLK3EOMEhzMSiK8jilAId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYwLecI3npU7tZNNcYFlffFj
        xyU/Ju7deNlBZG5yeMwnfsO7N9K+F1ff4k3+ekVxEt/qaaelAh67hJt4yK+P99kqbynj9auM
        eWruCukovknh5b0iseKnonmq3l9Yu/L5P3+XyQWpPSLtqp77q7bPC7pduFCzNzWRXYlxpfLc
        TfM3Lv51U2VHdKYSS3FGoqEWc1FxIgCpKf6BrQIAAA==
X-CMS-MailID: 20190416015851epcas1p4254157074ae4f9dd24a90e8fb5cd7203
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145546epcas3p2dd7b6049da59458b165eb54e4cc8162d
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145546epcas3p2dd7b6049da59458b165eb54e4cc8162d@epcas3p2.samsung.com>
        <20190415145505.18397-5-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> There is no real benefit from doing so, hence let's drop that rate setting
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 69581c9082d4..d62fb1b0d9bb 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -648,8 +648,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return PTR_ERR(tegra->emc_clock);
>  	}
>  
> -	clk_set_rate(tegra->emc_clock, ULONG_MAX);
> -

It seems like that initialize the emc_clock as the supported maximum clock.
But, if the rate for emc_clock initialized by either bootloader or clock driver
and it's well working until this code, actually, it is not necessary.

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


>  	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
>  	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
>  	if (err) {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
