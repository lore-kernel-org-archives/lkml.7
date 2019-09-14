Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA41C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 08:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B7B2089C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 08:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568450998;
	bh=J9o3/Ce1+YLaWOJS+1y9FmaoiXDLsFcat/B4OJD07xQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y6N0QomgMeV6+v7xKnE2Io+499uJK1gwg/DYoxHCT7QboiIEs8v4LC0okV2l29i1p
	 MzrQbRjyljpI9ivWTnzsi6qiuh2rb20jK2Bbo7jpF6b7Cr7LTozNPAOjJ6iyCQbHqU
	 X4bCRxBKV3cKwdq88Pb6rVRcw9VWlk/D75AwLPcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfINIt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 04:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfINIt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 04:49:56 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1529214AE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568450995;
        bh=J9o3/Ce1+YLaWOJS+1y9FmaoiXDLsFcat/B4OJD07xQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NvC0HAkbO+X0R/hUr5ElgQAkn9X+DlHgQCaI+WUT3QaLpkyww7ouKYCiu+gLQdPnN
         Zt2iNLvAcaA/7M7mBWG5GC72IVnUlLTjmJnBCwL8Gs+y4/DomRNvqSFSk4OlGnDjoe
         Dtl/nAegdQl/qfiWPrj/maTEs4oYOJwLv1kg+bio=
Received: by mail-wr1-f54.google.com with SMTP id h7so33183776wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 01:49:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXL4ES9vmkPCU9QSCvU1NGXsCh9sXKGi7o0DZ/soVqn0XviDIAs
        In0ILWQIl/OF8Mna9SUHYjC9QM29Y1XwUFpdrKY=
X-Google-Smtp-Source: APXvYqxg6MtzWsHNFmLRbH0IHgwRMp+vQZNFO479wjLXexAnH2ZbcUXa06WI/GBB3zidLYAHo44uDXvnrwuUeLiSDAI=
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr5204507wrr.343.1568450992705;
 Sat, 14 Sep 2019 01:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190321163623.20219-12-julien.grall@arm.com> <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com> <20190619091219.GB7767@fuggles.cambridge.arm.com>
 <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
 <20190619123939.GF7767@fuggles.cambridge.arm.com> <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
 <20190624104006.lvm32nahemaqklxc@willie-the-truck> <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
 <20190912140256.fwbutgmadpjbjnab@willie-the-truck> <CAJF2gTT2c45HRfATF+=zs-HNToFAKgq1inKRmJMV3uPYBo4iVg@mail.gmail.com>
 <CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
In-Reply-To: <CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 14 Sep 2019 16:49:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTKFwRN6vG3+fQK8BRFskeURjv-Ziv_qb7nc9MSKw0bLA@mail.gmail.com>
Message-ID: <CAJF2gTTKFwRN6vG3+fQK8BRFskeURjv-Ziv_qb7nc9MSKw0bLA@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Will Deacon <will@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>, julien.thierry@arm.com,
        aou@eecs.berkeley.edu, james.morse@arm.com,
        Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anup Patel <anup.Patel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Julien Grall <julien.grall@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, gary@garyguo.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        christoffer.dall@arm.com, linux-riscv@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the presentation, any comments is welcome.

https://docs.google.com/presentation/d/1sc295JznVAfDIPieAqzjcyUkcHnNFQsK8FF=
qdoCY854/edit?usp=3Dsharing

On Fri, Sep 13, 2019 at 3:13 PM Guo Ren <guoren@kernel.org> wrote:
>
> Another idea is seperate remote TLB invalidate into two instructions:
>
>  - sfence.vma.b.asyc
>  - sfence.vma.b.barrier // wait all async TLB invalidate operations finis=
hed for all harts.
>
> (I remember who mentioned me separate them into two instructions after se=
ssion. Anup? Is the idea right ?)
>
> Actually, I never consider asyc TLB invalidate before, because current ou=
r light iommu did not need it.
>
> Thx all people attend the session :) Let's continue the talk.
>
>
> Guo Ren <guoren@kernel.org> =E4=BA=8E 2019=E5=B9=B49=E6=9C=8812=E6=97=A5=
=E5=91=A8=E5=9B=9B 22:59=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Thx Will for reply.
>>
>> On Thu, Sep 12, 2019 at 3:03 PM Will Deacon <will@kernel.org> wrote:
>> >
>> > On Sun, Sep 08, 2019 at 07:52:55AM +0800, Guo Ren wrote:
>> > > On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org> wrote:
>> > > > > I'll keep my system use the same ASID for SMP + IOMMU :P
>> > > >
>> > > > You will want a separate allocator for that:
>> > > >
>> > > > https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.bruc=
ker@arm.com
>> > >
>> > > Yes, it is hard to maintain ASID between IOMMU and CPUMMU or differe=
nt
>> > > system, because it's difficult to synchronize the IO_ASID when the C=
PU
>> > > ASID is rollover.
>> > > But we could still use hardware broadcast TLB invalidation instructi=
on
>> > > to uniformly manage the ASID and IO_ASID, or OTHER_ASID in our IOMMU=
.
>> >
>> > That's probably a bad idea, because you'll likely stall execution on t=
he
>> > CPU until the IOTLB has completed invalidation. In the case of ATS, I =
think
>> > an endpoint ATC is permitted to take over a minute to respond. In real=
ity, I
>> > suspect the worst you'll ever see would be in the msec range, but that=
's
>> > still an unacceptable period of time to hold a CPU.
>> Just as I've said in the session that IOTLB invalidate delay is
>> another topic, My main proposal is to introduce stage1.pgd and
>> stage2.pgd as address space identifiers between different TLB systems
>> based on vmid, asid. My last part of sildes will show you how to
>> translate stage1/2.pgd to as/vmid in PCI ATS system and the method
>> could work with SMMU-v3 and intel Vt-d. (It's regret for me there is
>> no time to show you the whole slides.)
>>
>> In our light IOMMU implementation, there's no IOTLB invalidate delay
>> problem. Becasue IOMMU is very close to CPU MMU and interconnect's
>> delay is the same with SMP CPUs MMU (no PCI, VM supported).
>>
>> To solve the problem, we could define a async mode in sfence.vma.b to
>> slove the problem and finished with per_cpu_irq/exception.
>>
>> --
>> Best Regards
>>  Guo Ren
>>
>> ML: https://lore.kernel.org/linux-csky/



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
