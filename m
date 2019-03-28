Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89171C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52243206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="eZpNA8cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfC1KYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:24:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33220 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1KYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:24:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so22180072wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWlYvfOObBZY1CN9rzeBvDWTjXjv0i6VqvWKQU37Yy0=;
        b=eZpNA8cdzCGf2AtLKROLLZ9cxAOCS8zx0Du45GYbvDAGvdkxzoe3RHV5gP24rQxFsG
         WA/MjlnTtKuRUjSzR1UP3T+5Nr2fkrn3WYuQnwci13oPt5QTXmR141L6s+zYWQNsy17L
         NSqqQ5MmtJ4samK4xvaOL+g30/XZTZZ9zkpNIPGvYmmAOt0I2FO0LXw4aqWeIC6D+PC+
         1dCJ6b29nuO9uK3baHJY3T37DRhhv0yR3+WdH/itCfT3EOaPNppzERE9438dFEMdtw1R
         1X1JVle40QZ5AHLfy6GB7WIO/ac3wSKxFENi2D3obi3TN4bBNcA0LD/Zldb+3sfjS+md
         pr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWlYvfOObBZY1CN9rzeBvDWTjXjv0i6VqvWKQU37Yy0=;
        b=X5KWbgezngNlFT+h2F/1R2QL6J+xGKwO6S+eLfhle22NVJBKHt7F49bZlDZDAkbJs4
         WI++Y+hdx8CUaf1N0t+Aag6HHCOXBqmPz/suedvVGEndMo4YcG5+k4/hfJna7ppXkd+I
         5STuL2R/YJ9wnFfKOFU9O37bLf2MATsav0dIT+Nudz85D9dKnk4/5q9qjYpDnve4J+2o
         RZV0ueMvNTZHg6qHYNNaIQ9YveHwMYjVXub+YREMSIYNBwmCHiRCIA52BxMo4gtKBn0y
         sAaWW8Mh4OAX1mwzE8BtWYpJZxnwctwNgEuE8B7W8njKnCBZMIWEbIRQ+6hyO1ssab3r
         JhPQ==
X-Gm-Message-State: APjAAAWqHxLsTUKqDnLJ0NJAvC2MhbRWoB/7MeNsLNhv/ne+QOw6T/E8
        xZeP5W7ajTpGU6fyL/JI1o8sAjovQMsRzO9+BLW4qA==
X-Google-Smtp-Source: APXvYqwIUCm7BwmxyVm4IQN//+s5P94fUfjd32llHQkj6aF1tVknwU7UIi2AfK1ElwLziO+dcFq0lMmPhgbCQTuiars=
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr13435721wrx.187.1553768672809;
 Thu, 28 Mar 2019 03:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190325092234.5451-1-anup.patel@wdc.com> <20190325092234.5451-5-anup.patel@wdc.com>
 <20190325113935.GD27843@infradead.org> <CAAhSdy2dds7pp8=XX+zbKbMoWbgjPxP6r4aMZJeHyqHV2MP4CQ@mail.gmail.com>
 <20190325145919.GB14826@infradead.org> <CAAhSdy2je-_=AHPawbV-8cUR0P7WvqDZ5wNdEmDVQkR-a88Eog@mail.gmail.com>
 <20190327075441.GA29894@infradead.org> <20190328075526.GC14864@rapoport-lnx> <CAAhSdy3URWHVY_GPNb2yRBuctRELRtTTWPM2OpwUVSRFAyXyiA@mail.gmail.com>
In-Reply-To: <CAAhSdy3URWHVY_GPNb2yRBuctRELRtTTWPM2OpwUVSRFAyXyiA@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 28 Mar 2019 15:54:21 +0530
Message-ID: <CAAhSdy0iXct2L9g2+SGQMo-eBw3-LOveLiKFWh6Y8u42FsuAFw@mail.gmail.com>
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

On Thu, Mar 28, 2019 at 3:22 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, Mar 28, 2019 at 1:25 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Wed, Mar 27, 2019 at 12:54:41AM -0700, Christoph Hellwig wrote:
> > > On Mon, Mar 25, 2019 at 09:46:59PM +0530, Anup Patel wrote:
> > > > > Why do you even care about kernel mappings for non-existant ram.
> > > >
> > > > We care because there will always be some buggy kernel driver/code going
> > > > out-of-bound and accessing non-existent RAM. If we by default map all
> > > > possible kernel virtual address then behaviour of buggy accesses will be
> > > > unpredictable.
> > > >
> > > > Further, I think we should also make .text and .rodata sections of kernel
> > > > as read-only. This will protect kernel code and rodata.
> > >
> > > All of that is useful at the final_setup_vm() time - but none of it
> > > matters during early setup_vm where life is complicated.
> > >
> > > Mike suggested on the previous iteration that you only do smaller
> > > mappings when setting up the final mapping to avoid the ops churn,
> > > and I fully agree with him.
> > >
> > > So I would suggest we avoid complicated the fiddly early boot changes
> > > that just add complxity, and you instead redirect your efforts to
> > > say implemented proper ro and non-executable sections using 4k mappings
> > > in the final VM setup only.  That should actuall lead to less code
> > > and complexity, and provide more benefits.
> >
> > It might be worth keeping trampoline_pg_dir if we are to split setup_vm().
> > Then setup_vm() will only initialize the trampoline_pg_dir and
> > final_setup_vm() will setup the swapper_pg_dir and switch to it.
> > Otherwise final_setup_vm() would need to update live mappings which might
> > be fragile.
> >
>
> We finally know the purpose trampoline_pg_dir page table.
>
> The trampoline_pg_dir is suppose to contain only one 2M/4M mapping
> to handle case where PAGE_OFFSET < load_address.
>
> For 64bit systems, the PAGE_OFFSET is very high value typically
> 0xFFFFxxxxxxxxxxxx compared to RAM start 0x80000000. It is very
> unlikely that we will have enormous RAM ending somewhere
> 0xFFFFxxxxxxxxxxxx.
>
> For 32bit systems, it is quite possible that bootloader loads kernel at
> load_address > 0x80000000. Let say PAGE_OFFSET = 0xC0000000
> and load_address = 0xC0100000. Now the instruction which enables
> MMU will be 0xC0100xxx and after enabling it will try to fetch next
> instruction 0xC0100xxx + 4 but 0xC0100000 maps to 0xC0200000
> as load_address > PAGE_OFFSET hence we will see wrong instruction
> after enabling MMU.
>
> (Note: Above explanation was provided by Anthony)
>
> I guess we will have to keep both trampoline_pg_dir and swapper_pg_dir
> init in setup_vm() because trampoline_pg_dir will only contain just
> one 2M/4M mapping.
>
> Regards,
> Anup

I think we should go ahead with your suggestion but with additional
constraint as follows:

1. The setup_vm() will map only vmlinux_start to vmlinux_end and
FDT for early mapping in trampoline_pg_dir
2. The setup_vm() will hit BUG_ON() if load_address is between
vmlinux_start and vmlinux_end.
3. The setup_vm_final() will create swapper_pg_dir from scratch
to avoid updating live mappings

The point2 above essentially means that on 32bit/64bit systems
the bootloader cannot load kernel in physical address range
PAGE_OFFSET to PAGE_OFFSET + (vmlinux_size) even if
it is a valid RAM physical address range.

Suggestions??

Regards,
Anup
