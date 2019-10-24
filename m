Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D67CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E9F2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ztl5xY+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405089AbfJXBl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:41:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34043 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXBl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:41:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so23146898lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 18:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OJxaH+6kPmw9dgASj0fuVpQ14VN3FuPc/5yGSGtmbY=;
        b=Ztl5xY+MLrQm864BsPw6LxqQ7I482HU/mx+dmOZ3vBiev+zX+ecZlrDHrjPP1TJ5M0
         G1slYe3ezYIVVAOb2tNWoDLJLHhD2Cq6H0rjPHtbPmltWsEi235k+6Bbo49lYMGy7KwI
         ZUNKfysobLawVrjElAPcaLxASua/+EdSTxJrhZA2hUUL1kCZLO1oXm46VpEXehooJ2sQ
         GgBjKEg/L0bqGBaeDaY0zYdWAXOZfrHpYl0VaLF5l+JtJuNtN6QC6DZGRoZP4Tlb2y3m
         yynPG36KPPVA+HJWOKqXL2VPvB5d09J6tZSSxrrlrnhYSQB7nnQE5Nrylhs1XdHy1NBs
         L5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OJxaH+6kPmw9dgASj0fuVpQ14VN3FuPc/5yGSGtmbY=;
        b=b6jIyJRWKY8RS/se9dM/Edb6kRcvBY6vdrfjZlpE7aQyArtpTFX5uPFmTUyREG9+ao
         d/haZv0A8xvLOjF0BZSGBxVo/rE2KDOfwFkKgqzhiSXaboxEi6uqB2ccKVCi18Md5FD/
         rmgF/PLPtPHkTQsVX+4RbPJRvnthDoXaCNMdFTO0wwG77gjgnyLuAV/PHBf8T0GSBhx3
         XVVECoblO6pyx/803dFxTDlj8enBXAxYQ7vcQ+ps2ReXEdCGG7SBtyktopOftbZDi1cU
         alvkpYJXUTaT3HwGboghBy/6XaFAFtxIfvRAOFBDd9RaBs3ZThlDJWIs4j9YLdkZy2pS
         60SQ==
X-Gm-Message-State: APjAAAU9AezLyi+7hBtJgPeDxbEE0rJGZO7V3ItRdgg6gTXaOZvq2D3s
        TVg4YkVH1GyW7YZdUuo0PCJcxd8R04wkzikzgsN0ZA==
X-Google-Smtp-Source: APXvYqxFU/AdvtGEjXjz6AO9yFhahr2FZeEFXGQJlEkrVWjpBVlmtuHmyjLej6w3l0uiAHH5Qi0htKzJtZqZqFYOG2Q=
X-Received: by 2002:a2e:2c0f:: with SMTP id s15mr24577899ljs.63.1571881313012;
 Wed, 23 Oct 2019 18:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <2e3d8287d05ce2d642c0445fbef6f1960124c557.1571828539.git.baolin.wang@linaro.org>
 <CAK8P3a0i_xvSzeRxfT-5LLpaAfGx3USsuXX1dv1x6Bg87jeopg@mail.gmail.com> <CAOesGMg5MH3Dq8yBLhHZCJJwMqVaiqqJyhs-tNE_nWDzUaTPCw@mail.gmail.com>
In-Reply-To: <CAOesGMg5MH3Dq8yBLhHZCJJwMqVaiqqJyhs-tNE_nWDzUaTPCw@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 24 Oct 2019 09:41:41 +0800
Message-ID: <CAMz4kuKRzqtevbUfpT93MLM_9L6jA5oT7g=r9RKVyG4xK=_E1g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update the Spreadtrum SoC maintainer
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>, baolin.wang7@gmail.com,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 at 23:37, Olof Johansson <olof@lixom.net> wrote:
>
> On Wed, Oct 23, 2019 at 5:17 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Oct 23, 2019 at 1:06 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > +F:     drivers/power/reset/sc27xx-poweroff.c
> > > +F:     drivers/leds/leds-sc27xx-bltc.c
> > > +F:     drivers/input/misc/sc27xx-vibra.c
> > > +F:     drivers/power/supply/sc27xx_fuel_gauge.c
> > > +F:     drivers/power/supply/sc2731_charger.c
> > > +F:     drivers/rtc/rtc-sc27xx.c
> > > +F:     drivers/regulator/sc2731-regulator.c
> > > +F:     drivers/nvmem/sc27xx-efuse.c
> > > +F:     drivers/iio/adc/sc27xx_adc.c
> > >  N:     sprd
> >
> > Maybe add a regex pattern for "sc27xx" instead of listing each file
> > individually?
> > That would simplify it when files move around or you add more drivers that
> > follow the same naming.
>
> Agreed.
>
> In addition to that: Baolin, when you resend this, feel free to send
> it to soc@kernel.org so we get it into our patchwork tracker (if you
> want us to apply it directly).

Sorry, I missed soc@kernel.org mail list, and will add it in V2. Thanks.

-- 
Baolin Wang
Best Regards
