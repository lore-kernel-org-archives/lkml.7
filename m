Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EF6C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45A5214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z9/nz6nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfHTN2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:28:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49268 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfHTN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:28:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190820132759euoutp026f72a9271b931d968ec39811e21b6be9~8pIklF5yr0511905119euoutp027
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:27:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190820132759euoutp026f72a9271b931d968ec39811e21b6be9~8pIklF5yr0511905119euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566307679;
        bh=aNd+D6nVWwn40oSqwjXwHHw/g6OFI0Y2MyKCb3SCZ8A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Z9/nz6nV2V3A+ng4SfLSyjcyljds44kPfhFjn9nk4FT4DjI1iPuTn6artFvxsQrjZ
         sjDCdk/j3TuPCrLu2SbuJb9Z/G7Qxq2mP3ZMlXreBB1MorYO97g3nkxshSakQUifGI
         ZR+tTUzrHyLM8hNHzixKeKMwY/+S4UOLx00z3pb0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820132758eucas1p28bec048b38bd3cd07ec0c53fff6c8ffb~8pIj6bgML1855218552eucas1p2y;
        Tue, 20 Aug 2019 13:27:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AA.53.04309.E55FB5D5; Tue, 20
        Aug 2019 14:27:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190820132757eucas1p2bb69cd978b27b6dc90affffab975a30a~8pIi9-RG80831608316eucas1p2J;
        Tue, 20 Aug 2019 13:27:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190820132757eusmtrp24ac625c43ef0d08104fba7cdf64b44e4~8pIiv5yD32978629786eusmtrp2q;
        Tue, 20 Aug 2019 13:27:57 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-5b-5d5bf55ece1f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.25.04166.D55FB5D5; Tue, 20
        Aug 2019 14:27:57 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190820132756eusmtip27874d7937e0b487b32d9a8eed304bb07~8pIiTFHQU1313213132eusmtip2J;
        Tue, 20 Aug 2019 13:27:56 +0000 (GMT)
Subject: Re: [PATCH 1/9] drivers: ata: ahci_octeon: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6400d9a6-ebda-1a83-6000-fd1086a0b9f3@samsung.com>
Date:   Tue, 20 Aug 2019 15:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1566304548-19972-1-git-send-email-info@metux.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87pxX6NjDWZ9ErFYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZZxt+8Rc0MpZ0bP7AlsD43b2LkZODgkBE4n/mz4zdTFycQgJrGCU
        eHF1KjuE84VRYtanNqjMZ0aJN1d+scC0dC85wAqRWM4osXvmchYI5y2jxOUv7YxdjBwcwgJR
        EttWV4A0iAiYSzx+shCsgVlgDqPEx7/bwCaxCVhJTGxfxQhi8wrYSbz+co4JxGYRUJVY9+w5
        mC0qECFx/9gGVogaQYmTM5+A9XIK2Ev8a10LVsMsIC5x68l8KFteYvvbOcwgyyQEtrFL9Cxb
        CHW2i8S6l++YIWxhiVfHt0BDQEbi/875TBAN6xgl/na8gOreziixfPI/Nogqa4nDxy+ygrzG
        LKApsX6XPkTYUeLK23tsIGEJAT6JG28FIY7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7dq5k
        nsCoNAvJa7OQvDMLyTuzEPYuYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZiETv87
        /mUH464/SYcYBTgYlXh4d9yMjhViTSwrrsw9xCjBwawkwlsxJypWiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA+PC0g3VZ1xMFTbNbjVwPW90s0lRe7Xu
        BYard075XlDRYX63y3ZnpN7+g9UWSZGHjkqzxxp6HfjmXF/X/DStSDCgQd3G8r79esu3S3u0
        rsTtl2baWbVwrts7O7XqadeXzNjgPTGpzUwyfZKi9Isj2wL1fKPfZTkdadnVJfNqZmnU9nCG
        eVN7spVYijMSDbWYi4oTAYbLUJ0+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7qxX6NjDVa/FbNYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZZxt
        +8Rc0MpZ0bP7AlsD43b2LkZODgkBE4nuJQdYuxi5OIQEljJKnGo9x9bFyAGUkJE4vr4MokZY
        4s+1LjaImteMEvdWnmIHqREWiJLYtroCpEZEwFzi8ZOFYHOYBeYwSnxfPosVJCEkMIlR4uQ7
        axCbTcBKYmL7KkYQm1fATuL1l3NMIDaLgKrEumfPwWxRgQiJM+9XsEDUCEqcnPkEzOYUsJf4
        17oWrIZZQF3iz7xLzBC2uMStJ/Oh4vIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlx
        bnpusaFecWJucWleul5yfu4mRmDEbTv2c/MOxksbgw8xCnAwKvHw7rgZHSvEmlhWXJl7iFGC
        g1lJhLdiTlSsEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDk0FeSbyhqaG5haWhubG5sZmF
        kjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG84/lp34bORhcZ6zT3lrQddZqdsjLf/JP0g7V
        66n8LxFaYXyWVU4zQelOCN8+jrJjJ5evjWtMes3CvCLzrc68pSc0nnhrHoqNWL4j90LsJgNn
        zVi7wOqNe8tb7hSdzmEQasxVsMh4Vjh1uea5I2f/2OUFS6Zd327kOF3V5PyLGztvKgjfUq5R
        YinOSDTUYi4qTgQASSLXls4CAAA=
X-CMS-MailID: 20190820132757eucas1p2bb69cd978b27b6dc90affffab975a30a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820123558epcas1p1d3ad88d04bd6694ab47eb485bd269cc4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820123558epcas1p1d3ad88d04bd6694ab47eb485bd269cc4
References: <CGME20190820123558epcas1p1d3ad88d04bd6694ab47eb485bd269cc4@epcas1p1.samsung.com>
        <1566304548-19972-1-git-send-email-info@metux.net>
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
>  drivers/ata/ahci_octeon.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
> index 5a44e08..2280180 100644
> --- a/drivers/ata/ahci_octeon.c
> +++ b/drivers/ata/ahci_octeon.c
> @@ -32,13 +32,11 @@ static int ahci_octeon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = dev->of_node;
> -	struct resource *res;
>  	void __iomem *base;
>  	u64 cfg;
>  	int ret;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
