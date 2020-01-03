Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F719C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CD921D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sOauRfmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgACMRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:17:40 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55883 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgACMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:17:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200103121738euoutp02c0b640b45e0363d15532ef46f11b4bb2~mX5998Ztk2245022450euoutp02X
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 12:17:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200103121738euoutp02c0b640b45e0363d15532ef46f11b4bb2~mX5998Ztk2245022450euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578053858;
        bh=Q1lRn94T6zTZLhrBzX48cbGpKnNMHdU8KieAj7Jk+ew=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sOauRfmTuRzsZFbd2ox8odeV4wnuL+3renns/xnN4SBV3q3f12PLMA0oXGq1ztA4+
         257GeEhW0+I7ojkz1fZE40OXcnnnGGZNTPveRwoCRKtaU6XMpykhE3sodZyzW99/R+
         1xBuJwHQD4W7Iaoeuzib3+gQmwH39PDhRO3ufN5w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200103121737eucas1p27bf40fa10897e88f6fd92f7d749c4188~mX59zOim22834428344eucas1p2u;
        Fri,  3 Jan 2020 12:17:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 27.B6.60679.1E03F0E5; Fri,  3
        Jan 2020 12:17:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200103121737eucas1p16776590bbf3fe4ce45392ea68188a066~mX59fdoxn3131231312eucas1p1w;
        Fri,  3 Jan 2020 12:17:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200103121737eusmtrp2091def0757d73fedfeb7167dedeab35b~mX59ezzIf2799927999eusmtrp2k;
        Fri,  3 Jan 2020 12:17:37 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-24-5e0f30e17036
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.24.08375.1E03F0E5; Fri,  3
        Jan 2020 12:17:37 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200103121737eusmtip29d965df973edc23b371f4ec0c8502a19~mX59D15SS0409104091eusmtip2E;
        Fri,  3 Jan 2020 12:17:37 +0000 (GMT)
Subject: Re: [PATCH -next] fbdev/sa1100fb: use
 devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     maarten.lankhorst@linux.intel.com, daniel.vetter@ffwll.ch,
        viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <de1f8697-3b8a-20f1-e3fe-73a889b0e68a@samsung.com>
Date:   Fri, 3 Jan 2020 13:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904115754.21612-1-yuehaibing@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7oPDfjjDCZ/MrBY+PAus8WVr+/Z
        LE70fWC1uLxrDpvFwo9bWSwer3jLbrHxq4fFna/PWRw4PPZ+W8Di0XLkLavH4j0vmTzuXNvD
        5jHvZKDH/e7jTB6fN8kFsEdx2aSk5mSWpRbp2yVwZZx5d5Gp4DRXxY6LK5gbGB9wdDFyckgI
        mEhsXdzF2sXIxSEksIJRYsWjRnYI5wujxJ/p31ggnM+MEs+3XGWGaek53wZVtZxRYu3G9VD9
        bxklXk/6zQpSJSyQJDH13AUwW0RATaLl1BZmkCJmgSuMEn1t29lBEmwCVhIT21cxgti8AnYS
        r5f8ZwGxWQRUJB4cPA9WIyoQIfHpwWFWiBpBiZMzn4DVcApYS6zd1gd2ErOAuMStJ/OZIGx5
        ie1v50CdeopdYv4RbgjbRaLh6DoWCFtY4tXxLewQtozE/50gvVxA9jpGib8dL5ghnO2MEssn
        /2ODqLKWuHPuF5DNAbRBU2L9Ln2IsKNEy8wWFpCwhACfxI23ghA38ElM2jadGSLMK9HRJgRR
        rSaxYdkGNpi1XTtXMk9gVJqF5LNZSL6ZheSbWQh7FzCyrGIUTy0tzk1PLTbKSy3XK07MLS7N
        S9dLzs/dxAhMUKf/Hf+yg3HXn6RDjAIcjEo8vAnK/HFCrIllxZW5hxglOJiVRHjLA3njhHhT
        EiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamC0utp+qfXfU8XS
        91xHg83OGs/bnH6mfeV5w47gbftl5T+Xeu0Qe3NOzOX+/UW7Xrw+GlrKfuNqfVx/4TXGoNLP
        /0IenAy5Li62sf3Hbp4nE2vurEhzTFVdwsyhskziVkOvire9m/eP56y/7x7MbN1jZKVwyeDu
        9PUatyYKsiuXVVXse1Jq/k9NiaU4I9FQi7moOBEAkQ4iyEwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7oPDfjjDFrmyVksfHiX2eLK1/ds
        Fif6PrBaXN41h81i4cetLBaPV7xlt9j41cPiztfnLA4cHnu/LWDxaDnyltVj8Z6XTB53ru1h
        85h3MtDjfvdxJo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
        bFJSczLLUov07RL0Ms68u8hUcJqrYsfFFcwNjA84uhg5OSQETCR6zrexdzFycQgJLGWU6Ovf
        zdrFyAGUkJE4vr4MokZY4s+1LjaImteMEtP+TGACSQgLJElMPXeBFcQWEVCTaDm1hRmkiFng
        CqPE0YmLmCA6+hgles8dYQGpYhOwkpjYvooRxOYVsJN4veQ/WJxFQEXiwcHz7CC2qECExOEd
        s6BqBCVOznwCVsMpYC2xdlsfM4jNLKAu8WfeJShbXOLWk/lMELa8xPa3c5gnMArNQtI+C0nL
        LCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7iREYkduO/dy8g/HSxuBDjAIcjEo8
        vAnK/HFCrIllxZW5hxglOJiVRHjLA3njhHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmCzy
        SuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwygTNPWsh9UKC/c/5
        OVK7Q/iV5WqnhYoUXIvMDI21WGweKnUiNfQmh6rQrJzegCgjd/YfVwXjtmz7JBD+8dT7xbIX
        mGV3Lt20TXmqk9gkg+jQ6zt9uCwOuE9Z0HYwsTzlyc5szmc2M32fyPSKXDr0YqaRb5Wt+pfI
        OV66DbJvTDaKan5Omv1PiaU4I9FQi7moOBEAjLafL94CAAA=
X-CMS-MailID: 20200103121737eucas1p16776590bbf3fe4ce45392ea68188a066
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190904120019epcas2p2d20e3e922d6a51ebd51c226440bc5df9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190904120019epcas2p2d20e3e922d6a51ebd51c226440bc5df9
References: <CGME20190904120019epcas2p2d20e3e922d6a51ebd51c226440bc5df9@epcas2p2.samsung.com>
        <20190904115754.21612-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/19 1:57 PM, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/sa1100fb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
> index ae2bcfe..4428cef 100644
> --- a/drivers/video/fbdev/sa1100fb.c
> +++ b/drivers/video/fbdev/sa1100fb.c
> @@ -1156,7 +1156,6 @@ static struct sa1100fb_info *sa1100fb_init_fbinfo(struct device *dev)
>  static int sa1100fb_probe(struct platform_device *pdev)
>  {
>  	struct sa1100fb_info *fbi;
> -	struct resource *res;
>  	int ret, irq;
>  
>  	if (!dev_get_platdata(&pdev->dev)) {
> @@ -1172,8 +1171,7 @@ static int sa1100fb_probe(struct platform_device *pdev)
>  	if (!fbi)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	fbi->base = devm_ioremap_resource(&pdev->dev, res);
> +	fbi->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(fbi->base))
>  		return PTR_ERR(fbi->base);
>  
