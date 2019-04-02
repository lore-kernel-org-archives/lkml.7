Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50991C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135602084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="FJtet8aS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfDBJNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:13:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54199 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbfDBJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:13:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so2502532wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q74t7NN5KCgRUd8vrDluJPXV/cl64LRr+PLNp1Onwko=;
        b=FJtet8aSMrHIxCPgrGZZq3a2FWDJYLRUBw2QNrr8i6+f0MmuAioeF2Op+BNf99UaTb
         7QOwLInIsx8OMX1BzxvbzntYQvZQNzV0rxuZaO1yPRpI3zt/Erwjpvdqboh5odwfOQtE
         VvUN3TATrfZ0lpSDU50XNIwowrMdAyvTZ6W5RCYNmJ5yWuEQrAKlOPJkhcr+MBIdHJkD
         NcTf4XjNPOWmmvoGTdsz4aN303dzLaPkTCXQ2JuT1spxC4AjYOMHMSk0ulBJBN5o2+Z/
         X3+m3cwAwxwEqiypSOQopIkwPZeWbX8F+bs3oCeXxCZyThi/gQAE9QHTDfKoHD/xMkaP
         TSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q74t7NN5KCgRUd8vrDluJPXV/cl64LRr+PLNp1Onwko=;
        b=EnqwSob6b6RjlVcIZBGne6XMG6mXk3EyFwWdS7ec0xpXVJDBD7rg4na0J6I9Wi1MWC
         2R2JItCjwq9WbxJEbSB0gX8MA7Z7qa4YciFI2AR0L3GLRwxKAn5aHxwXjRLvlkmUbs0r
         sfi6F0CbyW1EWwnIcIKoIWcMRvUGNS1aimEyUyz8Agl1RmMd+p0m5PRxoCIj8S/q2dy5
         XLsZXa4VwqrwF55Z0lVYrV8+fpUYKiE4hCANGZfRtMbRL7NmtH8XDp+Qwwk9cc/Qdjxd
         pJegznQN5yApPNeKbbXN9qZM4+0cfBML3Y+9eFLhmo13tWigzx6e30LboijlSGdxURMZ
         UebQ==
X-Gm-Message-State: APjAAAUUyOrNOt1PDEhtsgiY/g4c2RAOVxkGjSF5XSg38PlDiOjo66xT
        h5vdzx/QTQg0vMHp5Bf5L4RCdxyrALQ94olrXwrGfp37irw=
X-Google-Smtp-Source: APXvYqwpDpGjzU5x4g8eAmSJoM3Gq2RV/LP/bFaBQGBrSk+DJzhJwL8qXLT/Vo+RFCKwOSGDdd2sVwspJuRU6k6J5ps=
X-Received: by 2002:a1c:81cc:: with SMTP id c195mr2897995wmd.61.1554196423236;
 Tue, 02 Apr 2019 02:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190402055902.14017-1-anup.patel@wdc.com> <20190402083456.GA2153@rapoport-lnx>
In-Reply-To: <20190402083456.GA2153@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 2 Apr 2019 14:43:31 +0530
Message-ID: <CAAhSdy2Umjz-=+qsEhpsDyF6bmZfL42=fQe7RffNeMX8P4AYaQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix Maximum Physical Memory 2GiB option for 64bit systems
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 2:05 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Apr 02, 2019 at 06:02:38AM +0000, Anup Patel wrote:
> > The Maximum Physical Memory 2GiB option for 64bit systems is currently
> > broken because kernel hangs at boot-time when this option is enabled
> > and the underlying system has more than 2GiB memory.
> >
> > This issue can be easily reproduced on SiFive Unleashed board where
> > we have 8GiB of memory.
> >
> > This patch fixes above issue by reserving unusable memory region in
> > setup_bootmem().
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/mm/init.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 5fd8c922e1c2..6b063f20a9d0 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -121,6 +121,14 @@ void __init setup_bootmem(void)
> >                        */
> >                       memblock_reserve(reg->base, vmlinux_end - reg->base);
> >                       mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
> > +
> > +                     /*
> > +                      * Reserve from the end of usable area to the end of
> > +                      * region
> > +                      */
> > +                     if ((reg->base + mem_size) < end)
> > +                             memblock_reserve(reg->base + mem_size,
> > +                                              end - reg->base - mem_size);
>
> The memory above MAXPHYSMEM should not be reserved. It should be either
> removed from memblock with memblock_remove or not added at the first place.

Sure, I will try memblock_remove() instead of memblock_reserve().

>
> Frankly, I fail to understand the logic behind setting PAGE_OFFSET to
> MAXPHYSMEM and then using PAGE_OFFSET as the limit for accessible physical
> memory. Still, as it is there, you can set MAX_MEMBLOCK_ADDR=PAGE_OFFSET in
> arch/riscv/include/page.h and then early_init_dt_add_memory_arch() will
> simply ignore the memory above PAGE_OFFSET.
>
> More sustainable fix for the long term, IMHO, would be to break
> PAGE_OFFSET and MAXPHYSMEM interdependency.

I agree with you. There is too much dependency on PAGE_OFFSET value.

Another thing that I had attempted in my setup_vm() patches, is to reduce
initial page tables memory consumption by making page table array size
independent of -PAGE_OFFSET.

Regards,
Anup
