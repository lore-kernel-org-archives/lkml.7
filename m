Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EF32077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V144qspz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfDZOpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:45:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46081 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:45:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id o7so1667537pll.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuGyGPN+7eSC7f2qZalmHSt7FhhkqUy3UJk2/jVyU4U=;
        b=V144qspzO/I5RKSoE6+VcXuK+GdR1gxULRrio2SbUu1lPdn10Scll1iAzZXEpj9Z7d
         D5ONYjpZLxMkXfMgXO/sG9mveMjg+GkM1fLpkI7dHTsK2Z4eOMxUHMLHlWLr8J6n9fMg
         3f5fmz2qFDaIngidxt4WxhyNp93ujhXTJnef3DKVOjs5avQxXgOgaZCtSVvyfIZBj22E
         MNVUWWv4MiVH0R/rJQzIotf3mI8M+u0lLhtJE2ZyakbHoIYaRgbu1jyiER6r0lJdqZDQ
         HgPME7G1Bb8pmxHQqJv3aRLxsFEnfqED6H30tVn55M8OBa+Y2XwNxVGUx62Lim84QGI6
         4ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuGyGPN+7eSC7f2qZalmHSt7FhhkqUy3UJk2/jVyU4U=;
        b=m16UubZwONvblq7PAiT15XYORrA1rjLN0GRr015WI8Q0+XHnG9wk55jBvmHiufxF7G
         /jEZPJH675uNnElgqU1X2N497RzguGbj0dobwaXAvUCx+q9sxW9U+hYOmvPehqR4o0Hs
         Js7Y9SfOIjSzm7eT97Eo7Q7AuiH2EYrV9RbNG388TG952cjQgtQbK87Ez/2orkPgrV6x
         RMuWE4wQZVH7JAv93SKl1wsviR/iU+mt7x27gJ/v88CucAVI6a2tAMJyiW0IFr2hlm4j
         vPzvvPQVFhxmyum0ndDuBIRi06eEuj/R4UyVEeFtwfLkZCVTx8dGkrehfBFQRtzdMqFF
         Zcfw==
X-Gm-Message-State: APjAAAUEgahbX73C5V1DAovlAOveGTFij4qrqch6x01GDSsQPj06qeiD
        9jpPgwTyJzIXy14bHITALo7vLwaGELdOb9x/zz4=
X-Google-Smtp-Source: APXvYqw6mwQTkgReR0n8xPup5JldH8EX1CL6/iz20Q5Vo4TVpost3A2c+z/dp9+VwF0XDn962vUm+zmyF2IALeJIFGU=
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr47054912pla.311.1556289905328;
 Fri, 26 Apr 2019 07:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <06b89c06-462a-788e-20f9-aa71ac1507b4@siemens.com>
In-Reply-To: <06b89c06-462a-788e-20f9-aa71ac1507b4@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Apr 2019 17:44:54 +0300
Message-ID: <CAHp75VevX_TAzgrmBTF0KY_5ZycG6VNnAY8CQf+nR-kdSKKrXQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel_quark_i2c_gpio: Adjust IOT2000 matching
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Su Bao Cheng <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:15 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Su Bao Cheng <baocheng.su@siemens.com>
>
> Since there are more IOT2040 variants with identical hardware but
> different asset tags, the asset tag matching should be adjusted to
> support them.
>
> For the board name "SIMATIC IOT2000", currently there are 2 types of
> hardware, IOT2020 and IOT2040. Both are identical regarding the
> intel_quark_i2c_gpio. In the future there will be no other devices with
> the "SIMATIC IOT2000" DMI board name but different hardware. So remove
> the asset tag matching from this driver.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> index 5bddb84cfc1f..11adbf77960d 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -74,16 +74,6 @@ static const struct dmi_system_id dmi_platform_info[] = {
>         {
>                 .matches = {
>                         DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
> -                       DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
> -                                       "6ES7647-0AA00-0YA2"),
> -               },
> -               .driver_data = (void *)400000,
> -       },
> -       {
> -               .matches = {
> -                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
> -                       DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
> -                                       "6ES7647-0AA00-1YA2"),
>                 },
>                 .driver_data = (void *)400000,
>         },
> --
> 2.16.4



-- 
With Best Regards,
Andy Shevchenko
