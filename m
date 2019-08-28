Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24995C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3240217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfH1TpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:45:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48310 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfH1TpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:45:11 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i33sQ-0003JR-JC; Wed, 28 Aug 2019 21:45:06 +0200
Date:   Wed, 28 Aug 2019 21:45:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch 1/2] x86/mm/pti: Handle unaligned address gracefully in
 pti_clone_pagetable()
In-Reply-To: <20190828185832.GA77809@gmail.com>
Message-ID: <alpine.DEB.2.21.1908282144200.1938@nanos.tec.linutronix.de>
References: <20190828142445.454151604@linutronix.de> <20190828143123.971884723@linutronix.de> <20190828185832.GA77809@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019, Ingo Molnar wrote:
> >  		pmd = pmd_offset(pud, addr);
> >  		if (pmd_none(*pmd)) {
> > -			addr += PMD_SIZE;
> > +			WARN_ON_ONCE(addr & PMD_MASK);
> > +			addr = round_up(addr + 1, PMD_SIZE);
> 
> So given that PUD_MASK and PMD_MASK are masking out the *offset*:
> 
>  arch/x86/include/asm/pgtable_64_types.h:#define PMD_MASK	(~(PMD_SIZE - 1))
> 
> Didn't we want something like:
> 
> 			WARN_ON_ONCE(addr & ~PUD_MASK);
> 
> 			WARN_ON_ONCE(addr & ~PMD_MASK);
> 
> to warn about an unaligned 'addr', or am I misreading the intent here?

Bah, right you are...
