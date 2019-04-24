Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD271C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809D5218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556091100;
	bh=Yq43yR/26yNlNAzPkhntuFD6hSDpczgTcnRzncShN5k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=sU2oqaTAu/7qigtz8xHNqEYDOcaWql9A+kVjch0OAnvgUkROHtGoj9zkhW22VUS2Q
	 /YvcmBH+WvrFG1qnmaN6QfpPWkTe+jm2edrg8QAxLFboS3kSjCPGLBM/yvdYDU54SE
	 COEiZ0n0Xg+t7loyPuOypNWwciW7d0rexsV1Pois=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfDXHbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfDXHbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:31:39 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4210C2089F;
        Wed, 24 Apr 2019 07:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556091098;
        bh=Yq43yR/26yNlNAzPkhntuFD6hSDpczgTcnRzncShN5k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tE3z7z2hD+BVHGp0DkT32geu3jd/XMaR/gkETky8rVcINgOAkaHuv+75cK8Cd37vg
         yIDCTzPEzTqp+w5HGITUqdMQYLsCjALeEyBMtDfgShh7hhSLdP+BqgOMCIq7HJ/J/C
         EHZAjblU0RP9WRNLhZGqOEnzFaZydAVHeNYAskOw=
Date:   Wed, 24 Apr 2019 09:31:34 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Nicolai Stange <nstange@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Remove in_nmi() warning from 64bit implementation
 of vmalloc_fault()
In-Reply-To: <20190424072610.GF4038@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.76.1904240927550.9803@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1904240902280.9803@cbobk.fhfr.pm> <20190424072610.GF4038@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Peter Zijlstra wrote:

> > In-NMI warnings have been added to vmalloc_fault() via ebc8827f75 ("x86: 
> > Barf when vmalloc and kmemcheck faults happen in NMI") back in the time 
> > when our NMI entry code could not cope with nested NMIs.
> > 
> > These days, it's perfectly fine to take a fault in NMI context and we 
> > don't have to care about the fact that IRET from the fault handler might 
> > cause NMI nesting.
> > 
> > This warning has already been removed from 32bit implementation of 
> > vmalloc_fault() in 6863ea0cda8 ("x86/mm: Remove in_nmi() warning from 
> > vmalloc_fault()"), but 64bit version was omitted.
> > 
> > Remove the bogus warning also from 64bit implementation of vmalloc_fault().
> 
> Cute; did you actually trigger this?

Nope; Nicolai tripped over it while he was looking into interactions 
between ftrace and pagefaults.

> > Fixes: 6863ea0cda8 ("x86/mm: Remove in_nmi() warning from vmalloc_fault()")
> > Reported-by: Nicolai Stange <nstange@suse.de>
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks,

-- 
Jiri Kosina
SUSE Labs

