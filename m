Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C47C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A336214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OVrq1T1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfHTN3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:29:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39818 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfHTN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:29:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190820132952euoutp01788ac08fb7a9a10434002961cc3c39b4~8pKN3fvYs2844128441euoutp01y
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:29:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190820132952euoutp01788ac08fb7a9a10434002961cc3c39b4~8pKN3fvYs2844128441euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566307792;
        bh=gMGt+C48DObcEXPmCG2SfXow6Z687O1QjQd04+4kn28=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OVrq1T1IPgEwk+rqnujHo5hbO5gdmN5PXVWJ04j5lKV7WOhobM5aOLpn8vpj3LsRY
         aXfFvCYXXoad0YtN28e7kbml0IHVfG/SYrKviDmSpUMLxZWxhRADgZUstVKjc4QTks
         vpYlojfDKFHkizNvunjmmOwfgpPzFfn9kK6PPp2k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820132951eucas1p254cee4bbf91829d81bd9f1d50adbb46e~8pKNQZD711143211432eucas1p2K;
        Tue, 20 Aug 2019 13:29:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F6.5E.04374.FC5FB5D5; Tue, 20
        Aug 2019 14:29:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190820132950eucas1p1f2467a1a3329e4fffc05f94f34bdcf4e~8pKMYsNRG0564505645eucas1p1L;
        Tue, 20 Aug 2019 13:29:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820132950eusmtrp1f53f3e6bbca859d46a2dceb8dac58555~8pKMKYykj1664416644eusmtrp1R;
        Tue, 20 Aug 2019 13:29:50 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-c1-5d5bf5cf3003
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.65.04166.EC5FB5D5; Tue, 20
        Aug 2019 14:29:50 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190820132950eusmtip1ccf392877fc2d4d330c6c65c6b9886e1~8pKL1k-VV1622416224eusmtip1U;
        Tue, 20 Aug 2019 13:29:50 +0000 (GMT)
Subject: Re: [PATCH 5/9] drivers: ata: libahci_platform: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, linus.walleij@linaro.org,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ed75f2c9-c49e-8fb4-a17f-686a76580f01@samsung.com>
Date:   Tue, 20 Aug 2019 15:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1566304548-19972-5-git-send-email-info@metux.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87rnv0bHGtxbJ2ux+m4/m8Wb49OZ
        LG427maymPJnOZPFsR2PmCwu75rDZtH5ZRabA7vH5bOlHneu7WHzmPDhLZvH+31X2Tw+b5IL
        YI3isklJzcksSy3St0vgymg+vZu54CJHxfZ7pxkbGGexdzFyckgImEisn7qDrYuRi0NIYAWj
        RF/XeVYI5wujxK4lLUwQzmdGiYc3drLCtLy8954dIrGcUWJP22RmCOcto8SDZYdYQKqEBeIl
        Li65zwhiiwiES/QfACni5GAWqJG4eOAe2CQ2ASuJie2rwGp4Bewkph5+DHYUi4CqxNL398Hq
        RQUiJO4f28AKUSMocXLmE7D5nAL2Ej/ntDFBzBSXuPVkPpQtL7H97RxmiEvXsUu8+WUNYbtI
        dM5/xQZhC0u8Or4FGgAyEqcn97CAPABUzyjxt+MFM4SznVFi+eR/UB3WEoePXwS6ggNog6bE
        +l36EGFHidMLQEHBAWTzSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZ
        SD6bheSbWUi+mYWwdwEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAFHT63/GvOxj3
        /Uk6xCjAwajEw5twPTpWiDWxrLgy9xCjBAezkghvxZyoWCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2M/i9azRa7bG1YGGgl8enhpazuLUoHVjX16AYE
        FdfUdG7bWWxj1fh+3b2PErwrW863HU9wXnXlDNcknZCpCubc1y6fYU4JnO/K7ftdvHGGylSu
        LZeZ1C/vP1tjf//zrrDqRVJy69aIOs20sWfjnBl35mr+8c6p1rNs/71PzFH5Mltr5XYu6To3
        JZbijERDLeai4kQA00z5qD0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7rnvkbHGjScU7RYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZTSf
        3s1ccJGjYvu904wNjLPYuxg5OSQETCRe3nsPZHNxCAksZZT41vuQrYuRAyghI3F8fRlEjbDE
        n2tdbBA1rxklJty/xAKSEBaIl7i45D4jiC0iEC7Rt+YRG4jNLFAjcfxfB1TDcUaJ1k2vWEES
        bAJWEhPbV4E18ArYSUw9/BjsChYBVYml7+8zg9iiAhESZ96vYIGoEZQ4OfMJmM0pYC/xc04b
        E8QCdYk/8y4xQ9jiEreezIeKy0tsfzuHeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnF
        hnrFibnFpXnpesn5uZsYgTG37djPzTsYL20MPsQowMGoxMO742Z0rBBrYllxZe4hRgkOZiUR
        3oo5UbFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MB3kl8YamhuYWlobmxubGZhZK4rwd
        AgdjhATSE0tSs1NTC1KLYPqYODilGhhL3ltknyg6yBvwiqtq3jqRFx+7ZDnWCXZckVsvo3Iv
        Zus2Ds47QRYKe79wRWU2CM56ltk3y+y4wq6Y8NCj86LDPkSc9eTeqtqTlxS0NsrX4nD9iWns
        uQluFh0v2To6MnJkffo+tRvvsrC9wLBb3srxTLeqoLRMTeGBM7qpc24fdTz99MSPpUosxRmJ
        hlrMRcWJAG/AnPPPAgAA
X-CMS-MailID: 20190820132950eucas1p1f2467a1a3329e4fffc05f94f34bdcf4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820123559epcas2p34bca6e3589759dc2ffe4ad7f194615a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820123559epcas2p34bca6e3589759dc2ffe4ad7f194615a5
References: <1566304548-19972-1-git-send-email-info@metux.net>
        <CGME20190820123559epcas2p34bca6e3589759dc2ffe4ad7f194615a5@epcas2p3.samsung.com>
        <1566304548-19972-5-git-send-email-info@metux.net>
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
>  drivers/ata/libahci_platform.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 9e9583a..3d84be8 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -408,8 +408,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  
>  	devres_add(dev, hpriv);
>  
> -	hpriv->mmio = devm_ioremap_resource(dev,
> -			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +	hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(hpriv->mmio)) {
>  		rc = PTR_ERR(hpriv->mmio);
>  		goto err_out;
