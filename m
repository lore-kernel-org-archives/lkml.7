Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82981C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512EB20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgDLNQfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfCZOAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:00:34 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50720 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:00:33 -0400
Received: by mail-it1-f194.google.com with SMTP id m137so19658203ita.0;
        Tue, 26 Mar 2019 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5odnq/eE8f9jjf/VG5lnZvtFMzdh1fBmKff2iR+7cg=;
        b=MgDLNQfGL9w1dMfxu0xyDd3sNOXZ2ivslCyS63gGWdHcwYDAf8aZZwnCd4/iKHoYDv
         Wv/9byPem7FjjFBo2V8JkPV/AELKcVJQJxS57eheAKex30H13CVTVLPHWOwZ8qcjPcIb
         2N3RTjmxrLVyy87ylcWWBNvwMaAJk6nW/mMcTgc0BzXUoFn/hVfXTLv5/gQn47Km1fbx
         ZFwztCbaZDtLdTpNJp0irt0e/JbiKkt5f14T84Nd6Lw9KcSVOAlr9JTbj9o+xEkw50gs
         0T1r/aiIyI/usyigmhEiPZC25xrea+Y8HUW+4vCObos6bofSyP93LN2ZMKVEgc3zzbUW
         ZQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5odnq/eE8f9jjf/VG5lnZvtFMzdh1fBmKff2iR+7cg=;
        b=gxT2/BltrO1kj/aDtYRn4XdrmTVclpLErbid8zS1gw/GUdVYsxeiJf9J2Ajf5rjHDf
         tiFuh3dqBatzeV71bAm0XjigpJjZv47SysQekQiMxqOi58eU8KwZd8ig0dlTtH53f0W/
         BFAKF8Z46uZ2rglPrJOpa+ieKnkdEGQi6oT5/+6cjHUvUvwL6nUKuRDvy6ue97uY2U/W
         3eNP9Vfm+cEGRMmPOkO/A/araWcj4yo9L0OTJjDItayRAE/hRB8TisQdA9l9HxlhTdbg
         Wce7JKQB3O4WxhJfNvsPabRXnPfmXsr+dcj9MPoH9e23bVT34jZCNgOFokXzkCNBaGKp
         Vtlg==
X-Gm-Message-State: APjAAAXRGpckp6gSkW+R2TAplb6bXdw9Vqgf80VbvUNaItVcoUKDlaGE
        Vz2EBz+w+rvZ/js00f850hxnBUYF3LVn8ymZdSk=
X-Google-Smtp-Source: APXvYqxm1dveqO3Txf9bnUagftkxFn8U7k6kwUhfL0r83SkuI/i+3PuP6AtsZd+B5d6WQAFDDTaM0f+gqlyDKfJemsU=
X-Received: by 2002:a24:7c04:: with SMTP id a4mr267551itd.143.1553608832768;
 Tue, 26 Mar 2019 07:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190322133105.5945-1-brgl@bgdev.pl> <20190322133105.5945-2-brgl@bgdev.pl>
In-Reply-To: <20190322133105.5945-2-brgl@bgdev.pl>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 26 Mar 2019 09:00:21 -0500
Message-ID: <CAHCN7xJj_aA8XFR6=ZxO-WrfkJRY5fS6NgjHbeqpdfhUnn1apA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: davinci: fix cpufreq registration on da850-evm
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 8:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The system_rev variable is never set on davinci and is always 0, so
> we're using the default max operating point of 300MHz. The cvdd supply
> comes from the tps6507 pmic and the voltage can go all the way to 1.3V
> so the maximum supported rate should be 456MHz.

My understanding is that only certain revisions of the silicon can go
to 456MHz.   The L138's Datasheet lists both a 456 and 375 version.  I
cannot find a way to read a register to determine which version of the
silicon is available. Maybe Sekhar can confirm.

adam
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 1fdc9283a8c5..58b2a485b527 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1155,17 +1155,7 @@ static struct edma_rsv_info *da850_edma_rsv[2] = {
>  #ifdef CONFIG_CPU_FREQ
>  static __init int da850_evm_init_cpufreq(void)
>  {
> -       switch (system_rev & 0xF) {
> -       case 3:
> -               da850_max_speed = 456000;
> -               break;
> -       case 2:
> -               da850_max_speed = 408000;
> -               break;
> -       case 1:
> -               da850_max_speed = 372000;
> -               break;
> -       }
> +       da850_max_speed = 456000;
>
>         return da850_register_cpufreq("pll0_sysclk3");
>  }
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
