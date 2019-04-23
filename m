Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A30C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE37720645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfDWODC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:03:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57070 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfDWODB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:03:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45F81EBD;
        Tue, 23 Apr 2019 07:03:01 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B693F238;
        Tue, 23 Apr 2019 07:02:59 -0700 (PDT)
Date:   Tue, 23 Apr 2019 15:02:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
Message-ID: <20190423140256.GA51985@arrakis.emea.arm.com>
References: <20190409040502.55361-1-cai@lca.pw>
 <20190416171104.GI31772@zn.tnic>
 <26957df8-f1b0-c000-2edf-1368ce22bfce@lca.pw>
 <20190418074510.GB27160@zn.tnic>
 <20190418095015.GB18646@arrakis.emea.arm.com>
 <20190423132518.GA16353@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423132518.GA16353@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tue, Apr 23, 2019 at 03:25:18PM +0200, Borislav Petkov wrote:
> On Thu, Apr 18, 2019 at 10:50:15AM +0100, Catalin Marinas wrote:
> > Kmemleak is basically a tri-colour marking tracing garbage collector [1]
> 
> Thanks for that - interesting read.
> 
> > but without automatic freeing. It relies on a graph of references
> > (pointers) between various objects and the root of such graph is the
> > .bss/.data.

Sorry for the misleading information here, the root of the graph was
changed recently (see below).

> > free_init_pages() is called on memory regions outside .bss/.data like
> > smp_locks, initrd, kernel init text which kmemleak does not track
> > anyway. That said, kmemleak_free_part() is tolerant to unknown pointers,
> > so we could call it directly from free_init_pages().
> 
> Ok, lemme think out loud for a bit here: kmemleak_scan() goes over
> an object list and I guess in our particular case, the memory which
> got freed in mem_encrypt_free_decrypted_mem() *was* in that list too,
> leading to the crash.

Yes.

> Looking at the splat, it is in scan_gray_list() which would mean that
> the object we freed was reachable from the root(s) in .bss.

The .bss/.data used to be root until recently when commit 298a32b13208
("kmemleak: powerpc: skip scanning holes in the .bss section") changed
this to accommodate a similar problem on powerpc. With this commit,
.bss/.data are traced objects but painted "grey" by default so that they
will be always scanned, pretty much like the root (and they can't
"leak").

In Qian's splat, the unmapped area was actually in the .bss which is now
a traced object (no longer a root one). In his previous report on
powerpc [1], the splat was in scan_large_block().

> Now, the docs say:
> 
> "The memory allocations via :c:func:`kmalloc`, :c:func:`vmalloc`,
> :c:func:`kmem_cache_alloc` and
> friends are traced and the pointers, together with additional
> information like size and stack trace, are stored in a rbtree."
> 
> So I guess free_init_pages() should be somehow telling kmemleak, "hey,
> just freed that object, pls adjust your tracking lists" no?
> 
> Because, otherwise, if we start sprinkling those kmemleak_free_part()
> calls everywhere, that'll quickly turn into a game of whack-a-mole. And
> we don't need that especially if kmemleak can easily be taught to handle
> such cases.

Object freeing is tracked in general via the corresponding kfree(),
vfree() etc. and don't need special handling. The .bss doesn't have this
alloc/free symmetry and not freeing it all either, hence this
workaround to register it as a traced object and allow partial freeing.

Anyway, I agree with you. As I mentioned in the previous email,
kmemleak_free_part() is tolerant to unknown objects (not tracked by
kmemleak), so I'm fine with calling it from free_init_pages() even if
not all address ranges passed to this function are known to kmemleak.

> > There is Documentation/dev-tools/kmemleak.rst briefly mentioning the
> > tracing garbage collector (although the Wikipedia link is no longer
> > valid, it should be replaced with [1]). It doesn't, however, state why
> > .bss/.data are special.
> 
> The fact that they're special is important info, I'd say.

I took a note to improve this when I get some time.

> > [1] https://en.wikipedia.org/wiki/Tracing_garbage_collection#Tri-color_marking
> 
> is nice. While reading, it made me think how our discussion would go if
> we didn't have wikipedia. You'd probably say, go to the library and read
> this and that section in this and that book on tri-color marking. :-)

There are probably some academic papers published somewhere ;). But
wikipedia makes things much easier (and free).

-- 
Catalin

[1] http://lkml.kernel.org/r/20190312191412.28656-1-cai@lca.pw
