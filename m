Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10D9C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8730E20855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lv1s5aR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfDHTIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:08:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55350 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHTIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:08:10 -0400
Received: from zn.tnic (p200300EC2F07270090E7A6A2A5AE3819.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:90e7:a6a2:a5ae:3819])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7BDFD1EC0B07;
        Mon,  8 Apr 2019 21:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554750488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SHqHYc/eOKCh+KxMIryEeLE4qmh9wDo/A0zT51iwnoI=;
        b=lv1s5aR876KqvYn4Ga4ZSDebDnn4i4apj0A1eBbtPF7yM1D9dNscehmBoukD7vJBwujRoC
        PURhdEPpeWDZADzChkO0kGxYLGIcZiqtlIb/hj5fu73GrsfZ/KiYfG7o2uU4oFn6rhPiwx
        6xSDzupmXwUMiJ1nwFoMjlnNj2TgcBc=
Date:   Mon, 8 Apr 2019 21:08:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gary R Hook <ghook@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Message-ID: <20190408190800.GL15689@zn.tnic>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
 <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
 <20190408165835.GJ15689@zn.tnic>
 <8a14050e-2516-5c0f-195d-611c6959b94b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a14050e-2516-5c0f-195d-611c6959b94b@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 06:41:30PM +0000, Gary R Hook wrote:
> Again, not arguing. I completely understand. However, to be fair, this 
> isn't about SME having trouble with those facilities, this is about 
> using certain features (e.g. command line option processing) early in 
> the boot. Any complex feature could have had that requirement, don't you 
> think?

Sure, but then why do we need that patch at all then? Why do we need to
disable instrumentation for SME early code and not for other early code?

I mean, if you grep around the tree you can see a bunch of
KASAN_SANITIZE but in lib/ we only have

lib/Makefile:210:KASAN_SANITIZE_stackdepot.o := n

which is special. But the rest of the generic code in lib/ or
arch/x86/lib/ isn't.

Now, there's this:

arch/x86/boot/Makefile:12:KASAN_SANITIZE                        := n
arch/x86/boot/compressed/Makefile:20:KASAN_SANITIZE                     := n

which disables KASAN for all boot code.

And this is what you mean - all early boot code should not be sanitized.

Which also gives the right solution, IMO:

cmdline.o should not be sanitized only when used in the boot code. But
that is already the case.

So why do you need to disable KASAN for arch/x86/lib/cmdline.c?

Because for those two:

arch/x86/boot/cmdline.c
arch/x86/boot/compressed/cmdline.c

that should already be the case due to the Makefile defines above.

> Right. My goal was to get a conversation started, because folks are
> running into this problem when KASAN is enabled.

You say KASAN. Why is there KCOV_INSTRUMENT_cmdline.o too?

> N.B. Here's another facet of this problem: cmdline.c doesn't (today) 
> contain anything that would trigger the stack protector. However, it's 
> possible to enable the stack protector globally when building, right? In 
> which case, a boot would fail, so we have the same issue: early boot 
> code has special requirements / restrictions.

How so?

This .config boots here in a vm just fine.

$ grep STACKPROT .config
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
