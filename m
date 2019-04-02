Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B072082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ayT/ztXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfDBJaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:30:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43846 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDBJaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:30:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so15648776wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oc09Dl5VnJwNMkzVxQL/s8VkqouE05vipzjBnfAum/g=;
        b=ayT/ztXlSmBKMpQwSMaxTN51wM33NPCBOSG+5gtD8y3PoCRK4M019isdENEEynH6ME
         jzoqV7Tu7vSudN/XKBPR8YaW7YupqNZwf2xdu3NphyA0CALKBvqaP1BaXSyjosYSu0xb
         QvUEyiwL5H4xIATAACmbSBqVP/M02oeH12eCd4ZV258cJKLaXJyvOyKOHJHIrWRtRW/t
         GEmRzVt5hwDafwcaZ3oB0B2vpKaHUq6sKkAP+sypceJS9SpKx9nHFNJlxkaqWX4ACxJT
         Urm56miRVpONQzXa+vBpttnZl64Ul+Qr6oIaIoujxsS/HXyQlEt5narvzTZgzG+tvlUq
         QISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oc09Dl5VnJwNMkzVxQL/s8VkqouE05vipzjBnfAum/g=;
        b=VFh9BxzYWywqpXcjQl2Fk9tajHZQN8L1fSVfh8AOQT1Bp3pp9X4BAbUZkZEr19Xe4/
         3/rKYlqNTHLwzMVY2STGyb3FO71zVT1pjB7rVsjqGV8BYZwxYSNmr6JZWpln2oPqyHfv
         Q0ubRgWGmPmoQ5xB1Y7e8HVISOluNIHTw7tQqgniDJunIPRfSAQGet2muZ8P3kJfkAN7
         kdlfNzGLbD1K/ba89FsNEY+ENl1F9NXW5WXhEvOQ+KM72HO+NObePsa2fx4F4jP2TYX8
         22dqSriwjBKnHnzZjIDXL/utdFjjZMQg/i0mYev4SYl8VnImwWE16N6UPsyjL6++9XlC
         vlkw==
X-Gm-Message-State: APjAAAVehT7lLbwxfXp/faHNLONA7YoHDjLoWos8ExR7XPG2G8YxdWCX
        Rpc3zZAPWNFKvhwU21E4Ejk650W3TLyMBTHcOV+jLYh8fLH0Bw==
X-Google-Smtp-Source: APXvYqyFWTZHBcs2XIO+GnPstQbUDpk0E07Pkxe2eCsN9M1fUoaDiiVuB5MoMgVHoOMU7SlmTTwRtGT9Q7PTcOO9WCA=
X-Received: by 2002:adf:f80d:: with SMTP id s13mr42907151wrp.38.1554197414056;
 Tue, 02 Apr 2019 02:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190402055902.14017-1-anup.patel@wdc.com> <20190402083456.GA2153@rapoport-lnx>
In-Reply-To: <20190402083456.GA2153@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 2 Apr 2019 15:00:02 +0530
Message-ID: <CAAhSdy1ZFW1zAqc-7904SOse-tWKOmpY3dCHb5Xe6U6KNno_JQ@mail.gmail.com>
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
>
> Frankly, I fail to understand the logic behind setting PAGE_OFFSET to
> MAXPHYSMEM and then using PAGE_OFFSET as the limit for accessible physical
> memory. Still, as it is there, you can set MAX_MEMBLOCK_ADDR=PAGE_OFFSET in
> arch/riscv/include/page.h and then early_init_dt_add_memory_arch() will
> simply ignore the memory above PAGE_OFFSET.

Little explanation about current code ...

The current code, assumes PAGE_OFFSET to have value such that
upper-bits are 1s lower bits are 0s.
For example,
0xc0000000 (32bit),
0xffffffff80000000 (64bit), and
0xffffffe000000000 (64bit)

For above PAGE_OFFSET values, -PAGE_OFFSET is size of virtual
address space and maximum supported physical memory is also
-PAGE_OFFSET hence MAXPHYMEM is tied with -PAGE_OFFSET.

If we try to force some arbitrary PAGE_OFFSET then things break.

Regards,
Anup
