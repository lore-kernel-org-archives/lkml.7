Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BED8C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115D521A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405722AbfIITiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 15:38:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37499 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfIITiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:38:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id g13so17239158qtj.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 12:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83C5cArNTuV93R+PRhbVcq8+PPG/Zw02UW3M6xNCISo=;
        b=aXCYMiXdpFBEt4xKtneB/M7TupsW7edlwMxBPKtlz5U2H8pYnsD1dtIztJ86OXmWv4
         SfXnbpAnmH7YHybW96tUs5yBwIGOjT3P6P+BnrNboGZFhqBDHLoAMw5QRAHp+KrzN1+4
         itEKQMv24dQF/5xzOkMF+cOxF+sR+A7iisK+rzKdhMGp/q95uJuHXINA8g/a/la6sOM6
         /QgemULYbRVuF6rXOt3IchZeGiaVEInMEpKGV3bcz0/9B11+7Z+ws1MurMHj4dcnjHmK
         Lv1VnjJmJuy4C+60RU99t+ZSt3pecT3IacKjcKRb7nlZNAF/heApXJ/TjE+0Z2w8XmuW
         +lKg==
X-Gm-Message-State: APjAAAX4PKzSFqlwqXn/ni+1NLkfJwRVDyH3VHN/9OvVxEDoooqvTlxr
        0xy0oPvJQfNwZdC/v2zJdABDHdQe8w3ZdOqXNUg=
X-Google-Smtp-Source: APXvYqznJr6bft2FiwRFx9J/NlM8tBNYOscDbgcfzeUzZ476EMTWBnkI79bb5QynlE2kwyHibHS1sjNun1Tqhuq/ovY=
X-Received: by 2002:a0c:e0c4:: with SMTP id x4mr15820028qvk.176.1568057902529;
 Mon, 09 Sep 2019 12:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190725131257.6142-1-brgl@bgdev.pl> <20190725131257.6142-5-brgl@bgdev.pl>
 <5fd79cda-59d4-b69b-9902-5d01e1087c62@ti.com>
In-Reply-To: <5fd79cda-59d4-b69b-9902-5d01e1087c62@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Sep 2019 21:38:06 +0200
Message-ID: <CAK8P3a0tCrax_5QvWConV5PF-FjFWusNLfnU73EyjQic+Zm9+Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ARM: davinci: support multiplatform build for ARM v5
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 9:38 AM Sekhar Nori <nsekhar@ti.com> wrote:
>
> On 25/07/19 6:42 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add modifications necessary to make davinci part of the ARM v5
> > multiplatform build.
> >
> > Move the arch-specific configuration out of arch/arm/Kconfig and
> > into mach-davinci/Kconfig. Remove the sub-menu for DaVinci
> > implementations (they'll be visible directly under the system type.
> > Select all necessary options not already selected by ARCH_MULTI_V5.
> > Update davinci_all_defconfig. Explicitly include the mach-specific
> > headers in mach-davinci/Makefile.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Ok, pulled both into arm/soc.

     Arnd
