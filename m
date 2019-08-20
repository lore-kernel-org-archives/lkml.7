Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0533C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q9de4Duw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfHTN3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:29:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39499 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfHTN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:29:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190820132902euoutp01aa18a2cf37e91c37073e6ffbe03a5daf~8pJfOhxtf2771827718euoutp017
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:29:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190820132902euoutp01aa18a2cf37e91c37073e6ffbe03a5daf~8pJfOhxtf2771827718euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566307742;
        bh=ekr+uujFA+89FeaH6cgv1B7FP6sGoj0TRxurzLQh028=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Q9de4DuwNT/T4EE7w2E6CorA1rcNtdiH/OY8jfPeiYhf7308YKI6o7IpiyBKZiBJU
         cARBE+CVuI2d2wVHiWPdNSvNgBP8DQRK40PsgaZXDTDrsISoFgjsjj5C9Ucb2daTcK
         aYwLv6Vv+Jkj8vOh3EVgy4l3wiHZLRKhF6qHa+w0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190820132901eucas1p117067dc78680b1845ac8cb7a059599f7~8pJe1nat91753317533eucas1p1L;
        Tue, 20 Aug 2019 13:29:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 15.A0.04469.D95FB5D5; Tue, 20
        Aug 2019 14:29:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190820132900eucas1p1ffd478933ac55f2e28ce67dbb1678088~8pJd9fPu80564505645eucas1p1L;
        Tue, 20 Aug 2019 13:29:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820132900eusmtrp135416b4d0f545860ef74f1b4e7cbbd3e~8pJdrIWtV1612716127eusmtrp1A;
        Tue, 20 Aug 2019 13:29:00 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-23-5d5bf59df110
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A5.B6.04117.C95FB5D5; Tue, 20
        Aug 2019 14:29:00 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190820132900eusmtip1ee8731bdda5a7cdffdd96c55446cab92~8pJdQZw6e1324013240eusmtip1W;
        Tue, 20 Aug 2019 13:29:00 +0000 (GMT)
Subject: Re: [PATCH 2/9] drivers: ata: ahci_seattle: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <81e2908c-1608-dd97-28cf-4c7467754519@samsung.com>
Date:   Tue, 20 Aug 2019 15:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1566304548-19972-2-git-send-email-info@metux.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7pzv0bHGqw/p2Gx+m4/m8Wb49OZ
        LG427maymPJnOZPFsR2PmCwu75rDZtH5ZRabA7vH5bOlHneu7WHzmPDhLZvH+31X2Tw+b5IL
        YI3isklJzcksSy3St0vgymj/uJq14AhHxd6539gbGCeydzFyckgImEhs6vrN1MXIxSEksIJR
        YnrDdmYI5wujxIylr1kgnM+MEu/vvmWCafm2agMbRGI5o8SyPWehWt4ySsx7f40ZpEpYIFqi
        u38BmC0iYC7x+MlCVpAiZoE5jBIf/25jAUmwCVhJTGxfxQhi8wrYSfz+dQdsBYuAqsSv79/A
        4qICERL3j21ghagRlDg58wlQLwcHp4C9xI013iBhZgFxiVtP5jNB2PIS29/OATtIQmAbu8Tu
        5llsEGe7SOy91MYIYQtLvDq+BRoCMhKnJ/ewQDSsY5T42/ECqns7o8Tyyf+guq0lDh+/yAqy
        mVlAU2L9Ln2IsKPE5X0f2EHCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrEhmUb2GDWdu1c
        yTyBUWkWks9mIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwCZ3+
        d/zTDsavl5IOMQpwMCrx8O64GR0rxJpYVlyZe4hRgoNZSYS3Yk5UrBBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWpRTBZJg5OqQZGj1qhNMHgn5Nc/yae2xjUzj27sOz+
        2c5iS+bGcFXdvWueXXT8LLiqPUg39ULhhkdJCwRL+Xn/ZuR583K/82XqXeU+bX70hn9uaxd8
        zeR8n/j6x54H02QFIi/N13kQ16909M3tB5uXF+qwflH4d7JJ5Lm8K9tn2fbG75+WHIkLNnLx
        7z0YJvpCiaU4I9FQi7moOBEAEkA06T4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7pzvkbHGuy5pGSx+m4/m8Wb49OZ
        LG427maymPJnOZPFsR2PmCwu75rDZtH5ZRabA7vH5bOlHneu7WHzmPDhLZvH+31X2Tw+b5IL
        YI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy2j/
        uJq14AhHxd6539gbGCeydzFyckgImEh8W7WBrYuRi0NIYCmjxK2Z+5m7GDmAEjISx9eXQdQI
        S/y51gVV85pRYtrmXiaQhLBAtER3/wJmEFtEwFzi8ZOFrCBFzAJzGCW+L5/FCtFxnFGi8fcF
        RpAqNgEriYntq8BsXgE7id+/7oBNYhFQlfj1/RtYXFQgQuLM+xUsEDWCEidnPmEBuYhTwF7i
        xhpvkDCzgLrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg0C0n3LCQts5C0zELSsoCRZRWjSGpp
        cW56brGRXnFibnFpXrpecn7uJkZgzG079nPLDsaud8GHGAU4GJV4eHfcjI4VYk0sK67MPcQo
        wcGsJMJbMScqVog3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgekgryTe0NTQ3MLS0NzY3NjM
        Qkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY9jOpsgdmXeF9Oa8OKfPkhe99qzC96vB0xJy
        X2lc0v60W8BmQVxU3L49R4KZ7IUueS9ZM533pKrI+sSdjtd+qB903dkuziPyWX49c8wFrS3+
        bcmNLPNUDuipNekJuDxP2+2z68KFO4uXdJ332vb2wRXnZP9jyW56H2bcF3u5xs596dztGlFm
        FUosxRmJhlrMRcWJAGU8jYXPAgAA
X-CMS-MailID: 20190820132900eucas1p1ffd478933ac55f2e28ce67dbb1678088
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820123559epcas2p12a7160b5fbd7fe6d648aa4471d94d603
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820123559epcas2p12a7160b5fbd7fe6d648aa4471d94d603
References: <1566304548-19972-1-git-send-email-info@metux.net>
        <CGME20190820123559epcas2p12a7160b5fbd7fe6d648aa4471d94d603@epcas2p1.samsung.com>
        <1566304548-19972-2-git-send-email-info@metux.net>
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
>  drivers/ata/ahci_seattle.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
> index ced12705..2d88d36 100644
> --- a/drivers/ata/ahci_seattle.c
> +++ b/drivers/ata/ahci_seattle.c
> @@ -132,8 +132,7 @@ static const struct ata_port_info *ahci_seattle_get_port_info(
>  	if (!plat_data)
>  		return &ahci_port_info;
>  
> -	plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
> -			      platform_get_resource(pdev, IORESOURCE_MEM, 1));
> +	plat_data->sgpio_ctrl = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(plat_data->sgpio_ctrl))
>  		return &ahci_port_info;

