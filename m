Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7979D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VjuVMDMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfHTNgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:36:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52736 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbfHTNgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:36:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190820133639euoutp02e7d8ccb35446dd6040795f8a92e1fab4~8pQIjiS7u1105011050euoutp02e
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:36:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190820133639euoutp02e7d8ccb35446dd6040795f8a92e1fab4~8pQIjiS7u1105011050euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566308199;
        bh=D4upNy5Z/FI8rlnFYgHOUDS4ndyqbVNBQ89eAaMZD+4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VjuVMDMufblxA+qrNpMAqUCnLS0YJpmrPCmQvsOD79hShHUg4IsS6Mkedwl2N9Mo0
         ngNeeFKmx4w9xwk65ltnBA0wdRMjf7m3NMvCxK6AOy7xleP14IRI0w2wQvSqwivkzc
         MAg/Hm6UW4kVuJ8eC2Jr3R/F6/2HBahmC1sr/tdg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820133638eucas1p27a672e609f7e3fe3a3b55c892833fb5d~8pQIPIYOy0313803138eucas1p2I;
        Tue, 20 Aug 2019 13:36:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E3.6F.04374.667FB5D5; Tue, 20
        Aug 2019 14:36:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190820133637eucas1p13c8129a8dbc1987fd71cb93bbff0bce9~8pQHYbFDU0444104441eucas1p1Q;
        Tue, 20 Aug 2019 13:36:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820133637eusmtrp1d31805f2abdeb827060d053120dad483~8pQHKAdLR2051720517eusmtrp1E;
        Tue, 20 Aug 2019 13:36:37 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-e1-5d5bf766f7db
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AE.B7.04117.567FB5D5; Tue, 20
        Aug 2019 14:36:37 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190820133637eusmtip240264164b9de8a150dcdc08acf90588d~8pQG0N3kI1713817138eusmtip2O;
        Tue, 20 Aug 2019 13:36:37 +0000 (GMT)
Subject: Re: [PATCH 8/9] drivers: ata: sata_gemini: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f7a9d877-e437-e22e-f9f8-d8da62273aa5@samsung.com>
Date:   Tue, 20 Aug 2019 15:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1566304548-19972-8-git-send-email-info@metux.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87pp36NjDe51S1qsvtvPZvHm+HQm
        i5uNu5kspvxZzmRxbMcjJovLu+awWXR+mcXmwO5x+Wypx51re9g8Jnx4y+bxft9VNo/Pm+QC
        WKO4bFJSczLLUov07RK4Mr5sf8lY8I674t+x1SwNjDc4uxg5OSQETCTWrVjPDmILCaxglLj+
        UhfC/sIoceSHQxcjF5D9mVFi78s/zF2MHGANf5arQsSXM0q83H2SCcJ5yyhx4cMKZpBuYYEo
        iRMvN4JNFREwl3j8ZCErSBGzwBxGiY9/t7GAJNgErCQmtq9iBLF5BewkWhf8YQOxWQRUJaY8
        u8cKYosKREjcP7aBFaJGUOLkzCcsIFdwCthLzHhXDxJmFhCXuPVkPhOELS+x/e0cZpBdEgK7
        2CXOTX3KCHG1i8T5X4IQHwtLvDq+hR3ClpE4PbmHBaJ+HaPE344XUM3bGSWWT/7HBlFlLXH4
        +EVWkEHMApoS63fpQ4QdJfo/7WWBmM8nceOtIMQNfBKTtk2HBhavREebEES1msSGZRvYYNZ2
        7VzJPIFRaRaSx2Yh+WYWkm9mIexdwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzD5
        nP53/OsOxn1/kg4xCnAwKvHwJlyPjhViTSwrrsw9xCjBwawkwlsxJypWiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA+NksWV+lsy/4nZtY82QbpeadG7T
        mTXaaienCbHWzDzB/c9t7f+8VxPyz2wxS/FUDNn1uTnQ61ddLe/Cy1ybwm/Xx3q1T1otu0yp
        xrNtpvy0ha3uIo+/abzeduNv9JXpuY9Np2T9vp/QfOh2QmXsAV51tf8yS5od5m4NK7CSjrSd
        /Dtbv5VzYYcSS3FGoqEWc1FxIgAjnHmBOgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7qp36NjDXY8l7FYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXzZ
        /pKx4B13xb9jq1kaGG9wdjFycEgImEj8Wa7axcjFISSwlFHizqXjLBBxGYnj68u6GDmBTGGJ
        P9e62EBsIYHXjBK39yqC2MICURInXm5kB7FFBMwlHj9ZyAoyh1lgDqPE9+WzWCGGHmeUePm5
        hRWkik3ASmJi+ypGEJtXwE6idcEfsKksAqoSU57dA6sRFYiQOPN+BQtEjaDEyZlPwA7iFLCX
        mPGuHiTMLKAu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKzULSPQtJyywkLbOQtCxgZFnFKJJa
        WpybnltspFecmFtcmpeul5yfu4kRGG/bjv3csoOx613wIUYBDkYlHt4dN6NjhVgTy4orcw8x
        SnAwK4nwVsyJihXiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGAqyCuJNzQ1NLewNDQ3Njc2
        s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwHhuV1Bk+aylU0u06q1MeaemHF+2R/qfSf+W
        G7+SPzxM23G7bs4JdsUz79jqvuXsWNHs/LDg4IvF22XYVAxDsuJErWX26XvNUZXU2ZYkut1b
        9XLuRfuUpa1/rZ6ZXM+Sv86idqxlc1zfhusfvW6fuT0rek7no2XtGfWs3JPmVeu9WzB3ut6J
        mexKLMUZiYZazEXFiQBtlJWXzQIAAA==
X-CMS-MailID: 20190820133637eucas1p13c8129a8dbc1987fd71cb93bbff0bce9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820123601epcas1p19aecef8b133d389e392fdd12273ef3a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820123601epcas1p19aecef8b133d389e392fdd12273ef3a6
References: <1566304548-19972-1-git-send-email-info@metux.net>
        <CGME20190820123601epcas1p19aecef8b133d389e392fdd12273ef3a6@epcas1p1.samsung.com>
        <1566304548-19972-8-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/19 2:35 PM, Enrico Weigelt, metux IT consult wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.

It would also be worth to mention in the patch description that
on !res condition the driver will now return -EINVAL (instead of
-ENODEV) and print an error.

> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_gemini.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
> index f793564..55e2689 100644
> --- a/drivers/ata/sata_gemini.c
> +++ b/drivers/ata/sata_gemini.c
> @@ -318,7 +318,6 @@ static int gemini_sata_probe(struct platform_device *pdev)
>  	struct device_node *np = dev->of_node;
>  	struct sata_gemini *sg;
>  	struct regmap *map;
> -	struct resource *res;
>  	enum gemini_muxmode muxmode;
>  	u32 gmode;
>  	u32 gmask;
> @@ -329,11 +328,7 @@ static int gemini_sata_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	sg->dev = dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> -
> -	sg->base = devm_ioremap_resource(dev, res);
> +	sg->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(sg->base))
>  		return PTR_ERR(sg->base);
