Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C229CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A0021721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570538391;
	bh=VOehHrjoEEH/9k1qS9ryy1x3ms6XAZCSJcvTxw4RJFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LW4Knja5vizvSxHr7R6PMnyu67fAkmRKFWrFn9XXBeBulYkRC/7x8DdUF8rNVC3xB
	 k1aSXq7XhNTcgm6ZziIZLEUjDMLSIudQ7+QHUw/ARj0EFiaBXCFZO3LCvN5g3vwiot
	 9PojwJVPN2s8XZhTfBXBm0pX5t3oJUOzZeIkLp4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfJHMju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730674AbfJHMju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:39:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5F3206B6;
        Tue,  8 Oct 2019 12:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570538389;
        bh=VOehHrjoEEH/9k1qS9ryy1x3ms6XAZCSJcvTxw4RJFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwaHKDtsfJzVVQq4/IuDx7OPcJ1OZEk1TNgWyf3KSKHP241RRMNvK2Y5lbwky4ez7
         LhZK0baYberKH77q90rA/AcHKfjADNwNqDvstzw6/4+SHednGlG0qZ90g5niGw+Fn7
         kBQ2DxxS+dqLZTW/evaUTo8vP3LSBCsoOgQsv7Q8=
Date:   Tue, 8 Oct 2019 13:39:44 +0100
From:   Will Deacon <will@kernel.org>
To:     "Justin He (Arm Technology China)" <Justin.He@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20191008123943.j7q6dlu2qb2az6xa@willie-the-truck>
References: <20190930015740.84362-1-justin.he@arm.com>
 <20190930015740.84362-4-justin.he@arm.com>
 <20191001125413.mhxa6qszwnuhglky@willie-the-truck>
 <DB7PR08MB3082563BD18482E5D541F019F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR08MB3082563BD18482E5D541F019F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 02:19:05AM +0000, Justin He (Arm Technology China) wrote:
> > -----Original Message-----
> > From: Will Deacon <will@kernel.org>
> > Sent: 2019年10月1日 20:54
> > To: Justin He (Arm Technology China) <Justin.He@arm.com>
> > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Mark Rutland
> > <Mark.Rutland@arm.com>; James Morse <James.Morse@arm.com>; Marc
> > Zyngier <maz@kernel.org>; Matthew Wilcox <willy@infradead.org>; Kirill A.
> > Shutemov <kirill.shutemov@linux.intel.com>; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > mm@kvack.org; Punit Agrawal <punitagrawal@gmail.com>; Thomas
> > Gleixner <tglx@linutronix.de>; Andrew Morton <akpm@linux-
> > foundation.org>; hejianet@gmail.com; Kaly Xin (Arm Technology China)
> > <Kaly.Xin@arm.com>
> > Subject: Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF
> > is cleared
> > 
> > On Mon, Sep 30, 2019 at 09:57:40AM +0800, Jia He wrote:
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index b1ca51a079f2..1f56b0118ef5 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
> > >  					2;
> > >  #endif
> > >
> > > +#ifndef arch_faults_on_old_pte
> > > +static inline bool arch_faults_on_old_pte(void)
> > > +{
> > > +	return false;
> > > +}
> > > +#endif
> > 
> > Kirill has acked this, so I'm happy to take the patch as-is, however isn't
> > it the case that /most/ architectures will want to return true for
> > arch_faults_on_old_pte()? In which case, wouldn't it make more sense for
> > that to be the default, and have x86 and arm64 provide an override? For
> > example, aren't most architectures still going to hit the double fault
> > scenario even with your patch applied?
> 
> No, after applying my patch series, only those architectures which don't provide
> setting access flag by hardware AND don't implement their arch_faults_on_old_pte
> will hit the double page fault.
> 
> The meaning of true for arch_faults_on_old_pte() is "this arch doesn't have the hardware
> setting access flag way, it might cause page fault on an old pte"
> I don't want to change other architectures' default behavior here. So by default, 
> arch_faults_on_old_pte() is false.

...and my complaint is that this is the majority of supported architectures,
so you're fixing something for arm64 which also affects arm, powerpc,
alpha, mips, riscv, ...

Chances are, they won't even realise they need to implement
arch_faults_on_old_pte() until somebody runs into the double fault and
wastes lots of time debugging it before they spot your patch.

> Btw, currently I only observed this double pagefault on arm64's guest
> (host is ThunderX2).  On X86 guest (host is Intel(R) Core(TM) i7-4790 CPU
> @ 3.60GHz ), there is no such double pagefault. It has the similar setting
> access flag way by hardware.

Right, and that's why I'm not concerned about x86 for this problem.

Will
