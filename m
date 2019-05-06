Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59B1C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DF62082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lSoJLHq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfEFHZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:25:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56475 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfEFHZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:25:00 -0400
Received: from [IPv6:2601:646:8680:2bb1:2c1a:a861:2af0:6203] ([IPv6:2601:646:8680:2bb1:2c1a:a861:2af0:6203])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x467OfQH4051413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 6 May 2019 00:24:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x467OfQH4051413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557127484;
        bh=2mwrs2IoZVU00bTH7LKnu03eIVqUi3rcwkPWpTGsk+M=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=lSoJLHq1Va2vnsuWLt02IKTx0oR3sdc0lc57h+vP4uFmYsJTWktIExKX0xK5WjRKR
         nzIs3dfpoaibeFrx3YUhnDVFUefI9YztGzdqxH5nCBugpRtCGbA+iYV+ZY0v4CPefw
         jniAOXi73xkFsIYnCQHM1CCqBAwK9NZeg9bXU8UnXJwisicrY945VNiPPjy5INznj5
         7yp+oXCpIkhvuTkUGy/lZBRbV72U7PntH9Zx3JEQ06eTptNHQAGYXz1wOrCFSwkvZd
         EEyzD9HMArvJ8lKVF4Tr8G+JRU24U8whDjhuIre4PgKiQL9UWafw8trYoOmyBOldcG
         9A5YgP0UpFjKg==
Date:   Mon, 06 May 2019 00:24:32 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190506072012.GA33946@gmail.com>
References: <20190506072012.GA33946@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] objtool changes for v5.2: Add build-time uaccess permissions and DF validation
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   hpa@zytor.com
Message-ID: <3D9DB587-A502-42EA-A6F6-5790735310F5@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 6, 2019 12:20:12 AM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>Linus,
>
>Please pull the latest core-objtool-for-linus git tree from:
>
>git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/tip/tip=2Egit
>core-objtool-for-linus
>
># HEAD: 29da93fea3ea39ab9b12270cc6be1b70ef201c9e mm/uaccess: Use
>'unsigned long' to placate UBSAN warnings on older GCC versions
>
>This is a series from Peter Zijlstra that adds x86 build-time uaccess=20
>validation of SMAP to objtool, which will detect and warn about the=20
>following uaccess API usage bugs and weirdnesses:
>
>	call to %s() with UACCESS enabled
>	return with UACCESS enabled
>	return with UACCESS disabled from a UACCESS-safe function
>	recursive UACCESS enable
>	redundant UACCESS disable
>	UACCESS-safe disables UACCESS
>
>As it turns out not leaking uaccess permissions outside the intended=20
>uaccess functionality is hard when the interfaces are complex and when=20
>such bugs are mostly dormant=2E
>
>As a bonus we now also check the DF flag=2E We had at least one=20
>high-profile bug in that area in the early days of Linux, and the=20
>checking is fairly simple=2E The checks performed and warnings emitted
>are:
>
>	call to %s() with DF set
>	return with DF set
>	return with modified stack frame
>	recursive STD
>	redundant CLD
>
>It's all x86-only for now, but later on this can also be used for PAN
>on=20
>ARM and objtool is fairly cross-platform in principle=2E
>
>While all warnings emitted by this new checking facility that got=20
>reported to us were fixed, there might be GCC version dependent
>warnings=20
>that were not reported yet - which we'll address, should they trigger=2E
>
>The warnings are non-fatal build warnings=2E
>
> Thanks,
>
>	Ingo
>
>------------------>
>Josh Poimboeuf (1):
>      tracing: Improve "if" macro code generation
>
>Peter Zijlstra (26):
>      sched/x86: Save [ER]FLAGS on context switch
>      x86/ia32: Fix ia32_restore_sigcontext() AC leak
>      i915, uaccess: Fix redundant CLAC
>      x86/uaccess: Move copy_user_handle_tail() into asm
>      x86/uaccess: Fix up the fixup
>      x86/nospec, objtool: Introduce ANNOTATE_IGNORE_ALTERNATIVE
>      x86/uaccess, xen: Suppress SMAP warnings
>      x86/uaccess: Always inline user_access_begin()
>      x86/uaccess, signal: Fix AC=3D1 bloat
>      x86/uaccess: Introduce user_access_{save,restore}()
>      x86/smap: Ditch __stringify()
>      x86/uaccess, kasan: Fix KASAN vs SMAP
>      x86/uaccess, ubsan: Fix UBSAN vs=2E SMAP
>      x86/uaccess, ftrace: Fix ftrace_likely_update() vs=2E SMAP
>      x86/uaccess, kcov: Disable stack protector
>      objtool: Set insn->func for alternatives
>      objtool: Handle function aliases
>      objtool: Rewrite add_ignores()
>      objtool: Add --backtrace support
>      objtool: Rewrite alt->skip_orig
>      objtool: Fix sibling call detection
>      objtool: Add UACCESS validation
>      objtool: Add Direction Flag validation
>      sched/x86_64: Don't save flags on context switch
>x86/uaccess: Dont leak the AC flag into __put_user() argument
>evaluation
>mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC
>versions
>
>
> arch/x86/entry/entry_32=2ES                  |   2 +
> arch/x86/ia32/ia32_signal=2Ec                |  29 ++-
> arch/x86/include/asm/alternative-asm=2Eh     |  11 +
> arch/x86/include/asm/alternative=2Eh         |  10 +
> arch/x86/include/asm/asm=2Eh                 |  24 --
> arch/x86/include/asm/nospec-branch=2Eh       |  28 +-
> arch/x86/include/asm/smap=2Eh                |  37 ++-
> arch/x86/include/asm/switch_to=2Eh           |   1 +
> arch/x86/include/asm/uaccess=2Eh             |  12 +-
> arch/x86/include/asm/uaccess_64=2Eh          |   3 -
> arch/x86/include/asm/xen/hypercall=2Eh       |  24 +-
> arch/x86/kernel/process_32=2Ec               |   7 +
> arch/x86/kernel/process_64=2Ec               |   1 +
> arch/x86/kernel/signal=2Ec                   |  29 ++-
> arch/x86/lib/copy_user_64=2ES                |  48 ++++
> arch/x86/lib/memcpy_64=2ES                   |   3 +-
> arch/x86/lib/usercopy_64=2Ec                 |  20 --
> drivers/gpu/drm/i915/i915_gem_execbuffer=2Ec |   6 +-
> include/linux/compiler=2Eh                   |   2 +-
> include/linux/uaccess=2Eh                    |   2 +
> kernel/Makefile                            |   1 +
> kernel/trace/trace_branch=2Ec                |   4 +
> lib/Makefile                               |   1 +
> lib/strncpy_from_user=2Ec                    |   5 +-
> lib/strnlen_user=2Ec                         |   4 +-
> lib/ubsan=2Ec                                |   4 +
> mm/kasan/Makefile                          |   3 +
> mm/kasan/common=2Ec                          |  10 +
> mm/kasan/report=2Ec                          |   3 +-
> scripts/Makefile=2Ebuild                     |   3 +
> tools/objtool/arch=2Eh                       |   8 +-
> tools/objtool/arch/x86/decode=2Ec            |  21 +-
> tools/objtool/builtin-check=2Ec              |   4 +-
> tools/objtool/builtin=2Eh                    |   2 +-
>tools/objtool/check=2Ec                      | 400
>++++++++++++++++++++++-------
> tools/objtool/check=2Eh                      |   4 +-
> tools/objtool/elf=2Ec                        |  15 +-
> tools/objtool/elf=2Eh                        |   3 +-
> tools/objtool/special=2Ec                    |  18 ++
> tools/objtool/special=2Eh                    |   1 +
> tools/objtool/warn=2Eh                       |   8 +
> 41 files changed, 602 insertions(+), 219 deletions(-)

Superb work=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
