Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2354DC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E175B2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ZRA8R31d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfFRK7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:59:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45625 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbfFRK7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:59:45 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so28613786ioc.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zE+SX6SmJuqniQ7NjAmJGscRWAHfDF73kRsg3p1vW/I=;
        b=ZRA8R31dARjasR829hrnWSoWnChAdV/Q4AnU2qy6oX7CcVMxtq2xlkRcVwLc0YoXCk
         uoKI6z+j33CzVT9lUiD/FxtpEtT1/pjthqE6evUlvx3z7DZpW3m11ZgIOm5umqWxKR0H
         5iJljS0EZ6Tz9nnkzZcclLjU46FHU9nc8v4+gbWcimyLnTNlwy2NVYiqx/z3uCLMAdaf
         N50hrnatqW8la1sYYWWTPFRX/es0ErzyJJ0uBodBxdc44Ipu5acCz6QlcrCQW0/Gwva0
         fj5AD1MbNn6ozSckHKhLzkZ4Qd0ERLxg9QKjT+wA32PNehHQUlPCbxTlqtmpisAwpQuc
         Zi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zE+SX6SmJuqniQ7NjAmJGscRWAHfDF73kRsg3p1vW/I=;
        b=COtg9IOD691klMnE1lQtW8cDxjfCPoC/yyXPaGMsUuHNP68tC3NWvU+iIzJpSnKcdR
         NvUTOkalyywuIniIxqD2fmEgnTQP7AFpR9rJVIPzYCUkMHrwz5Oubduge4PO5q2yL9vW
         lE/c2sKZdGxza4SBm6F+W1xf3GbeZ7ktl+KzzAk8jd4EtyoXYdDSa8YicFGCDlbhMPWO
         DPV0QlSDKy1yIk098BsSBV8XaErKysEbihabYj8HzlTHjLENDg9/YAsd8YxzP/wuA/tz
         ipyAu8bvpa40VSTCf5v29XZuITCSs7oOREhbIYe8zAYaWv/AJnDwsBBE16shdIVMbmN8
         E0CA==
X-Gm-Message-State: APjAAAW6MYaVrzNw6iX6MAsoPsJVn5qHoBht5Rs/wegk+EOTDLsbHk6p
        cMMaCsxHS6/zzEpK2rwrLYsow8aYWDZUF8xm4Gyx2g==
X-Google-Smtp-Source: APXvYqzjhXGg+TvQJGun9Olmz9fMYejbvTP9+tvJZTNfj66Ln++Fr+249qMlKBOev8QrSa5z7CguoXzfCqnyT5uNyfs=
X-Received: by 2002:a02:c519:: with SMTP id s25mr9785849jam.11.1560855584996;
 Tue, 18 Jun 2019 03:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122449.457744-1-arnd@arndb.de>
In-Reply-To: <20190617122449.457744-1-arnd@arndb.de>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 18 Jun 2019 11:59:33 +0100
Message-ID: <CAOesGMgx2OrKnLyQAu748eoqx9a4N9BhjiFw6qkHFYmWbTMvrg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: ixp4xx: don't select SERIAL_OF_PLATFORM
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 1:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Platforms should not normally select all the device drivers, leave that
> up to the user and the defconfig file.
>
> In this case, we get a warning for randconfig builds:
>
> WARNING: unmet direct dependencies detected for SERIAL_OF_PLATFORM
>   Depends on [n]: TTY [=y] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && OF [=y]
>   Selected by [y]:
>   - MACH_IXP4XX_OF [=y] && ARCH_IXP4XX [=y]
>
> Fixes: 9540724ca29d ("ARM: ixp4xx: Add device tree boot support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to arm/fixes. Thanks!


-Olof
