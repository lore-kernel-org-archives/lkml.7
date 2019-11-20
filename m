Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76103C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E34223D0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BNR/zhrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfKTLwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:52:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36256 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbfKTLwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:52:43 -0500
Received: from zn.tnic (p200300EC2F0D8C008093FCEEEFCF892F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8c00:8093:fcee:efcf:892f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA7C21EC0BEC;
        Wed, 20 Nov 2019 12:52:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574250757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RLkoxGNHE0MpSItY0sfwHmmrOz4TIxYH/DdJiVvVqKA=;
        b=BNR/zhrDGWjNt4n3V2KbYZOAFqq3A4mS4xDnAwzLkBeKSgv7CGOo4ymDnWc4K67KYxdE8p
        aEH2xhwsWqNg/rG/pv/bqg2IfBb5bWofCN/4CW9OdJt9ZG0d6IxCJQbdBBRTJhp2+0dsxF
        +Shl9/boxqkDFVBCw6tzSD9swpaEF8c=
Date:   Wed, 20 Nov 2019 12:52:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120115231.GD2634@zn.tnic>
References: <20191115191728.87338-1-jannh@google.com>
 <20191115191728.87338-2-jannh@google.com>
 <20191118142144.GC6363@zn.tnic>
 <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
 <CAG48ez1AWW7FkvU31ahy=0ZiaAreSMz=FFA0u8-XkXT9hNdWKA@mail.gmail.com>
 <CACT4Y+bfF86YY_zEGWO1sK0NwuYgr8Cx0wFewRDq0WL_GBgO0Q@mail.gmail.com>
 <20191118164407.GH6363@zn.tnic>
 <20191120114031.GA83574@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120114031.GA83574@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:40:31PM +0100, Ingo Molnar wrote:
> Well, this would break various pieces of tooling I'm sure.

Well, if at all, this will break them one last time. Ironically, the
intent here is to have a markup which doesn't break them anymore, once
that markup is agreed upon by all parties.

Because each time we touch those printk formats, tools people complain
about us breaking their tools. So we should get the best of both worlds
by marking those splats in a way that tools can grep for and we won't
touch the markers anymore, once established.

Also, "[]" was only an example. It can be anything we want, as in "<>"
or "!" or whatever is a short prefix that prepends those lines.

> Maybe it would be nicer to tooling to embedd the splat-counter in the 
> timestamp in a way:

Or that. Whatever we agree, as long as it is a unique marker for splats.
And it should say which splat it is, as that is also very useful
information to have it in each line.

> > [    2.542218-#1] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
> > [    2.543343-#1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc8+ #8
> > [    2.544138-#1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
> > [    2.545120-#1] RIP: 0010:kernel_init+0x58/0x107
> > [    2.546055-#1] Code: 48 c7 c7 e0 5c e7 81 e8 eb d2 90 ff c7 05 77 d6 95 00 02 00 00 00 e8 4e 1d a2 ff e8 69 b7 91 ff 48 b8 01 00 00 00 00 00 ff df <ff> e0 48 8b 3d fe 54 d7 00 48 85 ff 74 22 e8 76 93 84 ff 85 c0 89
> 
> That way we'd not only know that it's the first splat, but we'd know it 
> from all the *other* splats as well where they are in the splat-rank ;-)

That's exactly why I'd want the number in there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
