Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D4BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C7D2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YwxCRQ0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEOKed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:34:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44897 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEOKed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:34:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id w25so1110558qkj.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBnzaBIfj+VJI+Xtrd1Dlp5yMK/LG93WwPhwqIDDvn4=;
        b=YwxCRQ0Sftfr2BZal7AHb+p7cshOTkpVOdkSUGAChfZfPJbU6wba/NR76m4J30rnFT
         iBBMrikElQYf6bsXWI93nYm2OXWc8wOSuuxMuoyQgrQIsV2ccOvzgronYIMhL940cz8N
         jolmhnNoGaiC+eqT26fs74q5eJmU6K9lXIg3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBnzaBIfj+VJI+Xtrd1Dlp5yMK/LG93WwPhwqIDDvn4=;
        b=FFLRWcRkzWtwb06ExHMBL3U2juOsMCH4UmVY0ad3lKxOd4K3vav6uuW7eskVN/XDU6
         lcvT8z9F1o8agPKx2jrHDA2qxO4Q2FG7ze1BZSOxldHkRlCr8NtgCfEKa9T3j18Iy/3f
         V+nbmXjs69LbCgK6gi9kKk0z71mOmYqhmxhIaWhQW4KQOA9wNtfvOZDPBmZNnl8EewMb
         xY41AjnBDWFwc6Vj9ajAa/zPqX2GxazXmktjyHK/Te0rtvjmpqIEkqkP7CRNEEehBJm1
         PhlGWFaMnUs+SOmmdH3oFZ1h84sG4dWD2z5/QFSH8vR1UmSh4P96FVqopKHCwUCMv2Ed
         3m1w==
X-Gm-Message-State: APjAAAWgJNPYxgBp+vqzBvlUABKDwiQ5DRdk7epCSwuMkYkgOxxD3LFO
        b+fIZb+1Esa+bilXN15XWj8LGchINMF7ASHIV8j9ew==
X-Google-Smtp-Source: APXvYqxzaWty/pcJA3F9yFKN3kO92+0zWjAvItmiZ8fb0cYKsHAr5CMq7sSvA2KfS3dKL0erckWodpEpqMDQwVQNbc4=
X-Received: by 2002:a05:620a:1278:: with SMTP id b24mr31171654qkl.265.1557916472423;
 Wed, 15 May 2019 03:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190513003819.356-1-hsinyi@chromium.org> <20190513003819.356-2-hsinyi@chromium.org>
 <20190513085853.GB9271@rapoport-lnx> <CAJMQK-hKrU2J0_uGe3eO_JTNwM=HRkXbDx2u45izcdD7wqwGeQ@mail.gmail.com>
 <155786794318.14659.2925897827978978040@swboyd.mtv.corp.google.com> <20190515050059.GA4081@rapoport-lnx>
In-Reply-To: <20190515050059.GA4081@rapoport-lnx>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 15 May 2019 18:34:06 +0800
Message-ID: <CAJMQK-hGyuM=+C0ZPUbUwMqH8zPoYPF43L8oMP=p8MUeXrco4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] amr64: map FDT as RW for early_init_dt_scan()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 1:01 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > Why not just have fixmap_remap_fdt() that maps it as RW and reserves
> > memblock once, and then call __fixmap_remap_fdt() with RO after
> > early_init_dt_scan() or unflatten_device_tree() is called? Why the
> > desire to call memblock_reserve() twice or even three times?
>
> There's no desire to call memblock_reserve() twice. It's just that leaving
> the call for it in kaslr rather than in setup_arch() may end up with
> unreserved FDT because kaslr was disabled or even compiled out.
>
> I've suggested to use fixmap_remap_fdt() everywhere because IMHO this
> improves readability and allows to un-export __fixmap_remap_fdt().
>
> --
> Sincerely yours,
> Mike.
>

How about adding an arch hook that's not limited to be called at init
(like fixmap_remap_fdt). In this way we don't have to change currently
arm64 setup structure and only map fdt to RW before we need to modify
it (and can map back to RO after write). Since it can be called after
init, for CONFIG_KEXEC, we can also use it before updating fdt with a
new seed.

Does nothing by default, and for arm64 it can be like[1].
It's similar to __fixmap_remap_fdt on counting fdt size but using
update_mapping_prot() (will flush the TLBs).
And suppose fixmap_remap_fdt() is called at least once, region
checking is skipped.

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8080c9f489c3..e0fff8a009da 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/of_fdt.h>

 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -919,6 +920,22 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
        return dt_virt;
 }

+extern phys_addr_t fdt_pointer;
+
+/* Should be called after fixmap_remap_fdt() is called. */
+void update_fdt_pgprot(pgprot_t prot)
+{
+       u64 dt_virt_base = __fix_to_virt(FIX_FDT);
+       int offset, size;
+
+       offset = fdt_pointer % SWAPPER_BLOCK_SIZE;
+       size = fdt_totalsize((void *)dt_virt_base + offset);
+
+       update_mapping_prot(round_down(fdt_pointer, SWAPPER_BLOCK_SIZE),
+                       dt_virt_base,
+                       round_up(offset + size, SWAPPER_BLOCK_SIZE), prot);
+}
+


example use:
update_fdt_pgprot(PAGE_KERNEL);
fdt_delprop(initial_boot_params, node, "rng-seed");
update_fdt_pgprot(PAGE_KERNEL_RO);

I tested on arm64 device and it works. But if this doesn't seems
right, I'll probably just don't don't map fdt back to RO if kexec is
set.

Is this reasonable?

Thanks!
