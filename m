Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C10C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEF32171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxR+jAXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfCXEPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:15:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35268 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCXEPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:15:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id t13so5042759lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 21:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jer2AZEwQFVlrZwaIELF8+tLIxbA7AKPOFywFxWkr+4=;
        b=yxR+jAXSxUxroOkB3b+QJe5C7v3mno+CD1NUFwUSUMKoPNm1ev+ZaBTjfDu5zt0uLj
         Mq1vS5Jy4cBeuq04e8Sz/dwj0Eq/qFBCtWIeLdds7UJScn2pp12cLAze+SQ++rRdgJJB
         fUONOGzxztve5GKa4vbGj0qJqSrWwH03mobFMWMQeUh7DQu2VWm/EwZxCDMRU1HLARWJ
         vtStJsQPfQddgCEMRI4W1fu9716FBbtDxj8mmY9WQTj3nsZtPCW0mYN+ZD5kyjbsFvTO
         M4dix9LItqfi2UoXZk+YrCz9cCfrE6/2q8OXfMat6Dr04/W8NRozJqrgB9OuXWRkP3Y7
         KtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jer2AZEwQFVlrZwaIELF8+tLIxbA7AKPOFywFxWkr+4=;
        b=fgoYLeeMdj2kwFgm+wgJCfyuzdEh/4P+/SVwTiTAMjiAQPIqk4pporKBcY9Ufl5Uw7
         2pGokV1tTv6YFgoxVlduHjiIHmbOaoq3XpLTx2tJVSfd166eoLSNNxyeBaKNjA7q0XDy
         gYPNa3XV/LyX39eX2NeEm0XfJ45MtrcRaLfNQ0W+TLKnRv+7bqKtXItWiP8iwA2CTmA4
         t1AWK9kxXheKbJAHKZXG6Y0Ji54Ds7abcFlLgRaKvBnDPAHuqu2sjn6XFCf1tnz96Fsg
         GCOErY+aA/bkaACF4kMRecuMYsFkg6EF8qpiA5KtgHOD1L6J2LGpVYRLL7DlUlgmQu90
         jTBQ==
X-Gm-Message-State: APjAAAVjEteubR07MNmJk4EdoHfazlfya0esPKJvKTxG4re2/hpTJ387
        0aADO1cvZ1GQByqmU2bi9HoGuk81TbBE10o9TBdzKQ==
X-Google-Smtp-Source: APXvYqwOOUc6CYdY/J3nH+HPmUc2wEFXNeU1t9CRbbD8EU6xrdA7PkuBQpqgFec0GFUczvgYbWxvDvz+w2PYVqJXjhk=
X-Received: by 2002:a2e:b1c7:: with SMTP id e7mr9120808lja.107.1553400914975;
 Sat, 23 Mar 2019 21:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com> <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
In-Reply-To: <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Mar 2019 05:15:03 +0100
Message-ID: <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip
 select and whitens the GTA04 LCD panel
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Jan Kotas <jank@cadence.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 3:40 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> (1) c1c04cea13dc gpio: of: Fix logic inversion
>
> together with the basic patch
>
> (2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings
>
> leads to a severe regression for our GTA04 board.

Sorry! :(

I found the same problem on my Nomadik board.

But I fixed it in that case by introducing a spi-cs-high into the DTS file:
https://marc.info/?l=linux-arm-kernel&m=155292310015309&w=2

> I learned that it tries to handle a legacy "spi-cs-high" property of SPI slaves, but was stopped
> from doing so by a bug (1). So only with both patches, the legacy handler becomes active which
> explains why it was not noticed earlier.
>
> Now, our GTA04 device tree from 2014 (v3.16-rc1) was already written without any legacy spi properties
> in mind

I'm sorry about that, however if you look at the DT binding document:
Documentation/devicetree/bindings/spi/spi-bus.txt

You will see that spi-cs-high is mandatory. So these DTS files are
incorrect.

> Therefore I would suggest:
> * revert both patches as soon as possible (v5.1-rc series) to remove the unexpected spi legacy
>   code handler from the gpio subsystem.
> * replace all uses of spi-cs-high by correct cs-gpios flags - unless they already are there.
>   fgrep spi-cs-high arch/*/boot/dts/*.dts* shows only a handful of DTS candidates.
> * fix spi-bus.txt documentation to describe this potential pitfall.

This does not work because there are devices that requires spi-cs-high to be
respected and the DTS second cell GPIO flag to be ignored.

Jan Kotas reported this problem.

They might have deployed DTB binaries that need to keep working, so we
cannot change it to ignore spi-cs-high like this. (I might give in if it can be
proven that all of them just recompile the DTS all the time and no
DTBs are in flash.)

I think in this case the oldest binding wins. The spi-cs-high was there before
we came up with the scheme to use the flags cell with GPIO phandles.

I think you simply have to patch these GTA04 DTS files to use
spi-cs-high.

But I'm open to other ideas, let's discuss this.

Yours,
Linus Walleij
