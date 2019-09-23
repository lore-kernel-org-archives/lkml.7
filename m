Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F9C00043
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA2A20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="u0KoNwON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502745AbfIWU5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:57:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45548 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbfIWU5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:57:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id 41so13386246oti.12;
        Mon, 23 Sep 2019 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6c25qQsTeIPE9y+3+ZT0AbIPmrbpxHVzGa7akuxeXBU=;
        b=u0KoNwONLVDAye4B3NjPMQ0GIaXgrAmo677MziXVwc764mY7LMwTeDRHZwk1Q47ozk
         y9L8n4cGn9k8n0tsNkAUhQMErMbFm9EVlmHMcECZGs8gxDCgpCUYXXcWKlJb01S/ontV
         iJ/MfYNg0kaVadJBS5nehHQRaIbVQ9M8psrma9m3cCoyAJDD65MKOGgDapVVVYZcEFf+
         pa7hj1X/GyknoHHerWjEMPqGG4pI0e3SXekz0FoaYWezcIq1bv6W/lE8D/d1dVLiSeOr
         HjGRf6zGSHd6AWwWrAUtCIMg3COMZSx1qBmi4mh/w88UqvaR+gdHxnOm/6B96OH9k6bl
         c0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6c25qQsTeIPE9y+3+ZT0AbIPmrbpxHVzGa7akuxeXBU=;
        b=eIqrzfYb9v4fP5Mc2PY7TWEUkQtLRmFO9A1BPiM4KviRuzvswcSniYmRjHQSn+oatQ
         dWhr0CxXPRzIf9ZoQj9D/JQhnY9agaYHKV3tN9MpsCWYfeJrttcA80bdG3PDVGG4m45H
         IxlHtjk+oT0lZXbkxauOfm5EhGYdCHp5StSM4PVUrDABnfYiMx2eJcG/uE/oE8hEPjno
         u4fS8QCCngLOGXM4jrXxsazhTyDKkpu3ORqY5oNEF9Q6iMQKC+otRzS90QSkftphoeWg
         MEYfG7veJE2QEoF8S4YYjax0vuM8NvzZ+cCqHPnLViDs5WD1jdE0OWvtdEYO+dlN648g
         TdAA==
X-Gm-Message-State: APjAAAV04TsWFrRs16TcukqxgLUaRbeWXk3AsKD/Mt7yUtWrACpzVkHe
        VETnSpuDALuKG/AT+WLzNxnfp/t+0RQsexDYoEw=
X-Google-Smtp-Source: APXvYqx9NdiDBVuyqZt9xSlPQAPNa3d0edQayrOgAnpbJnLWMpJMaNDfO9DISDG4XF7q6HeXFGHY3XzGml8EDUXbPgE=
X-Received: by 2002:a9d:7d17:: with SMTP id v23mr181560otn.81.1569272250579;
 Mon, 23 Sep 2019 13:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
 <20190921151223.768842-5-martin.blumenstingl@googlemail.com> <1jwodzs6ir.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jwodzs6ir.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 23 Sep 2019 22:57:19 +0200
Message-ID: <CAFBinCDrN2Rvu6ry+voB5itU6X+ezCzT=ZkQ6Qz8rz_+1kCLCg@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: meson: meson8b: don't register the XTAL clock
 when provided via OF
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:31 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sat 21 Sep 2019 at 17:12, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > The XTAL clock is an actual crystal on the PCB. Thus the meson8b clock
> > driver should not register the XTAL clock - instead it should be
> > provided via .dts and then passed to the clock controller.
> >
> > Skip the registration of the XTAL clock if a parent clock is provided
> > via OF. Fall back to registering the XTAL clock if this is not the case
> > to keep support for old .dtbs.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/clk/meson/meson8b.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> > index b785b67baf2b..15ec14fde2a0 100644
> > --- a/drivers/clk/meson/meson8b.c
> > +++ b/drivers/clk/meson/meson8b.c
> > @@ -3682,10 +3682,16 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
> >               meson8b_clk_regmaps[i]->map = map;
> >
> >       /*
> > -      * register all clks
> > -      * CLKID_UNUSED = 0, so skip it and start with CLKID_XTAL = 1
> > +      * always skip CLKID_UNUSED and also skip XTAL if the .dtb provides the
> > +      * XTAL clock as input.
> >        */
> > -     for (i = CLKID_XTAL; i < CLK_NR_CLKS; i++) {
> > +     if (of_clk_get_parent_count(np))
>
> If we are going for this, I'd prefer if could explicity check for the
> clock named "xtal" instead of just checking if DT has clocks.
OK, I'll wait a few days and then fix this in v2


Martin
