Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD016C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92793206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="e0COSR2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfH0ClZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 22:41:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34304 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfH0ClZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:41:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so17183678wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLwjc8V9DcEQY4mgZxJcyca8OE/+OW2feKF41o89L9E=;
        b=e0COSR2awS2c34nGPmOzHdSQqzwKuBkOtldXhyFm+hlBohN+AliT8Y9MapnQZVunGN
         KdE5Sp5JvKCgpCgg3zc5NCSe5nxNrlEmqv4zR+tiK7jAPu7iRtpTkn3Mi+YqzN9QOldX
         EzVeJsiC+kaxR/kUkgNLesX6t7bxP/YXS/CSTKvrr172FYRpSPVOK27NB3g1Cf6/fbqv
         y+SiIc5pNOSQW2BTNhG/GJJFDE/uH2JWd5BMl0coLsHMVygd9TH7Ii4RrNVzCXNFNLHY
         aiT82Y+o7l9RIj8Sm14VHYNMG2boiajMHZJzY1KqjmBAWY3aPzmIBdY9zXuc1StuuY1m
         e8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLwjc8V9DcEQY4mgZxJcyca8OE/+OW2feKF41o89L9E=;
        b=ldpUlzu4ll+8QvefOuZcsdWC0tfBCxmI+rZBApQzCO6XUZUgKEkg/rdMyBi1zLcGgb
         kG9UyM7QvDQt6/gyruxnVRVPh4bEn1SA7S15XQD+sCuEvnZwS5V0m0UZ2WUfiS7kGt/o
         KOSalCRVwjjlOrkKF+1BbRO5fc3Is5FFjiQofntqV9R1YRXZUz9i23Sd67s98jBvGZpR
         7d5hDAxKf6vj+aAq7ROXKiIOCyPFP6d3X+3t+ZlmCXGpCQzZ4O6esKVg4ZzC7xvIGmqP
         qwlRgdXRlMgEOs2LpnHO+/3f7QEeNKRHpZSpynqpt2QhwIEeN7BUBv0NlFlp/MuQvg76
         /ouA==
X-Gm-Message-State: APjAAAV0BuHvSAIhHknc7Q/TXeW3MeUDWpOiR5ibQBveraUuzKSrtmq2
        sA+orkWzd3vyH847zFOOsb+I7xgkSg8uRHRsCw7KVg==
X-Google-Smtp-Source: APXvYqyj4Aatv69dlAadiIjvQkKrFOmtKVUEAXTrY26bsCZQniXxKF6YEvWkiWspo7D4QwkGrRITwKtofHpQlj7uwuY=
X-Received: by 2002:adf:f641:: with SMTP id x1mr26688501wrp.179.1566873681968;
 Mon, 26 Aug 2019 19:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190819051345.81097-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1908261704500.10109@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908261704500.10109@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 27 Aug 2019 08:11:10 +0530
Message-ID: <CAAhSdy0XALGpc-bCuO7njiBT3p-YvLqhMnRTRu4Hd4gMKeQMTw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Fix FIXMAP area corruption on RV32 systems
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 5:43 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Hello Anup,
>
> On Mon, 19 Aug 2019, Anup Patel wrote:
>
> > Currently, various virtual memory areas of Linux RISC-V are organized
> > in increasing order of their virtual addresses is as follows:
> > 1. User space area (This is lowest area and starts at 0x0)
> > 2. FIXMAP area
> > 3. VMALLOC area
> > 4. Kernel area (This is highest area and starts at PAGE_OFFSET)
> >
> > The maximum size of user space aread is represented by TASK_SIZE.
> >
> > On RV32 systems, TASK_SIZE is defined as VMALLOC_START which causes the
> > user space area to overlap the FIXMAP area. This allows user space apps
> > to potentially corrupt the FIXMAP area and kernel OF APIs will crash
> > whenever they access corrupted FDT in the FIXMAP area.
> >
> > On RV64 systems, TASK_SIZE is set to fixed 256GB and no other areas
> > happen to overlap so we don't see any FIXMAP area corruptions.
> >
> > This patch fixes FIXMAP area corruption on RV32 systems by setting
> > TASK_SIZE to FIXADDR_START.
>
> This part -- the TASK_SIZE change -- makes sense to me.
>
> However, the patch also changes FIXADDR_SIZE to be defined in terms of
> page table-related constants.  Previously, FIXADDR_SIZE was based on
> __end_of_fixed_addresses, as it is for most other architectures. The part
> of the patch that changes FIXADDR_SIZE seems unrelated to the actual fix.
>
> If that's indeed the case -- that the change to FIXADDR_SIZE is unrelated
> from the fix -- could you please split that into a separate patch, with a
> description of the rationale?  I think I understand why you're proposing
> it, but it seems odd to explicitly connect it to page table-related
> constants, rather than the contents of "enum fixed_addresses", and I'm
> reluctant to merge that part of this patch without a bit more discussion.

The FIXADDR_SIZE change is related to the TASK_SIZE requirement and
it is not a separate change because:

1. TASK_SIZE must be evenly divisible by PGDIR_SIZE. The FIXADDR_START
is defined as (FIXADDR_TOP - FIXADDR_SIZE). The original FIXADDR_SIZE
defined in-terms of __end_of_fixed_addresses is not a multiple of PGDIR_SIZE
hence it makes sense to make FIXADDR_SIZE as PGDIR_SIZE.

2. Let say we ignore point1 above then still we cannot continue to express
FIXADDR_SIZE in-terms of __end_of_fixed_addresses because of cyclic
header dependency where asm/fixmap.h includes asm/pgtable.h and
__end_of_fixed_addresses is defined in asm/fixmap.h. We certainly need
to move FIXADDR_TOP, FIXADDR_START, and FIXADDR_SIZE to
asm/pgtable.h so that we can express TASK_SIZE as FIXADDR_START
for RV32. If we don't simplify FIXADDR_SIZE then it will result in compile
errors.

Regards,
Anup

>
>
> > We also move FIXADDR_TOP, FIXADDR_SIZE, and FIXADDR_START defines to
> > asm/pgtable.h so that we can avoid cyclic header includes.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Tested-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> > Changes since v1:
> > - Drop braces from "#define FIXADDR_TOP"
> > ---
> >  arch/riscv/include/asm/fixmap.h  |  4 ----
> >  arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
> >  2 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> > index 9c66033c3a54..161f28d04a07 100644
> > --- a/arch/riscv/include/asm/fixmap.h
> > +++ b/arch/riscv/include/asm/fixmap.h
> > @@ -30,10 +30,6 @@ enum fixed_addresses {
> >       __end_of_fixed_addresses
> >  };
> >
> > -#define FIXADDR_SIZE         (__end_of_fixed_addresses * PAGE_SIZE)
> > -#define FIXADDR_TOP          (VMALLOC_START)
> > -#define FIXADDR_START                (FIXADDR_TOP - FIXADDR_SIZE)
> > -
> >  #define FIXMAP_PAGE_IO               PAGE_KERNEL
> >
> >  #define __early_set_fixmap   __set_fixmap
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index a364aba23d55..c24a083b3e12 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -420,14 +420,22 @@ static inline void pgtable_cache_init(void)
> >  #define VMALLOC_END      (PAGE_OFFSET - 1)
> >  #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> >
> > +#define FIXADDR_TOP      VMALLOC_START
> > +#ifdef CONFIG_64BIT
> > +#define FIXADDR_SIZE     PMD_SIZE
> > +#else
> > +#define FIXADDR_SIZE     PGDIR_SIZE
> > +#endif
> > +#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
> > +
> >  /*
> > - * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
> > + * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
> >   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
> >   */
> >  #ifdef CONFIG_64BIT
> >  #define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
> >  #else
> > -#define TASK_SIZE VMALLOC_START
> > +#define TASK_SIZE FIXADDR_START
> >  #endif
> >
> >  #include <asm-generic/pgtable.h>
> > --
> > 2.17.1
> >
>
>
> - Paul
