Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B37C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30E62251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OjXmSLn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfKTMje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:39:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45330 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfKTMje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:39:34 -0500
Received: from zn.tnic (p200300EC2F0D8C00B1B17C12861BCCA4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8c00:b1b1:7c12:861b:cca4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C9BE1EC0CE3;
        Wed, 20 Nov 2019 13:39:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574253572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zp+1xALzK6MVb4JuJSTpKsxknVwYBFmIQv2YEQLs+rY=;
        b=OjXmSLn6Lwc3Qnwt6j+mOJxv7SMfG3DzPADdwFyKrncZNuWJWJ0tqJsXG392WhdmlR6Evd
        BQrXpkEmH+Na1AC7P+3UIrPSix03glvJriHR3KbwgngWNmjri35erJNP+In39ZVOPv6Axc
        ZREtaMyGoowz1M1plXurckDz4qfruFo=
Date:   Wed, 20 Nov 2019 13:39:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120123926.GE2634@zn.tnic>
References: <20191120103613.63563-1-jannh@google.com>
 <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com>
 <CAG48ez0Frp4-+xHZ=UhbHh0hC_h-1VtJfwHw=kDo6NahyMv1ig@mail.gmail.com>
 <20191120123058.GA17296@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120123058.GA17296@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 01:30:58PM +0100, Ingo Molnar wrote:
> 
> * Jann Horn <jannh@google.com> wrote:
> 
> > You mean something like this?
> > 
> > ========================
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 9b23c4bda243..16a6bdaccb51 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -516,32 +516,36 @@ dotraplinkage void do_bounds(struct pt_regs
> > *regs, long error_code)
> >   * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
> >   * address, return that address.
> >   */
> > -static unsigned long get_kernel_gp_address(struct pt_regs *regs)
> > +static bool get_kernel_gp_address(struct pt_regs *regs, unsigned long *addr,
> > +                                          bool *non_canonical)
> 
> Yeah, that's pretty much the perfect end result!

Why do we need the bool thing? Can't we rely on the assumption that an
address of 0 is the error case and use that to determine whether the
resolving succeeded or not?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
