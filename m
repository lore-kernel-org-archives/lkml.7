Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099AEC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FBD21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="2JxvFy0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfEUHi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:38:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32966 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:38:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so1646332wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hyv8dbu1hXdVe8oH/C/wgPhiFce8VkAWKoNE8lVkSkE=;
        b=2JxvFy0ZoOzBLDEIiB+zZywTTKxMZm8uWiW4+G2QZV9sw9JxK1R9VdWTIXtCLg1n+w
         nAMaeaocUuXeeHDF2xPoj/C9FWwLpOI9ywmD7LiOJ8OwG7c//6QVdfNtg74bHeM1R7Pe
         v1xEHkVaQqBDCGJYNl2QDNL7qqG4if2mvXLPT2ruJWXyyVHUmdIkZTzv/E9hv+0qZsLW
         GCHuhRGIi531rD0AN1hToSSqWuBHrEBXJDvbP+BqsaqNMuk6GH3kbjyiXVR5TebJRHQr
         7mMA4U1Ld45CAI226Na4YMcm2/qxMDEqEQZO6yLrbeyvnxJ6zlaxyo/zYkK/RDdPqrbj
         oWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hyv8dbu1hXdVe8oH/C/wgPhiFce8VkAWKoNE8lVkSkE=;
        b=E0AdVnJs9F/Z5ePxnsZm2zm7gwEt+E4l4aOgnXeeq3aHL9gezB3lMaugDHW0epOEYZ
         5gKY9k4rOrYvvLraxHnmRzPUPQPZQFDXKd27RbcV4sfiAP8WrBwNlYQLgV/GAmP4b6SN
         joO4LW9uIl1JEHs+pIgZLESY76hGKNkJrCdKJjSnfK0F99mlkABRzd79kOr3FbnKMyoD
         /mY3Hjg1NbrdrzRfjFkDllsLCPa9yVWb/yOvfEd1o3Dk7aZyS4qUARrf4M5QlWh+DNd8
         WcAYPso7LJv/e4yawHd6b67kkyINR7m/LdCU8rff3DKAH+ZBchaXIJdW5NdS0oOlJ8Iz
         5Adg==
X-Gm-Message-State: APjAAAXkAwZTvZbdiAH9TCwiX8tDKQmobcgB0yE2IA1LPbEjiVSf+u/C
        GNLA87BaP3Fdx1zkORxAuasExCmx5LxcAJS4FwqAUg==
X-Google-Smtp-Source: APXvYqyP/kpDyd3HWL14CFb1aLrUrRlH/V5SRi6DWJCY7A1hpuXU2SkaVukqmredWu44P35iRvx6HnyqGZhTa6UVc8Q=
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr2117204wmh.55.1558424305961;
 Tue, 21 May 2019 00:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190502050206.23373-1-anup.patel@wdc.com> <20190502050206.23373-3-anup.patel@wdc.com>
 <20190520114352.GA5372@infradead.org>
In-Reply-To: <20190520114352.GA5372@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 21 May 2019 13:08:14 +0530
Message-ID: <CAAhSdy2SRxMEaJE6WsP87KeXw_J1X-6eYAMV7j0bhEGgNcLiyg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] RISC-V: Setup initial page tables in two stages
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 5:13 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> >  void __init parse_dtb(unsigned int hartid, void *dtb)
> >  {
> > -     if (early_init_dt_scan(__va(dtb)))
> > +     dtb = (void *)fix_to_virt(FIX_FDT) + ((uintptr_t)dtb & ~PAGE_MASK);
> > +     if (early_init_dt_scan(dtb))
>
> FYI, parse_dtb in mainline now lost the hartid argument and takes a
> phys_addr_t for the dtb address.

Okay, this patch is based on 5.1 kernel. I guess I will have to rebase
it anyway.

>
> That being said I find the above way to magic.  So we take the fixmap
> address and then only the offset from something passed as a pointer?
> This just looks very weird.  The way FIX_FDT is defined to add to my
> confusion, which might partially be due to not understanding fixmaps
> very well.  But it seems like at very least we should set up an
> actual kernel pointer for the dtb in setup_vm based on what that
> gets passed and stop passing any arguments to parse_dtb to keep
> that magic in one place.  And possibly add some comment.

I agree with your suggestion. I will setup early_dtb_ptr in setup_vm()
and use it here.

FYI, the fixmap virtual address range is not covered by linear va-to-pa
translation (i.e. __va() and __pa() cannot be used). The mapping
granularity of fixmap is always PAGE_SIZE hence add offset to
fix_to_virt(FIX_FDT).

>
> > +#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
>
> It seems MAX_EARLY_MAPPING_SIZE is defined to a fix constant,
> why do we need these conditionals?

Sure, I will remove the conditional. It's totally redundant. I forgot to
remove it previously.

Regards,
Anup
