Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6A0C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552B12184B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fOraWGwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfHEI3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:29:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45358 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfHEI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:29:31 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so165567985ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iLxJtjvXmnF0ClD5rX3LT66tsg88jqzkH20ohifxwQc=;
        b=fOraWGwyfxhB92mLPGjz/00Oak+jbQ+YLpTRbpVWHWcuxwikZZV4Of05k6816R1PkW
         7d0icsS6v/Mr2SltIwhV/Th3NQjkDlur+6GG/CHRMUtl6sN2ZQ0pQO3SsVKBwczn982P
         OkDJlwBXNREB19EESaDahW0RMPwWP6zvVra1NuFR8cH4TofWH0JmbNI79DkY+BGuerhB
         JQU607ENwNbf/K5WagQ2ifbpl6+6+VQ0ZNKrhALxAk0+u4SNh5iP5MTzpZWrKW2JA8Cl
         3DeAG8CwTjr6euCzQSFFABsCahSFE2qIl6SFnCeJd88c6jNJvl4Nwhel7BG+2hoo1oaD
         6bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iLxJtjvXmnF0ClD5rX3LT66tsg88jqzkH20ohifxwQc=;
        b=C1fGOzWCQJ+oE3J/1nyJL8tX5V/+Uejcl6IjhdKO9F1TAKLHPiRrxOUkUEI9Swz908
         RXUUHPqMu1Lebt2K3jRd16vetV45eMVycsD2cfEt/aHmkmiuvqQLTpyJmjlL7+nHALpa
         bTueHkTHTI51zl3HPZ1AtqqbBMmVrv6nWECWtIubeIO4wTe47UPUoJk7kyI/bRKmIAFe
         ByOeoMj7gj3rzV41ZQjOPs3QHj6DDA7kdGTS9sfM5o7vfTDOZ/EsboGl7x9zBXtIjtTF
         8axzQuf6/5KWoh7lN7/LdQjGMmwm11wrhKOji2BymXGaGsWclf+METMW78bh2eVKtc0F
         TiBg==
X-Gm-Message-State: APjAAAWBseOueesUHtRa6Xit5evl1f/DWt05LNGg51Y4bofIrluKR4H9
        YQqA8ixhL4S12cgdkALVcaYIkKQmG0oRbgIuMM5jJQ==
X-Google-Smtp-Source: APXvYqylC6BqYsdA/aIm6a0Duvol+v8+fZeSGpRVX9SM+u0ucmphSUpMjlqG3Pt4pNABoMPLDxbhEMxTtxwJnjkklQs=
X-Received: by 2002:a6b:bc42:: with SMTP id m63mr8748988iof.189.1564993770755;
 Mon, 05 Aug 2019 01:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190722131748.30319-1-brgl@bgdev.pl>
In-Reply-To: <20190722131748.30319-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 5 Aug 2019 10:29:19 +0200
Message-ID: <CAMRc=Mes8dEwscGU8LLQ5CcxmUnhBwt2iP0wk1qNRjRwy8CcFA@mail.gmail.com>
Subject: Re: [RESEND PATCH 00/10] ARM: davinci: use the new clocksource driver
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 22 lip 2019 o 15:17 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Sekhar,
>
> the following patches switch DaVinci to using the new clocksource driver =
which
> is now upstream. They are rebased on top of v5.3-rc1. Additionally the
> following two patches were reverted locally due to a regression in v5.3-r=
c1
> about which the relevant maintainers have been already notified:
>
>   2eef1399a866 modules: fix BUG when load module with rodata=3Dn
>   93651f80dcb6 modules: fix compile error if don't have strict module rwx
>
> Bartosz Golaszewski (10):
>   ARM: davinci: enable the clocksource driver for DT mode
>   ARM: davinci: WARN_ON() if clk_get() fails
>   ARM: davinci: da850: switch to using the clocksource driver
>   ARM: davinci: da830: switch to using the clocksource driver
>   ARM: davinci: move timer definitions to davinci.h
>   ARM: davinci: dm355: switch to using the clocksource driver
>   ARM: davinci: dm365: switch to using the clocksource driver
>   ARM: davinci: dm644x: switch to using the clocksource driver
>   ARM: davinci: dm646x: switch to using the clocksource driver
>   ARM: davinci: remove legacy timer support
>
>  arch/arm/Kconfig                            |   1 +
>  arch/arm/mach-davinci/Makefile              |   3 +-
>  arch/arm/mach-davinci/da830.c               |  45 +--
>  arch/arm/mach-davinci/da850.c               |  50 +--
>  arch/arm/mach-davinci/davinci.h             |   3 +
>  arch/arm/mach-davinci/devices-da8xx.c       |   1 -
>  arch/arm/mach-davinci/devices.c             |  19 -
>  arch/arm/mach-davinci/dm355.c               |  28 +-
>  arch/arm/mach-davinci/dm365.c               |  26 +-
>  arch/arm/mach-davinci/dm644x.c              |  28 +-
>  arch/arm/mach-davinci/dm646x.c              |  28 +-
>  arch/arm/mach-davinci/include/mach/common.h |  17 -
>  arch/arm/mach-davinci/include/mach/time.h   |  35 --
>  arch/arm/mach-davinci/time.c                | 414 --------------------
>  14 files changed, 110 insertions(+), 588 deletions(-)
>  delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
>  delete mode 100644 arch/arm/mach-davinci/time.c
>
> --
> 2.21.0
>

Hi Sekhar,

a gentle ping. Is this series good to go in for v5.4?

Bart
