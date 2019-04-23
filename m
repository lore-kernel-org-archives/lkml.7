Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C65FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C28A20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LRtWMt+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfDWNZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:25:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDWNZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:25:26 -0400
Received: from zn.tnic (p200300EC2F10CC007DBC012C031649F3.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:cc00:7dbc:12c:316:49f3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 457A51EC0A7C;
        Tue, 23 Apr 2019 15:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556025925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=t8fES2NF234BhFPYXDDc2ii1nfA5SWVCtlIDPcrrdiU=;
        b=LRtWMt+l+/+jPthzths1vXZMiOphN9hrVkhUOOTq6La6KUy2NOpT9vFVE0cliFWZbyGC9C
        WqBsD9D1MwIZbiCx6M1J1JQ1AaQVEqROzNk4TQfWmQol93Li++nDgL/dkTofYSEDe0mTz+
        xgShD6r/3JYeKgfYrQn1e/+9axbxsVg=
Date:   Tue, 23 Apr 2019 15:25:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <cai@lca.pw>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
Message-ID: <20190423132518.GA16353@zn.tnic>
References: <20190409040502.55361-1-cai@lca.pw>
 <20190416171104.GI31772@zn.tnic>
 <26957df8-f1b0-c000-2edf-1368ce22bfce@lca.pw>
 <20190418074510.GB27160@zn.tnic>
 <20190418095015.GB18646@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418095015.GB18646@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

sorry for the delay.

On Thu, Apr 18, 2019 at 10:50:15AM +0100, Catalin Marinas wrote:
> Kmemleak is basically a tri-colour marking tracing garbage collector [1]

Thanks for that - interesting read.

> but without automatic freeing. It relies on a graph of references
> (pointers) between various objects and the root of such graph is the
> .bss/.data.
> 
> free_init_pages() is called on memory regions outside .bss/.data like
> smp_locks, initrd, kernel init text which kmemleak does not track
> anyway. That said, kmemleak_free_part() is tolerant to unknown pointers,
> so we could call it directly from free_init_pages().

Ok, lemme think out loud for a bit here: kmemleak_scan() goes over
an object list and I guess in our particular case, the memory which
got freed in mem_encrypt_free_decrypted_mem() *was* in that list too,
leading to the crash.

Looking at the splat, it is in scan_gray_list() which would mean that
the object we freed was reachable from the root(s) in .bss.

Now, the docs say:

"The memory allocations via :c:func:`kmalloc`, :c:func:`vmalloc`,
:c:func:`kmem_cache_alloc` and
friends are traced and the pointers, together with additional
information like size and stack trace, are stored in a rbtree."

So I guess free_init_pages() should be somehow telling kmemleak, "hey,
just freed that object, pls adjust your tracking lists" no?

Because, otherwise, if we start sprinkling those kmemleak_free_part()
calls everywhere, that'll quickly turn into a game of whack-a-mole. And
we don't need that especially if kmemleak can easily be taught to handle
such cases.

IM *very* HO, of course. :-)

Here's where you tell me whether that even makes sense at all.

> There is Documentation/dev-tools/kmemleak.rst briefly mentioning the
> tracing garbage collector (although the Wikipedia link is no longer
> valid, it should be replaced with [1]). It doesn't, however, state why
> .bss/.data are special.

The fact that they're special is important info, I'd say.

Also,

> [1] https://en.wikipedia.org/wiki/Tracing_garbage_collection#Tri-color_marking

is nice. While reading, it made me think how our discussion would go if
we didn't have wikipedia. You'd probably say, go to the library and read
this and that section in this and that book on tri-color marking. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
