Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461CFC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA3021922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKg1XWz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfHGLS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:18:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38387 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfHGLS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:18:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so85092446ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OPtDIWD1oyhmvgdHSOSG81TcfHz+uzX2gkbcVtn5ULE=;
        b=BKg1XWz76ThRetJwm2Ypk0pOm23cGUXpYhH2r8gddn3xAjYJ5CWfD0j1qyCgWuBRiO
         C/epNQA8aWh/sWQPKrkiHTvxQc4z0L3ncGkiKT0bAdwiq1C61QtpvTCcDCW2uisk7OR+
         7FlctYuyZKTgbys5tZ3EXNLSxgyj67UoT7nVsDQZ0rxhoBjyoHwvMmpjfKteZ6UV47R0
         6I76lQUTYm5Z1UICmiqzv9ysTQzx4j475gksfMPOTwidtbkVNH7ujF9jiaex+H0CKkWL
         VGvkpCPKtPKwVLnn7kpe+xOcNHPE88/eAg6A4xUwbiysqwIuGhMLzQf6UsUfkOI12GfL
         MXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OPtDIWD1oyhmvgdHSOSG81TcfHz+uzX2gkbcVtn5ULE=;
        b=Gcz4YF6XjDKrMZvIVwYdxJBpqhidP4DJvyqpS6gjea1DOcY6hFV9g9xdLafJ84l81O
         KLybjiyGJAqiVvNyHIjQl/ispU7C4K7np6af2scFE9vzdO2rXm94uC7FxR0hehtm/epd
         NEQa9zw964LVeNnACoAipPri/py9TffX04ZS+u0M0mulgsujUPJn0VYqpGQZDmZbVo6a
         KIz/GFicxwA4Mex5hHAJBa5ajFTs/lthMzqhh+Zrr3aayZReAAKLgIZ5wa1xEd9Mnoe4
         tsjvQVGmW5IlZ/Va8a8JrGd4Pb6/P9TtKME4OcjR+P/jWluuOV1fHbIBnVSDGPR+CqV8
         11bw==
X-Gm-Message-State: APjAAAV39TErhNOsUb81rgFkxhs0PJRUFURe+pASG+gTfXhGSzk1uX+x
        VYkTzcZUpP9uKNsn0Y7ei/BNY2FjQnQpCkZvikHqbRMTmNU=
X-Google-Smtp-Source: APXvYqwTAVe95rSksZw+erekFdosmSxQDfjfhjtERnRYyENWOwshak+UScYbzsb44hFPW/YALmJunz/0Cw+mT4FzW4M=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr4497521ljc.123.1565176706159;
 Wed, 07 Aug 2019 04:18:26 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 7 Aug 2019 16:48:15 +0530
Message-ID: <CA+G9fYvehn=5Rn0RHjFvCc1pCDFTUtxNeR11CQjD6rjM53D4ig@mail.gmail.com>
Subject: Linux next-20190807: arm64: build failed - phy-rockchip-inno-hdmi.c:1046:26:
 error: anonymous bit-field has negative width (-1)
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        kishon@ti.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next 20190807 arm64 default config build failed due to below error.

/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:1046:26: error:
anonymous bit-field has negative width (-1)
                inno_write(inno, 0xc6, RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(v));
                                       ^
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:201:50: note:
expanded from macro 'RK3328_TERM_RESISTOR_CALIB_SPEED_7_0'
#define RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(x)         UPDATE(x, 7, 9)
                                                        ^
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:24:42: note: expanded
from macro 'UPDATE'
#define UPDATE(x, h, l)         (((x) << (l)) & GENMASK((h), (l)))
                                                ^
../include/linux/bits.h:39:3: note: expanded from macro 'GENMASK'
        (GENMASK_INPUT_CHECK(high, low) + __GENMASK(high, low))
         ^
../include/linux/bits.h:24:18: note: expanded from macro 'GENMASK_INPUT_CHECK'
        ((unsigned long)BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
                        ^
../include/linux/build_bug.h:16:47: note: expanded from macro
'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))

Config link,
https://storage.kernelci.org/next/master/next-20190807/arm64/defconfig/clang-8/kernel.config

Build link,
https://storage.kernelci.org/next/master/next-20190807/arm64/defconfig/clang-8/build.log

--
Naresh Kamoju
