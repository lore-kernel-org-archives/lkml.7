Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5586FC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADB8214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kz12+iAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGIIlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:41:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45481 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfGIIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:41:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so18695334lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KW4urHyn9lKTkE1GguMjzjUH4Z42XiBkXGp6QALBBzE=;
        b=Kz12+iAgKvNThqsgJb5ncahTCH39onCnTWNmtzIJz8N7M6yVJCHvKMJHqX7NMCYHJf
         mSUgKbRH2UsmFJwjAZsTdsyHkeRCerZVnsy1pLHUlPVdkTMtyhKinxm8SHrQvgAnx4hO
         fRnNUGP2SszVVIzqJRRJ9j0XKZNGzA202cCe+1Yx/2rsLfyYDFiy9dEfhTI8SVkT7omr
         BTbFn6bhEzZ9gEYs2dU4yCXPaPOvvcx2LXJalHx+DIjjLq9WvE20OpKPEpO/98wjuAdd
         i15huZwwlIBni6pnJNYBIqdnSk0wxWrypHLrxCVJS0vKCvH6RCWj/qt4cBG1aMVfkEUm
         rEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KW4urHyn9lKTkE1GguMjzjUH4Z42XiBkXGp6QALBBzE=;
        b=hDT8faP6uAjpFIas5SlVJqZ2xwyEh4xx9UbCJdOymxn3RKSFgQIT7X4ceTwKOn9z6v
         m+QGtWAu7aEqIdTJO+dxtPCqf2ELSyctmT13RLqvzdEyfX2TGzkL2ub9br5aWJVsjCRu
         +RqWRicVuzkJpbiMBXxIFEH/Ln1+A/Mt9NORo9/aINc/+qImL3oR0o9pz9ti/26OTT32
         8Ns4aQYAAJwfZ6g6lSvXPm9E6lPN3ZYBuqYdPDead+yFRC4p6fZcLo9x5dGPSTE+Yezk
         Jf7EUj+bdkyWgMkZYXJLSSY2OGu8W6yddPvCp4u2DsaINoIn5T0NZtGMNBttcUX6K69J
         0IMg==
X-Gm-Message-State: APjAAAVUVEQ5cKo+wqfZYMKNEiiSUM/SjsDr1Qdfcem5iWgghq1FraUI
        FwB6xw/aS+JmITDh37R//RulE5fLvM/DAmmPubl5yg==
X-Google-Smtp-Source: APXvYqw0jyVm13vCM2kziODAQ0A5OhPssA3jNapr/manrVR+U6kZZMvBVLPyYy6OTOyqEuhjHIFh+hTX4RVT+EaZ2VI=
X-Received: by 2002:a2e:9593:: with SMTP id w19mr9976145ljh.69.1562661677756;
 Tue, 09 Jul 2019 01:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190708203049.3484750-1-arnd@arndb.de>
In-Reply-To: <20190708203049.3484750-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Jul 2019 10:41:05 +0200
Message-ID: <CACRpkdY1JzUZKgmXbObb6hqFcLFygAj2NuMgPMj=8tCp9U2C1A@mail.gmail.com>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 10:31 PM Arnd Bergmann <arnd@arndb.de> wrote:

> llvm gets confused by inline asm with .rep directives,

Are the LLVM developers aware of the bug?
It seems like something we can work around but should
eventually be fixed properly in LLVM, right?

> which
> can lead to miscalculating the number of instructions inside it,
> and in turn lead to an overflow for relative address calculation:
>
> /tmp/cfi_cmdset_0002-539a47.s: Assembler messages:
> /tmp/cfi_cmdset_0002-539a47.s:11288: Error: bad immediate value for offset (4100)
> /tmp/cfi_cmdset_0002-539a47.s:11289: Error: bad immediate value for offset (4100)
>
> This might be fixed in future clang versions, but is not hard
> to work around by just replacing the .rep with a series of
> eight unrolled nop instructions.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=42539
> https://godbolt.org/z/DSM2Jy
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I guess this brings up the old question whether the compiler should
be worked around or just considered immature, but as it happens this
other day I was grep:ing around to find "the 8 NOP" that is so
compulsively inserted in ARM executables (like at the very start of
the kernel execution) and I couldn't find them and now I see why.
Spelling them out makes it easier to find so:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
