Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A259C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D7F2192B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH29RQJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfCUXKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:10:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36212 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfCUXKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:10:50 -0400
Received: by mail-io1-f68.google.com with SMTP id f6so244424iop.3;
        Thu, 21 Mar 2019 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9okr37RjDLxo+GuFaH+iyRUubfB3fgE0X3b0GB/hyzk=;
        b=YH29RQJg1C9TlhD1pAF2jWK3r87Av3+8QrmoA52dzgBYp97xUu6PMGl8oErsnwhP9G
         KHOrMaAGfOwk9d0xrf8gi11PsnKiZh3koUvUcbW5AZ2gokV2EnzLNxoo/Fb8YSVTmzIt
         mI0MI4wTnXMFFmiRA8xDxvd0FkjyDAxFNAKoRdEvJl+KmJUrG4DU62+nj4hf2mKKEb4+
         HWodTM/FpH++jBhYcmHEwBe6fvXfzYLJNlhkDQkVWIJdxnYEqoJhcvRSv8NvCkrikDh9
         1Px7Ca+Gm2hjZQk2i8Ru/y/Zx/yJggoSoIS/JqA1wcL6Y8g90gpVhBy4Ndztzm4eaaY7
         O7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9okr37RjDLxo+GuFaH+iyRUubfB3fgE0X3b0GB/hyzk=;
        b=MHsvWqHPzSGy+iJe7x4qkfJPjRefRtO46kJPsXFQxMXRK5N381epvZlwXU04zijjw1
         hjlhJ9m9/12wV8t3gjaZNMEgeuqThbKYJFEwYVTuDEIVjB8AdMNDr/kGyjexG05Izzrb
         DRqPmw1RGABTWCsJE+EShpUJabtTQWUkf34xni/BJZ4TkbInF4gKYmhL/U9oi87C8Mhb
         /3AqiJD8XCehF8AneuHduK1SiwgVMJUoLjVwEzR1pKU6iVqYCFGnYNgPPFYoMeF1uAWI
         JYYE9AXBH3Lpx8//zk83o8NUlKglhlCPOTT36ghFWj8+Ukba5BSmQgA27qtmk+nnRorj
         7aBw==
X-Gm-Message-State: APjAAAUTS7UO5PGVkMc9OOd9oHUUePTlaRHwdpGRHF4uqMAlOIwhHSDB
        jgOdZMTtHHpx0pMia6z1WVtusm+ndARCMdB+R1X4ku8rJbZfFg==
X-Google-Smtp-Source: APXvYqx2f6nJhvQ8HsATBHMU2ekh8ae/KYgGEo1Z6crUnT3VbVRQxCjpryFmRIMzwgfaJPZmY6OZH+PKISxa0MKV0IY=
X-Received: by 2002:a5e:a505:: with SMTP id 5mr5108013iog.28.1553209849528;
 Thu, 21 Mar 2019 16:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190321170334.15122-1-thirtythreeforty@gmail.com>
 <20190321170334.15122-2-thirtythreeforty@gmail.com> <20190321220159.GC7872@darkstar.musicnaut.iki.fi>
In-Reply-To: <20190321220159.GC7872@darkstar.musicnaut.iki.fi>
From:   George Hilliard <thirtythreeforty@gmail.com>
Date:   Thu, 21 Mar 2019 17:10:38 -0600
Message-ID: <CACmrr9hj6A_ZgbgO=bHuueav1FEc4jQ2-T9ddASa61Qe4mKR9g@mail.gmail.com>
Subject: Re: [RESEND PATCH] mips: ralink: allow zboot
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My version of U-Boot complains if I compile out LZMA support:
---
=> tftpboot 0x81000000 uImage; tftpboot 0x84000000 hawkeye.dtb; bootm
0x81000000 - 0x84000000
(snip)
Bytes transferred = 7349 (1cb5 hex)
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-5.1.0-rc1
   Image Type:   MIPS Linux Kernel Image (lzma compressed)
   Data Size:    1465871 Bytes = 1.4 MiB
   Load Address: 80000000
   Entry Point:  80344338
   Verifying Checksum ... OK
## Flattened Device Tree blob at 84000000
   Booting using the fdt blob at 0x84000000
   Uncompressing Kernel Image ... Unimplemented compression type 3
exit not allowed from main input shell.
=>
---

Thanks,
George

On Thu, Mar 21, 2019 at 4:56 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> On Thu, Mar 21, 2019 at 11:03:34AM -0600, George Hilliard wrote:
> > Architecturally, there's nothing preventing compressed images from
> > working.  Bootloaders built with support for the various compression
> > methods can decompress and run the kernel.  In practice, many
> > bootloaders do not support compressed images, but kernels for those
> > boards should just not be compressed.
>
> With zboot the decompressor is included in the image so no bootloader
> support is needed.
>
> A.
