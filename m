Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3173FC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0EA21019
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mPrbLeI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfEGGte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:49:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42356 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfEGGte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:49:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id w23so10944856lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDWB+PNcjI4q/A/1DW85bUa/9Snq5OItKRPTK4tpNfU=;
        b=mPrbLeI30J/5s8XP70Yj52evlvXJ+8D0wG4lJ7LzE0tziEfVMe35aZD1BE6WI1yyo0
         8+8e6vWuS+J0RC7AoQ6pQEKib60ad9mR1GiKSsQPkmmVxgqC//yQUpRJ67XKmGA6Zz1J
         rNFUfKVDPJ6wVNWUOGOkhXSh1udaWNlpNbtFKypXPZC5HQopgW4AEQ0d3upC3QSlPDMY
         z/dEKgODIODKyWS/Wm0VVsmRhf/9/1HhwwAKOC+5Si7DwyCjo1jcBIDLjaL+jGRCcXBQ
         J9et5jTt1BaIodrKCBBDxDF/Tm/RSpH9ZArW5N9nNu2H8wBKejWnt9Dvq794avLVnJUa
         NAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDWB+PNcjI4q/A/1DW85bUa/9Snq5OItKRPTK4tpNfU=;
        b=gaXjiWtVhLlzcqZfIKkFpa2ErndxymW9TzXYc6o/Szp8jE3QoTlDlq6Cqo+1E43n4W
         HqUExQdL7IHBd/uhxigPJwQxoAC1sYtP6QYzv92Z5yckw6n1h9n66tzDbYnrV0tELNZg
         fe3vVJi2mG7hrN7E6iyx1mI86EUMKbvGXfQqxCW5ouvHEYCN6xTgpiIs+uGrDqFiPgNS
         P6UQh6SxBKe1PHpiwVq4qCrVYJf9Lt1ayNbqNEvRZOgRS7uW+gdj+nVEm43dKn/Bqs/U
         RrY1SMaricy9JXkWThtja6CQF1EUf6kIlNaMjRHR1QUldVGEO9lb7DX57vM3bbBOA5x9
         FKIg==
X-Gm-Message-State: APjAAAWcA6lAh03xyoBcW4E8sHCdnYU7mmo26bQS9TrZv11wZagPS2m/
        iJo/R+VeiHIl9NRQcpn4Cg89l31DZrz3T5mkQccjwQCr0sUPdCL7zkGIHzQQjz+jDwT0YvWxXVZ
        soop23iM6FsORxHwIDQrLByYkCvC0EZaTjQ==
X-Google-Smtp-Source: APXvYqyfjgoxjBepkSXY0LT82aLu+Pj5tiZ6BdCvglYDPWY4vHbpWDaqXOtmKKpb03mlKKnpt8wbeK4r74iaaD2tR5A=
X-Received: by 2002:a19:81d4:: with SMTP id c203mr1957595lfd.160.1557211771188;
 Mon, 06 May 2019 23:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <1557139720-12384-1-git-send-email-yash.shah@sifive.com>
 <1557139720-12384-3-git-send-email-yash.shah@sifive.com> <d36b7a74-0d08-0143-b479-45f760c347ba@ti.com>
In-Reply-To: <d36b7a74-0d08-0143-b479-45f760c347ba@ti.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 7 May 2019 12:18:54 +0530
Message-ID: <CAJ2_jOFZjTNA3Nf=zNwLT+St21Q2_TPx_XYhggU=yef6LPkLdg@mail.gmail.com>
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

On Mon, May 6, 2019 at 5:48 PM Andrew F. Davis <afd@ti.com> wrote:
>
> On 5/6/19 6:48 AM, Yash Shah wrote:
> > The driver currently supports only SiFive FU540-C000 platform.
> >
> > The initial version of L2 cache controller driver includes:
> > - Initial configuration reporting at boot up.
> > - Support for ECC related functionality.
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  arch/riscv/include/asm/sifive_l2_cache.h |  16 +++
> >  arch/riscv/mm/Makefile                   |   1 +
> >  arch/riscv/mm/sifive_l2_cache.c          | 175 +++++++++++++++++++++++++++++++
> >  3 files changed, 192 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/sifive_l2_cache.h
> >  create mode 100644 arch/riscv/mm/sifive_l2_cache.c
> >
> > diff --git a/arch/riscv/include/asm/sifive_l2_cache.h b/arch/riscv/include/asm/sifive_l2_cache.h
> > new file mode 100644
> > index 0000000..04f6748
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/sifive_l2_cache.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * SiFive L2 Cache Controller header file
> > + *
> > + */
> > +
> > +#ifndef _ASM_RISCV_SIFIVE_L2_CACHE_H
> > +#define _ASM_RISCV_SIFIVE_L2_CACHE_H
> > +
> > +extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
> > +extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
> > +
> > +#define SIFIVE_L2_ERR_TYPE_CE 0
> > +#define SIFIVE_L2_ERR_TYPE_UE 1
> > +
> > +#endif /* _ASM_RISCV_SIFIVE_L2_CACHE_H */
> > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > index eb22ab4..1523ee5 100644
> > --- a/arch/riscv/mm/Makefile
> > +++ b/arch/riscv/mm/Makefile
> > @@ -3,3 +3,4 @@ obj-y += fault.o
> >  obj-y += extable.o
> >  obj-y += ioremap.o
> >  obj-y += cacheflush.o
> > +obj-y += sifive_l2_cache.o
> > diff --git a/arch/riscv/mm/sifive_l2_cache.c b/arch/riscv/mm/sifive_l2_cache.c
> > new file mode 100644
> > index 0000000..4eb6461
> > --- /dev/null
> > +++ b/arch/riscv/mm/sifive_l2_cache.c
> > @@ -0,0 +1,175 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SiFive L2 cache controller Driver
> > + *
> > + * Copyright (C) 2018-2019 SiFive, Inc.
> > + *
> > + */
[...]
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static struct dentry *sifive_test;
> > +
> > +static ssize_t l2_write(struct file *file, const char __user *data,
> > +                     size_t count, loff_t *ppos)
> > +{
> > +     unsigned int val;
> > +
> > +     if (kstrtouint_from_user(data, count, 0, &val))
> > +             return -EINVAL;
> > +     if ((val >= 0 && val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
>
> I'm guessing bit 16 is the enable and the lower 8 are some kind of
> region to enable the error? This is probably a bad interface, it looks
> useful for testing but doesn't provide any debugging info useful for
> running systems. Do you really want userspace to be able to do this?

Bit 16 selects the type of ECC error (0=data or 1=directory error).
The lower 8 bits toggles (corrupt) that bit index.
Are you suggesting to remove this debug interface altogether or you
want me to improve the current interface?
Something like providing 2 separate debugfs files for data and
directory errors. And create a separate 8-bit debugfs variable to
select the bit index to toggle.

- Yash

>
> Andrew
>

-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
