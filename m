Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175C2C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ED720863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfIIPJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:09:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39789 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfIIPJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:09:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so13380260qki.6;
        Mon, 09 Sep 2019 08:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRd75HfAMA/RM+2IUVcveN8rNVBoGEbq4cpvizDx7NM=;
        b=b43IxwCOSugVQGiMNJ1lDuBpsyM6wNPt+oC0fXNLqhUzBc3syZRR2dy47FKLc6uzTG
         2jKst0dekoCrDj4nYjYrMoR+GjImMPjNgUQv7uaT7optxKeGs3SK4BekV65Il44d+V+V
         niTPDMFIgtX+QEq4B7NVW6zhQbQrpTFaEwHaq35ATmsAcXAaPe7BlXdEvhR2jda+4xiM
         dbnG6e7ts8awB9VCFR67PG4id+QZIvm/WqZPivGpB5lT0apXGBjMtYAS9gOc1alwXxKX
         DjLsDH5uH5xGNxBt41fFhF/VT1EQKidpajFdZ2ADnaZEth4K5zHhrUrVa28nsJwZizP0
         16mQ==
X-Gm-Message-State: APjAAAV9N2qg+HITI1b9x0FI/rZeIj0tmMZiX8A0sxAXReVNkUpMD5si
        fR0CZ+U/VFCfcvei/N1G+HhFUgCQUjPKhK8erVM=
X-Google-Smtp-Source: APXvYqyixTPG+CFUK1hDkQTl3ReqfwNBD/A6zafQDgbntwdHXHwkh+RNO8Na4ISyGRsSqSCfU/vXAgp7FItNdTdN170=
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr3208112qkg.3.1568041746371;
 Mon, 09 Sep 2019 08:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <1568020220-7758-1-git-send-email-talel@amazon.com>
 <1568020220-7758-4-git-send-email-talel@amazon.com> <CAK8P3a0DEMeFWK+RuAdSLyDYduWWwj9DxP_Beipays-d_6ixnA@mail.gmail.com>
 <ab512ced-d989-5c10-a550-2a4723d38e7e@amazon.com> <CAK8P3a34eKFXoAPOfkFN5+H4kxOhRjXgws_0wy+d-186LFxcTw@mail.gmail.com>
 <0d36f94d-596f-0ec7-6951-b097b5ee0d2d@amazon.com>
In-Reply-To: <0d36f94d-596f-0ec7-6951-b097b5ee0d2d@amazon.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Sep 2019 17:08:50 +0200
Message-ID: <CAK8P3a0RUHxcpyUJU5bpd8nqpm0Sqhy4aJaoh7K9jVn8zJC6aQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: alpine: select AL_POS
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        paul.kocialkowski@bootlin.com, mjourdan@baylibre.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        hhhawa@amazon.com, ronenk@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, barakw@amazon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 3:59 PM Shenhar, Talel <talel@amazon.com> wrote:
> On 9/9/2019 4:45 PM, Arnd Bergmann wrote:
>
> Its not that something will get broken. its error event detector for POS
> events which allows seeing bad accesses to registers.
>
> What is the general rule of which configs to put under select and which
> under defconfig?
>
> I was thinking that "general" SoC support is good under select - those
> things that we always want.

I generally want as little as possible to be selected, basically only
things that are required for linking the kernel and booting it without
potentially destroying the hardware.

In particular, I want most drivers to be enabled as loadable modules
if possible. When you have general-purpose distributions support
your platform, there is no need to have this module built-in while
running on a different chip, even if you always want to load the
module when it's running on yours.

> And specific features, e.g. RAID support or features that supported only
> on specific HW shall go under defconfig.
>
> Similar, I see ARCH_LAYERSCAPE selecting EDAC_SUPPORT.

I think this was done to avoid a link failure. It's also possible that this
is a mistake and just did not get caught in review.

       Arnd
