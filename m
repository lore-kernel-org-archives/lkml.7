Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76828CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395342084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="nLqN5enM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733307AbfJWGMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:12:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52156 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfJWGMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:12:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id q70so12581736wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8le1WyXyeTyUa/Z2e+egXbBte2l9NNmas2pvZ4/syo=;
        b=nLqN5enMDqEAYntQA8O/U/OLZ4Os+aQ+ZzD6WpMcCZPacskczuoFfQR/hGWkoU+qOp
         595KTJObybNJe9Yttsbv8w+eQaSRN5172hZMY0c+ng/c8nFcuKqh0+x8h5L/o1sSCnkl
         Tzb5YM+U54tWEeSy9vlmVeLVLP1Wd0dfEMDdABMF52bEAMkxkJOjap7woq9L3SAmBg4H
         mP6BWpEyDTn4JzFMckLEhhs86iwEk9RvbU114w9e1Nx9vS/RR/8IOD0qy8YdzCfFbzxF
         PxLMZ4GLbHfN8VrRdRGJQSkXhY9qQTbLuqJ9Dt5yo7c65rL4e9gZEvI/SsXphv9Ovsn8
         y6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8le1WyXyeTyUa/Z2e+egXbBte2l9NNmas2pvZ4/syo=;
        b=oFaVYU6i4ReYnzqiOIP+yBLZ4slpjF6EqzQe7INO3dsVI/qHJhyshxeKCP1nsiY+Kb
         IbA4TPcB0f52gjnuyr7tMxALsZv8c05JM5pxQ2usxEJqlCaaREpOqcOL0GQNp+VQ77Pq
         kD+YVodvLKglW6poXTmW+aHkX99lpEwIv9rg3YjX7MqUR40KXh76AI1zh29Wxcl9x4HG
         yWK5u5Q+Tvx/eohmhSctgXEasGDqjb3yPIorCoRfj1/0xayO6ACnx7Evcn3AAH2WpXFU
         J4lF8F9QY0ZY9tR8ZoF5AXNGDel1Ai9rQiAU6YBQXcJ2fxZeWzHaEq+BSJjVtkaPQS2r
         cmMw==
X-Gm-Message-State: APjAAAW6kv5YIrUddAoemiNvQx21W5oD24SkmrW9N+JpRH0Cq44NWu97
        H2GddNP9/SI6bGs8bYvlCUu+t87Ak7xvs9N1pspdTA==
X-Google-Smtp-Source: APXvYqwyEoWUB1RH8jQxZgTmcn4QkfgMMeY3guAKffsaUXZDLVEqxRSPGnVR9jTgjqmizV+GwpDTEsSdSI25dby9QBs=
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr5690896wmk.24.1571811163897;
 Tue, 22 Oct 2019 23:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190925063706.56175-3-anup.patel@wdc.com> <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4>
 <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com>
 <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
 <17db4a6244d09abf867daf2a6c10de6a5cd58c89.camel@wdc.com> <alpine.DEB.2.21.9999.1910221751500.25457@viisi.sifive.com>
 <CAAhSdy3KccuzC0pV6Jy_diLwkdgb=SdHBQnsSoGrgpu6g7TCQA@mail.gmail.com> <alpine.DEB.2.21.9999.1910222250490.5600@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910222250490.5600@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 23 Oct 2019 11:42:32 +0530
Message-ID: <CAAhSdy00_snfqstOg1KVookNm8kG9gW=S-7fugzv+awtk+HBmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:30 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Wed, 23 Oct 2019, Anup Patel wrote:
>
> > On Wed, Oct 23, 2019 at 6:37 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > > Incidentally, just looking at drivers/platform/goldfish, that driver seems
> > > to be some sort of Google-specific RPC driver.  Are you all really sure
> >
> > Nopes, it's not RPC driver.  In fact, all Goldfish virtual platform
> > devices are MMIO devices.
>
> Is drivers/platform/goldfish/goldfish_pipe.c required for the Goldfish RTC
> driver or not?

No, it's not required.

>
> If not, then the first patch that was sent isn't the right fix.  It would
> be better to remove the Kbuild dependency between the code in
> drivers/platform/goldfish and the Goldfish RTC.

The common GOLDFISH kconfig option is there to specify the
common expectations of all GOLDFISH drivers from Linux ARCH
support.

Currently, all GOLDFISH drivers require HAS_IOMEM and
HAS_DMA support from underlying arch.

If you still think that common GOLDFISH kconfig option is not
required then please go ahead and send patch.

>
> If it is required, then surely there must be a simpler RTC implementation
> available.

GOLDFISH pipe is not required so GOLDFISH RTC is certainly
a simple RTC implementation.

>
> > The problem is VirtIO spec does not define any RTC device so instead of
> > inventing our own virtual RTC device we re-use RTC device defined in
> > Goldfish virtual platform for QEMU virt machine. This way we can re-use
> > the Linux Goldfish RTC driver.
>
> With 160+ RTC drivers in the kernel tree already, we certainly agree that
> it doesn't make sense to invent a new RTC.
>
>
> - Paul

Regards,
Anup
