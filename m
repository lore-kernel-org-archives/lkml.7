Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B5620643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552330930;
	bh=B3BGqfVJfoI+9HcuLNBFky9i71Oc5Sd5wE2NVIAeHzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zA+I7jYhZeupbZUGsUpnOBlkyMJdCCts7VZ87JY/1ZYEwMCNlTqLRtUxqjomuHrPt
	 iTPR+UG8CMGbZr8it2EXYCCB8UlnR6XnfAUKXsbr8N4bKIs2/aAWlC0UZnC75r+YjO
	 CjPgMoLDBxnaKsPg3+mzk6fnFw66c3txdYC1tc7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfCKTCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfCKTCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:02:07 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0B12147A;
        Mon, 11 Mar 2019 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552330925;
        bh=B3BGqfVJfoI+9HcuLNBFky9i71Oc5Sd5wE2NVIAeHzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ba5bSQnHZOUDkjZHQ/KFuqnRNR4K2sOL6fZaObjTDAP80VEKDzyKslsXM9zi+XuUN
         9WyuX/2XL5OLuXyvWPD3jLjGUGpUys47fTvb+PzjUDl4TP0iLEH4ndu5LuHbZJ+HSl
         3G9iNxy7kuBfzBSNYLieT6nIbiL09Gy/i6LH3MkA=
Received: by mail-wm1-f52.google.com with SMTP id 4so202435wmf.5;
        Mon, 11 Mar 2019 12:02:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWmi3JH2PmWgeRWmh42tEikLeY86m00Ybd5X97acalXmOneZVZ9
        gH8OoYrjo39+BniduYeLcpyN/j7vq2QbiHxuu1A=
X-Google-Smtp-Source: APXvYqwYQePj7WlHSYpRoBr83aP5VcxvocoBjWcLtc+ubKVWYhWjqZYmahcnSJiVvXfhxGRNj7/bqXLYkGRaiXjDIXA=
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr113518wmi.92.1552330923855;
 Mon, 11 Mar 2019 12:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1552275991-34648-2-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1552275991-34648-2-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 11 Mar 2019 12:01:52 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzo77XsggYZuhoTO20rh68PQrET1CSVB3GO4fpBzgWKPEw@mail.gmail.com>
Message-ID: <CAGp9Lzo77XsggYZuhoTO20rh68PQrET1CSVB3GO4fpBzgWKPEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mfd: mt6397: clean up code
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 10, 2019 at 8:48 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> clean up code
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 77b64bd..acb9812 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -18,17 +18,17 @@
>  #include <linux/of_irq.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/core.h>
> -#include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6323/core.h>
> -#include <linux/mfd/mt6397/registers.h>
> +#include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6397/registers.h>
>
>  #define MT6397_RTC_BASE                0xe000
>  #define MT6397_RTC_SIZE                0x3e
>
> -#define MT6323_CID_CODE                0x23
> -#define MT6391_CID_CODE                0x91
> -#define MT6397_CID_CODE                0x97
> +#define MT6323_CHIP_ID         0x23
> +#define MT6391_CHIP_ID         0x91
> +#define MT6397_CHIP_ID         0x97
>

It would be not necessary to simply rename the definition or do you
have a strong reason to do that?

>  static const struct resource mt6397_rtc_resources[] = {
>         {
> @@ -298,7 +298,7 @@ static int mt6397_probe(struct platform_device *pdev)
>                 return pmic->irq;
>
>         switch (id & 0xff) {
> -       case MT6323_CID_CODE:
> +       case MT6323_CHIP_ID:
>                 pmic->int_con[0] = MT6323_INT_CON0;
>                 pmic->int_con[1] = MT6323_INT_CON1;
>                 pmic->int_status[0] = MT6323_INT_STATUS0;
> @@ -312,8 +312,8 @@ static int mt6397_probe(struct platform_device *pdev)
>                                            0, pmic->irq_domain);
>                 break;
>
> -       case MT6397_CID_CODE:
> -       case MT6391_CID_CODE:
> +       case MT6391_CHIP_ID:
> +       case MT6397_CHIP_ID:
>                 pmic->int_con[0] = MT6397_INT_CON0;
>                 pmic->int_con[1] = MT6397_INT_CON1;
>                 pmic->int_status[0] = MT6397_INT_STATUS0;
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
