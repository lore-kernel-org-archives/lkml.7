Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4896EC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150E82184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="nL8FCkBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfHSEtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:49:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34921 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHSEtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:49:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so374423wmg.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60R/A+kC11q0AvPf3oQzvFsQ9aUEzwZLL3SNB5rWKEw=;
        b=nL8FCkBRIA9ZswKPpogtISq5zl3WUFiheZbLSi4QEdbvtLimsxQoQLIeMP5JtAlFDb
         ykekZsfnKLDai2fFfF6b69ku6rZ1zeROwWKbI1b80N6JfI5MB8jllwsI5CFVXgQuuuxN
         e9UCBmJsfHCY8xOf0ovTQbF9ScYF5/EckXpbRiSxJ3tI8PWZ3Tceg/KpRmzFp9H0hT/h
         WP6bXwT6hKDIXh27OqGvbD8AYcnweAMzQLz8+kZVzsJPT0fkkD8qOmmPWNI6aikATE3u
         39AKL36oW88Kc2Qvtj9T1hqdFnJN3ANrwExyfgA+wg1rrEtxGzcqwoRbpbzWelINbDYn
         rBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60R/A+kC11q0AvPf3oQzvFsQ9aUEzwZLL3SNB5rWKEw=;
        b=twSFI1yweVsXoOsKOJCJr733VaIw6+TADyw0PVp9reWLZdt5SJfmr4wYl2lwDLEzkB
         N/Ma4X1v0cKo5XQCj1OLlyJU8jjKKrxiigDWoc5KHAx3DOrWUGRhsAZyg1CG7qKV0eT8
         Mv6qOB49hxXeo/H5T1l03KIkzgIyH3efvsXaVX84YMQlqz/8XXwvm79W85xh3ttO5Y7U
         DCblaB5y2J5KjDgy6ls6DiHKmuVCvQVBqjB/vNnKMX9hNaH514jhPXyZ84s0gGYIrTAe
         9Zvu88Onxms0TPp9Zg2eBQOh31jMLP2ukeqMY2UgF9v5B/yi4xqZNSwcGeIPCPCf14R0
         mI6Q==
X-Gm-Message-State: APjAAAW+c24MOgXAoGFD05GAjvrhp7ARdAkPiU6LJKn/FdrP8YL5DtL1
        G78CTGXOz3SuSTuAI3cnH9OSY1w/CU745B4dcDQsRA==
X-Google-Smtp-Source: APXvYqxjwK3ZIYOpOhKcI+ZBVXW0UrOARuiEJ/I30F5R0lum5iB1rSe5G2ZIrcY+TLebQjGbo3iHZYOLbYqMwmqWLr8=
X-Received: by 2002:a1c:c909:: with SMTP id f9mr5518379wmb.52.1566190152793;
 Sun, 18 Aug 2019 21:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190816114915.4648-1-anup.patel@wdc.com> <20190818181914.GB20217@infradead.org>
In-Reply-To: <20190818181914.GB20217@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 19 Aug 2019 10:19:01 +0530
Message-ID: <CAAhSdy1arxoekV4p3so=2PtTtBCvT61sz+uDbaZ=e11p7b5DXg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix FIXMAP area corruption on RV32 systems
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 11:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +#define FIXADDR_TOP      (VMALLOC_START)
>
> Nit: no need for the braces, the definitions below don't use it
> either.

Sure, I will update and send v2 soon.

>
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
>
> Mentioning the addresses is a little weird.  IMHO this would be
> a much nicer place to explain the high-level memory layout, including
> maybe a little ASCII art.  Also we could have one #ifdef CONFIG_64BIT
> for both related values.  Last but not least instead of saying that
> something should be dividable it would be nice to have a BUILD_BUG_ON
> to enforce it.
>
> Either way we are late in the cycle, so I guess this is ok for now:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> But I'd love to see this area improved a little further as it is full
> of mine fields.

I agree with you. We also have Sparsemem and KASAN patches which
touch virtual memory layout so it's important to have virtual memory layout
documented clearly. I can add the required documentation as separate patch.

I think the best place to add ASCII art would be asm/pgtable.h where all
virtual memory related defines are placed. Suggestions??

Regards,
Anup
