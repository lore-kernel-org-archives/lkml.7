Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8902C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F0B2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rg+lCIVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfCVA3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:29:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40203 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfCVA3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:29:21 -0400
Received: by mail-io1-f67.google.com with SMTP id d201so348517iof.7;
        Thu, 21 Mar 2019 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/s4reNb2d5JvM0GKH8+9ifCLuMJVarYxecv9GX49Jkw=;
        b=rg+lCIVC+TuUlUJm/WPUq2N865vMLA7KcMjZlja29miVwOwXCPTkj6MA6meDWD3Glc
         bT//2B4Zr3H0Mmxkq0YHCIX48rAppFESRJtP7rG+IIImRYcNnGs93AFG16p00DmiDHSG
         vFqUDfvtjeA8Kiq666a8X36zt2MtkRP9w8CP8nm8ttZB2L5dt+YxdFTSTJSYdp0qwHfJ
         6Qx8XcXi3sVKHe9GoCdC09Zpg3lB9Oh3p82ldIOJOVFFxqlUEJvofCaaDuH2Kyzln32d
         5zJvO4zkawUfTP4jS45lVJfIY8Xw2GYKOuwtWm6spD0r4vnJ6RVaestVQD6EiRBUCd2t
         vVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/s4reNb2d5JvM0GKH8+9ifCLuMJVarYxecv9GX49Jkw=;
        b=tRt8VLGlP7tdp/r+cy4OeGgQX/4hphVvEotPJ/xkwBGvomjmxYnVSUlqaCVwpeOs4W
         d/zT5LUuSX+pZvr0aVzRaSliU+h32vgtPrw6+4LSaJ5DVg/tuLFSEybk2//mgYPhECTX
         OxWNLxncKx5WBf0RNLQJ5eUaK/neawmhZdJ2m8KhKs1q2NY0l3C6bN5sSqSEohrucKuX
         /1oIYOSEYabU2gpGzBdTAEEjDhw39YYUJVEp3lE2Us+FOBHs3qiwi3Wgd7s3DNoDoQaO
         dmz9fdaGwcHZI6xFrmYkp+ntlOkAxsRuldrszr1ECjD/6pnxa3SacORWWzayqiLkl+cF
         PIWQ==
X-Gm-Message-State: APjAAAWOlLl05h/rByzkXLbQUfvYdQ4h4375XcVUmn8ZLMSV7jNpj8e5
        hN0q03f4ObkpB+nGKh1T/ZVMHw2n/9dcDDUcZ+eCPBYiSMw=
X-Google-Smtp-Source: APXvYqyETYMJUbE08/eUnfkC4zgWGkcsPA3C25jFRJuk1xvFV1rvPBD/rt9ukOeAmQXlLcjtROU9zXYqDwvNOB4DPAA=
X-Received: by 2002:a5d:8597:: with SMTP id f23mr4926357ioj.148.1553214560813;
 Thu, 21 Mar 2019 17:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190321170334.15122-1-thirtythreeforty@gmail.com>
 <20190321170334.15122-2-thirtythreeforty@gmail.com> <20190321220159.GC7872@darkstar.musicnaut.iki.fi>
 <CACmrr9hj6A_ZgbgO=bHuueav1FEc4jQ2-T9ddASa61Qe4mKR9g@mail.gmail.com> <20190321234019.5ifoywetz2vnhpne@pburton-laptop>
In-Reply-To: <20190321234019.5ifoywetz2vnhpne@pburton-laptop>
From:   George Hilliard <thirtythreeforty@gmail.com>
Date:   Thu, 21 Mar 2019 18:29:09 -0600
Message-ID: <CACmrr9h2acsvEX9BghXz+5cYXFsPD29wg5yyOEbrzggubELefg@mail.gmail.com>
Subject: Re: [RESEND PATCH] mips: ralink: allow zboot
To:     Paul Burton <paul.burton@mips.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 5:40 PM Paul Burton <paul.burton@mips.com> wrote:
> On Thu, Mar 21, 2019 at 05:10:38PM -0600, George Hilliard wrote:
> > My version of U-Boot complains if I compile out LZMA support:
> > ---
> > => tftpboot 0x81000000 uImage; tftpboot 0x84000000 hawkeye.dtb; bootm
> > 0x81000000 - 0x84000000
> > (snip)
> > Bytes transferred = 7349 (1cb5 hex)
> > ## Booting kernel from Legacy Image at 81000000 ...
> >    Image Name:   Linux-5.1.0-rc1
> >    Image Type:   MIPS Linux Kernel Image (lzma compressed)
> >    Data Size:    1465871 Bytes = 1.4 MiB
> >    Load Address: 80000000
> >    Entry Point:  80344338
> >    Verifying Checksum ... OK
> > ## Flattened Device Tree blob at 84000000
> >    Booting using the fdt blob at 0x84000000
> >    Uncompressing Kernel Image ... Unimplemented compression type 3
> > exit not allowed from main input shell.
> > =>
> > ---
>
> There you're using a uImage though, which is different to
> CONFIG_SYS_SUPPORTS_ZBOOT. Even without CONFIG_SYS_SUPPORTS_ZBOOT
> enabled, you can build either a compressed or uncompressed uImage.
>
> Some platforms enable one of those targets by default but it doesn't
> appear that ralink does, so I guess you're specifying a uImage.lzma
> target when building the kernel? Try doing that when
> CONFIG_SYS_SUPPORTS_ZBOOT isn't enabled - it'll still generate the same
> type of LZMA-compressed uImage.

OK, Buildroot was obfuscating this a little from me.  I selected its LZMA
compression option, and nothing happened.  Asking for LZMA does not make it
build uImage.lzma.  Selecting the *kernel's* KERNEL_LZMA option caused
Buildroot's `make uImage` to make the same sort of image as made by
`make uImage.lzma` as you suggest, for a reason I have not figured out.

> What CONFIG_SYS_SUPPORTS_ZBOOT does is produce a program (vmlinuz) which
> contains a compressed version of vmlinux.bin along with some code to
> decompress it. The decompression is performed by vmlinuz itself, not by
> U-Boot.

OK, that makes more sense.  I have not tested zboot then :)

> Now it could still be valid to select CONFIG_SYS_SUPPORTS_ZBOOT if you
> had a need for a better compression algorithm & couldn't update your
> bootloader to support it, but that would be solving a different problem
> than your commit message claims & it wouldn't matter at all whether the
> bootloader supports a particular compression algorithm.

Yeah, I agree.  I will just make a uImage.lzma, which is what I was after
anyway.

Thank you very much for the explanation!

George
