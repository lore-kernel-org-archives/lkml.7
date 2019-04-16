Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0069C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919C12075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E25+R5M/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfDPGVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:21:15 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:56647 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfDPGVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:21:15 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190416062110epoutp01e723c255ec728cf2e61cfa7ad923b290~V4B8H3Pt60711707117epoutp01H
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 06:21:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190416062110epoutp01e723c255ec728cf2e61cfa7ad923b290~V4B8H3Pt60711707117epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555395670;
        bh=jsNBWYHup/330jXLGYWSEvkr2b+uu++8WjKVzNJlzqg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E25+R5M/03gf8lBrfsCmSktG2fLW6iyMuiymcQDGdgnf9WXLpotVIfe1ism1SyOEs
         EFNiEw1OVG5VojB0FR5zqN5qxBnHx76amqLAWH4Igdmxq95zvLZ+5BnvKuyKWHTvDK
         +EKHx2pd8BbA7JuWfwjIdgkQVRxkdFg+pXZGW0NM=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190416062107epcas1p1adbdd6e234c85d2b1b1eed1a49c177b1~V4B5oa2Zi1286312863epcas1p1_;
        Tue, 16 Apr 2019 06:21:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.58.04143.F4475BC5; Tue, 16 Apr 2019 15:21:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190416062102epcas1p1eb56dbad6e36a8c3c1c60a950782a2d8~V4B1EZftW3158831588epcas1p1y;
        Tue, 16 Apr 2019 06:21:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416062102epsmtrp247ed810780b959df0f97d3e24c105f3f~V4B1DriLt2153421534epsmtrp2V;
        Tue, 16 Apr 2019 06:21:02 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-6c-5cb5744f6f1d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.FA.03662.E4475BC5; Tue, 16 Apr 2019 15:21:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190416062102epsmtip2b010d660499c4759a311075aede0c380~V4B006whm3017130171epsmtip2A;
        Tue, 16 Apr 2019 06:21:02 +0000 (GMT)
Subject: Re: [PATCH v2 11/19] PM / devfreq: tegra: De-initialize properly on
 driver's probe error
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
Message-ID: <c6699e78-cb5d-6b9f-aa36-034d65e26dc4@samsung.com>
Date:   Tue, 16 Apr 2019 15:21:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-12-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+2131ymurkvzJFF6o0hj5nWbXkvDHsRIIaEIC2vd3GWKe7U7
        NbOgMkpF7R02TSNL0jLFVqlR5qNSW1aGJamVmiAlhvmg/uix2zXyv88553uev59ULL+J+0mT
        TTbWamIMJO6B3W0JDFZssd1JCBl460XfGB9C9DH7FYx+fnTUjX7dUIzTE/mtiM6ZtON075Hr
        OP2joQSjC6q68Gh3TV3/VaSpt/e7afKzxnBNgaMSaSZqF8dJdqZEJrGMjrX6s6ZEsy7ZpI8i
        Y7ZqN2jVYSGUgoqgw0l/E2Nko8iNsXGKTckG10CkfxpjSHW54hiOI1etjbSaU22sf5KZs0WR
        rEVnsERYgjnGyKWa9MGJZuNqKiQkVO0S7klJqridhyzOxftPlrS4HUYvIBdJpUCooKPZmIs8
        pHKiDsHAuTJcML4hmLxULhGMaQS/i85I/mUMdy7KRe4u/wMElaPLBf6KoCk3g+f5RCLUPLyH
        8bnexC8E3xoKJXxATOyAqaZrYp5xIggaR3pwnucRAdD9fQjxLCPWQrmz9a8fI5ZBd2GRiGcf
        Ih4+PKmRCBovaL/4CePZnQiH91m3REJ9X3j3qXSGl0DWnSIxPwQQv3EYOTqKhAU2wo9fKl4D
        xHz4/NThJrAfTIw9wAXOhIr2VlzIzUbgaHwpEQJKaLx2VsTXEROBUN2wSug1F8am8mbuI4Ps
        43JBvRRef+wXCbwQyk7kzJTXwJdTb/BTKMA+axv7rA3sszaw/292GWGVaAFr4Yx6lqMsytlP
        XYv+/tSg8DpU0xnbjAgpIj1lewocCXIJk8ZlGJsRSMWkt2ydzuWS6ZiMA6zVrLWmGliuGald
        xz4t9vNJNLv+vcmmpdShSqWSVlFhaooifWXV0RsS5ISesbEpLGthrf/yRFJ3v8Oo5Nk2Rabn
        mirHsdPlpuLovvMxezOyvca7enf3f9ENpt9dMeJxSNVSfHDlrjZK27OutN5aoFgzh90dq68o
        U0X+fDx4/Mm+0IpHdfmVivTpV+evRNBZeeurp5yZznp8xY0OT5lhc3f8fuzFkvtd02GTP8eT
        c2r70pzxFza1tRd5bB8+SGJcEkMFia0c8wevCQPjvwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvK5fydYYg4u/5SxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyVm7uYSw4I1fRP+8wewPjeYkuRg4OCQETiafn
        ZLoYuTiEBHYzSjz/uJu9i5ETKC4pMe3iUWaIGmGJw4eLQcJCAm8ZJX6fqwOxhQWSJTbs284C
        0isi0MQk8flhCxNIglkgUqL/UTcrxNBtjBJfzq9kAUmwCWhJ7H9xgw3E5hdQlLj64zEjiM0r
        YCex7MwRsDiLgKrE1RmzwQaJCkRInHm/ggWiRlDi5MwnYDangLnEveZ1UMvUJf7Mu8QMYYtL
        3HoyHyouL9G8dTbzBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz
        0vWS83M3MYIjTEtrB+OJE/GHGAU4GJV4eBP6tsQIsSaWFVfmHmKU4GBWEuF1TAEK8aYkVlal
        FuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYNTk8E10XZXjn1GSPNEq
        d2t+16+DIU959h0RUGl/pBaUwrw7SJ9ti2USX574W8dXVjP+vz4369zsksMK7iv3VngGhKds
        1DmzpemU9VSPujWJ+7YeyJyz7VHj7kwXmcNBB2/k/5/TPsOM85OUHEtPsf4p44uxmhYHb25+
        furO1/WnSzSat1gaVSqxFGckGmoxFxUnAgDd/kpBrAIAAA==
X-CMS-MailID: 20190416062102epcas1p1eb56dbad6e36a8c3c1c60a950782a2d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145736epcas1p280496bf4128eda3d8efa9db2584fb213
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145736epcas1p280496bf4128eda3d8efa9db2584fb213@epcas1p2.samsung.com>
        <20190415145505.18397-12-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I already replied against patch6 about the exception handling
of tegra_devfreq_probe(). This patchset split out the patch
related to error handling for probe(). I think that you can
squash the patches regarding of exception handling for probe()
to one patch instead of split out the multiple patches.

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> Reset hardware, disable ACTMON clock, release OPP's and free IRQ before
> removing devfreq device since there is no guarantee that interrupt
> handling won't run after masking interrupt in hardware.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 53 ++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 69b557df5084..a668e4fbc874 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -663,28 +663,28 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> -		return irq;
> +		err = irq;
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> +		goto remove_opps;
>  	}
>  
>  	platform_set_drvdata(pdev, tegra);
>  
>  	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> -	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
> -						 &tegra_devfreq_profile,
> -						 "tegra_actmon",
> -						 NULL);
> +	tegra->devfreq = devfreq_add_device(&pdev->dev,
> +					    &tegra_devfreq_profile,
> +					    "tegra_actmon",
> +					    NULL);
>  	if (IS_ERR(tegra->devfreq)) {
>  		err = PTR_ERR(tegra->devfreq);
> -		return err;
> +		goto remove_opps;
>  	}
>  
> -	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -					actmon_thread_isr, IRQF_ONESHOT,
> -					"tegra-devfreq", tegra);
> +	err = request_threaded_irq(irq, NULL, actmon_thread_isr, IRQF_ONESHOT,
> +				   "tegra-devfreq", tegra);
>  	if (err) {
>  		dev_err(&pdev->dev, "Interrupt request failed\n");
> -		goto remove_opps;
> +		goto remove_devfreq;
>  	}
>  
>  	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
> @@ -692,14 +692,23 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"Failed to register rate change notifier\n");
> -		goto remove_opps;
> +		goto disable_interrupt;
>  	}
>  
>  	return 0;
>  
> +disable_interrupt:
> +	free_irq(irq, tegra);
> +
> +remove_devfreq:
> +	devfreq_remove_device(tegra->devfreq);
> +
>  remove_opps:
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
> +	reset_control_reset(tegra->reset);
> +	clk_disable_unprepare(tegra->clock);
> +
>  	return err;
>  }
>  
> @@ -707,24 +716,14 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>  {
>  	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
>  	int irq = platform_get_irq(pdev, 0);
> -	u32 val;
> -	unsigned int i;
> -
> -	devm_devfreq_remove_device(&pdev->dev, tegra->devfreq);
> -	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> -
> -	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
> -		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
> -		val &= ~ACTMON_DEV_CTRL_ENB;
> -		device_writel(&tegra->devices[i], val, ACTMON_DEV_CTRL);
> -	}
> -
> -	actmon_write_barrier(tegra);
> -
> -	devm_free_irq(&pdev->dev, irq, tegra);
>  
>  	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
> +	free_irq(irq, tegra);
> +
> +	devfreq_remove_device(tegra->devfreq);
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
> +	reset_control_reset(tegra->reset);
>  	clk_disable_unprepare(tegra->clock);
>  
>  	return 0;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
