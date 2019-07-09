Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04668C004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92A4214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vb98Z4RP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGILsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:48:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33721 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfGILsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:48:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so19255456ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ssgulV7sWCfcM4PRZNwO9BuulmUUqW907/wO7hPiBc=;
        b=vb98Z4RP0gTCJjoVBOCo1CN9IHKRCGHfE7q3lgCeHP38GmDWCCDLwiNR+2sEdq/ZMl
         nOxdU9A0OrbX/7aoAJSE88mLRAgzBD1VrP2TudVDFUrp4DmqA/Sz4X9fkkFEBi9Tmhp2
         4B7Y9k22/zOot01eNVLWCx+5pFY4/mVO5Tm26hHyPPyYUbkS7QeNY4b6hIwXtR6B3cv/
         +f8fDWloVsbO93vHqS/gkfBSZxmF1YIc+6KD9jrKfux3uhkE6ZQ8fYBOr+dVXfmWx3gi
         PUoe1nddEy7sSHplHZPblYsxiQaV/+sarD1oR/MELsw32YpugBQAFZZsIUisMTqGLPLZ
         y1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ssgulV7sWCfcM4PRZNwO9BuulmUUqW907/wO7hPiBc=;
        b=HtsVsTNTqTk7t809G72/PGXtl1UOqlJXKz9l3bT/h2Gp6QkylFsEjKKv0dqdv6fd9r
         iTJ7w8GD4GmdfDxDefXlrXffYaVyxEO5N4ulB7CjvmJJpLXHhZlrhkZFQbydr9VnGWur
         n0f26lZSeTsRPT7x1B4SaJ43xiijOdPJU8M0RP9kJpVV2WaER2YOX1dSG60z+FDPsCHV
         MR1bL4CBc/gYlfu6/Q6J3dh3rpXaG/T3bs5WY4phy1ju0JTXx8Sx7xsAJpvgqUgPpXws
         Eocs64QkjrPgQ6mO4G8uGTKsB1u2YLQMleQxiHCr4GJByJpSy6YWLWCc+DdgZEkk+a4/
         GUVw==
X-Gm-Message-State: APjAAAU0QA4YHetEcRPBwW73/d3NtLb3BZQokDnYrgCvpUXPi9vqLnk/
        NEToGUPIAgBMes00VMd9x15k+Y3i+ZRUH7blMwiAJw==
X-Google-Smtp-Source: APXvYqwWvrNmIZaD+XHxDp7B5vU2aCobnnMO3Af/AFVXIizRGOojn8dMUQtZA0/oMlif6DulxK/S8J7u/9s597+dKos=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr13414410ljs.54.1562672902884;
 Tue, 09 Jul 2019 04:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190708203049.3484750-1-arnd@arndb.de> <CACRpkdY1JzUZKgmXbObb6hqFcLFygAj2NuMgPMj=8tCp9U2C1A@mail.gmail.com>
 <20190709091747.cg3cqmzdfpzks2vx@shell.armlinux.org.uk>
In-Reply-To: <20190709091747.cg3cqmzdfpzks2vx@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Jul 2019 13:48:11 +0200
Message-ID: <CACRpkdZbEL7njJEO+0UYzzkck+UeMuADgB4Nwvet5B2ZALDcZQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, clang-built-linux@googlegroups.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 11:17 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Tue, Jul 09, 2019 at 10:41:05AM +0200, Linus Walleij wrote:
> > I guess this brings up the old question whether the compiler should
> > be worked around or just considered immature, but as it happens this
> > other day I was grep:ing around to find "the 8 NOP" that is so
> > compulsively inserted in ARM executables (like at the very start of
> > the kernel execution)
>
> The NOPs at the start of the kernel executable have nothing what so ever
> to do with this.  They are there to align the kernel entry with the old
> a.out format that was used (which had a 32 byte header).  Consequently,
> there are boot loaders around that jump to 32 bytes into the kernel
> header.

Wow! Finally the puzzle pieces come together. And it makes a lot
of sense.

> There are other places that we insert 10 NOPs (at cpu_relax()) due to a
> CPU errata (otherwise a tight loop basically stalls other CPUs.)

Pretty interesting too!

I try to learn a bit more intrinsics of the Arm architecture (been doing
assembly experiments recent days) so getting to know things like
this is very valuable.

Yours,
Linus Walleij
