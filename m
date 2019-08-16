Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC34C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65C1206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDD0IAvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfHPW32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:29:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46826 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfHPW32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:29:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id f9so6562998ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcIQ8f7uiCgBRDYQZgvf9BdkFXQfiqi4Jnab8kvYofM=;
        b=DDD0IAvtj0S3l02ltQU8EpNBnZXa/LPDRrS4ggAiitlDhWaKUUJDCnxA9iSvTLf+N9
         JZWiD52Bcwo2O1maT+VX7N3rDWG8fv9AAnOB7/f/1WWnGc/YMMnbRqLO9qyo/efPOZS/
         Vxx/aIR67dEPcfQpYYXixqhhM2QH0AZsUyogKTjNIBdasiZlwTXiIuexbtky0AZxHq1T
         3xYzXlFudhl39/1Zhd13U4fFewgwdGqBUSj1kW090KxlTnaKJ+VLSIzpIwgSbpiVNCJI
         TdAtYozC06bsrgLh4jUhwGe7flg7gHfJOcuhikauTII5mO35xtcuLhNYkNBH3dVA5HrL
         rYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcIQ8f7uiCgBRDYQZgvf9BdkFXQfiqi4Jnab8kvYofM=;
        b=MCiMoP3pKMQlOUl2bKVevbc8HNxp+ae6EVSPvXobSnRXs23ygwNYxkcG2RzPeHSJ7G
         yqYo8PuXq2ItydoKwKvqt2SfMKLhmGkrZN/gk7W+DPtqXJWqbctmovAifVaL4QxNHaf8
         yXRD5zb0+myJz0M3g39IgpYlwFA4G361RX0gadZSqDu462uv5Y3pyNjwxIpb1ZYeY4Vg
         HWdAiLtP8/Cn3Gph7er5Avvs32871ajmZTdGycTgD/cvFOBLAaeV4nKBMOPqRmZfFabX
         SiLvodDFurXpSbe476KR84Bzeoeaa9tBM/d92FjE450UU/fr5XV8abtsiH7Tpl4yPxvE
         bXWw==
X-Gm-Message-State: APjAAAU+xqf6E1xfQO6/OiqKQ1O/5s+i/Rg+lMAa8PNUZGrcqR4wtfFt
        WKo0s57ZGLKbcRyjMMc7bqA9ciXP2lt3Q0LvJbpcbA==
X-Google-Smtp-Source: APXvYqz/Um0VpLAdA90TWsPCo26kbKDPeGImTYJpGVkwKP0ZHIykSPf1mpDFbizhE48JPVnKM4VviobMERdB5LF39uY=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr4644548ljg.62.1565994566351;
 Fri, 16 Aug 2019 15:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190816165000.32334-1-andreas@kemnade.info>
In-Reply-To: <20190816165000.32334-1-andreas@kemnade.info>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 17 Aug 2019 00:29:14 +0200
Message-ID: <CACRpkdaVHPFgw9g8D=zrYECO5Syk1kMT3VgL+wq2ebKQxg_FGA@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: fix Freescale SPI CS quirk handling
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 6:50 PM Andreas Kemnade <andreas@kemnade.info> wrote:

> On the gta04 we see:
> spi_gpio: probe of spi_lcd failed with error -2
>
> The quirk introduced in
> commit e3023bf80639 ("gpio: of: Handle the Freescale SPI CS")
> can also be triggered by a temporary -EPROBE_DEFER and
> so "convert" it to a hard -ENOENT.
>
> Disable that conversion by checking for -EPROBE_DEFER.
>
> Fixes: e3023bf80639 ("gpio: of: Handle the Freescale SPI CS")
> Suggested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Good catch! Patch applied for fixes.

Yours,
Linus Walleij
