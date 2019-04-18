Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C2C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EC72184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="As2lUXyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbfDRAWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:22:37 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:40308 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDRAWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:22:37 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190418002234epoutp028a58b33e74fa1f4f90ca94f83c24b2fe~Waba2S63S1673116731epoutp02z
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:22:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190418002234epoutp028a58b33e74fa1f4f90ca94f83c24b2fe~Waba2S63S1673116731epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555546954;
        bh=NGLJ+aV2bOTFi6xaKsG7ghyd0yJPzqJwhphSeJit3tw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=As2lUXyIYHe1OPapmMKPBkJlmaCUToBThe0U2KpJVS7o76j05sCiyRhB1Ris9hd/J
         1inswDVf0aF0FsDgun9nIErWqCzZioyTIL/aglhUIrAmGwCUORq/UnG9QxgQluDbFT
         UXXgEYQipSKI/BUHkBkHA7/ZDjtx+3V1AEJ/tfrM=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190418002232epcas1p26f60e939ad3fb9520337e34f47f8afdd~WabYR-iOD0957309573epcas1p2n;
        Thu, 18 Apr 2019 00:22:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.76.04143.643C7BC5; Thu, 18 Apr 2019 09:22:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190418002229epcas1p4917a83fa2f26467275615a4815584523~WabWE7aDN1994519945epcas1p47;
        Thu, 18 Apr 2019 00:22:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190418002229epsmtrp2aa31a29c219b438f3c793dce31ee5e38~WabWEJvnh1515115151epsmtrp2K;
        Thu, 18 Apr 2019 00:22:29 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-4a-5cb7c3464464
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.42.03692.543C7BC5; Thu, 18 Apr 2019 09:22:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190418002229epsmtip2daa2a42a3ac729cd4fb7a6d419b89695~WabV0kHz90762307623epsmtip2S;
        Thu, 18 Apr 2019 00:22:29 +0000 (GMT)
Subject: Re: [PATCH v3 04/16] PM / devfreq: tegra: Don't ignore clk errors
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
Message-ID: <8aa843d3-f1db-2309-8684-2d3a6f576a35@samsung.com>
Date:   Thu, 18 Apr 2019 09:23:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417222925.5815-5-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRD1a7fLVl1d6jU0RmGVGDBol7KwGiCe2ChGEqPxqMEN3dCGXtkt
        xCMmaj0Ab/0hFEHjERVQDFQFohLBKqKoETVGQUw8gwgCQjSebRcj/97Mm3nzZr6PUGou4lrC
        YncJop230vhw7EpDlC4mpeGqUZdXEcaV9bxB3A7PSYxr3t4ZwrXUHsO5vn23EJf31YNzL7ed
        w7nvtSUYt//CY3yO2lDddhoZajxtIYZ97i7csN9bigx9lZPSVGuyEs0CbxLEcMGe4TBZ7JlJ
        9JLl6fPT2XgdE8PM4hLocDtvE5LoBalpMSkWq98QHZ7DW7P9qTRekuiZyYmiI9slhJsdkiuJ
        Fpwmq3OWc4bE26Rse+aMDIdtNqPTxbL+wvVZ5icfGnBnI7nh7J4O1VbkHpGPCAKoOLhwkc1H
        wwkNVY1gZ1EnJge9CJ79OqOUgwEELb4beD5SBzuaasqRTFxH8KekZjDoRlD8uVwRqBpDLYaC
        nx1BYiz1G0FvbYEqQCip1dB/M6CrJnAqGuo+Pg/KjqYi4Om3NyhgiqSS4eHNTYE0RkVC07VX
        WACPo1ZB++1LQRmSCoW7hW+DeTXFQv3eYkyWnwAv3h5XyHgyuC8XKWXX7hA4W8DKeAH43E2D
        +THQcccbImMt9HVdH9xyM5y/ewsP+AcqF4G37pFKJvRQd+aIIuBTSUVBRe1MedYo6Orfq5Jv
        SkLuLo1cPQVaXrcpZBwGp3bnDcob4F1vI34QRXiGbOMZsoFnyAae/8NOIKwUjRecki1TkBin
        fuhjV6LgX41OqEaXHqTWI4pA9EjyXORVo0bF50gbbfUICCU9lpxr8ho1pInfuEkQHelitlWQ
        6hHrP/YhpXZchsP/8+2udIaN1ev1XBwTzzIMPYGsmDPfqKEyeZeQJQhOQfzXpyDU2q3IEdmc
        /HRaXuKPrualVUd9awfmdRjKFza/LOyf937d10VFaU33zKFhDSllfeyzlboV3WHLVDd+b1+c
        qyC1H4cdzpq65UrjXNH3yTjdvFwQrSOYA5vXxtZpLE+KW+Oqel5H+fhfu1IGyPc90vclp7xf
        WnZPHLC25rT7LPcVWCr/k6iiMcnMM9FKUeL/AliVHW/BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvK7r4e0xBkfuyVqs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlXHl+mK3gBG/F8u5XrA2MzdxdjJwcEgImEqd2
        rmHsYuTiEBLYzSjRvuEEC0RCUmLaxaPMXYwcQLawxOHDxRA1bxklviw6xQ5SIyzgJTHjzyuw
        ZhGBJiaJzw9bmEASzAKREv2PulkhOjYzSnx9PoMVJMEmoCWx/8UNNhCbX0BR4uqPx4wgG3gF
        7CTOH6wCCbMIqEqc2nMP7AhRgQiJM+9XgNm8AoISJ2c+AbM5BUwlDvXMZYHYpS7xZ94lZghb
        XOLWk/lQN8hLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi
        0rx0veT83E2M4BjT0tzBeHlJ/CFGAQ5GJR7eFarbY4RYE8uKK3MPMUpwMCuJ8DqmbIkR4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzvs071ikkEB6YklqdmpqQWoRTJaJg1OqgXHJ228emf2ykWJL
        +3iLWpnK9c4aT/1vVCFgPOuVHVNhtmaoC3e44vPghJmyihxrRK5kCz4x+3rvRephHQvOv+Ez
        N7yacfrKAvZfVuaPg3xOagjx3+kwj/35/PLHc1JcB+ZxPDm6RGv65ksKE3z01Y2f6troRiY4
        ma+d9izO0XTbrqt9ttf/KSqxFGckGmoxFxUnAgDttblPrQIAAA==
X-CMS-MailID: 20190418002229epcas1p4917a83fa2f26467275615a4815584523
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417224039epcas5p2562b745e90f4f8fdc788c69f8eb12b5a
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224039epcas5p2562b745e90f4f8fdc788c69f8eb12b5a@epcas5p2.samsung.com>
        <20190417222925.5815-5-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> The clk_set_min_rate() could fail and in this case clk_set_rate() sets
> rate to 0, which may drop EMC rate to minimum and make machine very
> difficult to use.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 7d7b9a5895b2..c7428c5eee23 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -484,8 +484,10 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  				u32 flags)
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
> +	struct devfreq *devfreq = tegra->devfreq;
>  	struct dev_pm_opp *opp;
>  	unsigned long rate;
> +	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(opp)) {
> @@ -495,10 +497,20 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	rate = dev_pm_opp_get_freq(opp);
>  	dev_pm_opp_put(opp);
>  
> -	clk_set_min_rate(tegra->emc_clock, rate);
> -	clk_set_rate(tegra->emc_clock, 0);
> +	err = clk_set_min_rate(tegra->emc_clock, rate);
> +	if (err)
> +		return err;
> +
> +	err = clk_set_rate(tegra->emc_clock, 0);
> +	if (err)
> +		goto restore_min_rate;
>  
>  	return 0;
> +
> +restore_min_rate:
> +	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
> +
> +	return err;
>  }
>  
>  static int tegra_devfreq_get_dev_status(struct device *dev,
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
