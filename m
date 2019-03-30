Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74686C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462D5217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1mN4wYb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfC3RIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:08:19 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:37796 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfC3RIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:08:19 -0400
Received: by mail-it1-f173.google.com with SMTP id u65so8916348itc.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LEFjJDlvsvwrbBTsR22rj7/EumjW2Lrd/84GK15bvmM=;
        b=1mN4wYb9Y1Rfk2qJRPwoqM+om/Z4U28Jl5ksMydZi934cSqLPJmoAaryI4TKTN3Fka
         57cdDGOLKvH8GgFrGvOPE/9ybWSrJ6wybffSvi6ruvpZdbwx4VRfFlFTpTClde+FYEpv
         GzkpLjF9MDLtyxtBcaQTCSEFkxQGrl3qsHH+r6kJhfg3vdqlbQBKmSVrtqIMWo3NVNxd
         FJoY+xUs8Nj9lSl9Qy1iN1qL1MVJkoCvDU+iltBQvfAkIK27cSC9Dyjfkv0Yoj4wPR1Z
         Ro3nGkzJNgd1m6DyaFteKDafjtXQ+cyaYJoJASMZBexd3+Yn/bQiuiQALCv7Yc+lsCsl
         B1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LEFjJDlvsvwrbBTsR22rj7/EumjW2Lrd/84GK15bvmM=;
        b=REKjJo/G6VWFROBnQQaUdKYHLG6x4cRzA5iUztIj6PL6APZMDWBVkxODRrIGyMVgY5
         S1KYT2A+nREVN2ziNiP1CWuRPFXoOgfD4SJeuNMV/z8EjTwrank1/gfJD/VUUBOQWw/N
         4ooIB3SzS7STvmtZGkUDtv2h/2E8HRazRjpXeBa1t37j3s1ak46eoMVKlG36TVYnsELS
         cR6ZYI+A5yp3ggKuzjMAWtcIHkebbxd2AtgOPrIRbvMPh0KLwl8PeaQ8TdKSSnCrzaMS
         zhUiQz8vYq9M2W2+NwdN57zkAVzVuOHyNfuR9XBZ2oMUCbtwIRcuRzXXLs/AUnqB/grH
         3FLQ==
X-Gm-Message-State: APjAAAXUGxoQruLhKIkt2v/keqQQY3erxoS5T4rkk2o+aQe/LZtdsUKb
        /7tYD5fM2ZCjwDb0HXNjSXHGCCw4Iy37EsU81BFKVA==
X-Google-Smtp-Source: APXvYqy28U+2NahzFS5U2xtNacw5mL0xmgqaMdlVMP7GJwbZAN7NmxRs0y9bA/9tCoMEAo9q0UVz015/d/42hwdUmyw=
X-Received: by 2002:a24:4d85:: with SMTP id l127mr2926460itb.53.1553965698262;
 Sat, 30 Mar 2019 10:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190329093334.3885-2-brgl@bgdev.pl> <20190330134525.0C68A218AC@mail.kernel.org>
In-Reply-To: <20190330134525.0C68A218AC@mail.kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 30 Mar 2019 18:08:07 +0100
Message-ID: <CAMRc=MeL0jSpfZ=8H71_m+bUP_Q_crvViXVCNc=3RK7ZArYt0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] ARM: davinci: add missing sentinels to GPIO lookup tables
To:     Sasha Levin <sashal@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 30 mar 2019 o 14:45 Sasha Levin <sashal@kernel.org> napisa=C5=82(a):
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>
> The bot has tested the following trees: v5.0.5, v4.19.32, v4.14.109, v4.9=
.166, v4.4.177, v3.18.137.
>
> v5.0.5: Failed to apply! Possible dependencies:
>     1703cf5d4fc0 ("ARM: davinci: da830-evm: use gpio lookup entries for u=
sb gpios")
>     c08df69149db ("ARM: davinci: omapl138-hawk: use gpio lookup entries f=
or usb gpios")
>
> v4.19.32: Failed to apply! Possible dependencies:
>     1703cf5d4fc0 ("ARM: davinci: da830-evm: use gpio lookup entries for u=
sb gpios")
>     c08df69149db ("ARM: davinci: omapl138-hawk: use gpio lookup entries f=
or usb gpios")
>
> v4.14.109: Failed to apply! Possible dependencies:
>     1703cf5d4fc0 ("ARM: davinci: da830-evm: use gpio lookup entries for u=
sb gpios")
>     c08df69149db ("ARM: davinci: omapl138-hawk: use gpio lookup entries f=
or usb gpios")
>     cd2428c368a6 ("i2c: davinci: switch to using gpiod for bus recovery g=
pios")
>     e53537653791 ("i2c/ARM: davinci: Deep refactoring of I2C recovery")
>
> v4.9.166: Failed to apply! Possible dependencies:
>     1703cf5d4fc0 ("ARM: davinci: da830-evm: use gpio lookup entries for u=
sb gpios")
>     1b6fe9798af8 ("ARM: davinci: board-da850-evm: fix WP pin polarity for=
 MMC/SD")
>     51e9f1216322 ("ARM: davinci: board-da830-evm: fix GPIO lookup for MMC=
/SD")
>     67c6b6ff221f ("ARM: davinci: board-da850-evm: fix GPIO lookup for MMC=
/SD")
>     b5e1438cf98a ("ARM: davinci: da830-evm: use gpio descriptor for mmc p=
ins")
>     bdf0e8364fd3 ("ARM: davinci: da850-evm: use gpio descriptor for mmc p=
ins")
>     c08df69149db ("ARM: davinci: omapl138-hawk: use gpio lookup entries f=
or usb gpios")
>     cd2428c368a6 ("i2c: davinci: switch to using gpiod for bus recovery g=
pios")
>     e53537653791 ("i2c/ARM: davinci: Deep refactoring of I2C recovery")
>
> v4.4.177: Failed to apply! Possible dependencies:
>     1703cf5d4fc0 ("ARM: davinci: da830-evm: use gpio lookup entries for u=
sb gpios")
>     1b6fe9798af8 ("ARM: davinci: board-da850-evm: fix WP pin polarity for=
 MMC/SD")
>     51e9f1216322 ("ARM: davinci: board-da830-evm: fix GPIO lookup for MMC=
/SD")
>     67c6b6ff221f ("ARM: davinci: board-da850-evm: fix GPIO lookup for MMC=
/SD")
>     b5e1438cf98a ("ARM: davinci: da830-evm: use gpio descriptor for mmc p=
ins")
>     bdf0e8364fd3 ("ARM: davinci: da850-evm: use gpio descriptor for mmc p=
ins")
>     c08df69149db ("ARM: davinci: omapl138-hawk: use gpio lookup entries f=
or usb gpios")
>     cd2428c368a6 ("i2c: davinci: switch to using gpiod for bus recovery g=
pios")
>     e53537653791 ("i2c/ARM: davinci: Deep refactoring of I2C recovery")
>
> v3.18.137: Failed to apply! Possible dependencies:
>     1703cf5d4fc0 ("ARM: davinci: da830-evm: use gpio lookup entries for u=
sb gpios")
>     1b6fe9798af8 ("ARM: davinci: board-da850-evm: fix WP pin polarity for=
 MMC/SD")
>     2c6ef04ffaf7 ("i2c: davinci: switch to use platform_get_irq")
>     2e65676f710e ("i2c: davinci: use bus recovery infrastructure")
>     51e9f1216322 ("ARM: davinci: board-da830-evm: fix GPIO lookup for MMC=
/SD")
>     67c6b6ff221f ("ARM: davinci: board-da850-evm: fix GPIO lookup for MMC=
/SD")
>     7ef97e9a312c ("i2c: davinci: use ICPFUNC to toggle I2C as gpio for bu=
s recovery")
>     a7ca2bcf2d2e ("ARM: davinci: Use standard logging styles")
>     b5e1438cf98a ("ARM: davinci: da830-evm: use gpio descriptor for mmc p=
ins")
>     bdf0e8364fd3 ("ARM: davinci: da850-evm: use gpio descriptor for mmc p=
ins")
>     c08df69149db ("ARM: davinci: omapl138-hawk: use gpio lookup entries f=
or usb gpios")
>     cd2428c368a6 ("i2c: davinci: switch to using gpiod for bus recovery g=
pios")
>     e53537653791 ("i2c/ARM: davinci: Deep refactoring of I2C recovery")
>
>
> How should we proceed with this patch?
>
> --
> Thanks,
> Sasha

Different GPIO lookup tables were added at different points and
backporting this patch will be a mess. I guess - since nobody
complained so far about any breakage - we can simply drop the stable
tag and treat it as an improvement of existing code.

Bart
