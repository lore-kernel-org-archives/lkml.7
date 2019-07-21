Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21758C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 03:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1A3208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 03:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rWZqNizH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfGUDpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 23:45:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:49690 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfGUDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 23:45:39 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6L3jTUn006757;
        Sun, 21 Jul 2019 12:45:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6L3jTUn006757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563680730;
        bh=+i1P1EOzIYuFKSpLhOGGexoKtgfai1r9bg5dNGXa6F0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rWZqNizHxDGhLXiH5RLEM1t/LUAvsgmp8EZk2jKss2AVNYPU4fdHNbMwigsoLYMLs
         UZE0/gzjudBE3rzE/Qh1bAbbpWMWEBhqyxX07k+ibiY0tTJQtkLW5cZ0Drmt9Um1Mi
         +W1GvIBSh8z6IG/egE0QRACea1V6Ej3N06iCH29ThBUqz+5siQ63qPpIm7qQUdBIly
         NaJ1C47+JSnH+6eArNrZ3vK40VJWjRfNyGrrP+SfXCyvkbDp8BYoqSrMQAym9DMf8s
         3Z5FWGq6CI5Pqv2Zwz+2nXV3vKgrK14OVX41zB8MGi8vl8Jmv28l9R5CefDW9rghK+
         Fyh6qQNdBFl2g==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id a186so22376498vsd.7;
        Sat, 20 Jul 2019 20:45:30 -0700 (PDT)
X-Gm-Message-State: APjAAAVUWjvL/brrK+krPala2k4FqbnTWkuFgGUuE7Gg4qzyKBVEE4S9
        klFJGiCZK/xGwdjiLruUFc8Vz2p8k9NRn5ESKjM=
X-Google-Smtp-Source: APXvYqyXn4LIVIGhGfe4GQcWn8jAhDg5lBZ7sWrCxxc9wSyaVu8Ptfm6hbnzjFDumV0Hyo1hL7V34uRrK01YyrMzJ7Y=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr15137391vsd.215.1563680729320;
 Sat, 20 Jul 2019 20:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
 <CAK8P3a2AeUpmNfFLJSvHT=AJ0kFRT2B=TWDm0HsTwoHt2jQ0gQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2AeUpmNfFLJSvHT=AJ0kFRT2B=TWDm0HsTwoHt2jQ0gQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 21 Jul 2019 12:44:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPbCjwzVnAigsQ8tQRXjC31uxgPg3jgi7pwp+N1RPgWw@mail.gmail.com>
Message-ID: <CAK7LNATPbCjwzVnAigsQ8tQRXjC31uxgPg3jgi7pwp+N1RPgWw@mail.gmail.com>
Subject: Re: [Question] orphan platform data header
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Sat, Jul 20, 2019 at 10:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jul 20, 2019 at 5:26 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > masahiro@grover:~/ref/linux$ git grep netxbig_led_platform_data
> > drivers/leds/leds-netxbig.c:                          struct
> > netxbig_led_platform_data *pdata,
> > drivers/leds/leds-netxbig.c:                                 struct
> > netxbig_led_platform_data *pdata)
> > drivers/leds/leds-netxbig.c:                      struct
> > netxbig_led_platform_data *pdata)
> > drivers/leds/leds-netxbig.c:    struct netxbig_led_platform_data
> > *pdata = dev_get_platdata(&pdev->dev);
> > include/linux/platform_data/leds-kirkwood-netxbig.h:struct
> > netxbig_led_platform_data {
> >
> >
> >
> > So, what shall we do?
> >
> > Drop the board-file support? Or, keep it
> > in case somebody is still using their board-files
> > in downstream?
>
> Generally speaking, I'd remove the board file support in another
> case like this, but it's worth looking at when it was last used and by
> what.
>
> For this file, all boards got converted to DT, and the old setup
> code removed in commit ebc278f15759 ("ARM: mvebu: remove static
> LED setup for netxbig boards"), four years ago, so it's a fairly
> easy decision to make it DT only.


Thanks.

I see another case, which is difficult
to make a decision.

For example, drivers/spi/spi-tle62x0.c

This driver supports only board-file, but the board-file
is not found in upstream.

Unless I am terribly missing something,
there is no one who passes tle62x0_pdata
to this driver.

$ git grep tle62x0_pdata
drivers/spi/spi-tle62x0.c:      struct tle62x0_pdata *pdata;
include/linux/spi/tle62x0.h:struct tle62x0_pdata {

But, removing board-file support
makes this driver completely useless...


--
Best Regards
Masahiro Yamada
