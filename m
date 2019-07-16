Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02038C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87542064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbfGPXRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:17:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfGPXRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:17:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9475F85376;
        Tue, 16 Jul 2019 23:17:21 +0000 (UTC)
Received: from treble (ovpn-123-204.rdu2.redhat.com [10.10.123.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 798865D71D;
        Tue, 16 Jul 2019 23:17:20 +0000 (UTC)
Date:   Tue, 16 Jul 2019 18:17:18 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 00/22] x86, objtool: several fixes/improvements
Message-ID: <20190716231718.flutou25wemgsfju@treble>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <20190715193834.5tvzukcwq735ufgb@treble>
 <CAKwvOdnXt=_NVjK7+RjuxeyESytO6ra769i4qjSwt1Gd1G22dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnXt=_NVjK7+RjuxeyESytO6ra769i4qjSwt1Gd1G22dA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 16 Jul 2019 23:17:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 02:45:39PM -0700, Nick Desaulniers wrote:
> For a defconfig, that's the only issue I see.
> (Note that I just landed https://reviews.llvm.org/rL366130 for fixing
> up bugs from loop unrolling loops containing asm goto with Clang, so
> anyone else testing w/ clang will see fewer objtool warnings with that
> patch applied.  A follow up is being worked on in
> https://reviews.llvm.org/D64101).
> 
> For allmodconfig:
> arch/x86/ia32/ia32_signal.o: warning: objtool:
> ia32_setup_rt_frame()+0x247: call to memset() with UACCESS enabled
> mm/kasan/common.o: warning: objtool: kasan_report()+0x52: call to
> __stack_chk_fail() with UACCESS enabled
> arch/x86/kernel/signal.o: warning: objtool:
> x32_setup_rt_frame()+0x255: call to memset() with UACCESS enabled
> arch/x86/kernel/signal.o: warning: objtool: __setup_rt_frame()+0x254:
> call to memset() with UACCESS enabled
> drivers/ata/sata_dwc_460ex.o: warning: objtool:
> sata_dwc_bmdma_start_by_tag()+0x3a0: can't find switch jump table
> lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch()+0x88:
> call to memset() with UACCESS enabled
> lib/ubsan.o: warning: objtool: ubsan_type_mismatch_common()+0x610:
> call to __stack_chk_fail() with UACCESS enabled
> lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch_v1()+0x88:
> call to memset() with UACCESS enabled
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
> .altinstr_replacement+0x56: redundant UACCESS disable
> 
> Without your series, I see them anyways, so I don't consider them
> regressions added by this series.  Let's follow up on these maybe in a
> new thread?  (Shall I send you these object files?)

Yes, maybe open a new thread and be sure to copy PeterZ.  He loves those
warnings ;-)  Object files are definitely needed.

> So for the series:
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

> 
> > >
> > >    I haven't dug into it yet.
> > >
> > > 2) There's also an issue in clang where a large switch table had a bunch
> > >    of unused (bad) entries.  It's not a code correctness issue, but
> > >    hopefully it can get fixed in clang anyway.  See patch 20/22 for more
> > >    details.
> 
> Thanks for the report, let's follow up on steps for me to reproduce.

Just to clarify, there are two clang issues.  Both of them were reported
originally by Arnd, IIRC.

1) The one described above and in patch 20, where the switch table is
   mostly unused entries.  Not a real bug, but it's a bit sloppy and
   wasteful, and objtool doesn't know how to interpret it.

2) The bug with the noreturn call site having a different stack size
   depending on which code path was taken.

> > > These patches are also at:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-many-fixes
> 
> Are these the same patches? Some of the commit messages look different, like:
> https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=objtool-many-fixes&id=3e39561c52c4f0062207d604c972148b7b60c341

Oops, those extra 3 commits weren't supposed to be there.  That's future
work.  I dropped them from the branch.

-- 
Josh
