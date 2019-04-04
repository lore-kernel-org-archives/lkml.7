Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F9C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE6E20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3rggirp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDDGlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:41:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39663 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDGlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:41:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id f10so1341490otb.6;
        Wed, 03 Apr 2019 23:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3o3hk6OVGvyTuD006lhhVSPuAvQZCtMla/eC+dyNEc=;
        b=u3rggirpZx4SYJfUDWxhPjiAYjpGsAA4c01aQ3oXdURfjfpuk2J4cjPJSyTgqgLutX
         F6lUX+3tMGXgxZaqWBcrwPJRwVJg56qfCZjM/4ofQFMyXACOND2dS4GOaQKRob8+fqGe
         n7UlolNHGIsKr6SFXxk29V0JyZz0wM/HsURbhW37X3vf+GAQnRvjHqxytiH0fU5sHp6O
         3ROMiERyf/bQTBKMSg3ClYA6/lKePamSYmH218+TBchbsY+X+i2EhkOT/MBW6i1A/5XM
         QGgwAQZpZ8YaSqkzmpty1bTLb+j9Ao0WK0SvdYFo8kA5S1LQqxq+Y4ZNd9uUuIi4x29R
         JL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3o3hk6OVGvyTuD006lhhVSPuAvQZCtMla/eC+dyNEc=;
        b=f72Yb1tT3Ll+bCOxnEIhfePIdspxifZMKbIfqEdUUGcjX0IQVyVR+tJwxqn8J/M4zq
         s0qDs/mBj8dVDdHD1n+DsJcLwWZa17EMxwiL83CjRR+43OgRErgcXt5itGRyUdc1A3X6
         aADvg+an4OZ/krc+FXrvo7byic5OHs2O6R2OblNV0O/SiDlePfvADytzH9QlH9jTc3Qb
         RbCoKgoE7xvKKNPmj4xoD18WT31VLOSY8fkbMsJ2WN31qOYMX6wtBKrNPvQS7KBM/smS
         zG0+WyDCVxL/LIJs1mkZS4ZOxV35KrJbYennZobOvQ+xxYsI2mZcUIUt4TTkrHlg1+2F
         OiLg==
X-Gm-Message-State: APjAAAWpdNj7kjSUsXww4zOPhd6dk6jWqnzdCRYS2gljf7rHO3RjjlLC
        EyDmX9r3idTBHVHpLKepxGd3VatRrhN8FUzK9cpXkGKK
X-Google-Smtp-Source: APXvYqy5GdrEL7QuSGpt08SxOeW9RNLquDzFWn5848TAl8OBDnq6Ks1c+uXjfgOJ4ExLZG8TctTytKtTeh2DVXh95bo=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr2995772oti.18.1554360095632;
 Wed, 03 Apr 2019 23:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190403204502.28917-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20190403204502.28917-1-lucasseikioshiro@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 4 Apr 2019 09:41:24 +0300
Message-ID: <CA+U=DsoYcNA4JUiFrLWWdDO+CmMWBy15x4WVEUTp803HT5EzUg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: cdc: ad7746: Replace bitshift by BIT
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     lars@metafoo.de,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        stefan.popa@analog.com, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 11:46 PM Lucas Oshiro <lucasseikioshiro@gmail.com> wrote:
>
> Replace bitshifts on lines 54, 56 and 78 of ad7746.c.
>

Hey,
This is only partially done.
If doing conversions to BIT(x) macro, I would say to do them for all cases.

Thanks
Alex

> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 0eb28fea876e..ea48b14cee72 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -51,9 +51,9 @@
>  #define AD7746_CAPSETUP_CACHOP         BIT(0)
>
>  /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
> -#define AD7746_VTSETUP_VTEN            (1 << 7)
> +#define AD7746_VTSETUP_VTEN            BIT(7)
>  #define AD7746_VTSETUP_VTMD_INT_TEMP   (0 << 5)
> -#define AD7746_VTSETUP_VTMD_EXT_TEMP   (1 << 5)
> +#define AD7746_VTSETUP_VTMD_EXT_TEMP   BIT(5)
>  #define AD7746_VTSETUP_VTMD_VDD_MON    (2 << 5)
>  #define AD7746_VTSETUP_VTMD_EXT_VIN    (3 << 5)
>  #define AD7746_VTSETUP_EXTREF          BIT(4)
> @@ -75,7 +75,7 @@
>  #define AD7746_CONF_VTFS_MASK          GENMASK(7, 6)
>  #define AD7746_CONF_CAPFS_MASK         GENMASK(5, 3)
>  #define AD7746_CONF_MODE_IDLE          (0 << 0)
> -#define AD7746_CONF_MODE_CONT_CONV     (1 << 0)
> +#define AD7746_CONF_MODE_CONT_CONV     BIT(0)
>  #define AD7746_CONF_MODE_SINGLE_CONV   (2 << 0)
>  #define AD7746_CONF_MODE_PWRDN         (3 << 0)
>  #define AD7746_CONF_MODE_OFFS_CAL      (5 << 0)
> --
> 2.21.0
>
