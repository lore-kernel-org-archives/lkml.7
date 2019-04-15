Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7516AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C91920675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfDOU7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:59:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37219 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfDOU7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:59:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so20908903qtn.4;
        Mon, 15 Apr 2019 13:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWLI9fj53wRY8kGJAGKGOER5dnhpxv64doRnZ2w70/I=;
        b=VUJFboz+Mnl4OcWMPYW77fLMEUGQ1jhD9vjq3M7Fyb3ajeIKWBTc8jOa3AwMkjEI/O
         hmWAFM0qPcVrTiPOFSANQnjYnF0ocZwDXxFpuCQupvw3F3QcPcqEg5KL6VvgvvGu1aXO
         LGYlLRmag3K/oP4UZw+1GhlfJ9ADGPsu81Ql7PN6+Qvoad+LvmJvSvtUvTfWgO4Zg+sW
         LBBGRVoMrJlJ4xOGIokuigJHajhwXlkXp70MbhwZZaNjNUzEMWxYD4ThMvil0q3BH51H
         Rf35V4IhYUIW/vnMOR78EluiZKNBMcq7aPFYGR/gJq4xfsHs5Wsj+QXoSTuGHbTQGNXa
         5zoA==
X-Gm-Message-State: APjAAAWjFcV90Ng0oO+8x0rs6RhhZE8gwqlLNvnz0QLIgzajqeDPNGhO
        zdMw3dFeRfHoZCNMoFilRXn3Oh4D26axNnizBFU=
X-Google-Smtp-Source: APXvYqy8ZsN8Q6/v0YbvEZ3xmFAf3qHJ3hXfOKmUu93cJ+qOftiqH9CQZI1RSvGFqANGIy0LfQpUI+72e/4yrn99mvg=
X-Received: by 2002:a0c:f68a:: with SMTP id p10mr63318409qvn.126.1555361947405;
 Mon, 15 Apr 2019 13:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190415202501.941196-1-arnd@arndb.de> <20190415205410.GA31583@roeck-us.net>
In-Reply-To: <20190415205410.GA31583@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Apr 2019 22:58:49 +0200
Message-ID: <CAK8P3a1sSt7YVJk6P_0bPYPONqWzNd+3pya265gNOdjr6=abrg@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: ks8695: watchdog: stop using mach/*.h
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Ungerer <gerg@uclinux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        arm-soc <arm@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> >
> >  config KS8695_WATCHDOG
> >       tristate "KS8695 watchdog"
> > -     depends on ARCH_KS8695
> > +     depends on ARCH_KS8695 || COMPILE_TEST
>
> Is __raw_readl / __raw_writel really available for all architectures / platforms ?

I'm fairly sure it is these days, only uml and s390 used to be the
exceptions here, but they both added this.

It's possible that something else is missing, I was hoping for the 0-day
bot to tell me if so.

> > @@ -238,6 +237,11 @@ static struct miscdevice ks8695wdt_miscdev = {
> >  static int ks8695wdt_probe(struct platform_device *pdev)
> >  {
> >       int res;
> > +     struct resource *resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +     tmr_reg = devm_ioremap_resource(&pdev->dev, resource);
>
> Please use devm_platform_ioremap_resource().

Ah, that is the function I was looking for, thanks for the hint.

      Arnd
