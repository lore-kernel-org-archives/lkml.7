Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51CDC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D4C2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfDHOC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:02:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39837 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:02:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so15484808qte.6;
        Mon, 08 Apr 2019 07:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yuKN26rYg6l+QIW3rEeREcNG5bzTh6MchTpVd+Fy9w=;
        b=NOLpfUSVt45L6UfqBhsOFxPWVq53x6NTbFWwd+XE7IFbXuouAXubM0K6Ow2LPAoy73
         VSQjpFzKQntXUBoSI9FUahKNGMZhHZqyZEzsfcnCQXLh1+nSwIW2GzjJFuBb1gGbT4k4
         UKfacVMoAKxZcNqepQn/l5rnOO06nMNrI7eGY0cgP7qKRVzHYXSDS/uE0qUoZUkZX9pa
         03NjWbEl0Oo2iUJcqws0/gy2tUJRs5SKWaFHQ6t36vWwQQDtE8nKNAewZsIjmEgp8pLn
         akRTHOeX62maYQzK8IYJVrODIpZSykpHDtqJfBzL+Kq25F/reerm07UK5FTTbpmTEVxy
         c+sg==
X-Gm-Message-State: APjAAAXLJ7yR56So+0GtvEGtquP8QhpmaI2aWRqXi9WvaZ+eV5R/TBxY
        gEzeCl9vXt+zMN9SBmpDFX+KvWlWoA17zDEgPHc=
X-Google-Smtp-Source: APXvYqzTA87jgwpL66Wb5dUEQW8CRB0gSz1o58R7QIJssUUEt60fLdlTxutLd/VVNvBDOx5rppp+3WJpkdafnF4mmf8=
X-Received: by 2002:a0c:e014:: with SMTP id j20mr23307167qvk.172.1554732148079;
 Mon, 08 Apr 2019 07:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190407140741.GE7480@piout.net> <20190408085812.db187b4a6f8ffc76d3d5ebdc@ao2.it>
In-Reply-To: <20190408085812.db187b4a6f8ffc76d3d5ebdc@ao2.it>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Apr 2019 16:02:11 +0200
Message-ID: <CAK8P3a0TKUQC7GkYsWrJGFaRsvK5AQjPn74AnkRcPioXUFef-Q@mail.gmail.com>
Subject: Re: Removing pcap? (EZX support in mainline linux)
To:     Antonio Ospite <ao2@ao2.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Harald Welte <laforge@gnumonks.org>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 8:58 AM Antonio Ospite <ao2@ao2.it> wrote:
> On Sun, 7 Apr 2019 16:07:41 +0200
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> adding Robert to CC as he is listed as the current maintainer of
> ARM/EZX SMARTPHONES in the MAINTAINERS file.
>
> > I've had a look at the PCAP RTC driver because I'm removing a few
> > deprecated APIs. While doing so, I've discovered that the driver has
> > never worked properly because PCAP_RTC_TOD_MASK and PCAP_RTC_DAY_MASK
> > are both missing a bit so every day would roll over at 18:12:15 and the
> > whole the date would roll over in 2014.
> >
> > I discussed with Arnd about 59ee93a528b9 ("ARM: pxa: remove irq_to_gpio
> > from ezx-pcap driver") and it seems the whole EZX support has been
> > broken for a while.
> >
>
> As Harald said in another message I tried taking over OpenEZX for a
> while, but eventually lost interest.
>
> JFTR some parts of the project has been backed up here:
> https://gitlab.com/openezx
>
> I should also have a git backup of the wiki somewhere.
>
> > Is it worth fixing the RTC driver or could I remove it?
> >
>
> I am not aware of any active user but I'd leave the final word to
> Robert, IIRC he received some EZX hardware "recently".
>
> FWIW I think EZX code can be removed if it is a maintenance burden for
> anyone.

I would prefer if we could either keep or remove all of the ezx code, but not
just remove a particular driver. Removing it all now would let us skip that
discussion the next time someone has a problem with another device driver
for it.

      Arnd
