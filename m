Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E8DC49ED9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E0C2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zJoyEZrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfIKCil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 22:38:41 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:58148 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKCik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 22:38:40 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x8B2cNmv028566
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:38:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x8B2cNmv028566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568169503;
        bh=kwm81c9IMZEMWqWCh4SEaGMBY3UA4Ym5AXJ3YOtA5+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zJoyEZrIkQ8nChPfD9IJErNDmj/GImnq8qLyL9iZBPFZhmRzWYG8e2ALxm0R0cxuy
         Ea6FqTcl3LoYh24nM6O2QK3Eca701X1esVwQ6QpXHX7tgu++1uyRD+GgHmY3y495QA
         2AF+0eoC4A7noN4djCJw40dW8mybuVhC9vJtQ4io4xjf3NlL7RlaP0JyiqZc2K7cQd
         8rtiFEo6T90LJzbqjXjJg3fbXGHK67JM6i5ENZBASQkXLCSWxm9MFCI0g/GHsYEIrw
         pX0FMQqp6l/nGRyORcd7Tg4KRYzQnMRpf8frmMbjDzBGKojQUqL6lSpQbW5jPuWr5x
         Xc5YDGjQjq2Aw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id g14so7179964vsp.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 19:38:23 -0700 (PDT)
X-Gm-Message-State: APjAAAW1krQMIer4ReQUKQkN6msdOAnki18KCQTDNsoyeBgA9idg2LOC
        ZY1QB1uOB9utt8g+LG0m7vEsNV+rnpasGqpXD8o=
X-Google-Smtp-Source: APXvYqwVMpAGBP9ZGdeflRgNSfdoIpeK9RuiTyzaWElh1Uu6Vn8S2OVwOzzEoLHCiBvcHRI9SAzQptRMW33EuaC6e40=
X-Received: by 2002:a67:dc86:: with SMTP id g6mr12744040vsk.181.1568169502363;
 Tue, 10 Sep 2019 19:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <5143724.5TqzkYX0oI@dabox> <CAK7LNAR8xtURiCoJC0eWLFw0q+78Eb_axoOzWH+JNugf-24Qig@mail.gmail.com>
 <3020870.hsMMj5ogRZ@dabox> <9bb2fb0e-a9e7-c389-f9b7-42367485ff83@kernel.org>
In-Reply-To: <9bb2fb0e-a9e7-c389-f9b7-42367485ff83@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 11 Sep 2019 11:37:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARCPwqY+YmUzsHkABpshzzS3tC=fDgp4vZjVgBwS+LKJw@mail.gmail.com>
Message-ID: <CAK7LNARCPwqY+YmUzsHkABpshzzS3tC=fDgp4vZjVgBwS+LKJw@mail.gmail.com>
Subject: Re: mtd raw nand denali.c broken for Intel/Altera Cyclone V
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Tim Sander <tim@krieglstein.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh,

On Wed, Sep 11, 2019 at 12:22 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>
>
> On 9/10/19 8:48 AM, Tim Sander wrote:
> > Hi
> >
> > I have noticed that my SPF records where not in place after moving the server,
> > so it seems the mail didn't go to the mailing list. Hopefully that's fixed now.
> >
> > Am Dienstag, 10. September 2019, 09:16:37 CEST schrieb Masahiro Yamada:
> >> On Fri, Sep 6, 2019 at 9:39 PM Tim Sander <tim@krieglstein.org> wrote:
> >>> Hi
> >>>
> >>> I have noticed that there multiple breakages piling up for the denali nand
> >>> driver on the Intel/Altera Cyclone V. Unfortunately i had no time to track
> >>> the mainline kernel closely. So the breakage seems to pile up. I am a
> >>> little disapointed that Intel is not on the lookout that the kernel works
> >>> on the chips they are selling. I was really happy about the state of the
> >>> platform before concerning mainline support.
> >>>
> >>> The failure starts with kernel 4.19 or stable kernel release 4.18.19. The
> >>> commit is ba4a1b62a2d742df9e9c607ac53b3bf33496508f.
> >>
> >> Just for clarification, this corresponds to
> >> 0d55c668b218a1db68b5044bce4de74e1bd0f0c8 upstream.
> >>
> >>> The problem here is that
> >>> our platform works with a zero in the SPARE_AREA_SKIP_BYTES register.
> >>
> >> Please clarify the scope of "our platform".
> >> (Only you, or your company, or every individual using this chip?)
> > The company i work for uses this chip as a base for multiple products.
> >
> >> First, SPARE_AREA_SKIP_BYTES is not the property of the hardware.
> >> Rather, it is about the OOB layout, in other words, this parameter
> >> is defined by software.
> >>
> >> For example, U-Boot supports the Denali NAND driver.
> >> The SPARE_AREA_SKIP_BYTES is a user-configurable parameter:
> >> https://github.com/u-boot/u-boot/blob/v2019.10-rc3/drivers/mtd/nand/raw/Kcon
> >> fig#L112
> >>
> >>
> >> Your platform works with a zero in the SPARE_AREA_SKIP_BYTES register
> >> because the NAND chip on the board was initialized with a zero
> >> set to the SPARE_AREA_SKIP_BYTES register.
> >>
> >> If the NAND chip had been initialized with 8
> >> set to the SPARE_AREA_SKIP_BYTES register, it would have
> >> been working with 8 to the SPARE_AREA_SKIP_BYTES.
> >>
> >> The Boot ROM is the only (semi-)software that is unconfigurable by users,
> >> so the value of SPARE_AREA_SKIP_BYTES should be aligned with
> >> the boot ROM.
> >> I recommend you to check the spec of the boot ROM.
> > We boot from NOR flash. That's why i didn't see a problem booting probably.
> >
> >> (The maintainer of the platform, Dihn is CC'ed,
> >> so I hope he will jump in)
> > Yes i hope so too.
> >
>
> I don't have access to a NAND device at the moment. I'll try to find one
> and debug.
>
> Dinh


Dinh,
Do you have answers for the following questions?


- Does the SOCFPGA boot ROM support the NAND boot mode?

- If so, which value does it use for SPARE_AREA_SKIP_BYTES?




-- 
Best Regards
Masahiro Yamada
