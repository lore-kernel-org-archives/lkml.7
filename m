Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546D7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3056321872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRBh9irE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbfHZSEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:04:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40510 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbfHZSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:03:59 -0400
Received: by mail-io1-f65.google.com with SMTP id t6so39510752ios.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrIqYBjOEoC2bEbTCnzekyDA0blqp/IM4h4nsnqYLQk=;
        b=uRBh9irELtf92IyXVnLTglOyGQ4/MJOkPqXqH/jUizR2Jrwwqfp+wGCFtXZD1pqs9S
         XGGTmvQeGAbpxH+iDO9kY4VP1gBLqEOrmWoAn+xtFp2nOQDJrueDyApHBEIm3A0CGLXm
         Xq1AWEXZ8W/Qsxv83RqAdhHcyBNQ+Hze5By1EXjaPz2xBw69iMFaVVmRVzhqM6P1K1kr
         YvP/773r9Uex2OCTeLzABxc5w7iFpHN34Yih8jlDKSIEx6zbLqw/vSUwA45ZZ6YDvzL6
         hZ8rRHbcP0DhtLlIjSLR4c9mxrgPPAOxRlmYwQPQxl1dlPii0r8QxsV6QSaWP5VMQ9zd
         tcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrIqYBjOEoC2bEbTCnzekyDA0blqp/IM4h4nsnqYLQk=;
        b=lLgf9kxEsXDnVWTpEwH19ObqjUn6xtm07CdNa9/uOqkcc7AMByuQ7tcFSesLhiERkc
         r8YaG5LcdecEBDsjyCuqWIw1qV8CM6rPcnkJJq1w5FY6udw5GYCqDo/buW/APiN1taL3
         B8X7y0GLR/bitbd23UCp6A7f0EhiE+9L5AfppVGj6Z8XmHT4KA+5cSdTDhuDOhpnswBc
         Bf8AP7sbYMECi2J40CUUPiyEghb28EFXXFqlObdHKa3kSroZsW05SgJcXkeABXYz27dk
         e47u+9Df3VRuxzXBkT3OP9OpwH19zXwWLYO+OuouaSQx/WaE2w7gu6AESoNBkjuKKktX
         oWeQ==
X-Gm-Message-State: APjAAAVjbhu21xilf7C4kVDdVmuEtsmCRh7NSB7FGnFDmmcegf2XMrHz
        zosg03AUuwNcxSAGyRpByQnZSKCv2Bl1MGiN8Do=
X-Google-Smtp-Source: APXvYqwduCOXAxDpvIg+uSvC8pVPEHkDcYIa7NUf4UkUZ1qwyIlKwOW6cVVfOJAOWE4Xk9NaAauKgSCdZcYU18uCHVc=
X-Received: by 2002:a5e:8a48:: with SMTP id o8mr9330137iom.287.1566842638954;
 Mon, 26 Aug 2019 11:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190820031952.14804-1-andrew.smirnov@gmail.com> <20190824191148.GD16308@X250.getinternet.no>
In-Reply-To: <20190824191148.GD16308@X250.getinternet.no>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 26 Aug 2019 11:03:47 -0700
Message-ID: <CAHQ1cqGy_Cyw2rdC9hGvvr+2ke+KGy2ZExNfeJL9MW5oH9efTQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Drop redundant I2C properties
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 12:12 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Aug 19, 2019 at 08:19:52PM -0700, Andrey Smirnov wrote:
> > Drop redundant I2C properties that are already specified in
> > vf610-zii-dev.dtsi
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 10 ----------
> >  1 file changed, 10 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> > index 48086c5e8549..e500911ce0a5 100644
> > --- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> > +++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> > @@ -323,11 +323,6 @@
> >  };
> >
> >  &i2c0 {
> > -     clock-frequency = <100000>;
> > -     pinctrl-names = "default";
> > -     pinctrl-0 = <&pinctrl_i2c0>;
>
> pinctrl for i2c0 is not same as what vf610-zii-dev.dtsi has.

The only difference I can see is in pinctrl-names so I am assuming
that's what you mean. Not configuring I2C recovery on Rev B board was
not intentional. I'll update commit log in v2.

Thanks,
Andrey Smirnov
