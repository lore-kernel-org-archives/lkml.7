Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AB9C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C23204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfDSTwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:52:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43166 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfDSTwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:52:50 -0400
Received: by mail-io1-f65.google.com with SMTP id x3so5164276iol.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EquybNfivVd7iyASULDNQsV8V7M9xg3yLB6OIuuy8BU=;
        b=qRj/vZ4t0t/yskOfDgo+mNip87NOLswGkRUjiAK1TmUsxm1zEoaytzWOfFfJBFr9L6
         useVXofo5YbJEdVTWzvKVEstunf478PeAlY2fXlpLF+YlxUSe9djSQxWe4Cu+WiTqh91
         mElWG/5Rjg1Ni9IVSMSJ5YJQEvGgMeBfVC3qPIUgVairnKge9ewKHE0HemxETz0UhhjC
         nk2nybQTAO9z6NtglWZMromXuOqSpcA8V3/XuzsZwMLlLlOE+4nwlZ64XAVHC0X/OPKM
         ELxmX1FU8Xi3bO1oVUUARwFTs8RIuh80uEriPj/1oKhjy6Xk0aXiH1lw8UNu1fAO0Yrr
         4J3Q==
X-Gm-Message-State: APjAAAVvSEdfIz1AXsn1Gwp9z01SIRGMOhJYKXrUfREliRbgDdDjqlFF
        854iT8urBUpNZw6OeUAhFx1+IT9rpk41ZnLjjyaOWHhhvVN4qA==
X-Google-Smtp-Source: APXvYqx/lRq5G+I9J4h/9Q5ybgcajR33xdeupqPjDWAXeCJNJ2FDnq84r/hR3vAPlYkkeWba4KG5xKCRtOQkaBfz9YQ=
X-Received: by 2002:a6b:6509:: with SMTP id z9mr1913841iob.43.1555666779770;
 Fri, 19 Apr 2019 02:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190416095209.GG27892@zn.tnic> <20190419083458.503-1-kasong@redhat.com>
 <20190419085804.GD11060@MiWiFi-R3L-srv>
In-Reply-To: <20190419085804.GD11060@MiWiFi-R3L-srv>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 19 Apr 2019 17:39:28 +0800
Message-ID: <CACPcB9ebt2pGuyDaevehU6B9dcKduGKNTo12qsE-gFXYBpiYjg@mail.gmail.com>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 4:58 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 04/19/19 at 04:34pm, Kairui Song wrote:
> >  /* Locates and clears a region for a new top level page table. */
> >  void initialize_identity_maps(void)
> >  {
> > -     /* If running as an SEV guest, the encryption mask is required. */
> > -     set_sev_encryption_mask();
> > -
> > -     /* Exclude the encryption mask from __PHYSICAL_MASK */
> > -     physical_mask &= ~sme_me_mask;
> > -
> > -     /* Init mapping_info with run-time function/buffer pointers. */
> > -     mapping_info.alloc_pgt_page = alloc_pgt_page;
> > -     mapping_info.context = &pgt_data;
> > -     mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
> > -     mapping_info.kernpg_flag = _KERNPG_TABLE;
> > -
> > -     /*
> > -      * It should be impossible for this not to already be true,
> > -      * but since calling this a second time would rewind the other
> > -      * counters, let's just make sure this is reset too.
> > -      */
> > -     pgt_data.pgt_buf_offset = 0;
> > -
> > -     /*
> > -      * If we came here via startup_32(), cr3 will be _pgtable already
> > -      * and we must append to the existing area instead of entirely
> > -      * overwriting it.
> > -      *
> > -      * With 5-level paging, we use '_pgtable' to allocate the p4d page table,
> > -      * the top-level page table is allocated separately.
> > -      *
> > -      * p4d_offset(top_level_pgt, 0) would cover both the 4- and 5-level
> > -      * cases. On 4-level paging it's equal to 'top_level_pgt'.
> > -      */
> > -     top_level_pgt = read_cr3_pa();
> > -     if (p4d_offset((pgd_t *)top_level_pgt, 0) == (p4d_t *)_pgtable) {
> > -             debug_putstr("booted via startup_32()\n");
> > -             pgt_data.pgt_buf = _pgtable + BOOT_INIT_PGT_SIZE;
> > -             pgt_data.pgt_buf_size = BOOT_PGT_SIZE - BOOT_INIT_PGT_SIZE;
> > -             memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
> > -     } else {
> > -             debug_putstr("booted via startup_64()\n");
> > -             pgt_data.pgt_buf = _pgtable;
> > -             pgt_data.pgt_buf_size = BOOT_PGT_SIZE;
> > -             memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
> > +     top_level_pgt = early_boot_top_pgt;
> > +     if ((p4d_t *)top_level_pgt != (p4d_t *)_pgtable)
> >               top_level_pgt = (unsigned long)alloc_pgt_page(&pgt_data);
>
> Kairui, will you make a patchset to include these changes separately
> later on? I don't get the purposes of code changes. E.g here, I
> don't know why you introduce a new variable early_boot_top_pgt, and
> allocate the page table, even though they have been done in the old
> initialize_identity_maps().
>
> Thanks
> Baoquan
>

OK, right, it's not a good idea to mess up things together, I'll
resend the patch, and will sent the cleanup separately. Without clean
up it may bring in some extra burden with certain kernel config, but
that should be OK for the fix.

-- 
Best Regards,
Kairui Song
