Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC4420833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1yk5MAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfDBESy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:18:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40536 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfDBESx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:18:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id a28so7891510lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtMDkGMm09Zd9QftoRPPyQjOXgtXSLaLkwZTIh8CzO4=;
        b=A1yk5MAwSIbE+MciEVJjhSSeJwbcGBWzxIO1wRWuH+9XoPZXnRT7WV0shp1T4W/NqA
         CPpqmY7Uw7vJ1R8YjPvsnYp7art+utFoKZMH7WbxyhIZK9+kVk9H5vs0og2IV1rQ+shw
         B6IimeFzn23vBT7MNMr4Lkjvn3J4mRPvlZEZHACsuEP+MaCrA/ntszKF668DwbX4Odoz
         LjeWggIDlRiNgCJw6oAtlYSesL9uZsQ2Ku9OTWeUhRyroOtKkukR+Fgucsyyh6iBPOuS
         HxhXRX/ZkslSw2HrByMINcxwBtZU6DhPiyDAhhHdGoPd8cLWMkIryLxF+77FCYEq9ECV
         H5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtMDkGMm09Zd9QftoRPPyQjOXgtXSLaLkwZTIh8CzO4=;
        b=dQmxtDKZX8Q9+D2r1NrJka/lkbeQnvpghOhqUIcCeIaFCZYN/L5kmy4KptFWSyp81V
         dLkrNMiiSOMC9jNmT9F13jJ0YCMP6N5nVA6d8XS3Be3shMff1G0Dpsc2ZjoZefrXA9fG
         /oJyAQZNVhBO4wFO2fVRfcji96x6jDVjTBmqXgQQ634gLttQMS81btvHk0MDGGhmgbRu
         JSQn1dkbIaTIWqciQ1c6LClI5lSZxbiNz88E7oqGaCm8362LJiQqWxGljq1vTp8yj+0s
         LJmx9+dIHEXCEsSTqEYEGipbVYLlT+2AuJ8qPpfePsoRk0ikA3ZQffZSlekLfLIDxWQN
         f6Xg==
X-Gm-Message-State: APjAAAXI2DgwA+521dXJ0ZeYIscy5Qsw6K9i53PECvHvlcM/rYEVvLtO
        18wQSIrs+1aK/ceuythhZ7puGmfGcwKYrSe5hABxjA==
X-Google-Smtp-Source: APXvYqygNvWO0xCUkgYXNg19hOQAWJw5CyXnER+D6vVY2brKaVHAIvvKESDhdEaB2jUlSZmOIE5Hhw4erTinwvjJeKs=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr7875318lfh.103.1554178731707;
 Mon, 01 Apr 2019 21:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
 <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
 <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com> <20190330193259.5054655e@aktux>
In-Reply-To: <20190330193259.5054655e@aktux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 11:18:39 +0700
Message-ID: <CACRpkdaqz+_j_n0kuduGqOb38W6ETyOzUgaiZVX3CQWXN2_zbQ@mail.gmail.com>
Subject: Re: [Letux-kernel] [BUG] gpiolib: spi chip select legacy support
 breaks modern chip select and whitens the GTA04 LCD panel
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Jan Kotas <jank@cadence.com>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 1:33 AM Andreas Kemnade <andreas@kemnade.info> wrote:

> > > But I fixed it in that case by introducing a spi-cs-high into the DTS file:
> > > https://marc.info/?l=linux-arm-kernel&m=155292310015309&w=2
> >
> > Yes, that of course works and is our temporary solution.
> >
> > And I see that you also have it on the controller node and not the slave node.
> >
> So if I get it right is a check added for undocumented properties
> (nothing about  spi-cs-high  in controller node in the bindings
> documentation, only in the slave node) in the two patches mentioned.
>
> And then you add that undocumented property to a dts file in your "fix".
>
> That all sounds strange to me.

Yeah it sounds strange because it is strange :)

I was simply confused and wrong. Sometimes we all do very uniformed
things, today it was me.

The flag should of course be on the slave node.

So now I have to fix my fix.

Yours,
Linus Walleij
