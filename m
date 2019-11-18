Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB98BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988602186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JVrUTk3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKRRi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:38:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59752 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfKRRi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:38:56 -0500
Received: from zn.tnic (p200300EC2F27B5003D22FC05E431AFF8.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b500:3d22:fc05:e431:aff8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D1D11EC072D;
        Mon, 18 Nov 2019 18:38:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574098731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/zpixmJKEK2DyhKs6AeIjcFfA5HziA0TuK8uE0/KAJY=;
        b=JVrUTk3gJRZJwoaj7Pm0kBocQxkdT0b8912XwpNNwXrLoXn/pwdBL+U4q3U2HJLdapv6NO
        ctqtMIEzJXoHO1+ObaQneXG7EjtdJTlcHgUDezw+JP11/Lfgofnl/qTGAFfnDLvI5JQ1/N
        08IbCVumGcM5imH5h8KzvEEi1ceg1+Y=
Date:   Mon, 18 Nov 2019 18:38:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191118173850.GL6363@zn.tnic>
References: <20191115191728.87338-1-jannh@google.com>
 <20191115191728.87338-2-jannh@google.com>
 <20191118142144.GC6363@zn.tnic>
 <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
 <CAG48ez1AWW7FkvU31ahy=0ZiaAreSMz=FFA0u8-XkXT9hNdWKA@mail.gmail.com>
 <CACT4Y+bfF86YY_zEGWO1sK0NwuYgr8Cx0wFewRDq0WL_GBgO0Q@mail.gmail.com>
 <20191118164407.GH6363@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118164407.GH6363@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 05:44:07PM +0100, Borislav Petkov wrote:
> [    2.523708] Write protecting the kernel read-only data: 16384k
> [    2.524729] Freeing unused kernel image (text/rodata gap) memory: 2040K
> [    2.525594] Freeing unused kernel image (rodata/data gap) memory: 368K
> [    2.541414] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> 
> <--- important first splat starts here:
> 
> [    2.542218] [*] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
		  ^

Btw, tglx just suggested on IRC to simply slap the die_counter number here so
that you have

[    2.543343] [1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc8+ #8
[    2.544138] [1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
...

which also tells you to which splat the line belongs to.

Also useful.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
