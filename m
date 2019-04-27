Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1C3C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574C4206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="D3P0EVus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfD0TrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:47:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35561 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:47:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id g24so885389otq.2;
        Sat, 27 Apr 2019 12:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnC9wW8bLhTgixXJHjwZfaafnkCtCkiIzI7KsiKrQ5g=;
        b=D3P0EVusslkqOu2NxAHkYAjshY5hTyCsXDxygXfOKRUwg9oGXA9SpbdvUANyO7+A6e
         4WbOzfIghxTsXTkfaGFuEhJRQWK8StNHaMtXGwOOziyiVlDMDnC+BCBlUPsdYXMFuuv7
         0BxevVxisEtSP5kdjc4P+fdZlCE5F6RmBnq9avDodG7/4L841sr2Zra98f1lOeIZ0UuI
         kbk2Xm3BTXk0M03JPyCrz6Bjtb+/7EP09gjJKWlJkfxop9Rf6XZa5ACmKVUr2uZPbEvx
         0udsy2MDNyyT0TIELI73nOHI54xANTTLl0Rs1sg9HT1xKoSOjcI5zigDxFsX1Ki9Ium/
         BTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnC9wW8bLhTgixXJHjwZfaafnkCtCkiIzI7KsiKrQ5g=;
        b=h0/Q56aEsZjFwY+m4lfs0JS6P9MfXY2dUMyamiNBXPQypojXDOyijzRSuCUorTHUS8
         XeEOw2sg8SS0dx89tuGZAje7k7N5IrLYjg4sb5x7HhBkDzBYFrppeUOGgwl+pOgJo5A2
         7qFA+2kK+u72mUN25WcJ4FYmRQLCsRRe7ChZEVNYK6cXJlW9QgycrdMzXLSbz+eezchn
         I7yhS1yiC6+J6ubXgL8jIR8DTZfL4Iz77VeDuAtL4lzDlyPGIbuCh0RFpqTRVLPpmAjr
         a4Tl1/mZ7ZEHmP0GYzke52OIt6FhcmLzfysADKZGnFGnWeZvdsK/CcpCF15A+XXK6i7W
         Xz1A==
X-Gm-Message-State: APjAAAW3SwWBTtkMWrDCN9XDrG8GJNdyYERWTWZUhThGw5NHDCYuwQKQ
        cKgC5OBK4Q0ueGZqLqaUq/C9K+IzhGPlKgxI5co=
X-Google-Smtp-Source: APXvYqzOCr6ZHZAvIYQ7cLYYckNGZXqEF3l4GCGyyPjKCt9lTVzG3xpx2kfc+9mooMdLyCzRekYktfZdUHMN6/jQy3k=
X-Received: by 2002:a9d:3db4:: with SMTP id l49mr32819522otc.131.1556394420732;
 Sat, 27 Apr 2019 12:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190418124758.24022-1-glaroque@baylibre.com> <CACRpkdbLJYgU5ZP5CkwX1FBv8eHp+7TsAMv3_H51C_EOA85X4A@mail.gmail.com>
In-Reply-To: <CACRpkdbLJYgU5ZP5CkwX1FBv8eHp+7TsAMv3_H51C_EOA85X4A@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 21:46:50 +0200
Message-ID: <CAFBinCCgGbvN6nLywsGk3TXT7eDLD=2A=uD_W07QumyBJSCAuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add drive-strength in Meson pinctrl driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Apr 23, 2019 at 1:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Apr 18, 2019 at 2:48 PM Guillaume La Roque
> <glaroque@baylibre.com> wrote:
>
> > The purpose of this patchset is to add drive-strength support in meson pinconf
> > driver. This is a new feature that was added on the g12a. It is critical for us
> > to support this since many functions are failing with default pad drive-strength.
> >
> > The value achievable by the SoC are 0.5mA, 2.5mA, 3mA and 4mA and the DT property
> > 'drive-strength' is expressed in mA.
> > So this patch add another generic property "drive-strength-uA". The change to do so
> > would be minimal and could be benefit to other platforms later on.
> >
> > Cheers
> > Guillaume
>
> This needs to be reviewed by Martin Blumenstigl, Martin can you have a look
> at this patch set? If you don't have the patches I think Guillaume can
> resend them.
thank you for the reminder - I just sent my feedback.
can you please also have a look at patch 4/4? there are two cases
where I'm not sure what the best practice of the pinctrl subsystem is


Regards
Martin
