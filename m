Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC049C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAD12077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksPywcVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfDZOlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:41:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43307 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfDZOla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:41:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id i68so2532127lfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8A/DBMlykBRk9je3MQOquQSyDPGfoAhAV+nIoffZtM=;
        b=ksPywcVtlH/vdqGR51BsuhUYt8Hds1bgcXLbmhWvFrdeW9woc33gg6I7ftIQ2fBO/B
         PcqbU7ZA8YpoL7UItJsk7ECUzY2v8/PmQo/OIZnfgJb5ZNcvkN0YRxIZxHWTQY2xjdpU
         8r8fHq3PiPBgLZASkliV7vGYeKoyQKQmqXqnejOGK0qwUm3VNAnKVWeDf4yHYnqtKyzS
         b7tkOTwrqktNbCo+FoOphA7iCanffBEAgoNBQr2NsvL0CzOJaUOKaH2umVP/dI+gZeui
         ghAAukjTcI3u2192PAYcpfc8wnmHEu0unXbFiQdNzvEEEWnm1YWrcBTyk3GbiIzaFsJA
         CKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8A/DBMlykBRk9je3MQOquQSyDPGfoAhAV+nIoffZtM=;
        b=DxwxQwNQR8VBzP4eAsvKFoNczytXInCs6mUr2vNBK2dfje0dFkinKtztogw95Dh8W/
         atvgkwSooe7eaW1LD9y6b86ik1PyRq/Q1ewh5rwtWmVYilCvJjYlZoGbksZ0RgOOk+iX
         moxBX9ltMqsHewDq1eg/qbdOL640orFEvdw/moIXsL1dGMYksaARQT1MVq+F93N/e1Kd
         xIDL0Qad2hJm6E9v8WkRvkv7U+CpfWoPwjBaXjwp21ACUulK9qLTxwpLhmVc3YFtt/JC
         O4i9s5hXMpGI4vDskgYIRL4uXaFyGHyK3YwddfeoVPxwHKmDQUmU1EdYuzRZV9+j9rVL
         5Yhg==
X-Gm-Message-State: APjAAAU39jbztH4Oj5WTo+VoZPdlBMtru5/pseAHOEJJ3dYSh94gR4SF
        jLrtkpBPCB+BKkgvT3UMOF5gIGNcJJYkKGB7NuIxiw==
X-Google-Smtp-Source: APXvYqweW9MyYNW0TtBxQyE0UhjJb/jB1dhIKzBSGpVZ9YGPZoncfQIF/6gk/qjl0yTH/737Fb862WXpi+VKy351/PI=
X-Received: by 2002:ac2:4a86:: with SMTP id l6mr24093374lfp.51.1556289688388;
 Fri, 26 Apr 2019 07:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190424081802.GV2654@lahna.fi.intel.com> <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com> <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com> <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com> <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com> <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
In-Reply-To: <20190426130615.GT9224@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Apr 2019 16:41:16 +0200
Message-ID: <CACRpkdY=m1QJVqvERiAY+7taUgjPXn=9U2Eajx7d7NPo-iNhiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 3:06 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Apr 24, 2019 at 12:39:35PM +0200, Jan Kiszka wrote:
> > On 24.04.19 12:33, Mika Westerberg wrote:
> > > On Wed, Apr 24, 2019 at 12:19:02PM +0200, Jan Kiszka wrote:
>
> > > > And even if that were possible, we would be back to the square of existing
> > > > devices without those definitions. If this were a recent chipset, I would
> > > > say, "go, fix future firmware versions". But this one is legacy.
> > >
> > > Is it fixing some real issue with these legacy platforms? I mean without
> > > the patch some GPE event is not handled properly? It was not clear to me
> > > from the commit message.
> > >
> >
> > Without that patch, you are forced to poll for event changes in your
> > application, timer-driven. There are application that cannot process these
> > GPIOs because they lack such logic (mraa with node-red-node-intel-gpio is a
> > public example).
>
> Just a side note: MRAA is a hack itself. It abuses almost all interfaces Linux
> kernel provides.

I think it's pretty clean for GPIOs these days. My colleague Manivannan
was part of cleaning it up a while back and since then it is doing
what userspace should be doing if userspace absolutely cannot
abstain from using GPIOs directly (i.e. uses the character device).
https://github.com/intel-iot-devkit/mraa/blob/master/src/gpio/gpio_chardev.c

I don't know about other resources than GPIOs though.

Yours,
Linus Walleij
