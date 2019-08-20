Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B66C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF9E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q2rBP5xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfHTNhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:37:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53069 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbfHTNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:37:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190820133732euoutp023fbd57109e3d0473ce18283a8e1712cb~8pQ6qnFYq1087610876euoutp02V
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:37:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190820133732euoutp023fbd57109e3d0473ce18283a8e1712cb~8pQ6qnFYq1087610876euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566308252;
        bh=fIltFgh4FQqaKPpC/8SMMnCWDHSp/imJMC2mFE6UnRE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=q2rBP5xlkMRG6Kv9DCNAhQKuUJbcxCsAOMn5f2OkfkmNB3AEIQVTlB75/rkZqXrOJ
         3swwhSBe1X46AK1dAHreoXNtsCPQEC8FHPjFeAu9JAh+l6Yk1BA80mF3CjcWM49TBr
         ZUujKKXl0N+8vAl2HoIjD8kvqNlSQgmtTFTtCid0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190820133732eucas1p1e923ec6e6554ec5fb8803482d8ecf6fd~8pQ6AjYOr0458904589eucas1p1s;
        Tue, 20 Aug 2019 13:37:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E0.8F.04374.B97FB5D5; Tue, 20
        Aug 2019 14:37:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190820133731eucas1p14e17abcc932ef835969279f0da26e85f~8pQ5Sjtt90458904589eucas1p1p;
        Tue, 20 Aug 2019 13:37:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190820133731eusmtrp2e353196d1282be97bd4af3a7ba873ca4~8pQ5EdD2G0279302793eusmtrp2E;
        Tue, 20 Aug 2019 13:37:31 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-8e-5d5bf79b21e6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D5.86.04166.B97FB5D5; Tue, 20
        Aug 2019 14:37:31 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190820133730eusmtip27b2e76797df773d6eefa4494436fd121~8pQ4wCEKI1825618256eusmtip2X;
        Tue, 20 Aug 2019 13:37:30 +0000 (GMT)
Subject: Re: [PATCH 9/9] drivers: ata: sata_rcar: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3e9340d8-bfd2-5b9b-7454-d41697e9d25f@samsung.com>
Date:   Tue, 20 Aug 2019 15:37:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1566304548-19972-9-git-send-email-info@metux.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87qzv0fHGnw6ZWqx+m4/m8Wb49OZ
        LG427maymPJnOZPFsR2PmCwu75rDZtH5ZRabA7vH5bOlHneu7WHzmPDhLZvH+31X2Tw+b5IL
        YI3isklJzcksSy3St0vgyrh5ZTtzwUSuindvNzA1MC7h6GLk4JAQMJF49MG9i5GLQ0hgBaNE
        V9dRNpC4kMAXRol1rhDxz4wSfy9/ZYKpf3chDSK+nFFi04UNTBDOW0aJy7O/MHYxcnIIC0RI
        PLiyFMwWETCXePxkIStIEbPAHEaJj3+3sYAk2ASsJCa2rwIr4hWwk+hfdpkdZAOLgKrElSne
        IGFRoDn3j21ghSgRlDg58wlYK6eAvcSEfevB4swC4hK3nsxngrDlJba/ncMMsktCYBu7xPUz
        x8CKJARcJPreT2OHsIUlXh3fAmXLSPzfOZ8JomEd0JsdL6C6tzNKLJ/8jw2iylri8PGLrCDX
        MQtoSqzfpQ8RdpS49fwDOyRY+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5
        AqPSLCSvzULyziwk78xC2LuAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYPI5/e/4
        1x2M+/4kHWIU4GBU4uFNuB4dK8SaWFZcmXuIUYKDWUmEt2JOVKwQb0piZVVqUX58UWlOavEh
        RmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGRrF9JxZsuveCd9mHwyvfdnTr/JUykn+y
        M22T1uTj5puLteLak7rnuO5I+sEzeVJ/v99Ebx7OQ69rTA2KL5aovd/wsZl/3Qprvp02GktE
        T/n+mNhwYs5bpUl6RQJWJrZ2VvJ3Xs13O7TN7JBn3i+zb7qVgf4dgcllti6b58Qb/juosdhz
        m2mWjhJLcUaioRZzUXEiACB+jYQ6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7qzv0fHGhx5y2qx+m4/m8Wb49OZ
        LG427maymPJnOZPFsR2PmCwu75rDZtH5ZRabA7vH5bOlHneu7WHzmPDhLZvH+31X2Tw+b5IL
        YI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7h5
        ZTtzwUSuindvNzA1MC7h6GLk4JAQMJF4dyGti5GLQ0hgKaPE2tN9LBBxGYnj68u6GDmBTGGJ
        P9e62CBqXjNKTDn8gREkISwQIfHgylIwW0TAXOLxk4WsIEXMAnMYJb4vn8UKkhASOM4osXuq
        IYjNJmAlMbF9FVgDr4CdRP+yy+wgy1gEVCWuTPEGCYsCzTzzfgULRImgxMmZT8BsTgF7iQn7
        1oONZBZQl/gz7xIzhC0ucevJfCYIW15i+9s5zBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3O
        Tc8tNtQrTswtLs1L10vOz93ECIy3bcd+bt7BeGlj8CFGAQ5GJR7eHTejY4VYE8uKK3MPMUpw
        MCuJ8FbMiYoV4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR5HxgKsgriTc0NTS3sDQ0NzY3NrNQ
        EuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cA4+/P7U+9FM4oWRYimrcyutFZg2b30UExIbecp
        xvVPHu3M/DG9ZbPX5h/3c74vWhD7bqrHx42afzniU6VXGdxo4j8w92nvUss7NVd38r728DDf
        nPqw/lfbN86fr25/2hxrrt12w/vF6iCN0BVnkqb/aWLrSvFQelPC0B0w2/ZGxoTkH9luLMxy
        SizFGYmGWsxFxYkAAeGTos0CAAA=
X-CMS-MailID: 20190820133731eucas1p14e17abcc932ef835969279f0da26e85f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820123601epcas1p157f0a0c3a8d0a5b4d1e4bf497221bc08
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820123601epcas1p157f0a0c3a8d0a5b4d1e4bf497221bc08
References: <1566304548-19972-1-git-send-email-info@metux.net>
        <CGME20190820123601epcas1p157f0a0c3a8d0a5b4d1e4bf497221bc08@epcas1p1.samsung.com>
        <1566304548-19972-9-git-send-email-info@metux.net>
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
>  drivers/ata/sata_rcar.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 3495e17..14ea1d6 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -886,7 +886,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct ata_host *host;
>  	struct sata_rcar_priv *priv;
> -	struct resource *mem;
>  	int irq;
>  	int ret = 0;
>  
> @@ -915,8 +914,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
>  
>  	host->private_data = priv;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base = devm_ioremap_resource(dev, mem);
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base)) {
>  		ret = PTR_ERR(priv->base);
>  		goto err_pm_put;
