Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41DC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6B1206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SgPNHmHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbfIPS3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:29:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35982 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfIPS3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:29:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so280312plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Jp6I/WhdjgXBrLm8XFTV/W2CbBlPUTPrifY9W91dfHI=;
        b=SgPNHmHUI3s6Y5U+Q0BVqT7wuZAahYN9Sp7bvK/WkhmSDCYSm5A+2HKPWAwtkqtGXp
         9J3gPqcUCHFjkPsRUuU3/KOZR1hYBqyd/MNpI1ipdxi9pUvmGf4l8CrTHsTBzP2tIBQ8
         hFmy5Ft2frUue4ny34BBNvYMvx8XYRjMj04QJzEGKwueGRY2SpndnAROT9qoBFdw5EJm
         pmSgIzCOb60ekhNb5wLkLoTTOYA6xXYpqBLK5btuPldjQ2T2RWcShbymrS2g+P20jTDk
         J+EEppal95vaxj+HdoxekXNZMooOdG9AHCiBegMOADmYTE4Cj6LN4ZjAIM8hUT2YUY+H
         p7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Jp6I/WhdjgXBrLm8XFTV/W2CbBlPUTPrifY9W91dfHI=;
        b=YoHkkPPF83LhpSpJS3M1mGJHUZj8uA6C0cVqVOCMOyeDkCd+eU652g+ekG617JCop7
         isGAA8dLnO9IDyeRh+CDVn3foLA7mQssSEIr1f2lVb4oIrEI2iPgXbDmmuBTgfD4F23o
         ZPTJ6VQXC2h1W0p/DIFLqOeAvzDhnyJ+j6Eul5rpyIlbBAtOaFvnyJI3cZ206cEkKzyn
         d8xADaJwdVzVD2ec+HheVPdMD+/KurQDIog973fxLo9WLmSAxTQHTTspvtUdhb99hJ2H
         41djr3fY4htv3oMggLy7zjZILIPEUiiAYVIC/ocu04j2FW2/MgAI9f7ngT7Biifc2GOJ
         xIVQ==
X-Gm-Message-State: APjAAAWmy2cWz0wbYhSHnlhdsSLtQvUeKctwKru0+bA0hKSZMB9I5XOo
        sEEAB/IXL4JWjY3xZ+Tf6y280Q==
X-Google-Smtp-Source: APXvYqyPLzCNMj7vNHvNiodpwn0FVuHbfPgpqBsoZRBBK2pBoeehbEWH1qRowZP5cnYDV+iwsY1UPQ==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr1093510plm.31.1568658539014;
        Mon, 16 Sep 2019 11:28:59 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a4sm12595350pfn.110.2019.09.16.11.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:28:58 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:28:58 -0700 (PDT)
X-Google-Original-Date: Mon, 16 Sep 2019 11:28:52 PDT (-0700)
Subject:     Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a separate file
In-Reply-To: <20190916181800.7lfpt3t627byoomt@willie-the-truck>
CC:     Anup Patel <Anup.Patel@wdc.com>, guoren@kernel.org,
        Will Deacon <will.deacon@arm.com>, julien.thierry@arm.com,
        aou@eecs.berkeley.edu, james.morse@arm.com,
        Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>, julien.grall@arm.com,
        gary@garyguo.net, Paul Walmsley <paul.walmsley@sifive.com>,
        christoffer.dall@arm.com, linux-riscv@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     will@kernel.org
Message-ID: <mhng-11e0cc7f-264b-4412-9424-2357bc27dcb3@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019 11:18:00 PDT (-0700), will@kernel.org wrote:
> On Sun, Sep 15, 2019 at 05:03:38AM +0000, Anup Patel wrote:
>>
>>
>> > -----Original Message-----
>> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
>> > owner@vger.kernel.org> On Behalf Of Palmer Dabbelt
>> > Sent: Saturday, September 14, 2019 7:31 PM
>> > To: will@kernel.org
>> > Cc: guoren@kernel.org; Will Deacon <will.deacon@arm.com>;
>> > julien.thierry@arm.com; aou@eecs.berkeley.edu; james.morse@arm.com;
>> > Arnd Bergmann <arnd@arndb.de>; suzuki.poulose@arm.com;
>> > marc.zyngier@arm.com; catalin.marinas@arm.com; Anup Patel
>> > <Anup.Patel@wdc.com>; linux-kernel@vger.kernel.org;
>> > rppt@linux.ibm.com; Christoph Hellwig <hch@infradead.org>; Atish Patra
>> > <Atish.Patra@wdc.com>; julien.grall@arm.com; gary@garyguo.net; Paul
>> > Walmsley <paul.walmsley@sifive.com>; christoffer.dall@arm.com; linux-
>> > riscv@lists.infradead.org; kvmarm@lists.cs.columbia.edu; linux-arm-
>> > kernel@lists.infradead.org; iommu@lists.linux-foundation.org
>> > Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
>> > separate file
>> >
>> > On Thu, 12 Sep 2019 07:02:56 PDT (-0700), will@kernel.org wrote:
>> > > On Sun, Sep 08, 2019 at 07:52:55AM +0800, Guo Ren wrote:
>> > >> On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org> wrote:
>> > >> > > I'll keep my system use the same ASID for SMP + IOMMU :P
>> > >> >
>> > >> > You will want a separate allocator for that:
>> > >> >
>> > >> > https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.bruck
>> > >> > er@arm.com
>> > >>
>> > >> Yes, it is hard to maintain ASID between IOMMU and CPUMMU or
>> > >> different system, because it's difficult to synchronize the IO_ASID
>> > >> when the CPU ASID is rollover.
>> > >> But we could still use hardware broadcast TLB invalidation
>> > >> instruction to uniformly manage the ASID and IO_ASID, or OTHER_ASID in
>> > our IOMMU.
>> > >
>> > > That's probably a bad idea, because you'll likely stall execution on
>> > > the CPU until the IOTLB has completed invalidation. In the case of
>> > > ATS, I think an endpoint ATC is permitted to take over a minute to
>> > > respond. In reality, I suspect the worst you'll ever see would be in
>> > > the msec range, but that's still an unacceptable period of time to hold a
>> > CPU.
>> > >
>> > >> Welcome to join our disscusion:
>> > >> "Introduce an implementation of IOMMU in linux-riscv"
>> > >> 9 Sep 2019, 10:45 Jade-room-I&II (Corinthia Hotel Lisbon) RISC-V MC
>> > >
>> > > I attended this session, but it unfortunately raised many more
>> > > questions than it answered.
>> >
>> > Ya, we're a long way from figuring this out.
>>
>> For everyone's reference, here is our first attempt at RISC-V ASID allocator:
>> http://archive.lwn.net:8080/linux-kernel/20190329045111.14040-1-anup.patel@wdc.com/T/#u
>
> With a reply stating that the patch "absolutely does not work" ;)
>
> What exactly do you want people to do with that? It's an awful lot of effort
> to review this sort of stuff and given that Guo Ren is talking about sharing
> page tables between the CPU and an accelerator, maybe you're better off
> stabilising Linux for the platforms that you can actually test rather than
> getting so far ahead of yourselves that you end up with a bunch of wasted
> work on patches that probably won't get merged any time soon.
>
> Seriously, they say "walk before you can run", but this is more "crawl
> before you can fly". What's the rush?

I agree, and I think I've been pretty clear here: we're not merging this ASID 
stuff until we have a platform we can test on, particularly as the platforms we 
have now already need some wacky hacks around TLB flushing that we haven't 
gotten to the bottom of.

> Will
