Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EBAECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA23B2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571269577;
	bh=1d+anmR89+BsXGTeKAeDSQMGxC4eYRI2kxsjcdlZMTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tlc+px4lYxZxpdscXj6DE5PV6I8GpI8SZwQkMucpmi90CfGmlx2QBx3g6nl32nQED
	 mqT3lL/PoPrODbEv55tZOYAApg+RnEP7znRIe+RuuXNpVaI0okl4UtOizgtbWE0VSA
	 yImXCZZ2WWv3IP03v90HfBCOoqrbhcMqrizjU0Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394881AbfJPXqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfJPXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:46:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971AB20659;
        Wed, 16 Oct 2019 23:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571269574;
        bh=1d+anmR89+BsXGTeKAeDSQMGxC4eYRI2kxsjcdlZMTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6Qx+YjtJmpoUVU8R7/jtOToPUmweQ91tIuV2pHkqKBannSmtgnxpD10pvX/mMjBb
         aThIrnvXcv4Y9U1Lf5Ly6vCeEKvNk3pFBM/Q3I9LjbuPY0fNPzxbINylySRKYve0BK
         mkq4d9FNRSMXljwo1DSsWbBB9x0S6XLS2cSludn0=
Date:   Thu, 17 Oct 2019 00:46:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Justin.He@arm.com, Catalin.Marinas@arm.com, Mark.Rutland@arm.com,
        James.Morse@arm.com, maz@kernel.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, punitagrawal@gmail.com, tglx@linutronix.de,
        akpm@linux-foundation.org, hejianet@gmail.com, Kaly.Xin@arm.com,
        nd@arm.com
Subject: Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20191016234607.626nzv5kf5fgz25x@willie-the-truck>
References: <20191008123943.j7q6dlu2qb2az6xa@willie-the-truck>
 <mhng-dd251518-8ac0-40fa-9f62-20715d9ba906@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-dd251518-8ac0-40fa-9f62-20715d9ba906@palmer-si-x1e>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Palmer,

On Wed, Oct 16, 2019 at 04:21:59PM -0700, Palmer Dabbelt wrote:
> On Tue, 08 Oct 2019 05:39:44 PDT (-0700), will@kernel.org wrote:
> > On Tue, Oct 08, 2019 at 02:19:05AM +0000, Justin He (Arm Technology China) wrote:
> > > > On Mon, Sep 30, 2019 at 09:57:40AM +0800, Jia He wrote:
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index b1ca51a079f2..1f56b0118ef5 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
> > > > >  					2;
> > > > >  #endif
> > > > >
> > > > > +#ifndef arch_faults_on_old_pte
> > > > > +static inline bool arch_faults_on_old_pte(void)
> > > > > +{
> > > > > +	return false;
> > > > > +}
> > > > > +#endif
> > > >
> > > > Kirill has acked this, so I'm happy to take the patch as-is, however isn't
> > > > it the case that /most/ architectures will want to return true for
> > > > arch_faults_on_old_pte()? In which case, wouldn't it make more sense for
> > > > that to be the default, and have x86 and arm64 provide an override? For
> > > > example, aren't most architectures still going to hit the double fault
> > > > scenario even with your patch applied?
> > > 
> > > No, after applying my patch series, only those architectures which don't provide
> > > setting access flag by hardware AND don't implement their arch_faults_on_old_pte
> > > will hit the double page fault.
> > > 
> > > The meaning of true for arch_faults_on_old_pte() is "this arch doesn't have the hardware
> > > setting access flag way, it might cause page fault on an old pte"
> > > I don't want to change other architectures' default behavior here. So by default,
> > > arch_faults_on_old_pte() is false.
> > 
> > ...and my complaint is that this is the majority of supported architectures,
> > so you're fixing something for arm64 which also affects arm, powerpc,
> > alpha, mips, riscv, ...
> > 
> > Chances are, they won't even realise they need to implement
> > arch_faults_on_old_pte() until somebody runs into the double fault and
> > wastes lots of time debugging it before they spot your patch.
> 
> If I understand the semantics correctly, we should have this set to true.  I
> don't have any context here, but we've got
> 
>                /*
>                 * The kernel assumes that TLBs don't cache invalid
>                 * entries, but in RISC-V, SFENCE.VMA specifies an
>                 * ordering constraint, not a cache flush; it is
>                 * necessary even after writing invalid entries.
>                 */
>                local_flush_tlb_page(addr);
> 
> in do_page_fault().

Ok, although I think this is really about whether or not your hardware can
make a pte young when accessed, or whether you take a fault and do it
by updating the pte explicitly.

v12 of the patches did change the default, so you should be "safe" with
those either way:

http://lists.infradead.org/pipermail/linux-arm-kernel/2019-October/686030.html

Will
