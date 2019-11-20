Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3A4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0449E206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gQHFgTgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfKTRha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:37:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33888 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbfKTRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:37:30 -0500
Received: from zn.tnic (p200300EC2F0D8C00F553B94F3FB99B80.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8c00:f553:b94f:3fb9:9b80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B40D1EC0BEC;
        Wed, 20 Nov 2019 18:37:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574271449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dt0skX+t5TApZIf10QlyBTuMhhHdR5oeyUG697yEIWI=;
        b=gQHFgTgSinL/5JlBJMWwVcoiC4JiDWLyhR2HQfxHkmcYp0ul2Sgg3mDQ4MzrPq0mUnHo9p
        CBFeF+pLJRnBLVYX/cxau2SUryK629DxsQFQs2PBbi74QTx1VWyHCLm70oamPWvMxAxmmq
        bmmviKmuV4aXD3SxnSbZdu5UaYoBbH0=
Date:   Wed, 20 Nov 2019 18:37:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120173722.GH2634@zn.tnic>
References: <20191120103613.63563-1-jannh@google.com>
 <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com>
 <CAG48ez0Frp4-+xHZ=UhbHh0hC_h-1VtJfwHw=kDo6NahyMv1ig@mail.gmail.com>
 <20191120123058.GA17296@gmail.com>
 <20191120123926.GE2634@zn.tnic>
 <20191120132830.GB54414@gmail.com>
 <20191120133913.GG2634@zn.tnic>
 <20191120162143.GB32572@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120162143.GB32572@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 08:21:43AM -0800, Sean Christopherson wrote:
> On Wed, Nov 20, 2019 at 02:39:13PM +0100, Borislav Petkov wrote:
> > On Wed, Nov 20, 2019 at 02:28:30PM +0100, Ingo Molnar wrote:
> > > I'd rather we not trust the decoder and the execution environment so much 
> > > that it never produces a 0 linear address in a #GP:
> > 
> > I was just scratching my head whether I could trigger a #GP with address
> > of 0. But yeah, I agree, let's be really cautious here. I wouldn't want
> > to debug a #GP with a wrong address reported.
> 
> It's definitely possible, there are a handful of non-SIMD instructions that
> generate #GP(0) it CPL=0 in 64-bit mode *and* have a memory operand.  Some
> of them might even be legitimately encountered in the wild.
> 
>   - CMPXCHG16B if it's not supported by the CPU.
>   - VMXON if CR4 is misconfigured or VMX isn't enabled in FEATURE_CONTROL.
>   - MONITOR if ECX has an invalid hint (although MONITOR hardcodes the
>     address in DS:RAX and so doesn't have a ModR/M byte).
> 
> Undoudbtedly there are other instructions with similar sources of #GP.

Right, we currently put our trust in the insn decoder to handle those
correctly too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
