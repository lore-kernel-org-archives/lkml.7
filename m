Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED41C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E288214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p6ac7oz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfHTNa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:30:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40254 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbfHTNaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:30:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190820133054euoutp018280d9e1910973d8fa260f65d99db7da~8pLHTOHbm3067330673euoutp01U
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:30:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190820133054euoutp018280d9e1910973d8fa260f65d99db7da~8pLHTOHbm3067330673euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566307854;
        bh=/t3KxMf7noDEJ6n4BDpGewDuBYttiUk64Q/ztb5Vlss=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=p6ac7oz/PIE3i1OX6J96nBEazMXIoF8LcXxoHD98StlHUn7w5+HnuDcSVSFPCirik
         V3Th0fE7i6XMtAWiwRt/AyoOAb0bl+phS1+t6meDsUwqKuqenOazNKPGwlvLEKrJPg
         dA5QzGsgfI7r0T8uYvVbLBqFx4DuhSub3Vv3SBMk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820133053eucas1p2fbe1e38aec821f5a0d5113f97c9d9a4a~8pLGsAqAm1903519035eucas1p2K;
        Tue, 20 Aug 2019 13:30:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 64.E0.04469.D06FB5D5; Tue, 20
        Aug 2019 14:30:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190820133052eucas1p293f12e7cdf66e5ee1194c154fdeadaf4~8pLFzl7ky1143611436eucas1p2W;
        Tue, 20 Aug 2019 13:30:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190820133052eusmtrp26fabca1de536980742356d327d5e5694~8pLFlYc9g3182731827eusmtrp2N;
        Tue, 20 Aug 2019 13:30:52 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-81-5d5bf60db5da
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.F6.04117.C06FB5D5; Tue, 20
        Aug 2019 14:30:52 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190820133051eusmtip15186b92b2b17df57a7de78e95964fa07~8pLFRckRA1776217762eusmtip14;
        Tue, 20 Aug 2019 13:30:51 +0000 (GMT)
Subject: Re: [PATCH 6/9] drivers: ata: pata_bk3710: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d567bae7-b952-7dcd-976c-13d833c7d0a8@samsung.com>
Date:   Tue, 20 Aug 2019 15:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1566304548-19972-6-git-send-email-info@metux.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87q836JjDdbu47JYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZcw83cNY0MFT8fPpZ9YGxsecXYycHBICJhK/J+xk72Lk4hASWMEo
        8bZjFiuE84VR4s+mZVDOZ0aJm11TmWFaWtetYYRILGeUuNZ8D6r/LaPEur97WECqhAWiJB7t
        +s4IYosImEs8frIQbBSzwBxGiY9/t4EVsQlYSUxsXwVWxCtgJ7Hp+2pWEJtFQFXiTNccNhBb
        VCBC4v6xDawQNYISJ2c+AevlFLCXaPm3A8xmFhCXuPVkPhOELS+x/e0cZpBlEgLb2CXmn57H
        BnG3i8Sk51OYIGxhiVfHt7BD2DIS/3eCNIM0rGOU+NvxAqp7O6PE8sn/oLqtJQ4fvwh0BgfQ
        Ck2J9bv0IcKOEtMbFzGBhCUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5
        AqPSLCSvzULyziwk78xC2LuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYBo6/e/4
        px2MXy8lHWIU4GBU4uHdcTM6Vog1say4MvcQowQHs5IIb8WcqFgh3pTEyqrUovz4otKc1OJD
        jNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjNnreKf/v8u74PPBWSIrS1NWphffZTm9
        0fhHBvfjqttJKaLODPbSyvziBV+PpG7QCFp0MfC+fepGbrkD3wOuJ80VeDWf7Q+v0oWQ6VtP
        zo676buJx3x23Oysyb9XPRGZOOd3TWOn3TJpFsUmsewtH4zufzIIOnOqXPdym4+ExNw+v8z5
        IkusDJVYijMSDbWYi4oTAeFz3kI/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xu7o836JjDVau4rVYfbefzeLN8elM
        FjcbdzNZTPmznMni2I5HTBaXd81hs+j8MovNgd3j8tlSjzvX9rB5TPjwls3j/b6rbB6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZcw8
        3cNY0MFT8fPpZ9YGxsecXYycHBICJhKt69YwdjFycQgJLGWUePXoPJDDAZSQkTi+vgyiRlji
        z7UuNoia14wS77/uYgRJCAtESTza9R3MFhEwl3j8ZCErSBGzwBxGie/LZ7FCdBxnlFh4cAM7
        SBWbgJXExPZVYB28AnYSm76vZgWxWQRUJc50zWEDsUUFIiTOvF/BAlEjKHFy5hMwm1PAXqLl
        3w4wm1lAXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4
        Nz232EivODG3uDQvXS85P3cTIzDqth37uWUHY9e74EOMAhyMSjy8O25GxwqxJpYVV+YeYpTg
        YFYS4a2YExUrxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAhJBXEm9oamhuYWlobmxubGah
        JM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHRiLUm/J3S1u9t9XM+StXdZt22Q41L/mSdSYnr
        kxMRlxKPuZUsz/3Zw7oy4+WaP+UabN0cO558ffaTSfQj1+Q6+33OL2587RbpVrq2hbViqUpB
        /O/XQSZnrJ+tSpukKCFvs+9vxEuBZ0fWdi969VWVmy/t49z2n26Oi0XWzJx11fvCignSFRXp
        SizFGYmGWsxFxYkAna+Tv9ACAAA=
X-CMS-MailID: 20190820133052eucas1p293f12e7cdf66e5ee1194c154fdeadaf4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820123559epcas2p1be29e0bcaef4f4b1042b6177f387d7e2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820123559epcas2p1be29e0bcaef4f4b1042b6177f387d7e2
References: <1566304548-19972-1-git-send-email-info@metux.net>
        <CGME20190820123559epcas2p1be29e0bcaef4f4b1042b6177f387d7e2@epcas2p1.samsung.com>
        <1566304548-19972-6-git-send-email-info@metux.net>
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
>  drivers/ata/pata_bk3710.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
> index fad95cf..92b036d 100644
> --- a/drivers/ata/pata_bk3710.c
> +++ b/drivers/ata/pata_bk3710.c
> @@ -291,7 +291,6 @@ static void pata_bk3710_chipinit(void __iomem *base)
>  static int __init pata_bk3710_probe(struct platform_device *pdev)
>  {
>  	struct clk *clk;
> -	struct resource *mem;
>  	struct ata_host *host;
>  	struct ata_port *ap;
>  	void __iomem *base;
> @@ -310,15 +309,13 @@ static int __init pata_bk3710_probe(struct platform_device *pdev)
>  	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
>  	ideclk_period = 1000000000UL / rate;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		pr_err(DRV_NAME ": failed to get IRQ resource\n");
>  		return irq;
>  	}
>  
> -	base = devm_ioremap_resource(&pdev->dev, mem);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
