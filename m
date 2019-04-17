Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560BC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B2A217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbfDQPNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:13:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40006 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:13:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id x12so27726883qts.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPpDyR1TImNVNYqF2q/3qy/OcFmkJj7RZ7WPFQFYJQU=;
        b=qTENOQ7ob+pRO3UqkjtIY2AsdIsSUMnCUNL3ds/JgOz5Ix5o5O7dD2U7LYZbqfvIqd
         pyKLnmcoGDjTFzdet7DUs630P1kyk+Q6brGs9m9QASx8gMbjIBTG17xBPP8CNIpQfzFa
         lbnynJWpBJgayGd5S0scS4W512dJrOlKL/YqdXzQ+OcKgyZnuF1yjeazfypIC9VGq6hc
         zUK7B2s5gOmA/mAds9abc8staAVmy3V1pBQAKVnf0bSsRiY6uvy3BvwN7CC5iZG9pnwn
         R5aRQq6wOMqnZtd/WeZIJQHwAUraErP1aqcNEMwUjuujuKS0DwWbyqMYSH2ItTo+ODzi
         vJQQ==
X-Gm-Message-State: APjAAAXrdWxAWwMwOFgYBnNEWF7O8hwBOhOA+VnpeV/8N2cBXr+K995X
        Wh35r8rAI1sr4YIcYXJjI/IzhashU1hvgiX/v6Y=
X-Google-Smtp-Source: APXvYqycDvLWOGIsMmS2vi+5bJOVEZO0ea+VJfmhcnJd4YrAOOFl2e31U9asJg30QlE5/qw3HwsMIfbDdH2AD55hfI8=
X-Received: by 2002:ac8:1637:: with SMTP id p52mr69278530qtj.212.1555514002111;
 Wed, 17 Apr 2019 08:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190417125153.2510262-1-arnd@arndb.de> <87zhoohg0v.fsf@tarshish>
In-Reply-To: <87zhoohg0v.fsf@tarshish>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Apr 2019 17:13:05 +0200
Message-ID: <CAK8P3a3U4vOxZCTsND3i=vSYE_kKStX5qW9bnfwZ7i09Y8nCDg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: debug-ll: add default address for digicolor
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     arm-soc <arm@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 4:18 PM Baruch Siach <baruch@tkos.co.il> wrote:
> On Wed, Apr 17 2019, Arnd Bergmann wrote:

> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 6d6e0330930b..12c0d29b75e3 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -1677,6 +1677,7 @@ config DEBUG_UART_PHYS
> >       default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
> >       default 0xe8008000 if DEBUG_R7S72100_SCIF2
> >       default 0xf0000be0 if ARCH_EBSA110
> > +     default 0xf0100000 if DEBUG_DIGICOLOR_UA0
>
> Should be 0xf0000000 for the physical address.
>
> >       default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
> >       default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
> >       default 0xf7fc9000 if DEBUG_BERLIN_UART
> > @@ -1784,6 +1785,7 @@ config DEBUG_UART_VIRT
> >       default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
> >       default 0xfd883000 if DEBUG_ALPINE_UART0
> >       default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
> > +     default 0xfe000000 if DEBUG_DIGICOLOR_UA0
>
> Maybe you intended to change the virtual address to 0xf0100000?

Ouch, sorry for messing it up again. Sending a v3 now.

       Arnd
