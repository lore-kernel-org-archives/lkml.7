Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77680C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E72421473
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371742;
	bh=d4H3ytDN4+6bzOFsrB7H72D5xnyH2d7DzxF9eKjN0sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gbh3lyoedRVV3e+fXpI8jvtnZZtKa6TfEExGis4yGW+g1i8M3AJhtoVY66yS/eqQN
	 +BxXJmZDRTnry0rTqa+dyBZ1r/bEJKg0XnkkV40Yuc0Mv/adxJ9PQ942hv2UzV/5+H
	 6lVIjkPTosjyyu9xwZvBlGzPdSgyxHGrze54FpMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfFXKWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731092AbfFXKWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:22:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691F9208E4;
        Mon, 24 Jun 2019 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371736;
        bh=d4H3ytDN4+6bzOFsrB7H72D5xnyH2d7DzxF9eKjN0sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwiHHdW7tU89KwjK81T7yWoMzvqANGQZczB5UCgT2eBTMTSj/2WtBXwPLu9Bm31O5
         r/b9kyNOheWOPU6eueHBoKQB11SLCVWYnVhoKTq/4mVb1bd1PgiaqOudYcyxSqF2PT
         S4tMcKDxPqFg/3U3pumEBb3BDhOvWlvqmdZEXn2I=
Date:   Mon, 24 Jun 2019 11:22:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, julien.thierry@arm.com,
        aou@eecs.berkeley.edu, james.morse@arm.com, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Anup Patel <anup.Patel@wdc.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        hch@infradead.org, Atish Patra <Atish.Patra@wdc.com>,
        Julien Grall <julien.grall@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, gary@garyguo.net,
        paul.walmsley@sifive.com, christoffer.dall@arm.com,
        linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Message-ID: <20190624102209.ngwtosgr5fvp3ler@willie-the-truck>
References: <20190321163623.20219-1-julien.grall@arm.com>
 <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
 <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
 <20190621141606.GF18954@arrakis.emea.arm.com>
 <CAJF2gTTVUToRkRtxTmtWDotMGXy5YQCpL1h_2neTBuN3e6oz1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTVUToRkRtxTmtWDotMGXy5YQCpL1h_2neTBuN3e6oz1w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:35:35AM +0800, Guo Ren wrote:
> On Fri, Jun 21, 2019 at 10:16 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > On Wed, Jun 19, 2019 at 07:51:03PM +0800, Guo Ren wrote:
> > > On Wed, Jun 19, 2019 at 4:54 PM Julien Grall <julien.grall@arm.com> wrote:
> > > > On 6/19/19 9:07 AM, Guo Ren wrote:
> > > > > Move arm asid allocator code in a generic one is a agood idea, I've
> > > > > made a patchset for C-SKY and test is on processing, See:
> > > > > https://lore.kernel.org/linux-csky/1560930553-26502-1-git-send-email-guoren@kernel.org/
> > > > >
> > > > > If you plan to seperate it into generic one, I could co-work with you.
> > > >
> > > > Was the ASID allocator work out of box on C-Sky?
> > >
> > > Almost done, but one question:
> > > arm64 remove the code in switch_mm:
> > >   cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > >   cpumask_set_cpu(cpu, mm_cpumask(next));
> > >
> > > Why? Although arm64 cache operations could affect all harts with CTC
> > > method of interconnect, I think we should keep these code for
> > > primitive integrity in linux. Because cpu_bitmap is in mm_struct
> > > instead of mm->context.
> >
> > We didn't have a use for this in the arm64 code, so no point in
> > maintaining the mm_cpumask. On some arm32 systems (ARMv6) with no
> > hardware broadcast of some TLB/cache operations, we use it to track
> > where the task has run to issue IPI for TLB invalidation or some
> > deferred I-cache invalidation.
> The operation of set/clear mm_cpumask was removed in arm64 compared to
> arm32. It seems no side effect on current arm64 system, but from
> software meaning it's wrong.
> I think we should keep mm_cpumask just like arm32.

It was a while ago now, but I remember the atomic update of the mm_cpumask
being quite expensive when I was profiling this stuff, so I removed it
because we don't need it for arm64 (at least, it doesn't allow us to
optimise our shootdowns in practice).

I still think this is over-engineered for what you want on c-sky and making
this code generic is a mistake.

Will
