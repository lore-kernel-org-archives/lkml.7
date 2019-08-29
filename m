Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF079C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2F821874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkU2I+5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfH2RgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:36:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42295 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfH2RgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:36:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id 26so174228pfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5iUGvAYzw1O+VHiYFxxP1p7qYVjC0wX4h6uEN9gWE4=;
        b=AkU2I+5LyVWtiDWxTrCK7eUxO+Bv7qLQlJkRSGT0G08mU9629Pt/v3xAvu5GxZdoAd
         7QT25ijZy2B0CzlyDY7VlVIPSxmKvRD0X9k1v9pnkQwMJwoGUJmcfTx1Q+R02cLc1nuJ
         JEK7v/PpWkMpN+AwyHYQrtVdXWeRP+jfwe8PNmJ+vMQBddJHIINpZiCTBWb4QXx8LAzX
         q5cNTay3h8HOpJglpxnD45NetrwervgYWLrmY8znN1vVPBQaKhhI0qnuCYWvHupsun8I
         T/+ijd9Yz+5bsYvMCtQ/paQOr3LRz7eJh/4qHCzyRPNtd18wb0VzxxvFb4BDDowVVn7n
         fRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5iUGvAYzw1O+VHiYFxxP1p7qYVjC0wX4h6uEN9gWE4=;
        b=Kqy1RedC8X9CpQb+Jld4Tl+ztzIo62yGPEiIEtTs5AVRqTjiTkbjfvjrZ719kwzSam
         e0b4RzvkxuI8k3Clj/9dFib4xNoe8v6ylIeYDa+UUuM8xFJ4oK7E+M/lPARvNHjPvTMx
         sbarnqwaFQUXCZbaF7YdUD/scB4xSOjIhehs1vnXmXCeM80tzV5R+dZzdQH8OylB65yd
         0TEePtw4uFcLVRqvYyD/kMLLDs+YitId2+OspNLia9CLrJ2Z5whYdjYXwhFsV2NOCInL
         sY2Xk2vg1XGnDpFcQPvWto/8Zh5Qsz2hHuua420eaVXWQNEIwgtav4n+D+8C836iumfd
         dcLQ==
X-Gm-Message-State: APjAAAVOK5uL2/WjDpBUUzelyhfhkUX9A6DtYXU2v1mK8Q2J7+CWXKOP
        7SnhsHe/IVG0wr46qVVMJz1wut2LTjLzqp9f+q8CuQ==
X-Google-Smtp-Source: APXvYqwGAWGynbiX0IGvvgALuqzKpT0+yyQmc630WeYhUdpEdomER7dDIxj+IglPndEaW83ZaozMlSoJRjihIdTu7qE=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr10959450pjt.123.1567100183263;
 Thu, 29 Aug 2019 10:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Aug 2019 10:36:12 -0700
Message-ID: <CAKwvOdnUXiX_cAUTSpqgYJTUERoRF-=3LfaydvwBWC6HtzfEdg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] make use of gcc 9's "asm inline()"
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Masahiro, who sent patches earlier this week also looking to clean
up our redefinition of `inline` more.
https://lkml.org/lkml/2019/8/28/44

On Thu, Aug 29, 2019 at 1:32 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> gcc 9 provides a way to override the otherwise crude heuristic that
> gcc uses to estimate the size of the code represented by an asm()
> statement. From the gcc docs
>
>   If you use 'asm inline' instead of just 'asm', then for inlining
>   purposes the size of the asm is taken as the minimum size, ignoring
>   how many instructions GCC thinks it is.

Hi Rasmus,
Thanks for the RFC and including me in the discussion.  Can you link
me to the release notes this came from, and the bug related to this
features development?

I'm curious what "the size of the asm" means, and how it differs
precisely from "how many instructions GCC thinks it is."  I would
think those are one and the same?  Or maybe "the size of the asm"
means the size in bytes when assembled to machine code, as opposed to
the count of assembly instructions?

It looks like LLVM estimates based on instruction count, not assembled
byte size:
https://github.com/llvm/llvm-project/blob/6289ee941d6f8fc222225fb6845efce477bf5094/llvm/lib/CodeGen/TargetInstrInfo.cpp#L75-L125
(That's an arch independent version, that only has an override for hexagon)
I'd imagine it would be possible to implement a machine-code-size
based estimate.

That one snippet alludes to a problem with the existing `asm` GNU C
extension.  (I personally have fixed bugs in LLVM where forgetting to
measure the estimated size of inline assembly leads to instruction
selection that can't represent the appropriate jump ranges.  Knowing
the size of inline assembly is important for the inliner's cost model,
and AIUI gets difficult for some of the assembler directives)  If the
internal heuristic had an issue, I'm curious to know more about the
design decision that led to the introduction of a new GNU C extension
rather than adjustments to the existing heuristic or cost model, and I
assume the bug would have more info?  (Maybe giving developers choice
between two different cost models? Did actual code break changing the
existing `asm` cost model?  Feels like a choice between an imprecise
and a precise cost model, but at this point I'm speculating too far
ahead.)

In particular the reuse of the keyword `inline` in the new GNU C
extension is problematic for our code, as your patchset clearly
illustrates.  I understand that adding new keywords to a language is
impossibly difficult (how many different meanings does `static` have
now, in different contexts) and thus the reuse of them in differing
parse contexts is common (reuse of `auto` in C++11 comes to mind,
though it's not a differing parse context).  I think if the GCC
developers were aware that we redefine the `inline` keyword via C
preprocessor, they may have chosen a different design.  But as you
illustrate, the changes we'd have to make to the kernel are not
insurmountable.

Tangent:
There are many GNU C extensions I love and I hope ISO will adopt.
I've been talking with Hans Boehm about joining up ISO WG14
specifically to help standardize them.  But then again, I don't like
standards that I can't download (the ratified version, not a draft
version).  I also think it's better for implementers to have more say
over standards, and the W3C/WHATWG split is a very very interesting
case study in this regard.  That said, I wish more LLVM folks were
included in the design discussion of GNU C extensions; as trying to
reimplement new language features can flush out edge cases that allow
us to nail down behavior in the spec (let alone have a spec) ASAP.
The only way I find out about new GNU C extensions is when someone in
the kernel goes to use them, and Clang doesn't support it, then the
build is broken until we support them. :(

>
> For compatibility with older compilers, we obviously want a
>
>   #if new enough
>   #define asm_inline asm inline
>   #else
>   #define asm_inline asm
>   #endif

Requesting a feature test macro to the GCC developers would be great;
then we could use feature detection in one place rather than brittle
version checks in multiple places.  Imagine the C preprocessor would
define something like HAS_GNU_ASM_INLINE, then writing a guard would
be simple, and other compilers could define the same preprocessor
token when they add support.  GCC already does this for a recent
extension to inline asm for x86 (I forget the feature name, something
to do with hinting at the flags or output IIRC, Redhat had a blog post
and we recently implemented support).

>
> But since we #define the identifier inline to attach some attributes,
> we have to use the alternate spelling __inline__ of that
> keyword. Unfortunately, we also currently #define that one (to
> inline), so we first have to get rid of all (mis)uses of
> __inline__. Hence the huge diffstat. I think patch 1 should be
> regenerated and applied just before -rc1.
>
> There are a few remaining users of __inline__, in particular in uapi
> headers, which I'm not sure what to do about (kernel-side users of
> those will get slightly different semantics since we no longer
> automatically attach the __attribute__((__gnu_inline__)) etc.). So RFC.

No thoughts on uapi, but I think we should break this work logically into two:
1. remove our redefinition of inline
2. implement asm_inline for GCC

I think what you have for 2 so far is ok, but I need to spend more
time thinking about it.

For 1:
Our redefinition of inline currently looks like:

146 #define inline inline __attribute__((__always_inline__))
__gnu_inline \
147   __maybe_unused notrace

So we have:
1. always_inline attribute
2. gnu_inline attribute
3. maybe_unused
4. notrace

I'm not convinced that always_inline works as intended.  An inliner
can still refuse to inline something if it doesn't have the machinery
to perform all of the transformations required for inlining or it's
not safe to do so.  The C preprocessor is the one true always inline
(and type safety be damned).  It would be interesting to study the
effects of removing that attribute.  Android's Java runtime, ART uses
this everywhere for all functions, and it's not clear that adding
attribute always_inline everywhere is an "optimization."  Research
folks at Google are playing with finding better inlining heuristics
via machine learning, which is quite exciting.

I introduced gnu_inline; it's like the one semantically different
thing from C89 to C99 IIRC.  I introduced it because a few places in
the kernel were redefining KBUILD_CFLAGS, dropping `-std=gnu89`.  It
seems now that there's only a few places left that do that, and
they're all under arch/x86/ (see:
https://github.com/ClangBuiltLinux/linux/issues/618#issuecomment-525712390).
Note that it's a little tricky to undo this; someone just reported
yesterday that I broke kexec, and we're working on cleaning that up,
but I think doing that then adding a check to not redefine
KBUILD_CFLAGS (cc Joe) to scripts/checkpatch.pl would doable.  If we
fixed that, than we could use `-fgnu_inline` (or w/e the spelling is)
command line flag instead of the compiler attribute.

Masahiro is playing around with the maybe_unused part.  Seems to be a
difference in GCC and Clang warning on unused static inline functions.
I think this can be solved with correct usage of #ifdef guards for the
appropriate CONFIG_'s, rather than __maybe_unused.

notrace's definition is pretty complicated, I have no idea what any of
those attributes do...

But maybe all of that is moot, if we just use __inline__.  Looking
more at your patchset after typing this all out, seems like that will
work.

>
> The two x86 changes cause smaller code gen differences than I'd
> expect, but I think we do want the asm_inline thing available sooner
> or later, so this is just to get the ball rolling.

Is it a net win for all arch's? Or just x86?  `differences` being an
improvement or a regression?


>
> Rasmus Villemoes (5):
>   treewide: replace __inline__ by inline
>   compiler_types.h: don't #define __inline__
>   compiler-gcc.h: add asm_inline definition
>   x86: alternative.h: use asm_inline for all alternative variants
>   x86: bug.h: use asm_inline in _BUG_FLAGS definitions
>
>  arch/alpha/include/asm/atomic.h               | 12 +++---
>  arch/alpha/include/asm/bitops.h               |  6 +--
>  arch/alpha/include/asm/dma.h                  | 22 +++++-----
>  arch/alpha/include/asm/floppy.h               |  2 +-
>  arch/alpha/include/asm/irq.h                  |  2 +-
>  arch/alpha/include/asm/local.h                |  4 +-
>  arch/alpha/include/asm/smp.h                  |  2 +-
>  .../arm/mach-iop32x/include/mach/uncompress.h |  2 +-
>  .../arm/mach-iop33x/include/mach/uncompress.h |  2 +-
>  .../arm/mach-ixp4xx/include/mach/uncompress.h |  2 +-
>  arch/ia64/hp/common/sba_iommu.c               |  2 +-
>  arch/ia64/hp/sim/simeth.c                     |  2 +-
>  arch/ia64/include/asm/atomic.h                |  8 ++--
>  arch/ia64/include/asm/bitops.h                | 34 ++++++++--------
>  arch/ia64/include/asm/delay.h                 | 14 +++----
>  arch/ia64/include/asm/irq.h                   |  2 +-
>  arch/ia64/include/asm/page.h                  |  2 +-
>  arch/ia64/include/asm/sn/leds.h               |  2 +-
>  arch/ia64/include/asm/uaccess.h               |  4 +-
>  arch/ia64/oprofile/backtrace.c                |  4 +-
>  arch/m68k/include/asm/blinken.h               |  2 +-
>  arch/m68k/include/asm/checksum.h              |  2 +-
>  arch/m68k/include/asm/dma.h                   | 32 +++++++--------
>  arch/m68k/include/asm/floppy.h                |  8 ++--
>  arch/m68k/include/asm/nettel.h                |  8 ++--
>  arch/m68k/mac/iop.c                           | 14 +++----
>  arch/mips/include/asm/atomic.h                | 16 ++++----
>  arch/mips/include/asm/checksum.h              |  2 +-
>  arch/mips/include/asm/dma.h                   | 20 +++++-----
>  arch/mips/include/asm/jazz.h                  |  2 +-
>  arch/mips/include/asm/local.h                 |  4 +-
>  arch/mips/include/asm/string.h                |  8 ++--
>  arch/mips/kernel/binfmt_elfn32.c              |  2 +-
>  arch/nds32/include/asm/swab.h                 |  4 +-
>  arch/parisc/include/asm/atomic.h              | 20 +++++-----
>  arch/parisc/include/asm/bitops.h              | 18 ++++-----
>  arch/parisc/include/asm/checksum.h            |  4 +-
>  arch/parisc/include/asm/compat.h              |  2 +-
>  arch/parisc/include/asm/delay.h               |  2 +-
>  arch/parisc/include/asm/dma.h                 | 20 +++++-----
>  arch/parisc/include/asm/ide.h                 |  8 ++--
>  arch/parisc/include/asm/irq.h                 |  2 +-
>  arch/parisc/include/asm/spinlock.h            | 12 +++---
>  arch/powerpc/include/asm/atomic.h             | 40 +++++++++----------
>  arch/powerpc/include/asm/bitops.h             | 28 ++++++-------
>  arch/powerpc/include/asm/dma.h                | 20 +++++-----
>  arch/powerpc/include/asm/edac.h               |  2 +-
>  arch/powerpc/include/asm/irq.h                |  2 +-
>  arch/powerpc/include/asm/local.h              | 14 +++----
>  arch/sh/include/asm/pgtable_64.h              |  2 +-
>  arch/sh/include/asm/processor_32.h            |  4 +-
>  arch/sh/include/cpu-sh3/cpu/dac.h             |  6 +--
>  arch/x86/include/asm/alternative.h            | 14 +++----
>  arch/x86/include/asm/bug.h                    |  4 +-
>  arch/x86/um/asm/checksum.h                    |  4 +-
>  arch/x86/um/asm/checksum_32.h                 |  4 +-
>  arch/xtensa/include/asm/checksum.h            | 14 +++----
>  arch/xtensa/include/asm/cmpxchg.h             |  4 +-
>  arch/xtensa/include/asm/irq.h                 |  2 +-
>  block/partitions/amiga.c                      |  2 +-
>  drivers/atm/he.c                              |  6 +--
>  drivers/atm/idt77252.c                        |  6 +--
>  drivers/gpu/drm/mga/mga_drv.h                 |  2 +-
>  drivers/gpu/drm/mga/mga_state.c               | 14 +++----
>  drivers/gpu/drm/r128/r128_drv.h               |  2 +-
>  drivers/gpu/drm/r128/r128_state.c             | 14 +++----
>  drivers/gpu/drm/via/via_irq.c                 |  2 +-
>  drivers/gpu/drm/via/via_verifier.c            | 30 +++++++-------
>  drivers/media/pci/ivtv/ivtv-ioctl.c           |  2 +-
>  drivers/net/ethernet/sun/sungem.c             |  8 ++--
>  drivers/net/ethernet/sun/sunhme.c             |  6 +--
>  drivers/net/hamradio/baycom_ser_fdx.c         |  2 +-
>  drivers/net/wan/lapbether.c                   |  2 +-
>  drivers/net/wan/n2.c                          |  4 +-
>  drivers/parisc/led.c                          |  4 +-
>  drivers/parisc/sba_iommu.c                    |  2 +-
>  drivers/parport/parport_gsc.h                 |  4 +-
>  drivers/scsi/lpfc/lpfc_scsi.c                 |  2 +-
>  drivers/scsi/pcmcia/sym53c500_cs.c            |  4 +-
>  drivers/scsi/qla2xxx/qla_inline.h             |  2 +-
>  drivers/scsi/qla2xxx/qla_os.c                 |  2 +-
>  drivers/tty/amiserial.c                       |  2 +-
>  drivers/tty/serial/ip22zilog.c                |  2 +-
>  drivers/tty/serial/sunsab.c                   |  4 +-
>  drivers/tty/serial/sunzilog.c                 |  2 +-
>  drivers/video/fbdev/core/fbcon.c              | 20 +++++-----
>  drivers/video/fbdev/ffb.c                     |  2 +-
>  drivers/video/fbdev/intelfb/intelfbdrv.c      |  8 ++--
>  drivers/video/fbdev/intelfb/intelfbhw.c       |  2 +-
>  drivers/w1/masters/matrox_w1.c                |  4 +-
>  fs/coda/coda_linux.h                          |  6 +--
>  fs/freevxfs/vxfs_inode.c                      |  2 +-
>  fs/nfsd/nfsfh.h                               |  4 +-
>  include/acpi/platform/acgcc.h                 |  2 +-
>  include/asm-generic/ide_iops.h                |  8 ++--
>  include/linux/atalk.h                         |  4 +-
>  include/linux/compiler-gcc.h                  |  4 ++
>  include/linux/compiler_types.h                |  5 ++-
>  include/linux/hdlc.h                          |  4 +-
>  include/linux/inetdevice.h                    |  6 +--
>  include/linux/parport.h                       |  4 +-
>  include/linux/parport_pc.h                    | 22 +++++-----
>  include/net/ax25.h                            |  2 +-
>  include/net/checksum.h                        |  2 +-
>  include/net/dn_nsp.h                          | 16 ++++----
>  include/net/ip.h                              |  2 +-
>  include/net/ip6_checksum.h                    |  2 +-
>  include/net/ipx.h                             | 10 ++---
>  include/net/llc_c_ev.h                        |  4 +-
>  include/net/llc_conn.h                        |  4 +-
>  include/net/llc_s_ev.h                        |  2 +-
>  include/net/netrom.h                          |  8 ++--
>  include/net/scm.h                             | 14 +++----
>  include/net/udplite.h                         |  2 +-
>  include/net/x25.h                             |  8 ++--
>  include/net/xfrm.h                            | 18 ++++-----
>  include/video/newport.h                       | 12 +++---
>  net/appletalk/atalk_proc.c                    |  4 +-
>  net/appletalk/ddp.c                           |  2 +-
>  net/core/neighbour.c                          |  2 +-
>  net/core/scm.c                                |  2 +-
>  net/decnet/dn_nsp_in.c                        |  2 +-
>  net/decnet/dn_nsp_out.c                       |  2 +-
>  net/decnet/dn_route.c                         |  2 +-
>  net/decnet/dn_table.c                         |  4 +-
>  net/ipv6/af_inet6.c                           |  2 +-
>  net/ipv6/icmp.c                               |  4 +-
>  net/ipv6/udp.c                                |  2 +-
>  net/lapb/lapb_iface.c                         |  4 +-
>  net/llc/llc_input.c                           |  2 +-
>  sound/sparc/amd7930.c                         |  6 +--
>  131 files changed, 449 insertions(+), 442 deletions(-)
>
> --
> 2.20.1
>


--
Thanks,
~Nick Desaulniers
