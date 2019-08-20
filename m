Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E1EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C27A22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JsqA37Ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfHTNp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:45:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45894 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbfHTNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:45:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190820134522euoutp0175406455fad9d816a421ab9bc940a6dc~8pXwdcRs60707807078euoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:45:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190820134522euoutp0175406455fad9d816a421ab9bc940a6dc~8pXwdcRs60707807078euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566308722;
        bh=Pk0t1/6+CK9w0PIy98d4IlAgpvrtyWbn4svzsn0utJE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JsqA37UrHU+Xry8R3X03A4Fp1ZmH6hbFi+wUOlZjtBufyjD4tAOv7E3DRKxqg9Nne
         lIJuZ6ovu9j2y1hwBBArxbHD03uR1fQooE/HtFMyoAuB2sBl1jgxwVpXKz2jSsgOlU
         mBUgEy6pRDZXz62DAa+iRdVmCpgwP+lqAeHPYUjU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820134522eucas1p2bf60e6c13585a4ee06ec5b55659b027d~8pXv4J4a91959019590eucas1p2I;
        Tue, 20 Aug 2019 13:45:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 22.A0.04374.179FB5D5; Tue, 20
        Aug 2019 14:45:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190820134521eucas1p1eeac5c5a1657db92d8ae60268728d9a8~8pXvIsJBS1025910259eucas1p1c;
        Tue, 20 Aug 2019 13:45:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190820134521eusmtrp204d49c4a594f0d9447ef2b33ae36c0dd~8pXu6nQow0665206652eusmtrp2W;
        Tue, 20 Aug 2019 13:45:21 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-73-5d5bf971477b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.F8.04117.179FB5D5; Tue, 20
        Aug 2019 14:45:21 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190820134520eusmtip26bb6956c6ab6ba23de77c073840116a2~8pXuhYbHi1581215812eusmtip2L;
        Tue, 20 Aug 2019 13:45:20 +0000 (GMT)
Subject: Re: [PATCH 4/9] drivers: ata: ahci_xgene: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <00a33e10-b563-a7e1-4180-10386f803b75@samsung.com>
Date:   Tue, 20 Aug 2019 15:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1566304548-19972-4-git-send-email-info@metux.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7pFP6NjDS6dZbRYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZaz5OIm5YLtoxbSPrYwNjGcEuxg5OSQETCTWPdrDBmILCaxglDi7
        zKKLkQvI/sIosebAeSYI5zOjxPl9XxnhOj73sEIkljNK7Ox4AFX1llHi7Y0vzCBVwgKREn9W
        /GcCsUUEzCUeP1kI1sEsMIdR4uPfbSwgCTYBK4mJ7avAxvIK2El8+PgOrIFFQFVi1pz5YDWi
        AhES949tYIWoEZQ4OfMJWJxTwF7iXMcWdhCbWUBc4taT+UwQtrzE9rdzmEGWSQhsY5d4ffIc
        C8TdLhLb599lh7CFJV4d3wJly0j83zmfCaJhHaPE344XUN3bGSWWT/7HBlFlLXH4+EWgMziA
        VmhKrN+lDxF2lGhpXcYMEpYQ4JO48VYQ4gg+iUnbpkOFeSU62oQgqtUkNizbwAaztmvnSuYJ
        jEqzkLw2C8k7s5C8Mwth7wJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBSej0v+Nf
        dzDu+5N0iFGAg1GJhzfhenSsEGtiWXFl7iFGCQ5mJRHeijlRsUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5qxkeRAsJpCeWpGanphakFsFkmTg4pRoYG5Uc29Y+EGlZMu3a9tx77yz0rj39udxk
        wfPqXsG8Izy7q5qUNS5P6Nqa/L3cWbssN6ht5ceck54TjEtqGVwvsB2ecqBKyFzD0u1CCafR
        /u8bbyv2zXQqlZzu5XX4SOTje8ulynlVLySvuGEUk9XXX5m8YS7nmq5jZiL7V8X++q82c+/f
        fI8XSizFGYmGWsxFxYkAimeZ3z4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7qFP6NjDRb95bJYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZaz5
        OIm5YLtoxbSPrYwNjGcEuxg5OSQETCTWfe5h7WLk4hASWMooce7sK5YuRg6ghIzE8fVlEDXC
        En+udbFB1LxmlHi4s4sJJCEsECnxZ8V/MFtEwFzi8ZOFYIOYBeYwSnxfPgtq6nFGiZ5rNxlB
        qtgErCQmtq8Cs3kF7CQ+fHwH1s0ioCoxa858FhBbVCBC4sz7FSwQNYISJ2c+AbM5BewlznVs
        YQexmQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz
        03OLjfSKE3OLS/PS9ZLzczcxAqNu27GfW3Ywdr0LPsQowMGoxMO742Z0rBBrYllxZe4hRgkO
        ZiUR3oo5UbFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MCHkl8YamhuYWlobmxubGZhZK
        4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhgn9mZ+3jbX97XKo15dAbEzE9M9fvLWa3Heu5Cg
        OFft9MLMDeGOgYsevUmbX+sdfWtv+SMWbbOb7N160YIl2XGZ5z+vWOp4+15Fr5byn01+Ne2P
        Y4VePjp8PGLmyRe9H4w3R8Xm5P6METyj1P0hTpqtS5VJQpRfqpx1x1+BvLXdt44kHD1TnKTE
        UpyRaKjFXFScCABrM2tH0AIAAA==
X-CMS-MailID: 20190820134521eucas1p1eeac5c5a1657db92d8ae60268728d9a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820123600epcas1p41f9e4e891a48fbafefcb2c22b5da7155
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820123600epcas1p41f9e4e891a48fbafefcb2c22b5da7155
References: <1566304548-19972-1-git-send-email-info@metux.net>
        <CGME20190820123600epcas1p41f9e4e891a48fbafefcb2c22b5da7155@epcas1p4.samsung.com>
        <1566304548-19972-4-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/19 2:35 PM, Enrico Weigelt, metux IT consult wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/ata/ahci_xgene.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 16246c8..5391f5d 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -739,7 +739,6 @@ static int xgene_ahci_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct ahci_host_priv *hpriv;
>  	struct xgene_ahci_context *ctx;
> -	struct resource *res;
>  	const struct of_device_id *of_devid;
>  	enum xgene_ahci_version version = XGENE_AHCI_V1;
>  	const struct ata_port_info *ppi[] = { &xgene_ahci_v1_port_info,
> @@ -759,31 +758,25 @@ static int xgene_ahci_probe(struct platform_device *pdev)
>  	ctx->dev = dev;
>  
>  	/* Retrieve the IP core resource */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	ctx->csr_core = devm_ioremap_resource(dev, res);
> +	ctx->csr_core = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(ctx->csr_core))
>  		return PTR_ERR(ctx->csr_core);
>  
>  	/* Retrieve the IP diagnostic resource */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	ctx->csr_diag = devm_ioremap_resource(dev, res);
> +	ctx->csr_diag = devm_platform_ioremap_resource(pdev, 2);
>  	if (IS_ERR(ctx->csr_diag))
>  		return PTR_ERR(ctx->csr_diag);
>  
>  	/* Retrieve the IP AXI resource */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> -	ctx->csr_axi = devm_ioremap_resource(dev, res);
> +	ctx->csr_axi = devm_platform_ioremap_resource(pdev, 3);
>  	if (IS_ERR(ctx->csr_axi))
>  		return PTR_ERR(ctx->csr_axi);
>  
>  	/* Retrieve the optional IP mux resource */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
> -	if (res) {
> -		void __iomem *csr = devm_ioremap_resource(dev, res);
> -		if (IS_ERR(csr))
> -			return PTR_ERR(csr);
> -
> -		ctx->csr_mux = csr;
> +	ctx->csr_mux = csr = devm_platform_ioremap_resource(pdev, 4);

This conversion is incorrect - despite the resource being optional
we will get error message from devm_[platform_]ioremap_resource()
(it always prints an error on !res condition).

> +	if (IS_ERR(ctx->csr_mux)) {
> +		dev_info(&pdev->dev, "cant get ip mux resource (optional)");

No need for this message.

> +		ctx->csr_mux = NULL;
>  	}
>  
>  	of_devid = of_match_device(xgene_ahci_of_match, dev);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
