Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59497C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB94206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="BYMulcOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfC1JxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:53:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34284 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfC1JxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:53:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so22057050wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhA1qdRHEXWJUF9ewlQbprtaxlTvnHssd0Yr2vmSUhU=;
        b=BYMulcOUPLgEeyeLI4wbm/JXS9MwOLz5b7TIjN2cpUB5w1g9mekqEdnF45oAyH2mDM
         uXLL1XYXzsAg3AqmLb+iwleGyQ4ngjZ8YRIUKKx5c4sGYZy14Rhygmd/5u62uduuBeR7
         F+mc2Cu8sm450bIPpaJQnDQ+agIMi0S76TeVZwTTMIVUGUCbxChPxnz+t/SEteGBesg7
         LeNJwSOlhu8LKPfDENdCGuIqQLM/Dwn0mpgdLreLRPZbhXDOgG64RHdte6oijZS0vyEd
         x/g/HRqow+V6B4o0gd1+dJmZqjdYjdpCnp4Hl22mm8jhRpu0GMC9pMB4CBxB+LDJ2R7R
         6rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhA1qdRHEXWJUF9ewlQbprtaxlTvnHssd0Yr2vmSUhU=;
        b=DGwKugGBwTtUm6JOZsX/JdyVDzqkWMktcdtzubmS0PJj6bIu8NZMV8b9eh6j5kZ2p3
         0b0KVXSpvtirpCk8K+sp/Q7havrajQAT4xNCukgnv0083bQQigBYiQfY71ym6hjugU3r
         jflf5Rn7YYpdkV7++kZChd7ixDXCMYFjONEMR33wy8PTbmwqN1IooVt73yU+PFXIbSEf
         BX16py83XjlycEPijgZE85wxLTCwYREhpDvvIE1bSfs2g+3EVfJXf48RYX5pn+VRNvaI
         E7LHAJAJ3VnuFV5/s1fHlTvTlHlCSaXL3XinI1fonJVN5O0yz2jigJ1ZhlB6EYO2wD+Q
         L6XQ==
X-Gm-Message-State: APjAAAVseWX7GjHsOyIQFFSx+PpQGRAT7n4qYRBP71YPA4q8FpNbXp+P
        RbVEWcFpAM0tvcc9nh6bMynlHNMCwEcr5y3yub5i2UhCokg=
X-Google-Smtp-Source: APXvYqz2Z/87jFTLbsOqO8EdDrWPIMgjY0k8QKqRKQu30h+XFb11vYvJQ/iNhdbZASNsI7fVA9fqXG3iyeinfH72Qts=
X-Received: by 2002:adf:9427:: with SMTP id 36mr27906412wrq.128.1553766790178;
 Thu, 28 Mar 2019 02:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190325092234.5451-1-anup.patel@wdc.com> <20190325092234.5451-5-anup.patel@wdc.com>
 <20190325113935.GD27843@infradead.org> <CAAhSdy2dds7pp8=XX+zbKbMoWbgjPxP6r4aMZJeHyqHV2MP4CQ@mail.gmail.com>
 <20190325145919.GB14826@infradead.org> <CAAhSdy2je-_=AHPawbV-8cUR0P7WvqDZ5wNdEmDVQkR-a88Eog@mail.gmail.com>
 <20190327075441.GA29894@infradead.org> <20190328075526.GC14864@rapoport-lnx>
In-Reply-To: <20190328075526.GC14864@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 28 Mar 2019 15:22:58 +0530
Message-ID: <CAAhSdy3URWHVY_GPNb2yRBuctRELRtTTWPM2OpwUVSRFAyXyiA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] RISC-V: Allow booting kernel from any 4KB aligned address
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        me@anthonycoulter.name
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:25 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Mar 27, 2019 at 12:54:41AM -0700, Christoph Hellwig wrote:
> > On Mon, Mar 25, 2019 at 09:46:59PM +0530, Anup Patel wrote:
> > > > Why do you even care about kernel mappings for non-existant ram.
> > >
> > > We care because there will always be some buggy kernel driver/code going
> > > out-of-bound and accessing non-existent RAM. If we by default map all
> > > possible kernel virtual address then behaviour of buggy accesses will be
> > > unpredictable.
> > >
> > > Further, I think we should also make .text and .rodata sections of kernel
> > > as read-only. This will protect kernel code and rodata.
> >
> > All of that is useful at the final_setup_vm() time - but none of it
> > matters during early setup_vm where life is complicated.
> >
> > Mike suggested on the previous iteration that you only do smaller
> > mappings when setting up the final mapping to avoid the ops churn,
> > and I fully agree with him.
> >
> > So I would suggest we avoid complicated the fiddly early boot changes
> > that just add complxity, and you instead redirect your efforts to
> > say implemented proper ro and non-executable sections using 4k mappings
> > in the final VM setup only.  That should actuall lead to less code
> > and complexity, and provide more benefits.
>
> It might be worth keeping trampoline_pg_dir if we are to split setup_vm().
> Then setup_vm() will only initialize the trampoline_pg_dir and
> final_setup_vm() will setup the swapper_pg_dir and switch to it.
> Otherwise final_setup_vm() would need to update live mappings which might
> be fragile.
>

We finally know the purpose trampoline_pg_dir page table.

The trampoline_pg_dir is suppose to contain only one 2M/4M mapping
to handle case where PAGE_OFFSET < load_address.

For 64bit systems, the PAGE_OFFSET is very high value typically
0xFFFFxxxxxxxxxxxx compared to RAM start 0x80000000. It is very
unlikely that we will have enormous RAM ending somewhere
0xFFFFxxxxxxxxxxxx.

For 32bit systems, it is quite possible that bootloader loads kernel at
load_address > 0x80000000. Let say PAGE_OFFSET = 0xC0000000
and load_address = 0xC0100000. Now the instruction which enables
MMU will be 0xC0100xxx and after enabling it will try to fetch next
instruction 0xC0100xxx + 4 but 0xC0100000 maps to 0xC0200000
as load_address > PAGE_OFFSET hence we will see wrong instruction
after enabling MMU.

(Note: Above explanation was provided by Anthony)

I guess we will have to keep both trampoline_pg_dir and swapper_pg_dir
init in setup_vm() because trampoline_pg_dir will only contain just
one 2M/4M mapping.

Regards,
Anup
