Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E1BC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AD82064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ATn+ZtuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCGRG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:06:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54078 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfCGRG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:06:28 -0500
Received: from zn.tnic (unknown [IPv6:2003:ec:2f08:1c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79C761EC066F;
        Thu,  7 Mar 2019 18:06:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551978386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l8cTM4Q9P0s3RXZNsCWcgbO0ogkOlG4bqVEytx8DQK0=;
        b=ATn+ZtuVU+ClpyQgBAKOuZpfBSy9/Dx5UMED9ml4h113elugzb1qFn7lbGNrpfnfie8mmC
        aoP9aXiU+zgnRgI9OpXbhrqrFnO3PsdxLF9jaXXCA2oBndyvQzd6FYW3H78uhFnwXocnhf
        XncZ0ieSiRYL2PGhG+PbQZvyAnmQfM8=
Date:   Thu, 7 Mar 2019 18:06:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     hpa@zytor.com
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 10/20] x86: avoid W^X being broken during modules
 loading
Message-ID: <20190307170629.GG26566@zn.tnic>
References: <20190129003422.9328-11-rick.p.edgecombe@intel.com>
 <20190211182956.GN19618@zn.tnic>
 <1533F2BB-2284-499B-9912-6D74D0B87BC1@gmail.com>
 <20190211190108.GP19618@zn.tnic>
 <A671F14F-3E03-4A97-9F54-426533077E0C@gmail.com>
 <20190211191059.GR19618@zn.tnic>
 <3996E3F9-92D2-4561-84E9-68B43AC60F43@gmail.com>
 <20190211194251.GS19618@zn.tnic>
 <20190307072947.GA26566@zn.tnic>
 <EF5F87D9-EA7B-4F92-81C4-329A89EEADFA@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EF5F87D9-EA7B-4F92-81C4-329A89EEADFA@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 08:53:34AM -0800, hpa@zytor.com wrote:
> If we *do*, what is the issue here? Although boot_cpu_has() isn't
> slow (it should in general be possible to reduce to one testb
> instruction followed by a conditional jump) it seems that "avoiding an
> alternatives slot" *should* be a *very* weak reason, and seems to me
> to look like papering over some other problem.

Forget the current thread: this is simply trying to document when to use
static_cpu_has() and when to use boot_cpu_has(). I get asked about it at
least once a month.

And then it is replacing clear slow paths using static_cpu_has() with
boot_cpu_has() because there's purely no need to patch there. And having
a RIP-relative MOV and a JMP is good enough for slow paths.

Makes sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
