Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70433C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B3722D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPB2yYVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfHUMzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:55:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34497 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbfHUMzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:55:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id m10so1688381qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Im1BQWra9a4owWUT8RgHgoF9dvQvnpJmlT3+mhtCgoE=;
        b=UPB2yYVqL11rw/8JcJtyRckbAB8TMsSQlLsO1sZnlRr7OWWSVn1qGXk/BbnNfmMqZz
         OFr1YF2LwDFVCVLWkYmhv9C02+s0BNku0oQHq7D7gT/N0dSBTpqVdTwszY7oYB14y8Hd
         LKz0zoyRRWj3SYH36glpC8nEWpP0ou8LpeiwA5Dk0cCgEZcxw+4fEBmGc9ajJXN8MD9P
         lutwenSIH3zEQL9FY8bLqd4ERg07A3f9Pxo2YDnYyr/JDZHOcouRXePg0b+aLoMMJMJL
         ShLp1EQ02Spd+FfLglFjKyxCrHotYSoUGWs34ptu2viXpyFw+jYDzRJwjq2Jox2JV/FV
         6WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Im1BQWra9a4owWUT8RgHgoF9dvQvnpJmlT3+mhtCgoE=;
        b=SpFaGfPybBerQvmuyu4ysF4SfflD5zVHrHtBcDZfda0kjd8x9k1wqeUVjaEKZsBR9R
         JLbufJ6X3ZzLSpXS+dlW6USVSciFNFqbUFENIe5qkbqb7qY6IbPrLd0NPlqnuTgpPpjV
         +t0yYaIAM/p/o7II9iBjQ3elxy9qoFL+TcRPaHW7s0PmH6TNRFawAcvSFYD5sqRKJIBK
         TT4P8EFQKLfh+BVDTeH73SozXJHPUukhldBwRbxPiZqx1e7MyieAXwbEyosc11qDwJs2
         7o0huKaVIZ+vKfU2tEXiKEcr8kJ8NEC1BWA9fW+mmhdMu/EBVLtLVAQptKRPOwiL0knU
         A21w==
X-Gm-Message-State: APjAAAV7nZ/dnTQEVNwmmBLc7Fwm1kqTAp8wQ0dI0DyGHxW0w+Py42gF
        eiv07fne6towBtp7/OU7lMwMtJBP1I3BeWs/ke/siw==
X-Google-Smtp-Source: APXvYqzlnkcVZMpbi72pz29jEwoz0BYHgizVfpVGTVzXfD3RUN9g+U+ZiRfawCCMm8eorQ6/RoNiy9kXez3qEaScSkw=
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr7693095qkj.127.1566392151546;
 Wed, 21 Aug 2019 05:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <534b5017c2210ba8d541c206dace204d6617b4c9.1564091601.git.amit.kucheria@linaro.org>
 <5d577d77.1c69fb81.b6b07.83e6@mx.google.com> <CAHLCerMpWTVquyM3fYQxz-ZhDvnY276hfnZvZOmjV--cgm53UQ@mail.gmail.com>
 <5d5ab1e0.1c69fb81.d71db.1ca3@mx.google.com>
In-Reply-To: <5d5ab1e0.1c69fb81.d71db.1ca3@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 21 Aug 2019 18:25:39 +0530
Message-ID: <CAP245DV=pVF1oK2eFvK=iRng=Qxg=oDLWmHXBWtJH=VMxmmAvQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] drivers: thermal: tsens: Add debugfs support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 7:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-08-19 00:58:23)
> > On Sat, Aug 17, 2019 at 9:37 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > +
> > > > +static void tsens_debug_init(struct platform_device *pdev)
> > > > +{
> > > > +       struct tsens_priv *priv = platform_get_drvdata(pdev);
> > > > +       struct dentry *root, *file;
> > > > +
> > > > +       root = debugfs_lookup("tsens", NULL);
> > >
> > > Does this get created many times? Why doesn't tsens have a pointer to
> > > the root saved away somewhere globally?
> > >
> >
> > I guess we could call the statement below to create the root dir and
> > save away the pointer. I was trying to avoid #ifdef CONFIG_DEBUG_FS in
> > init_common() and instead have all of it in a single function that
> > gets called once per instance of the tsens controller.
>
> Or call this code many times and try to create the tsens node if
> !tsens_root exists where the variable is some global.

So I didn't quite understand this statement. The change you're
requesting is that the 'root' variable below should be a global?

tsens_probe() will get called twice on platforms with two instances of
the controller. So I will need to check some place if the 'tsens' root
dir already exists in debugfs, no? That is what I'm doing below.

> >
> > > > +       if (!root)
> > > > +               priv->debug_root = debugfs_create_dir("tsens", NULL);
> > > > +       else
> > > > +               priv->debug_root = root;
> > > > +
