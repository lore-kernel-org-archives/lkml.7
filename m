Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D56C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6425B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BUP5OmRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfHHHlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:41:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39587 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbfHHHlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:41:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so108941655otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IngtmsHwu9gnFB43lssfDLWSkL176YIsJ9vKXeaVWC4=;
        b=BUP5OmRS+yTdCFOhHeQyg7Sm7K9gB9rfyd5jTP6G/6XEqK+QpDhLUbQGGqIiWUjkQX
         hY6Z5hbPGS2gwfs54RpC8YU4cXLO6SG1UGpmq1lBsSRYtBSDo9m67IWAiKOC8J3bBFkk
         9dpTi2s8dsrFYaIXsvI9CcCa3MLuk27JUDq/HdkQXRXyXOZZVp3NHbXkM2PHTG5LmXk6
         nVohO90P8uIDZ1TjttsqWl7rIL+Ym9JT0+tbhOQNAge9qJG8a5uY/lanKszjDXU6kQBj
         /I9x9sHKy7Ql4ZMZexEWa0cfle42FpVPeOIyVIE6RYjlsHHKSQhJJG66UDMdTbBKLnKs
         7o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IngtmsHwu9gnFB43lssfDLWSkL176YIsJ9vKXeaVWC4=;
        b=W0ksNQ7nTO3xcb6mp2g+Yzk7/u+friAhdWWctmGjSq//GL7fXp+icCloHoPL32p6SC
         ItN2t7AJpCPwv1A2fLw85leIxh8NDNGjtW/fcum0E0G9Kj3pn5pgQoXbV96tPoEgIozT
         KIBSEzEF7VUIE7AQ3NJiMmJcAYbZv8RY28e3qw+vVGon9fYVuxojPA2df7wBzbzNYIVO
         lCVroV8m5EKnZ22CivKvgAfyvW+1n/XV4PMCcWjU27meEEWgN1zpMabaCLuHmWajyefJ
         hxVlfqgFrsG0KyK6IsTWRxPMRk5sz3X1IcurJGpgG7dJfz2/N9wnQfE5QV1MunpNTBbX
         Ri1A==
X-Gm-Message-State: APjAAAUaa4nQofeecp273qlxkjWgF48lERI98PMTmBtS+of4+iTGHqLe
        LTnp9LbItS5NgRzo+OZm/cRSlxzvdkxFCX93vZxldHxn
X-Google-Smtp-Source: APXvYqzEP4UJJeVOwojRyt4X8cuuhbcAnFAAQObvIlCAtYm5szbosS6hphi792ozs++3WLH8oxk/9jRqQzS+kzLLcic=
X-Received: by 2002:a5e:8a48:: with SMTP id o8mr4781623iom.287.1565250082034;
 Thu, 08 Aug 2019 00:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190722131748.30319-1-brgl@bgdev.pl> <CAMRc=Mes8dEwscGU8LLQ5CcxmUnhBwt2iP0wk1qNRjRwy8CcFA@mail.gmail.com>
 <9e5704a3-8169-1575-4027-61d36c5e39b4@ti.com>
In-Reply-To: <9e5704a3-8169-1575-4027-61d36c5e39b4@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 8 Aug 2019 09:41:11 +0200
Message-ID: <CAMRc=MeTgNf5Xsv6dSY0LJbsAOuoHcfB-x1riMwQkWtVc7wddQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 00/10] ARM: davinci: use the new clocksource driver
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 7 sie 2019 o 21:28 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 05/08/19 1:59 PM, Bartosz Golaszewski wrote:
> > pon., 22 lip 2019 o 15:17 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
> >>
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> Sekhar,
> >>
> >> the following patches switch DaVinci to using the new clocksource driv=
er which
> >> is now upstream. They are rebased on top of v5.3-rc1. Additionally the
> >> following two patches were reverted locally due to a regression in v5.=
3-rc1
> >> about which the relevant maintainers have been already notified:
> >>
> >>   2eef1399a866 modules: fix BUG when load module with rodata=3Dn
> >>   93651f80dcb6 modules: fix compile error if don't have strict module =
rwx
> >>
> >> Bartosz Golaszewski (10):
> >>   ARM: davinci: enable the clocksource driver for DT mode
> >>   ARM: davinci: WARN_ON() if clk_get() fails
> >>   ARM: davinci: da850: switch to using the clocksource driver
> >>   ARM: davinci: da830: switch to using the clocksource driver
> >>   ARM: davinci: move timer definitions to davinci.h
> >>   ARM: davinci: dm355: switch to using the clocksource driver
> >>   ARM: davinci: dm365: switch to using the clocksource driver
> >>   ARM: davinci: dm644x: switch to using the clocksource driver
> >>   ARM: davinci: dm646x: switch to using the clocksource driver
> >>   ARM: davinci: remove legacy timer support
> >>
> >>  arch/arm/Kconfig                            |   1 +
> >>  arch/arm/mach-davinci/Makefile              |   3 +-
> >>  arch/arm/mach-davinci/da830.c               |  45 +--
> >>  arch/arm/mach-davinci/da850.c               |  50 +--
> >>  arch/arm/mach-davinci/davinci.h             |   3 +
> >>  arch/arm/mach-davinci/devices-da8xx.c       |   1 -
> >>  arch/arm/mach-davinci/devices.c             |  19 -
> >>  arch/arm/mach-davinci/dm355.c               |  28 +-
> >>  arch/arm/mach-davinci/dm365.c               |  26 +-
> >>  arch/arm/mach-davinci/dm644x.c              |  28 +-
> >>  arch/arm/mach-davinci/dm646x.c              |  28 +-
> >>  arch/arm/mach-davinci/include/mach/common.h |  17 -
> >>  arch/arm/mach-davinci/include/mach/time.h   |  35 --
> >>  arch/arm/mach-davinci/time.c                | 414 -------------------=
-
> >>  14 files changed, 110 insertions(+), 588 deletions(-)
> >>  delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
> >>  delete mode 100644 arch/arm/mach-davinci/time.c
> >>
> >> --
> >> 2.21.0
> >>
> >
> > Hi Sekhar,
> >
> > a gentle ping. Is this series good to go in for v5.4?
>
> Hi Bartosz, a quick test shows that DM365 fails to boot after this. Can
> you please see if there is anything obviously wrong for that SoC. Rest
> seems to be okay.
>
> Thanks,
> Sekhar

Hi Sekhar,

just verified on Kevin's dm365-evm rebased on top of v5.3-rc3 and it
boots fine. I know that davinci failed to boot at v5.3-rc1.

Let me know if I can help with debugging.

Bart
