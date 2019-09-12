Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AC1C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA9C20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568296985;
	bh=W/mFNJBuhBpmbDbmK2QLeeqrvyKptqabZ5ypFqgATbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kD+t8cbJuv6TLQ3wONQisGmv4Zd3KFTfWFoM0t/hln4fLiRGUwvy6gQpUDQjSsnAk
	 WFBicpsaTbUu0NmuRdrgQXrmAwnEN9qIF/x6kNE0aZuOJc4kdobjOPkcXpPkeQufYA
	 2wabn2sy+GMlRMt3UFLUhDw3fimRPChj11zHQbiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfILODE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731971AbfILODE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:03:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBFBA20856;
        Thu, 12 Sep 2019 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568296983;
        bh=W/mFNJBuhBpmbDbmK2QLeeqrvyKptqabZ5ypFqgATbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zZWoHe9qke0fWfFJOlp7u5U6VNJ/lxOM6p5vMkZZFDleEdE1MM1auzRRZd1JCYzZN
         nCbzbEtEpYAkC86lEARz1IW1i5vUYhqPWk9cRUWCg/5A3JAdcXl5MG4tPAjfsJj/+m
         puXi1FKE2G+rPXBGADanJd04R0aDp5LpwZKXyxes=
Date:   Thu, 12 Sep 2019 15:02:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Guo Ren <guoren@kernel.org>
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
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Message-ID: <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
References: <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
 <20190619091219.GB7767@fuggles.cambridge.arm.com>
 <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
 <20190619123939.GF7767@fuggles.cambridge.arm.com>
 <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
 <20190624104006.lvm32nahemaqklxc@willie-the-truck>
 <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 07:52:55AM +0800, Guo Ren wrote:
> On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org> wrote:
> > > I'll keep my system use the same ASID for SMP + IOMMU :P
> >
> > You will want a separate allocator for that:
> >
> > https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.brucker@arm.com
> 
> Yes, it is hard to maintain ASID between IOMMU and CPUMMU or different
> system, because it's difficult to synchronize the IO_ASID when the CPU
> ASID is rollover.
> But we could still use hardware broadcast TLB invalidation instruction
> to uniformly manage the ASID and IO_ASID, or OTHER_ASID in our IOMMU.

That's probably a bad idea, because you'll likely stall execution on the
CPU until the IOTLB has completed invalidation. In the case of ATS, I think
an endpoint ATC is permitted to take over a minute to respond. In reality, I
suspect the worst you'll ever see would be in the msec range, but that's
still an unacceptable period of time to hold a CPU.

> Welcome to join our disscusion:
> "Introduce an implementation of IOMMU in linux-riscv"
> 9 Sep 2019, 10:45 Jade-room-I&II (Corinthia Hotel Lisbon) RISC-V MC

I attended this session, but it unfortunately raised many more questions
than it answered.

Will
