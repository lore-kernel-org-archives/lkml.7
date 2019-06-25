Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A778C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547E9213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD0m+cdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfFYN53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:57:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41837 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFYN53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:57:29 -0400
Received: by mail-lf1-f65.google.com with SMTP id 136so12712390lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTW1RTzufVVCLIfnh+7h6hW+A8p2OrQGWdWYeH+4NGc=;
        b=rD0m+cdPPd//2jtOKnRrGA+yNzIqtS2OrqhFqNvI9BwnBTByDXePb2d3VmLU2Jsp2b
         Oydu3kFeAuwXsLOTos5YOl2x5uYhXgslRKqRtNLsVCKqeXMHqkFg2ymZljatvVr6VYlA
         O0tiN6MFwgHkc8Q/ZYT/7xhM6QsmCfMQ8+TvCfARZfEtL92HD+7UYauRjumeafw5xCsk
         BZExa7hD1Zs1iEwk2uLNjmROHkuq7YMAp1FA+V8VgxqVdo+xk38mlwJEz72Xnk7ppxBr
         +0cinfadSpALzcrTBdhVj0HVufS77V7TugkgzF4l2XAZenupQ1QYRRNAyk/hiuknm6eP
         3NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTW1RTzufVVCLIfnh+7h6hW+A8p2OrQGWdWYeH+4NGc=;
        b=Ck6dLDv/R+Il7flM2ERltSoWxGI1cnEjsULu1VVbilp85eL+ZLn99QfdmGiWErZQJy
         HWO+2ChRmzUD4Ee+ieirSFXC0XmUidNEJmyUbujInYSqPHNCmFEe75MhqBR0G3GjzPH0
         zVUdsBNrxBEJIamf4Z43HKN8ary3B26cu614lssz1Z5CWpntqMj6mBtaWCfiETpBcEdk
         OOl/2/nlgtgGCPWMegntBUexBk5CY42EPM7nFl2ZVwnr/+sRwu2TNoWPbReEFRIuutZQ
         Vow0Vr4s1ft1wOPD97/ti3pno0NqsrVvDh2XJZU9pkznMEJ7GzUTwJ4YuwmZSmrmjA6Q
         hqmw==
X-Gm-Message-State: APjAAAVvPK0z+NbGsWtkuam2bg3bPzUHghwTW3ynBcf8oNfzvGhxLx7h
        uEpCAe8C354nkNG7c3FZKoZ+1/eDeYaEhdoKxCsw7g==
X-Google-Smtp-Source: APXvYqwtMnHq1yBBhWHpEFgSyvvNlRPOWrNyzfQxiPn5jAkCYYNbYam/5KODrrng0KafhfQTzullbXmVYSc52G3PQ3I=
X-Received: by 2002:a19:7616:: with SMTP id c22mr25238102lff.115.1561471047372;
 Tue, 25 Jun 2019 06:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190623043801.14040-1-icenowy@aosc.io> <20190623043801.14040-2-icenowy@aosc.io>
 <20190624124019.o6acnnkjikekshl5@flea>
In-Reply-To: <20190624124019.o6acnnkjikekshl5@flea>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 15:57:15 +0200
Message-ID: <CACRpkdaQSg4qWWF1XurWA8wnW+ezGtTympVT9DvkF87VKEQVzw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] pinctrl: sunxi: v3s: introduce support for V3
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 2:40 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Sun, Jun 23, 2019 at 12:37:53PM +0800, Icenowy Zheng wrote:
> > Introduce the GPIO pins that is only available on V3 (not on V3s) to the
> > V3s pinctrl driver.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > Changes in v3:
> > - Fixed code alignment.
> > - Fixed LVDS function number.

> > -               SUNXI_FUNCTION(0x2, "uart2"),         /* TX */
> > -               SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),  /* PB_EINT0 */
> > +               SUNXI_FUNCTION(0x2, "uart2"),                 /* TX */
> > +               SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),          /* PB_EINT0 */
>
> I'm not sure why all that churn is needed.
>
> Looks good otherwise.

Should I apply the patch or wait for a new version without the
whitespace fixes?

Yours,
Linus Walleij
