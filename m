Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB69C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE1721537
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIYNzCRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfDZRos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:44:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35909 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfDZRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:44:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id w20so1286656plq.3;
        Fri, 26 Apr 2019 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+wz9yZx1wmA45aHBRwLyUV3wvKIM+8HiQVPMF85bPk=;
        b=dIYNzCRyyhHPrQ8H3Y5kRm4rDmU0W57ABKzAjjhkKAJDaMzixFzrU0AbBCrYEBrD1j
         IOYW+sXwFNryVTzuBHJ0LB6zY/tEuyWqq+e6uWSWFdhPFk6wshqGoATEOu+aUT4WItTr
         IUO/nE87fAS0PKrJZm+O5F+dk/gqxpqmZrxaiN+c2ZjoeH4jCkVmPTEc7yn4bT3tXzMe
         dnsolcrFeXZFnbxuY7EZeMYJ1Fcg4Ru1DaOqJfPtWoC88TYtQW/t9299QGl0fFMWKuoV
         TMOlUp/ZXhGqwT2MOctWqh7wV4E0Gwr4Rrdbj7M8AY/j1IdH6pChlr7qwm7uNJu15lyG
         1+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+wz9yZx1wmA45aHBRwLyUV3wvKIM+8HiQVPMF85bPk=;
        b=ac4H9T6BFDnLiBlyoPIQCdTxBDu5w/nNRWLRoex098Jg7fGJy700l/B41+YJw1nPz1
         9hHOmbnjBK4Pt6ZJ56GqTjDF9WXl3LpZlsZQzAQNRqftYyksr+aVhF5/ruWFUOjxM2BB
         bHzRHRg+8HucumtjEg/tZlT01tCIMEya8iHzsmGUR1mhJEtG+OlGQpRPE57OF8ctz/KO
         a2ppjTz2NBIhX9UTo3ht4pXnlotFoWsykocAmnrW9q/K/X/7wU4K3XfQOGfWy2Z9tObY
         AVuWeyFlJYm+oEsw3hd1YaeePf1SOo4bz5FDqCgYkPVzICJVH4S83/d3fvOuoS2Sw5r/
         TG9A==
X-Gm-Message-State: APjAAAX6jkrp2H2SRgpaU2A6E0H5ZYI59pQiKuvSA6TVWJKRqYvu7rzw
        XwI3xe0j0dZfXCOEYWVVfPbBmxDIMMg9EZT+u6GSmGZmcTk=
X-Google-Smtp-Source: APXvYqy5F7P/HIH5GG6ubF+EEpkTWCk5Kut5C9lU/7u4EIARhhMAow1YZLV2r3r1oyTnt/veElK4KEnPvlw1RZEeyow=
X-Received: by 2002:a17:902:758b:: with SMTP id j11mr10110791pll.87.1556300687807;
 Fri, 26 Apr 2019 10:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com> <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com> <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com> <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net> <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com> <20190426173329.GA31161@Mani-XPS-13-9360>
In-Reply-To: <20190426173329.GA31161@Mani-XPS-13-9360>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Apr 2019 20:44:36 +0300
Message-ID: <CAHp75VdcS_LaKNhaKsFaWa9ReQw4KRDRpc-81kv0Hb9wbZFCTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Fri, Apr 26, 2019 at 8:33 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Fri, Apr 26, 2019 at 08:20:19PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > > On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
> > > > On 26.04.19 15:36, Jan Kiszka wrote:

> > The problem here is opaque number. This has to be chip + *relative* pin number/
> > See this:
> > https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640
> >
>
> But for platform like 96Boards we don't need controller specific lookup, these
> are all handled by the platform code [1] so that the users can use the standard
> pinout number to access GPIOs.

This is a complete mistake.

There is *no* global GPIO numbers anymore in Linux. (I don't count
very old legacy platforms)
Read above, it applies to DT or whatever resource provider.

> For instance, pin 23 on the Low Speed expansion
> header is the GPIO for all 96Boards platform, so the user can access that pin
> using 23 itself in the application and it will run across all supported
> 96Boards.
>
> That's one of the reason why we prefer MRAA.

> [1] https://github.com/intel-iot-devkit/mraa/blob/master/src/arm/96boards.c#L75

-- 
With Best Regards,
Andy Shevchenko
