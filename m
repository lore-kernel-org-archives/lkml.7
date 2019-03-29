Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404D8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E8C218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAQET9er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfC2VlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:41:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42730 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbfC2VlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:41:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so3354383otd.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ntsor/qCmdjkWmlOoyynMkE4TxeGboUKg9xj07HF+bY=;
        b=mAQET9ertk4bfpkPDVy7Rd90XBuMFVYHFHEHIjjTGcYzg4/ZEAmCOSXAOF7P2edmcE
         mgvrx2lTDVYxfsp9vL8Z3csVu767QmQms2BdqoN2bP+F/zXP91s8BsBfx+P+NJqvXuoj
         isA9OkdbEGB+6CVQVg66fV++SyDb1uT9X0JTnuekWfh4XEDcQXO+K5FkYkJ/TO4WKOb3
         sQW4i643IrU3/756KmObKTfYIdCw8klGe+KxCxux5IQud3IN/fZDugzDf/OjfXZQZuSO
         yt72cWTi27gtLSoypazdolqvdL0+0dbbaqYHxIaiQZnGDoM3u2E6emll4tMnhxjpmMYf
         l5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ntsor/qCmdjkWmlOoyynMkE4TxeGboUKg9xj07HF+bY=;
        b=hGz7GpF8wKHmi2BFv2QaLfk82fdHCU24Zx34s7nYur2EzI7VLSgzJ+OtVYkZBa8PBk
         x8J/Mmug+PVN6BPpbolhnTUksox35je+hln+72mI2Jwj8ybZp5GYkfe7fiGspmDFkWyI
         hwnc45c48SvMsbkfKjA5Pnac+17L1wgyg6F6KpfJV2ZQEQViR45ADCSCWdTYbdu4W7ce
         OSplsXjbYjUreWA1xMxLEbaxJzBcfpSP5DLD3vmbgX/VE+c4Q2wpYKwcxYko3EmyLCBS
         0jPCDl4jLLsxIFR8Bwe5O5jMLOFhydiPx6D8rHHWIGul3kKCsPw9v//ikds6DsgdzYti
         Z6ig==
X-Gm-Message-State: APjAAAUGENoqid5NI2K1Vfg0k5UpqOMEj/t9nlQgqOSVY0iX4Kd2+J+y
        6/wDcysmZclVseex3L35Nd1pAK1JtkZP3GijSmWhEA==
X-Google-Smtp-Source: APXvYqyXmqk0SaQBMyL7tl0d2tNueh24Z5B3HMn2BdasJQeT7LOLOxsaKd+ESYa92O+pEdP5+As4EtjrFFtoeiBWPJI=
X-Received: by 2002:a05:6830:1216:: with SMTP id r22mr11054399otp.198.1553895676071;
 Fri, 29 Mar 2019 14:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190328225925.241998-1-jannh@google.com> <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
 <CAG48ez3UE6cnA0TZQ-7DUnB_QWPFV04bJsv9oKXfgBtu=ugBLw@mail.gmail.com>
 <CAG48ez13xg1oUiO_pyDHVbJkWRQdW4CoX7uGzoujyf4L6VB-dw@mail.gmail.com> <3275e86a-5b12-29ff-9b1f-d8eba099ae98@deltatee.com>
In-Reply-To: <3275e86a-5b12-29ff-9b1f-d8eba099ae98@deltatee.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Mar 2019 22:40:50 +0100
Message-ID: <CAG48ez1e=vHZqRp7=rQCvOjJnHjQtR5wQKZ69jOAZChto7RDCA@mail.gmail.com>
Subject: Re: [PATCH] x86/calgary: fix bitcast type warnings
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Muli Ben-Yehuda <mulix@mulix.org>,
        Jon Mason <jdmason@kudzu.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        iommu@lists.linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:32 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> On 2019-03-29 3:19 p.m., Jann Horn wrote:
> >>> Can the existing api's not be used here like iowrite64be/ioread64be/ or
> >>> similar variant in "include/asm-generic/io.h"
> >>
> >> Oooh! I didn't realize that those exist. I'll change that and send a v2.
> Yes, they are very new! It took me a while to get those patches in as it
> is a bit more complicated than it seems.
>
> > Actually, that doesn't work at the moment on x86-64:
> >
> > include/asm-generic/io.h only defines these things if
> > CONFIG_GENERIC_IOMAP isn't defined; and X86 unconditionally defines
> > it. With CONFIG_GENERIC_IOMAP set, these functions are provided by
> > include/asm-generic/iomap.h.
>
> For CONFIG_GENERIC_IOMAP, lib/iomap.c provides _lo_hi and _hi_lo
> implementations seeing the pio regions must be emulated with 32bit
> operations and we have to define the order.
>
> > The definitions for these are in lib/iomap.c, except that there are no
> > definitions for ioread64be() and iowrite64be(); if you try to use
> > them, you get linker errors.
>
> Some platforms implement these but most do not. If I recall correctly
> only powerpc does.
>
> If you want to use 64 bit operations in a portable fashion, you should
> include "linux/io-64-nonatomic-hi-lo.h" or
> "linux/io-64-nonatomic-lo-hi.h", depending on weather you want the lower
> bits or the higher bits to be written or read first in cases where an
> atomic operation is not available.

So what is the right thing to do in the context of
arch/x86/kernel/pci-calgary_64.c? That code wants to perform MMIO with
endianness conversion, and these accesses are always performed as
MMIO. Using the non-atomic 64-bit I/O helpers for this would be kind
of awkward, since the accesses would never actually be split...
