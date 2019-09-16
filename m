Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477AFC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE10214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568657890;
	bh=cvqXyAoP8LXl4eQWtl4xAFxdBZY+YNwOUsM8E8y5L+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DInVIh2Foo/sOLiphZoU5v02/mO8A6ylROISVgNn7URgWn7KzQIkisg5OTvzXjnmK
	 TnKwfRgdZhGSTJGRNTY8xZImHZiEdOhC5VNCyK7kyvHy5VTZ7VbX7gUKBxkU+kScYX
	 wgnMJG+Kg0UtANlskMPjqJ4SirjYg9qcTmR/hlEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbfIPSSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732383AbfIPSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:18:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49CE206A4;
        Mon, 16 Sep 2019 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568657887;
        bh=cvqXyAoP8LXl4eQWtl4xAFxdBZY+YNwOUsM8E8y5L+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCmKcOBdZQjDrk/s24oKublKlHuvENgTEev4fbOttzaSiyY1s8W7HQFd0rotrvv87
         S4zvcdSpSDg9o+9giWpiCF24fHzYKjBU7vVaY0TzRg42R6e8zdKauzviGVD913jFxO
         FrwmDsU3hjX6DSKArgN63xEx+rHvAH21xb3FOAng=
Date:   Mon, 16 Sep 2019 19:18:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "julien.grall@arm.com" <julien.grall@arm.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Message-ID: <20190916181800.7lfpt3t627byoomt@willie-the-truck>
References: <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
 <mhng-166dcd4f-9483-4aab-a83a-914d70ddb5a4@palmer-si-x1e>
 <MN2PR04MB606117F2AC47385EF23D267D8D8D0@MN2PR04MB6061.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR04MB606117F2AC47385EF23D267D8D8D0@MN2PR04MB6061.namprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 05:03:38AM +0000, Anup Patel wrote:
> 
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > owner@vger.kernel.org> On Behalf Of Palmer Dabbelt
> > Sent: Saturday, September 14, 2019 7:31 PM
> > To: will@kernel.org
> > Cc: guoren@kernel.org; Will Deacon <will.deacon@arm.com>;
> > julien.thierry@arm.com; aou@eecs.berkeley.edu; james.morse@arm.com;
> > Arnd Bergmann <arnd@arndb.de>; suzuki.poulose@arm.com;
> > marc.zyngier@arm.com; catalin.marinas@arm.com; Anup Patel
> > <Anup.Patel@wdc.com>; linux-kernel@vger.kernel.org;
> > rppt@linux.ibm.com; Christoph Hellwig <hch@infradead.org>; Atish Patra
> > <Atish.Patra@wdc.com>; julien.grall@arm.com; gary@garyguo.net; Paul
> > Walmsley <paul.walmsley@sifive.com>; christoffer.dall@arm.com; linux-
> > riscv@lists.infradead.org; kvmarm@lists.cs.columbia.edu; linux-arm-
> > kernel@lists.infradead.org; iommu@lists.linux-foundation.org
> > Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
> > separate file
> > 
> > On Thu, 12 Sep 2019 07:02:56 PDT (-0700), will@kernel.org wrote:
> > > On Sun, Sep 08, 2019 at 07:52:55AM +0800, Guo Ren wrote:
> > >> On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org> wrote:
> > >> > > I'll keep my system use the same ASID for SMP + IOMMU :P
> > >> >
> > >> > You will want a separate allocator for that:
> > >> >
> > >> > https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.bruck
> > >> > er@arm.com
> > >>
> > >> Yes, it is hard to maintain ASID between IOMMU and CPUMMU or
> > >> different system, because it's difficult to synchronize the IO_ASID
> > >> when the CPU ASID is rollover.
> > >> But we could still use hardware broadcast TLB invalidation
> > >> instruction to uniformly manage the ASID and IO_ASID, or OTHER_ASID in
> > our IOMMU.
> > >
> > > That's probably a bad idea, because you'll likely stall execution on
> > > the CPU until the IOTLB has completed invalidation. In the case of
> > > ATS, I think an endpoint ATC is permitted to take over a minute to
> > > respond. In reality, I suspect the worst you'll ever see would be in
> > > the msec range, but that's still an unacceptable period of time to hold a
> > CPU.
> > >
> > >> Welcome to join our disscusion:
> > >> "Introduce an implementation of IOMMU in linux-riscv"
> > >> 9 Sep 2019, 10:45 Jade-room-I&II (Corinthia Hotel Lisbon) RISC-V MC
> > >
> > > I attended this session, but it unfortunately raised many more
> > > questions than it answered.
> > 
> > Ya, we're a long way from figuring this out.
> 
> For everyone's reference, here is our first attempt at RISC-V ASID allocator:
> http://archive.lwn.net:8080/linux-kernel/20190329045111.14040-1-anup.patel@wdc.com/T/#u

With a reply stating that the patch "absolutely does not work" ;)

What exactly do you want people to do with that? It's an awful lot of effort
to review this sort of stuff and given that Guo Ren is talking about sharing
page tables between the CPU and an accelerator, maybe you're better off
stabilising Linux for the platforms that you can actually test rather than
getting so far ahead of yourselves that you end up with a bunch of wasted
work on patches that probably won't get merged any time soon.

Seriously, they say "walk before you can run", but this is more "crawl
before you can fly". What's the rush?

Will
