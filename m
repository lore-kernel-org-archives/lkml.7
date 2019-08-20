Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C5C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5279622DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="djVCe4oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfHTNoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:44:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55620 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfHTNoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:44:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190820134409euoutp02dfa1b20a7721d2565d8cae027d5d11e1~8pWshoc9L1533215332euoutp02Z
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:44:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190820134409euoutp02dfa1b20a7721d2565d8cae027d5d11e1~8pWshoc9L1533215332euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566308650;
        bh=q9DQJtTXITuIpi60bahAci5B3lERTi6ynqpY7bxrP24=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=djVCe4oQY3nDLBvwrGShycyve/cp2B84UhbTwE9HoMewYb4/uDX3ibktbQcJUtFTu
         PoN6CMcFsT2K1xgk1kvT2wuCKQZcotj64wIpXJFbDFiYeCTOsgv+Qmu/4Ay4HE2tx0
         i1pGqZQZEyXOtbHJyMa9U5XFUL/g5ItJ5sMcrDzI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190820134409eucas1p17c23db625d397514956d770ea698b493~8pWr8AITF0632006320eucas1p1L;
        Tue, 20 Aug 2019 13:44:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 74.C5.04309.929FB5D5; Tue, 20
        Aug 2019 14:44:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190820134408eucas1p28765f1e244cccab2e61d69b2dafe8619~8pWrMQKgj1274512745eucas1p2i;
        Tue, 20 Aug 2019 13:44:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820134408eusmtrp1491f8a7d64278aff4e4456996714eb70~8pWq9-ppI2463724637eusmtrp1a;
        Tue, 20 Aug 2019 13:44:08 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-e6-5d5bf9295193
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.77.04166.829FB5D5; Tue, 20
        Aug 2019 14:44:08 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190820134407eusmtip19ae4ab7e475d7b38d06bc0809b45ee64~8pWqj9GJT2534125341eusmtip1q;
        Tue, 20 Aug 2019 13:44:07 +0000 (GMT)
Subject: Re: [PATCH 3/9] drivers: ata: ahci_tegra: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <b3ab1d66-177a-d342-fdcb-a23c14325ba2@samsung.com>
Date:   Tue, 20 Aug 2019 15:44:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1566304548-19972-3-git-send-email-info@metux.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHvTOzs6M1cl0NDyYGKwkGaUngks/AcI0+GPTBFK0pB5VcV3dc
        HwVhSflIWh+ZuEgZWpr5SkPXNURM3UwTRLJVirIkNVzc0CJDLccx8tvv/s/533P+l8uQikaZ
        B5OSlsnr0rhUJe1EdQ2vjR/2XYuLP7I2T6qefjDQqiVLFaGavt5LqO6uNxCqYdNnQjVprqFV
        RatGOlyunnyjV7+fekGrS+02Wr3c95ZWr3R4RctinYIT+dSULF7nH3rBKXl4yEqkV+GcOmsB
        nYea2WLkyAA+BuMlLUhkBW5E8GtQK/EqgmabdzFy2uIVBDPlY/JixGwb6n5ESXoDAoO9hpQO
        NgTmd/Wk6HbF52Cz7A8hshsOhC9zD2ViE4lrEHzf6KLEAo2PQ1lBExJvZXEo9M3mijKFD0Ld
        qyKZyPtwDHwcbt9mFrvASPXcttURh0G93b7NJHaHmbkHhMQHoNsmLQTYLAdLeSeSYkZAQdUK
        JbErfLM8l0vsCaMVJZRkaEWwUbiw4+5G0FCxSUtdQfDSMiETNyWxL7SZ/SX5BNS/7tl5Fmew
        2lykJZyhvKuKlGQWCm8ppG4faH/cTv8bW9zzhCxFSuOuaMZdcYy74hj/z61FVBNy5/WCJokX
        AtL4bD+B0wj6tCS/S1pNB9r6P6ObllUTMq9fHECYQcq9rGk6Ll4h47KEXM0AAoZUurE5NbHx
        CjaRy73C67TndfpUXhhA+xlK6c5edfgUp8BJXCZ/mefTed2/KsE4euSh0AB7dW/0b6u9ZELx
        7PYCNcM8qow40ybn2YSlGO3N/MEbkVFaeikjxKS95xWZKDQ4hJW2+o7Io5QLKt2Ud+CQ1lBh
        Pn2yUWhz1pvvB4dwenvC8jxEpxt+hhMttQunbPl3+g1F2eVBJs+zs0u+/dfCKysXxzK4xc6v
        PntKepWUkMwdPUTqBO4vYj9Q2TsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7oaP6NjDa6c57VYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZRw7
        eoOpYLpAxeIb7WwNjGt4uxg5OCQETCQWf/XsYuTiEBJYyiixbNIvdoi4jMTx9WVdjJxAprDE
        n2tdbBA1rxklth+6yQ6SEBaIlPg38T8TiC0iYC7x+MlCVpAiZoE5jBLfl89iheg4zijxckkD
        K0gVm4CVxMT2VYwgG3gF7CT2PawECbMIqEosPtEJViIqECFx5v0KFhCbV0BQ4uTMJ2A2p4C9
        xJIPH8BsZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU
        0uLc9NxiQ73ixNzi0rx0veT83E2MwIjbduzn5h2MlzYGH2IU4GBU4uHdcTM6Vog1say4MvcQ
        owQHs5IIb8WcqFgh3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgcmg7ySeENTQ3MLS0NzY3Nj
        Mwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYwycVld+ROPvxAxLXiurh7Z18Op1HpIxHTR
        8urwZcrdmxYyz4y5Pl1SX7Sq5Y1pv2v4EeHeN8efrM17ueXd8XeNk9v+V7wVMwzcd256VV3/
        IRaGm/r/r7IITWs2FlmiH17HNPV1CefPu1oOBiyhfXN4b0czT13au7nL7cKThzuW3dOwPDzX
        6bASS3FGoqEWc1FxIgDKCfCuzgIAAA==
X-CMS-MailID: 20190820134408eucas1p28765f1e244cccab2e61d69b2dafe8619
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820123600epcas1p2dd50661f5073defeeca49b86e94ff241
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820123600epcas1p2dd50661f5073defeeca49b86e94ff241
References: <1566304548-19972-1-git-send-email-info@metux.net>
        <CGME20190820123600epcas1p2dd50661f5073defeeca49b86e94ff241@epcas1p2.samsung.com>
        <1566304548-19972-3-git-send-email-info@metux.net>
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
>  drivers/ata/ahci_tegra.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index e3163da..3845c23 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -481,7 +481,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>  {
>  	struct ahci_host_priv *hpriv;
>  	struct tegra_ahci_priv *tegra;
> -	struct resource *res;
>  	int ret;
>  	unsigned int i;
>  
> @@ -498,19 +497,17 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>  	tegra->pdev = pdev;
>  	tegra->soc = of_device_get_match_data(&pdev->dev);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
> +	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(tegra->sata_regs))
>  		return PTR_ERR(tegra->sata_regs);
>  
>  	/*
>  	 * AUX registers is optional.
>  	 */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	if (res) {
> -		tegra->sata_aux_regs = devm_ioremap_resource(&pdev->dev, res);
> -		if (IS_ERR(tegra->sata_aux_regs))
> -			return PTR_ERR(tegra->sata_aux_regs);
> +	tegra->sata_aux_regs = devm_platform_ioremap_resource(pdev, 2);

This conversion is incorrect - despite the resource being optional
we will get error message from devm_[platform_]ioremap_resource()
(it always prints an error on !res condition).

> +	if (IS_ERR(tegra->sata_aux_regs)) {
> +		dev_info(&pdev->dev, "Cant get aux registers (optional)");

No need for this message.

> +		tegra->sata_aux_regs = NULL;
>  	}
>  
>  	tegra->sata_rst = devm_reset_control_get(&pdev->dev, "sata");
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
