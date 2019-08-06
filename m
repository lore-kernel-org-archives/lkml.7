Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCFFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A507214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzIMi9FX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHFN1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:27:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40117 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:27:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so84437671qtn.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QepbGpjxdz/Q+6YHfXtoICko0cdKUjwXX4QETCQHWj8=;
        b=bzIMi9FXppLRWZzJ/iI9ZBXddD4PnneBE9NT/UoqebYxXA7CflUoPASr63iMdGtUBG
         Jwrbq1C0xSH9LIN5UdVNoHQCog70zRvlWfB7azMbuC+6Jn+2u15izE38bZomNxKHYJPA
         e8DiwPrQ+XaxM+rGs6hoXZuGMfRItnU+HM0zGMnAj7UUKF0SIAz09R+NnAKrerpSGXvo
         Kk7yVf5KECa3Iu4C3uvBpsJTFTpzygQX5eZxFqN9d+WbjlebcyTfbAy0i1SXHYMSpD4x
         KL3f86a0sMYIS5P9c8H8iy217oBZ4vytmlRRjpGAea0rJ5QL8OH8+CDi3octHWy+DIhO
         biYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QepbGpjxdz/Q+6YHfXtoICko0cdKUjwXX4QETCQHWj8=;
        b=AqgPuJcQEmKAT7k0KRe9moyINcIvuWvHR6GLbHV+BoygEgWnqeS56XpAwgNMqhXiz3
         ZlFhqlTBaBRcsQysAOFDcuwQ2sThxFkcaZyHPnii+qZz2mtSjE5vNJejOwSFQkmXZoMG
         7f6pJz/b3ewbVZ6icmH81lcIrOycb4QVC2SHgWworFTgZ1/O4bFS2OZdz+Qk8t+Pxl1g
         i27RJb7/uXckXR/zrC8kXFP16AEFNc+89U9AuII8P0zQaJiTzV0h8GJviwR6uWOMkiGq
         dFyuuT2saoW+oX0egaTpLiYbD0KZueRi1G6K3RTALnhlIdYCAUQ2/itqfykOUWZvZs43
         1eHA==
X-Gm-Message-State: APjAAAXXdKID9NhHhjv0L6Wwr5fRInLsnaua1iK5QLCMuHAcbvo4r60e
        b/rIA0enhfojpkaBHMqG8m6jAk3MpFDfwjrBCbnQMA==
X-Google-Smtp-Source: APXvYqxjReH9a5RdVKP44/CxV4GA6MJPPJv6EhlnpRpk8YLqn8A8+xTkel+Txw9cXO0QR33NnMHiklTBqawLAq053vE=
X-Received: by 2002:ac8:253d:: with SMTP id 58mr3074770qtm.40.1565098022510;
 Tue, 06 Aug 2019 06:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <1563958245-6321-1-git-send-email-chunfeng.yun@mediatek.com>
 <CACRpkdaBT24JPH_VsKtgp6fjWtVuqM50rXkDVYKmLHgR5hdJzA@mail.gmail.com> <1565077710.23705.21.camel@mhfsdcap03>
In-Reply-To: <1565077710.23705.21.camel@mhfsdcap03>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Aug 2019 15:26:50 +0200
Message-ID: <CACRpkdZ8LjG22QCA0tB+vMi7fPJNBiX-sL1+t0yZqcfRjMJF7Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] add USB GPIO based connection detection driver
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 9:48 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> On Mon, 2019-08-05 at 12:06 +0200, Linus Walleij wrote:
> > On Wed, Jul 24, 2019 at 10:51 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> > But for just "hey I'm plugged in" we can surely keep this
> > ID on GPIO detection in the USB subsystem.
>
> Sorry, you mean provide a common API? could you please describe more
> clearer about your suggestion?

Sorry I am not suggesting anything, this code is fine.

But:

> > I just get a bit insecure about how we should ideally
> > handle these "funny-PHY's".

I am more thinking about which subsystem these things really
belong in. But let's keep it like this for the simple GPIO case.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
