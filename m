Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D682C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 05:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D27021655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 05:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kHDOaiT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfEHFuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 01:50:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37470 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfEHFuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 01:50:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id h126so2427616lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VNO32gkOjAFDvmj3qsaBg8BBWn0BQYs6mBExH3P2Mw=;
        b=kHDOaiT0j+o+B2ZBt/yia1FDIojDnQcjSebmgLII5LR7JOWw294hu55v0nXrCpBUdL
         lArwxfnLA9ISj86HwTGPaYC5GPf3Yz3kYtAQ8pLhG19chrWtfwC9h0w1PKQxDDXtDCM2
         I3W2V7uNhr/2Kah0vK48oklVzuPcgrNUxSJJDJjU6B0GRdSPIgrhki19Ghmc7ihzs+xc
         zwhpr146/EcT4Ema9/11rBaZQz68cmJCeTnXtJYoPDd83IGaxJq5NjgABw75EBiAQgEy
         5r/WFBCFfViaeuvG4HgbIKCcvKm9uR0U2mrQP3FruchWQmgEyI50Z83lASvgFJ6yNGMX
         ZV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VNO32gkOjAFDvmj3qsaBg8BBWn0BQYs6mBExH3P2Mw=;
        b=cDAKJWVq5uYcmpRwMmvpRg20dlMjtw9KJVshPzkQVlbTDSe9QOCfspiJ5dfUKCKP6y
         mcLfwZTjvRBI3ClYn/qfcYcS9B1e9ITIJBHlvLZdp2KYkavPBTf1lHqmBZ87AkQjd4w1
         dbIQ/SU9NPsRex4OTn/Qk8U2RGY5EHRUOGBUs/kpioy4Ul2gJJ08YRNYFWZFlT1ZjQyr
         QwJqpoZikEXl/LPZPvXfe6dqmMoMNRGfz5jZkuw72Yi8EX2wyvLEqXr6IWPRAdbZgcWJ
         mK6ixf5guoUKOUvZCGn1HoukPLHOGVgPTuYGe99A3HaqH4EGiBwseD/4e0/d/5wx623X
         ZHbw==
X-Gm-Message-State: APjAAAW2Y+a/CpYxroRVBLEYKEEaplyQJlTtyT9Oc/VE6j+twDmWO68k
        vw6zONUzyws2pFH+nCqeqDJtW1yX4rk7HkG3yuYrHw==
X-Google-Smtp-Source: APXvYqxFjNGsLoaZWXanwoQsNpAMlsMY20XLb11x/2kdZLwwRghwoGBYiufbVNzDvHDHChGZGZ+z9EalpEtsELhzzQc=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr8992780lff.27.1557294614444;
 Tue, 07 May 2019 22:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <1557139720-12384-1-git-send-email-yash.shah@sifive.com>
 <1557139720-12384-3-git-send-email-yash.shah@sifive.com> <d36b7a74-0d08-0143-b479-45f760c347ba@ti.com>
 <CAJ2_jOFZjTNA3Nf=zNwLT+St21Q2_TPx_XYhggU=yef6LPkLdg@mail.gmail.com> <ba1481d0-f21b-5b0d-e3d5-ecb9faf42407@ti.com>
In-Reply-To: <ba1481d0-f21b-5b0d-e3d5-ecb9faf42407@ti.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Wed, 8 May 2019 11:19:37 +0530
Message-ID: <CAJ2_jOFPqgFzc_q0kq3GZY2w5KAS6wkbvBx4vZSgLXfAeanR7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] RISC-V: sifive_l2_cache: Add L2 cache controller
 driver for SiFive SoCs
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 7:15 PM Andrew F. Davis <afd@ti.com> wrote:
>
> On 5/7/19 2:48 AM, Yash Shah wrote:
> > On Mon, May 6, 2019 at 5:48 PM Andrew F. Davis <afd@ti.com> wrote:
> >>
> >> On 5/6/19 6:48 AM, Yash Shah wrote:
> >>> The driver currently supports only SiFive FU540-C000 platform.
> >>>
> >>> The initial version of L2 cache controller driver includes:
> >>> - Initial configuration reporting at boot up.
> >>> - Support for ECC related functionality.
> >>>
> >>> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> >>> ---
> >>>  arch/riscv/include/asm/sifive_l2_cache.h |  16 +++
> >>>  arch/riscv/mm/Makefile                   |   1 +
> >>>  arch/riscv/mm/sifive_l2_cache.c          | 175 +++++++++++++++++++++++++++++++
> >>>  3 files changed, 192 insertions(+)
> >>>  create mode 100644 arch/riscv/include/asm/sifive_l2_cache.h
> >>>  create mode 100644 arch/riscv/mm/sifive_l2_cache.c
> >>>
> >>> diff --git a/arch/riscv/include/asm/sifive_l2_cache.h b/arch/riscv/include/asm/sifive_l2_cache.h
> >>> new file mode 100644
> >>> index 0000000..04f6748
> >>> --- /dev/null
> >>> +++ b/arch/riscv/include/asm/sifive_l2_cache.h
> >>> @@ -0,0 +1,16 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +/*
> >>> + * SiFive L2 Cache Controller header file
> >>> + *
> >>> + */
> >>> +
> >>> +#ifndef _ASM_RISCV_SIFIVE_L2_CACHE_H
> >>> +#define _ASM_RISCV_SIFIVE_L2_CACHE_H
> >>> +
> >>> +extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
> >>> +extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
> >>> +
> >>> +#define SIFIVE_L2_ERR_TYPE_CE 0
> >>> +#define SIFIVE_L2_ERR_TYPE_UE 1
> >>> +
> >>> +#endif /* _ASM_RISCV_SIFIVE_L2_CACHE_H */
> >>> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> >>> index eb22ab4..1523ee5 100644
> >>> --- a/arch/riscv/mm/Makefile
> >>> +++ b/arch/riscv/mm/Makefile
> >>> @@ -3,3 +3,4 @@ obj-y += fault.o
> >>>  obj-y += extable.o
> >>>  obj-y += ioremap.o
> >>>  obj-y += cacheflush.o
> >>> +obj-y += sifive_l2_cache.o
> >>> diff --git a/arch/riscv/mm/sifive_l2_cache.c b/arch/riscv/mm/sifive_l2_cache.c
> >>> new file mode 100644
> >>> index 0000000..4eb6461
> >>> --- /dev/null
> >>> +++ b/arch/riscv/mm/sifive_l2_cache.c
> >>> @@ -0,0 +1,175 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * SiFive L2 cache controller Driver
> >>> + *
> >>> + * Copyright (C) 2018-2019 SiFive, Inc.
> >>> + *
> >>> + */
> > [...]
> >>> +
> >>> +#ifdef CONFIG_DEBUG_FS
> >>> +static struct dentry *sifive_test;
> >>> +
> >>> +static ssize_t l2_write(struct file *file, const char __user *data,
> >>> +                     size_t count, loff_t *ppos)
> >>> +{
> >>> +     unsigned int val;
> >>> +
> >>> +     if (kstrtouint_from_user(data, count, 0, &val))
> >>> +             return -EINVAL;
> >>> +     if ((val >= 0 && val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
> >>
> >> I'm guessing bit 16 is the enable and the lower 8 are some kind of
> >> region to enable the error? This is probably a bad interface, it looks
> >> useful for testing but doesn't provide any debugging info useful for
> >> running systems. Do you really want userspace to be able to do this?
> >
> > Bit 16 selects the type of ECC error (0=data or 1=directory error).
> > The lower 8 bits toggles (corrupt) that bit index.
> > Are you suggesting to remove this debug interface altogether or you
> > want me to improve the current interface?
> > Something like providing 2 separate debugfs files for data and
> > directory errors. And create a separate 8-bit debugfs variable to
> > select the bit index to toggle.
> >
>
> I was suggesting to remove the whole thing. I don't see it being all
> that useful, but it is up to you.

Thanks for the suggestion, but I will keep it as we do need it for our testing.

- Yash
