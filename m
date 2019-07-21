Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A24C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 09:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47E521872
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 09:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGUJKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 05:10:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43380 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGUJKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 05:10:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id m14so792775qka.10;
        Sun, 21 Jul 2019 02:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbP2X6NIQ0TsX6f4YAaWzUSD+G4Atkgs9bO3GMLpkFo=;
        b=S8YBxnqkUM+kxxvnU5QZpqsAP8ZEEQVh2aL+5/6pYcwPD2TTOvWUQC2BUdbbTKWF2A
         aukBFJjR0yFqDX8C1Io5MA71icVNCoIb01RlJPM7eBasbNbJO7FfqLE4PJ1gr9vwAW0o
         FWlRTd1S9oaPJOQHPJZ1PuqNCJipWWRcXfsxAw8gY/WyCJN0AQ4b3lgAWJW5kjrKlaJn
         GD78X1JSiM+wimy0vEKBx4BxaiZpKtNxr4V/50ERWDwQ9GcmGPoFkWnfIOwpcz4ISwoe
         F4IsIVLOC6RdVbnHLrZO7u5epOIwE7EWOIOBaT089c6JQWlw2iiKpDWo3sRAqYE3gKvF
         2SDw==
X-Gm-Message-State: APjAAAWuJOyPUj0/iovPv3ZKtMH2Wf+DBQwaNai5kMT85g7NaJeIf1L/
        kW2s6Xb2aMQ/6jEmV3yO74VRr+gJVMTz54UDJJ4=
X-Google-Smtp-Source: APXvYqxjHmilE5N9LuNpTfJRWTexnfcMwdOlI/rw0tJewIMNf4YcI56JyWv6tb+DANtn3aJAz06JD3ezoAiIRcMhEcU=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr40996804qka.138.1563700211845;
 Sun, 21 Jul 2019 02:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
 <CAK8P3a2AeUpmNfFLJSvHT=AJ0kFRT2B=TWDm0HsTwoHt2jQ0gQ@mail.gmail.com> <CAK7LNATPbCjwzVnAigsQ8tQRXjC31uxgPg3jgi7pwp+N1RPgWw@mail.gmail.com>
In-Reply-To: <CAK7LNATPbCjwzVnAigsQ8tQRXjC31uxgPg3jgi7pwp+N1RPgWw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Jul 2019 11:09:55 +0200
Message-ID: <CAK8P3a3cURmbGZc-6ESLjrF465VLnBroD4QENyfsSsCrNenRrA@mail.gmail.com>
Subject: Re: [Question] orphan platform data header
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
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

On Sun, Jul 21, 2019 at 5:45 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Sat, Jul 20, 2019 at 10:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Jul 20, 2019 at 5:26 AM Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> > > So, what shall we do?
> > >
> > > Drop the board-file support? Or, keep it
> > > in case somebody is still using their board-files
> > > in downstream?
>>
> > For this file, all boards got converted to DT, and the old setup
> > code removed in commit ebc278f15759 ("ARM: mvebu: remove static
> > LED setup for netxbig boards"), four years ago, so it's a fairly
> > easy decision to make it DT only.
>
> I see another case, which is difficult
> to make a decision.
>
> For example, drivers/spi/spi-tle62x0.c
>
> This driver supports only board-file, but the board-file
> is not found in upstream.
>
> Unless I am terribly missing something,
> there is no one who passes tle62x0_pdata
> to this driver.
>
> $ git grep tle62x0_pdata
> drivers/spi/spi-tle62x0.c:      struct tle62x0_pdata *pdata;
> include/linux/spi/tle62x0.h:struct tle62x0_pdata {
>
> But, removing board-file support
> makes this driver completely useless...

Adding Ben Dooks to Cc.

I suspect this driver is completely obsolete and should be removed.

For some reason, it's not an SPI controller driver like all the other
files in that directory, but implements low-level access to the state
of a particular SPI device.

However, there should not really be a low-level driver for it that
just exports the pins to user space. It should either be a gpiolib
driver to let other drivers talk to the pins, or a high-level driver that
exposes the intended functionality (watchdog, regulator, ...)
to those respective subsystems.

       Arnd
