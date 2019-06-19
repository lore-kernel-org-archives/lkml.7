Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C2DC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03506214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfFSMjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:39:45 -0400
Received: from foss.arm.com ([217.140.110.172]:37752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbfFSMjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:39:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 945BC360;
        Wed, 19 Jun 2019 05:39:44 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 092A33F738;
        Wed, 19 Jun 2019 05:39:41 -0700 (PDT)
Date:   Wed, 19 Jun 2019 13:39:39 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        aou@eecs.berkeley.edu, gary@garyguo.net, Atish.Patra@wdc.com,
        hch@infradead.org, paul.walmsley@sifive.com, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        julien.thierry@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Message-ID: <20190619123939.GF7767@fuggles.cambridge.arm.com>
References: <20190321163623.20219-1-julien.grall@arm.com>
 <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
 <20190619091219.GB7767@fuggles.cambridge.arm.com>
 <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 08:18:04PM +0800, Guo Ren wrote:
> On Wed, Jun 19, 2019 at 5:12 PM Will Deacon <will.deacon@arm.com> wrote:
> > This is one place where I'd actually prefer not to go down the route of
> > making the code generic. Context-switching and low-level TLB management
> > is deeply architecture-specific and I worry that by trying to make this
> > code common, we run the real risk of introducing subtle bugs on some
> > architecture every time it is changed.
> "Add generic asid code" and "move arm's into generic" are two things.
> We could do
> first and let architecture's maintainer to choose.

If I understand the proposal being discussed, it involves basing that
generic ASID allocation code around the arm64 implementation which I don't
necessarily think is a good starting point.

> > Furthermore, the algorithm we use
> > on arm64 is designed to scale to large systems using DVM and may well be
> > too complex and/or sub-optimal for architectures with different system
> > topologies or TLB invalidation mechanisms.
> It's just a asid algorithm not very complex and there is a callback
> for architecture to define their
> own local hart tlb flush. Seems it has nothing with DVM or tlb
> broadcast mechanism.

I'm pleased that you think the algorithm is not very complex, but I'm also
worried that you might not have fully understood some of its finer details.

The reason I mention DVM and TLB broadcasting is because, depending on
the mechanisms in your architecture relating to those, it may be strictly
required that all concurrently running threads of a process have the same
ASID at any given point in time, or it may be that you really don't care.

If you don't care, then the arm64 allocator is over-engineered and likely
inefficient for your system. If you do care, then it's worth considering
whether a lock is sufficient around the allocator if you don't expect high
core counts. Another possibility is that you end up using only one ASID and
invalidating the local TLB on every context switch. Yet another design
would be to manage per-cpu ASID pools.

So rather than blindly copying the arm64 code, I suggest sitting down and
designing something that fits to your architecture instead. You may end up
with something that is both simpler and more efficient.

Will
