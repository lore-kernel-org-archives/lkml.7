Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF97C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AAE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tyuTrmlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfHTNbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:31:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40569 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbfHTNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:31:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190820133136euoutp01941330f91ee044e2839e0d3afcc6f9cb~8pLukQQeb3048830488euoutp01M
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:31:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190820133136euoutp01941330f91ee044e2839e0d3afcc6f9cb~8pLukQQeb3048830488euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566307896;
        bh=/M243j4OJT6eoQ8Z/Cqc29WkvI3Ya4CgdMgE4sAnkHQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tyuTrmlIDcA1Ky2w2YUYiQH+zlazOtFshh69gNZBNzaYc2eJ3n0UTvMbom6XmnRMS
         43ynRy57ZhMq7whJP4xGRFJA7Xf6+5fxwEIYXkTGFDa58A1sCk4MwjdHIucDsPPmaM
         VI9ydvkwYl1cNmNgBQb2Cgp8zdi8U+jSK0+Uavt8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820133135eucas1p23876cb7a542bc53f89fe806781bd786b~8pLty4QFm0761707617eucas1p2g;
        Tue, 20 Aug 2019 13:31:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5C.F0.04469.736FB5D5; Tue, 20
        Aug 2019 14:31:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190820133134eucas1p196767a0db3e3554cb4dc3be227ee5ed2~8pLs9eADE3070630706eucas1p1Q;
        Tue, 20 Aug 2019 13:31:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820133134eusmtrp1681ed982675d5340723d047e678919b4~8pLsvHUel1787317873eusmtrp1Y;
        Tue, 20 Aug 2019 13:31:34 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-01-5d5bf637a11c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3E.A5.04166.636FB5D5; Tue, 20
        Aug 2019 14:31:34 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190820133133eusmtip154dcafbf995a88828f79d7651beb0eba~8pLsXsReK1939119391eusmtip1V;
        Tue, 20 Aug 2019 13:31:33 +0000 (GMT)
Subject: Re: [PATCH 7/9] drivers: ata: sata_dwc_460ex: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <68b89d3d-9feb-1b62-5b17-cc97cb5bd225@samsung.com>
Date:   Tue, 20 Aug 2019 15:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1566304548-19972-7-git-send-email-info@metux.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7rm36JjDV6vZrdYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZfy+eJmpYBp3RcPfaUwNjMs5uxg5OSQETCT2Pj/O2sXIxSEksIJR
        4sTOzUwgCSGBL4wSs87IQCQ+M0r0/p7HDNPx8dNfRojEckaJ7RsOM0M4bxklpn/+C1YlLBAr
        sWnLFDYQW0TAXOLxk4VgO5gF5jBKfPy7jQUkwSZgJTGxfRUjiM0rYCfx9/IXsAYWAVWJ7Zsu
        gQ0SFYiQuH9sAytEjaDEyZlPgHo5ODgF7CWW7pQCCTMLiEvcejKfCcKWl9j+dg7YQRICu9gl
        dn7czQhxtovE5NlToV4Qlnh1fAs7hC0jcXpyDwtEwzpGib8dL6C6tzNKLJ/8jw2iylri8PGL
        rCCbmQU0Jdbv0ocIO0pMvNHDDBKWEOCTuPFWEOIIPolJ26ZDhXklOtqEIKrVJDYs28AGs7Zr
        50rmCYxKs5B8NgvJO7OQvDMLYe8CRpZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgSno
        9L/jn3Ywfr2UdIhRgINRiYd3x83oWCHWxLLiytxDjBIczEoivBVzomKFeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MHbveH6s+4HxkmlSeo9b3TsfPVD8
        ksqSNVHQd21f6lqOls1Xjhru2zSp5pSCiq14XnfLWYaItvMHt93uT+3wjzCbpLmtcPesk3np
        hlNZbrhutz/6Sjf0f85W56OXuz5eWOs6mcNSuZh9jQ770+ez33G0OCjWW2Y0lTfaZP1dtyms
        afObrLd+J5RYijMSDbWYi4oTATzV5uE9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7pm36JjDSZs5rFYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfy+
        eJmpYBp3RcPfaUwNjMs5uxg5OSQETCQ+fvrL2MXIxSEksJRR4njzN+YuRg6ghIzE8fVlEDXC
        En+udbGB2EICrxklWm+VgNjCArESm7ZMAYuLCJhLPH6ykBVkDrPAHEaJ78tnsUIMPc4ocarh
        PTNIFZuAlcTE9lWMIDavgJ3E38tfwLpZBFQltm+6BFYjKhAhceb9ChaIGkGJkzOfsIAcxClg
        L7F0pxRImFlAXeLPPIhyZgFxiVtP5jNB2PIS29/OYZ7AKDQLSfcsJC2zkLTMQtKygJFlFaNI
        amlxbnpusaFecWJucWleul5yfu4mRmDEbTv2c/MOxksbgw8xCnAwKvHw7rgZHSvEmlhWXJl7
        iFGCg1lJhLdiTlSsEG9KYmVValF+fFFpTmrxIUZToN8mMkuJJucDk0FeSbyhqaG5haWhubG5
        sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGyUu3yOif5DLeJtnGWu7nxN4/Y2IB6053
        z9QWgeQ1NheP8jTonvxzR649RGLyy1iGVwo2OXf3l678IBfxob2T035Hi/OMlvOKuw2q5SLv
        FCWYdD5eEXM2Y7a0baz0yZZTO46sOllc5l7dKlPQdfe4+qmrbFNWzm285fbiR8L2Rft+VIQ8
        23BQiaU4I9FQi7moOBEAddmfgc4CAAA=
X-CMS-MailID: 20190820133134eucas1p196767a0db3e3554cb4dc3be227ee5ed2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820123601epcas2p1494c1485f111056fe585668e3591d756
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820123601epcas2p1494c1485f111056fe585668e3591d756
References: <1566304548-19972-1-git-send-email-info@metux.net>
        <CGME20190820123601epcas2p1494c1485f111056fe585668e3591d756@epcas2p1.samsung.com>
        <1566304548-19972-7-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/19 2:35 PM, Enrico Weigelt, metux IT consult wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_dwc_460ex.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 9dcef6a..de248fa 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -237,7 +237,6 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  				 struct sata_dwc_device *hsdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	struct resource *res;
>  
>  	hsdev->dma = devm_kzalloc(&pdev->dev, sizeof(*hsdev->dma), GFP_KERNEL);
>  	if (!hsdev->dma)
> @@ -254,8 +253,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  	}
>  
>  	/* Get physical SATA DMA register base address */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	hsdev->dma->regs = devm_ioremap_resource(&pdev->dev, res);
> +	hsdev->dma->regs = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(hsdev->dma->regs))
>  		return PTR_ERR(hsdev->dma->regs);

