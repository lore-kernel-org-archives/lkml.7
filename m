Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DFDC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7DF20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ER+E7dCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgAAShC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 13:37:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40518 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgAAShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:37:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id w21so46329256otj.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 10:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8+LgrDTXxrAyzAw0RwZGEpTji/oOjaXA22yzdPDbF0=;
        b=ER+E7dCHHwS2LyjRD/sibbzhy4ilLrTDS0sxOpsAWtNtWZJIzJ4UsXI3Xuc0X39nFR
         G26VajH34OccYtdr+Spk/68MUyy6L3p5BLJ9hOzQd2yrRlszfiDp47kYOZaYTgEKf4os
         T4voUx1tZuDlevN8qv5QBHIjfqke6x6qv3H10OFOoCExN9dsWBS4BBZsYFLPPMO1Zkar
         nbwwUioLXnA/2pNkAakYWqCGgsqFk7LnlpZyEHUxuu7ebvKiM99vhN9fMMZbCV3a6XCN
         hIIp37SNuEpLr9F/Ypn7IhoqWkyhVkrYKWeb/1cuAT+i001byfj4LipH4tE5sGrd3Ypm
         a2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8+LgrDTXxrAyzAw0RwZGEpTji/oOjaXA22yzdPDbF0=;
        b=hOuXUU05EaMDOQx+vJAb10YKlHxn2SSAnViyfQyI03+OzBRR/b1fPeCYzbmwEsH2ES
         vwDXYC9cOV79OZ3FmGlJFex3PgilIIqZPeIQiEYdSZRMedFPXVhekuUECwp6a9VaSH1n
         i8gY4qLgpR5+OmAnIYuhtr0rxZv/1guX//T57FHJBbnybthsE8Nu+6TgF7lq70F38l7G
         YPm/EZmeo2JSQ5B364pUTsKiongo5tP4OEcWlp63HiKjArEeXBnx1rXyNtP1LKbAR4LN
         17KWnn2fkpnqrGk6KRbvdGI4G5xI0madsOW49chapDw+r3JBp+PBsV70rs5ZG2jJz9lr
         tgUw==
X-Gm-Message-State: APjAAAUzIW5TuaxxS/MQExDecHosvlmbDTPPV92udMEzE5oRtqZn/NiY
        fOQSVlL4TesbJO+8gfWlP7jDn1PmzrPYEZtYwjlL3Q==
X-Google-Smtp-Source: APXvYqxWXdgchp08m0zeoknzHEMFoL9O+rhOarc8rGB6n6O+4jpJ7xdl8iJQjfEJCFf7EFr4drxCSnfwuKevgQPjq8w=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr50572049oto.207.1577903821166;
 Wed, 01 Jan 2020 10:37:01 -0800 (PST)
MIME-Version: 1.0
References: <157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157782987865.367056.15199592105978588123.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200101045141.GA15155@dhcp-128-65.nay.redhat.com> <CAPcyv4hSB9B5tiKVwtNOgDS6KS2Pj6f962OPBZVZpPjrBt6Z8A@mail.gmail.com>
 <20200101061505.GA15717@dhcp-128-65.nay.redhat.com> <20200101062047.GA16393@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200101062047.GA16393@dhcp-128-65.nay.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Jan 2020 10:36:50 -0800
Message-ID: <CAPcyv4ivPw7Z8y0yBT4j41=cgLqGjKafHHB==h=cC8aXvHK7Kw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] efi: Fix handling of multiple efi_fake_mem= entries
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, kexec@lists.infradead.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 10:21 PM Dave Young <dyoung@redhat.com> wrote:
>
> > > Does kexec preserve iomem? I.e. as long as the initial translation of
> > > efi entries to e820, and resulting resource tree, is preserved by
> > > successive kexec cycles then I think we're ok.
> >
> > It will not preserve them automatically, but that can be fixed if
> > needed.
> >
> > There are two places:
> > 1. the in kernel loader, we can do similar with below commit (for Soft
> > Reseved instead):
> > commit 980621daf368f2b9aa69c7ea01baa654edb7577b
> > Author: Lianbo Jiang <lijiang@redhat.com>
> > Date:   Tue Apr 23 09:30:07 2019 +0800
> >
> >     x86/crash: Add e820 reserved ranges to kdump kernel's e820 table
>
> Oops, that is for kdump only, for kexec, should update the kexec e820
> table.  But before doing that we need first to see if this is necessary.

We can cross that bridge later, but I expect it will eventually be
necessary. The soft-reservation facility will become more prevalent as
more platforms ship with DRAM differentiated memory ranges, like
high-bandwidth-memory, and the system needs to reserve it from general
kernel allocations. See commit 262b45ae3ab4 "x86/efi: EFI soft
reservation to E820 enumeration" and commit fe3e5e65c06e "efi:
Enumerate EFI_MEMORY_SP" for more details.
