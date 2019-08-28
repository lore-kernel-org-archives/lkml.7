Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC17217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RqC6ax56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1JLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:11:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58303 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfH1JLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:11:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190828091101euoutp027c2b6a5affc1c9c31890bbe53a4ecb64~-CyfyTwYX2541425414euoutp02g
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:11:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190828091101euoutp027c2b6a5affc1c9c31890bbe53a4ecb64~-CyfyTwYX2541425414euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566983461;
        bh=/78qr5227MV+TuCigKN0flb6YO8aEfLCevv1v7kfb/Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RqC6ax56WxCo1LuIUkF4WnOmwPZYVVga5YWwDZ2ihJCv3Z420REcf/b1iVv22tDRS
         uFUFP7YCESQoSfyHT+9kAJXtNK1uZPojv9+myShEZnwdlW8AxgtvDAy8VuEDu2qcvB
         EYVy24i+hVbeB4B0J7IMMHw1RUjo7Ogrj4hgp+1s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190828091100eucas1p25f1d41e9dc2fc01e61e8b75f05a19cb1~-Cye2WN5j2197421974eucas1p26;
        Wed, 28 Aug 2019 09:11:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 73.69.04309.425466D5; Wed, 28
        Aug 2019 10:11:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190828091059eucas1p28ebe49a4bdc34e2e7e2f813cd35b9ea5~-CyeBBSgo2923829238eucas1p2K;
        Wed, 28 Aug 2019 09:10:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190828091059eusmtrp12748cba904097ff82db35493e6f537ee~-Cydyn72f1194511945eusmtrp1Z;
        Wed, 28 Aug 2019 09:10:59 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-7f-5d6645249efc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.4C.04117.325466D5; Wed, 28
        Aug 2019 10:10:59 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190828091058eusmtip153d0b7e901f3ce58af85c95b5276d75d~-CydV-2fh2182421824eusmtip1n;
        Wed, 28 Aug 2019 09:10:58 +0000 (GMT)
Subject: Re: [PATCH 2/2] hwmon: pwm-fan: Use platform_get_irq_optional()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <980b3960-e648-0275-ae82-34fd8f307a69@samsung.com>
Date:   Wed, 28 Aug 2019 11:10:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190828083411.2496-2-thierry.reding@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87oqrmmxBtdmC1o0L17PZnF2QqDF
        zBPtrBbtr7cyWlzeNYfN4snCM0wWc79MZbY4fucpk8XPXfNYHDg9ZjdcZPHYOesuu8emVZ1s
        HvvnrmH32Pm9gd1j/ZarLB6fN8l5XDnSyB7AEcVlk5Kak1mWWqRvl8CVMWXLfMaC++wVe2af
        Zm1gXMvWxcjJISFgIrFg02QmEFtIYAWjxInFRl2MXED2F0aJP01NbBDOZ0aJt3efssN0bJz5
        lRWiYzmjxMeV4hBFbxklpm1cwQKSEBbwkNj7bTuYLSKgK/H/9BsWkCJmgVVMEn8e3gJLsAlY
        SUxsX8XYxcjBwStgJ3GlhRckzCKgKnFp5X6w80QFIiTuH9sAtoxXQFDi5MwnYK2cArYSm/p7
        wc5mFhCXuPVkPpQtL7H97RxmiEPvsUuc3lEAYbtIHJi+ghHCFpZ4dXwL1DMyEqcn94DdJiGw
        jlHib8cLZghnO6PE8sn/oIFkLXH4+EVWkEOZBTQl1u/Shwg7Shy+ugXsfgkBPokbbwUhbuCT
        mLRtOjNEmFeio00IolpNYsOyDWwwa7t2rmSewKg0C8lns5B8MwvJN7MQ9i5gZFnFKJ5aWpyb
        nlpslJdarlecmFtcmpeul5yfu4kRmLBO/zv+ZQfjrj9JhxgFOBiVeHg7+FNjhVgTy4orcw8x
        SnAwK4nwPlIBCvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCU
        amBULs3aMD2+Wi/i7u2lCcqys78deek56eWXndMtWbVECn8umencVrfXKaNR3nDV8kqeFo8L
        k06kvpneWcf/6eMpdeabc7yXX9dQCDIMZfFyPaQc4SglKnM7Yq+8MUvY375pX3M2uWw02/R0
        JReff5+l3WSlpNl54oyOotJBU/86Ta7iMs/0KVdiKc5INNRiLipOBADw9VDzVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7rKrmmxBnt/iVo0L17PZnF2QqDF
        zBPtrBbtr7cyWlzeNYfN4snCM0wWc79MZbY4fucpk8XPXfNYHDg9ZjdcZPHYOesuu8emVZ1s
        HvvnrmH32Pm9gd1j/ZarLB6fN8l5XDnSyB7AEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMWXLfMaC++wVe2afZm1gXMvWxcjJISFgIrFx5lfW
        LkYuDiGBpYwSMw4eYexi5ABKyEgcX18GUSMs8edaFxtEzWtGiS+3mthBEsICHhJ7v21nAbFF
        BHQl/p9+wwJSxCywikni16oGJoiOw4wSL/s/MYJUsQlYSUxsXwW2gVfATuJKCy9ImEVAVeLS
        yv1gF4kKREiceb8CbCivgKDEyZlPwGxOAVuJTf29TCA2s4C6xJ95l5ghbHGJW0/mQ8XlJba/
        ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAKN127OeW
        HYxd74IPMQpwMCrx8Hbwp8YKsSaWFVfmHmKU4GBWEuF9pAIU4k1JrKxKLcqPLyrNSS0+xGgK
        9NxEZinR5HxgAskriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cDI
        furcjo+1mZM2r72i0n6VffmFw6mrpjyfsnnmU88HB55PXN1WdvplYcz/Q+Wvij+W3/0yY7f5
        K9872VPWTT89U5a52f2YcbSSZ9nm5+yCdd+n1x5u/pH1+I1KgKN4+lvhLn5pP6nkh8YHOW7I
        xU9s1HB8dPHt54uXTCX2TPJ0tXvyb1Lmv/tHlyuxFGckGmoxFxUnAgCrJ3Ed6AIAAA==
X-CMS-MailID: 20190828091059eucas1p28ebe49a4bdc34e2e7e2f813cd35b9ea5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190828083420epcas2p3a97c84e609c80213bb9b5283a3c0643d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190828083420epcas2p3a97c84e609c80213bb9b5283a3c0643d
References: <20190828083411.2496-1-thierry.reding@gmail.com>
        <CGME20190828083420epcas2p3a97c84e609c80213bb9b5283a3c0643d@epcas2p3.samsung.com>
        <20190828083411.2496-2-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/28/19 10:34 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The PWM fan interrupt is optional, so we don't want an error message in
> the kernel log if it wasn't specified.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/hwmon/pwm-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 54c0ff00d67f..42ffd2e5182d 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -304,7 +304,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, ctx);
>  
> -	ctx->irq = platform_get_irq(pdev, 0);
> +	ctx->irq = platform_get_irq_optional(pdev, 0);
>  	if (ctx->irq == -EPROBE_DEFER)
>  		return ctx->irq;
>  
