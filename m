Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37F3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE3020830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfCYNJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:09:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33430 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbfCYNJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:09:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so10156611qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92mvcF86b1uViDorcCKiHGHaTxeqyybdDnbnT9Ty+bc=;
        b=uPxDKPZ6Zl0JjxzROuBqtCgUn0pGa3SFz/v1tWmZiX8BC7NgAf58ew4qVmv4id7k/1
         1LipfKjhYCy21f3QWPVIHmcHoOmyb9wT6nmnWPRdw+k15+Zf3MhYvSUl24ziYlZAXpIi
         4BaHA1/0M3jgSs4+KHc7CBwgp4S0BtJN1mgPDlDVjA769JT0u+KbuTCwUkyW3ySdIQct
         J6+A6qwBOiYxLK0xIOvg1subDO28rHCsdP+RnJh6xqkZRlK0mxy1ZXyoVbwhPpNAcOLI
         8Zct1Mt7NqbnyQthMc7TrCFunAfi2qWaqhiY3EhYN9tw9zl2XIlzHEy3CEtDutDmSeMs
         28ZA==
X-Gm-Message-State: APjAAAUCJ6zniYHFEyAExP8K6i79kEzfFORMrxT7jH+JAU5do2z2V8O+
        65qe3v4XaiQxEmZf1z/Hz2S7WEIAojlWZb+Ll/iOpw==
X-Google-Smtp-Source: APXvYqwEpwp37hy7mAF92Xvv/h2FCLy8roAZP+x2sB4MXrDSN1WVI7AyQYNSLNFvgX8nmbAzOjT7Fl39J0UY1ioHs3M=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr20329630qto.343.1553519344025;
 Mon, 25 Mar 2019 06:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190318122901.7231-1-brgl@bgdev.pl> <20190318122901.7231-2-brgl@bgdev.pl>
In-Reply-To: <20190318122901.7231-2-brgl@bgdev.pl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Mar 2019 14:08:47 +0100
Message-ID: <CAK8P3a0EhCRH7O87WSyfHujomQ_Dzz3=BT0SaXF-33Z9g0oSjA@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] ARM: davinci: support multiplatform build for
 ARM v5
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 1:29 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add modifications necessary to make davinci part of the ARM v5
> multiplatform build.
>
> Move the arch-specific configuration out of arch/arm/Kconfig and
> into mach-davinci/Kconfig. Remove the sub-menu for DaVinci
> implementations (they'll be visible directly under the system type.
> Select all necessary options not already selected by ARCH_MULTI_V5.
> Update davinci_all_defconfig. Explicitly include the mach-specific
> headers in mach-davinci/Makefile.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I like this a lot, it gives me some hope that we can eventually
do the same for the remaining ARMv5 platforms that are
not multiplatform yet (s3c24xx, ks8695, w90x900, lpc32xx,
omap1, ep93xx, and maybe even the xscale based ones).

I have done a lot of randconfig testing with this patch appled now
and not found any issues, great work!

      Arnd
