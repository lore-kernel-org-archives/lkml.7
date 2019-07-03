Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A88BC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E357D21880
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rv8/eydR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfGCHje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:39:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44084 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfGCHjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:39:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id e189so1241835oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+ONtwKrr9MoAxJy3nzYyZYaZtN7tZSEZElIWhYkH6s=;
        b=rv8/eydRATgo4XLG7QYMsUNM6tIoAfjMBeIEw526lP66oRfS1YEvpduOSz0u7nibUl
         nb76zfYHzWEFwMrqiGxJbb+vcHmiIHpS7tFjZ2ltXqaYUkFhKztC9otdCyajFbmp/N/u
         VMJK38E3H+WyuHIeRFz7e3AmhIHOJr6kz2xOYRbsaMFVBGxPXF1Lys2N4W6Z70E8i8/C
         MuzeQrOzkxXI/3PPnh42oDJmnOXbrx8nT/8lVQLr3qTTlR6i2SN2J59cRwl6JJmgamuw
         loUICPT9wT9KTrXh97PDSBDor1LhPYL9aH+2dXN/tcH4XWDVKf9Ish5qOZvC3rqpl4n7
         KlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+ONtwKrr9MoAxJy3nzYyZYaZtN7tZSEZElIWhYkH6s=;
        b=sRsQpub41zYg4gVvANf2rPbb/XsWsfDoW4Am27p9K4TtvYde94pXatMXnqsTxK5RGs
         h3QmMdLeZUXZCl6FZS9cwp6F3uppTUe+7n/HnuDSUZi4/WFgIfranhFlEaP0suG4MvyG
         lE0SXnz3GZamKNdGK8MQsKPts4Hd6kC1RZXELIo4876Sp8qEgUiUQPIE7aK+bVobYTAz
         40s4acBPrmdkEmsIkRjsc9wA4uKhWt6QvU0ON7NKff2O6q6EPyRypyTchOSIdBmRzo3P
         uPbtqhB4yvekA4KQ5pm3p4MliS7nVnsJUvcOZ1UYXYqq8E5YvnBnSIcPuj+fsPiXJsKD
         gdMg==
X-Gm-Message-State: APjAAAU2nIoFyxIirMnFxqzhEKvaZiDlCaAwOv7nkRtiAEVIc+Z5kDSr
        RtuJi2V6QvaJ6tv+YHyTwFUJdjJaCL4IV7T5ts6C3g==
X-Google-Smtp-Source: APXvYqxN4JBehPtSNVFvMgeIctFw8U6GM1tPTFUqjq+7Uz2D6J3GcSi6Tcqvx53ETCvfY/YyDqrTPsjGLQzG92y6q3s=
X-Received: by 2002:aca:574e:: with SMTP id l75mr5705600oib.2.1562139570860;
 Wed, 03 Jul 2019 00:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 3 Jul 2019 15:39:19 +0800
Message-ID: <CA+Px+wXBBgeWbjZ5uQmwJgn+d=ZE-N0aehitog7==ak3GDxMsQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: codecs: ad193x: Group register
 initialization at probe
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 8:05 PM Codrin Ciubotariu
<codrin.ciubotariu@microchip.com> wrote:
> +struct ad193x_reg_default {
> +       unsigned int reg;
> +       unsigned int val;
> +};
You probably don't need to define this.  There is a struct
reg_sequence in regmap.h.

> +
> +/* codec register values to set after reset */
> +static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
> +{
> +       const struct ad193x_reg_default reg_init[] = {
> +               {  0, 0x99 },   /* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
> +               {  1, 0x04 },   /* PLL_CLK_CTRL1: no on-chip Vref */
> +               {  2, 0x40 },   /* DAC_CTRL0: TDM mode */
> +               {  4, 0x1A },   /* DAC_CTRL2: 48kHz de-emphasis, unmute dac */
> +               {  5, 0x00 },   /* DAC_CHNL_MUTE: unmute DAC channels */
> +       };
> +       const struct ad193x_reg_default reg_adc_init[] = {
> +               { 14, 0x03 },   /* ADC_CTRL0: high-pass filter enable */
> +               { 15, 0x43 },   /* ADC_CTRL1: sata delay=1, adc aux mode */
> +       };
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(reg_init); i++)
> +               regmap_write(ad193x->regmap, reg_init[i].reg, reg_init[i].val);
> +
> +       if (ad193x_has_adc(ad193x)) {
> +               for (i = 0; i < ARRAY_SIZE(reg_adc_init); i++) {
> +                       regmap_write(ad193x->regmap, reg_adc_init[i].reg,
> +                                    reg_adc_init[i].val);
> +               }
> +       }
And you could use regmap_multi_reg_write( ) to substitute the two for-loops.

See https://mailman.alsa-project.org/pipermail/alsa-devel/2019-June/151090.html
as an example.  It also has some reg initializations in component
probe( ).
