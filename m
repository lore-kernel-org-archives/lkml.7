Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF8BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726412177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfDQMul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:50:41 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32912 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbfDQMuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:50:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so14236468qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 05:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMeVsFrgR5TEBv9Vb0bGwhd7cTIny/CqvL30XSr7i54=;
        b=hgTGgvJ8HLos3Nzjcj7BZrqG/kf9jk9/RNvSupqzYhaz978jXjlIhYz+cYHvrJb4Rh
         FjKtmr1kxfS4wngVJRNmxetmon90KXoHYaODo5oe7xzPrwJoUP9pcHSMrmslhcdDnIxA
         MgaSffVkVGj8hdDrbQcEBjG36DZFkE0kPI0Nfu3GkHmGncXPXcXbggIBvOHX9ugIH7ct
         B0aGt6o8uvvaLcBHuTqf9OVXkWZh3RRL9DN541TA47dP4vnz/0VOdZk9sl3ftCXqLpSp
         UO4Twc3LFkn3iOukSZ8jLWjl20gIdOLmVEMZsMI3FeDIbQvFvLpsSbQ0W256eofLgW6K
         QXBA==
X-Gm-Message-State: APjAAAUbaRukM/+wJe+R5tRIe0aHdhE2HttMIuUyI4LxdvIRiOvJa08Z
        aBbzRsPiw6qKudkJLMDUggG6Fm/oUxLmUbHlkCN0KP2x
X-Google-Smtp-Source: APXvYqz5p3SremLfTfHxzGFDwRUcoEzi6lmU77Gs1LNPtLgI1g0Si+cA2zlcma6yOtlqz9WdWVHLbJo+toRpD7bBndI=
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr69282752qkj.6.1555505439497;
 Wed, 17 Apr 2019 05:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190416131746.1303495-1-arnd@arndb.de> <20190417041250.nbqy2ltjw77wlnts@tarshish>
In-Reply-To: <20190417041250.nbqy2ltjw77wlnts@tarshish>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Apr 2019 14:50:22 +0200
Message-ID: <CAK8P3a36NGB3V6Feve5PdhyEHuh+g0FOHqttu149V2ApwWp3=w@mail.gmail.com>
Subject: Re: [PATCH] ARM: debug-ll: add default address for digicolor
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 6:12 AM Baruch Siach <baruch@tkos.co.il> wrote:
> On Tue, Apr 16, 2019 at 03:17:30PM +0200, Arnd Bergmann wrote:
> > The digicolor platform has three UARTs, but the Kconfig.debug
> > file explicitly lists port zero as the one to be used for the
> > console, while not providing any default values.
> >
> > This can get an automated randconfig build stuck in a loop
> > waiting for the user to input the number. As we already know
> > the physical address, this patch provides that number as
> > default, along with a reasonable default value for the virtual
> > address.
> >
> > Cc: Baruch Siach <baruch@tkos.co.il>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/Kconfig.debug | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index a8a1e14f20ab..e5f0b36d797f 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -1676,6 +1676,7 @@ config DEBUG_UART_PHYS
> >       default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
> >       default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
> >       default 0xe8008000 if DEBUG_R7S72100_SCIF2
> > +     default 0xf0000740 if DEBUG_DIGICOLOR_UA0
>
> The addruart macro in arch/arm/include/debug/digicolor.S adds the 0x740 offset.
> So CONFIG_DEBUG_UART_PHYS should be 0xf0000000.

Ok, fixed.

> >       default 0xf0000be0 if ARCH_EBSA110
> >       default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
> >       default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
> > @@ -1785,6 +1786,7 @@ config DEBUG_UART_VIRT
> >       default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
> >       default 0xfd883000 if DEBUG_ALPINE_UART0
> >       default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
> > +     default 0xfe000740 if DEBUG_DIGICOLOR_UA0
>
> The value I used when testing used to be 0xf0100000.

Ok, using that now. It shouldn't matter either way here, we only care
about that there is nothing else at that address.

     Arnd
