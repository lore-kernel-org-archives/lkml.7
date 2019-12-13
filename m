Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A0C50712
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1732470C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBrpArr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLMNys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:54:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43141 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfLMNyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:54:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so2710525ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 05:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RdSTB5NQwjOoYrj/2BgnJiFXxkWUYSC7knKRCi5Mjio=;
        b=PBrpArr9B3u6JbYnLb66q7dKmEGL2MtvGbWr/C+TjOKxAEIUfpOMogcjHNKobdOupn
         ti3jniJZ/GhhfpTfZcUV9yKZcNGGA3smXcs3/rs/Gr221XP/DSC5c6FrNNJKrqvwRb9e
         OCI/jZiHF1Z6USxpdsQ1rJK2siLGFyXAmzqG8EToVo7+VbF9Rb7vQTWNx5dw6KEs4lvz
         2CQpj3uTWh5Sti8hI6DUESBXD1Dk2UPfUDYXqCroccZNuzycyNVZLdUseJkDx4lpE66n
         KOkN4NZXnKZa0l8wvPlsEzPVbQjKJpbccoQdmuLKJFntwWO/NdDDXVoK87H0dl1Yfuc+
         RSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RdSTB5NQwjOoYrj/2BgnJiFXxkWUYSC7knKRCi5Mjio=;
        b=hmpNxX7mf2ylClb0oOzD6WrY+C5xCfevGoO8IeWoMKYeeq/giTGwkhygQKoDv9fvTD
         LUctMpbonFsSsHSS0GGLch0p3IjRoz+NCXQRoSGccu67n8zMbJxSCLZ8cnOr2VNdIUTo
         aq1t4bIkiyMXM2RIQjzjlTGfoBb9M1eojVKaK9PW366hFaqA9r78ELpPJ5BJ/SvP0oAI
         NF/GiRQ7hUUzwotdpsjdzzQ9JUoqJO8m51YAoDF/p7a1pW3AxGvEjiTCBAnCijuUHkFd
         tPJMaG3AGnE7sjweUPY1+WJhpfvwnMEB7jXGUp3k2WQMq/QWlcTee4GhnOUT7NkDqmNg
         HOTg==
X-Gm-Message-State: APjAAAViMKwu1L4YjQD7hdPciGPdO1Ml4sOWKkLFD7HD859fOowUJuBi
        3yJV1/E9hm9fvVGDVkI9l+Y1/8oSChuEyOYa8BE=
X-Google-Smtp-Source: APXvYqzqvCk1kwftFb654uEcSobrO2skRbkphlZl1DN3n8ilpPs7nU3A24nx5rjZqGjRILC0iVulzf1o9GdPy/5pADs=
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr10049365ljh.50.1576245285476;
 Fri, 13 Dec 2019 05:54:45 -0800 (PST)
MIME-Version: 1.0
References: <1576037311-6052-1-git-send-email-orson.zhai@unisoc.com>
 <CAK8P3a0244jKrEop2rHVyJZ57h4A9+mqb-5g-wLUSfR2G1svwg@mail.gmail.com>
 <20191213024935.GD9271@lenovo> <20191213082336.GD3468@dell>
In-Reply-To: <20191213082336.GD3468@dell>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Fri, 13 Dec 2019 21:54:33 +0800
Message-ID: <CA+H2tpH7QW-KG4pPXp7=_9J_yvXiL9O-2mCEP19HnRpM+QRqJA@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon reference
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Orson Zhai <orson.zhai@spreadtrum.com>,
        Rob Herring <robh@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        baolin.wang@unisoc.com, Kevin Tang <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        liangcai.fan@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 4:23 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 13 Dec 2019, Orson Zhai wrote:
>
> > Hi Lee and Rob,
> >
> > On Wed, Dec 11, 2019 at 02:55:39PM +0100, Arnd Bergmann wrote:
> > > On Wed, Dec 11, 2019 at 5:09 AM Orson Zhai <orson.zhai@unisoc.com> wr=
ote:
> > > >
> > > > There are a lot of similar global registers being used across multi=
ple SoCs
> > > > from Unisoc. But most of these registers are assigned with differen=
t offset
> > > > for different SoCs. It is hard to handle all of them in an all-in-o=
ne
> > > > kernel image.
> > > >
> > > > Add a helper function to get regmap with arguments where we could p=
ut some
> > > > extra information such as the offset value.
> > > >
> > > > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > > > Tested-by: Baolin Wang <baolin.wang@unisoc.com>
> > >
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Does this patch look good to be applied?
> >
> > Or if any comments please feel free to send to me.
>
> If it looks good to Arnd, it looks good to me.
>
> I have quite a number of reviews to get through first though, please
> bear with me and resist the urge to nag.

Got it.
Thanks for your kind reply!

-Orson
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
