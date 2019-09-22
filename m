Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BB2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCAD2070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 08:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSsWX8MA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfIVIdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 04:33:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45524 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfIVIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 04:33:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33so9961053edh.12;
        Sun, 22 Sep 2019 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnbpJSkHQzTc6pmpTpcRMwwuobVDPRMcKcK57Dlzk7s=;
        b=oSsWX8MAi9CmHhMtDZH2PkTyNHhml35+tyR4/HTBmDuhXTGcBnMvHwywN1eGnAEpIz
         MiKnJqIIkpZSwg421YJUEc9/2KDyHf+MER5g2HU1EfblJgMbItMRIdukLM9uUPjf6OI9
         lV44KVbSylFHq18H9MEP4dhx3Z5hO9SyTdkx3DmfoCeDZ8q7SFXTCFrdyCSy+jLVyW0w
         5bqkmkPiWfUmhqHc+n72QqdniCU/gUSTzbLZu+drg+TDaObaZKgorpZsBO/GCqzkNunP
         OZcCDEHgCQF0+btlcXyQsqi1TmJVl3ll0wYH90IEZCDVVR6+a7/si3rrpRIMg4x3mrHn
         uYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnbpJSkHQzTc6pmpTpcRMwwuobVDPRMcKcK57Dlzk7s=;
        b=eq/b4wsQgjbQSgu5JTMfKZVSKoq9qcFTvyeOFyFuQEJtAXPpTCW3BqEMxlTJZt6FRQ
         S77GGDect2amuVufzW4lkliUKaSkPl55++iVsHjFoC5aDewEHZwGK8UQX8jKe7yqABBZ
         vDolhPoqEwkOONh8HRywxdfjUW4mN9BdZtKtgEPKDf+w5WsYF6AXtR2rGlyGVCl16phG
         44ErzHwx8jr/mqlLKxXgu/85wfx8/GJ41JLGnKUz8W1li6mxgGKnoC6dzDGMFErsLmGX
         A0QofrC+0AVr5wEE/UsiQYqI8x3dk4/ZmjDO5vJHatntpQVwgaSxQgvHJf7/2VSUJzXZ
         65mw==
X-Gm-Message-State: APjAAAXI6bRRFzuR0IFYlqDdAsK2ZGY6KorvVMNs1U3TfN57oi8YSBPY
        MF80GYn/hDuWnaoG0lhY0sYJIMHp354CKorv9aRS8A==
X-Google-Smtp-Source: APXvYqwbSafmsMSyT9iRmDj1HLUmS3rr3Afzvg7/9V0DzYSpgmhHcmuFCDXg/cz1m9VSoJZWEK67Si51TVhIBihJbc4=
X-Received: by 2002:a17:906:ccd6:: with SMTP id ot22mr5253413ejb.1.1569141195127;
 Sun, 22 Sep 2019 01:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqwizJ2HXdiU7aSH9t=ecBEHnxdVVsQ4wUpTYRpCgdXf=w@mail.gmail.com>
In-Reply-To: <CADxRZqwizJ2HXdiU7aSH9t=ecBEHnxdVVsQ4wUpTYRpCgdXf=w@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sun, 22 Sep 2019 11:33:08 +0300
Message-ID: <CADxRZqzx=8jNQuvi8WN=7U_G5a0f+v_GODHH8q3QJVYmg=n1LA@mail.gmail.com>
Subject: Re: latest git kernel (v5.3-11506-gf7c3bf8fa7e5) does not compile
To:     Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 11:13 AM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> Hello!
>
> Latest git kernel does not compile for me:
>
> ~/linux-2.6$ git desc
> v5.3-11506-gf7c3bf8fa7e5
>
> ~/linux-2.6$ make
>   CALL    scripts/checksyscalls.sh
> <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>   CALL    scripts/atomic/check-atomics.sh
>   CHK     include/generated/compile.h
>   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> make[2]: *** [scripts/Makefile.build:266:
> arch/sparc/vdso/vdso32/vclock_gettime.o] Error 1
> make[2]: *** Deleting file 'arch/sparc/vdso/vdso32/vclock_gettime.o'
> make[1]: *** [scripts/Makefile.build:509: arch/sparc/vdso] Error 2
> make: *** [Makefile:1667: arch/sparc] Error
>
> but I was able to compile successfully v5.3-10169-g574cc4539762
>
> Not sure my bisect log is right, but here it is:
>
> $ git bisect good
> 54b8ae66ae1a3454a7645d159a482c31cd89ab33 is the first bad commit
> commit 54b8ae66ae1a3454a7645d159a482c31cd89ab33
> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date:   Fri Aug 30 13:34:01 2019 +0900
>
>     kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)
>
>     Kbuild provides per-file compiler flag addition/removal:
>
>       CFLAGS_<basetarget>.o
>       CFLAGS_REMOVE_<basetarget>.o
>       AFLAGS_<basetarget>.o
>       AFLAGS_REMOVE_<basetarget>.o
>       CPPFLAGS_<basetarget>.lds
>       HOSTCFLAGS_<basetarget>.o
>       HOSTCXXFLAGS_<basetarget>.o
>
>     The <basetarget> is the filename of the target with its directory and
>     suffix stripped.
>
>     This syntax comes into a trouble when two files with the same basename
>     appear in one Makefile, for example:
>
>       obj-y += foo.o
>       obj-y += dir/foo.o
>       CFLAGS_foo.o := <some-flags>
>
>     Here, the <some-flags> applies to both foo.o and dir/foo.o
>
>     The real world problem is:
>
>       scripts/kconfig/util.c
>       scripts/kconfig/lxdialog/util.c
>
>     Both files are compiled into scripts/kconfig/mconf, but only the
>     latter should be given with the ncurses flags.
>
>     It is more sensible to use the relative path to the Makefile, like this:
>
>       obj-y += foo.o
>       CFLAGS_foo.o := <some-flags>
>       obj-y += dir/foo.o
>       CFLAGS_dir/foo.o := <other-flags>
>
>     At first, I attempted to replace $(basetarget) with $*. The $* variable
>     is replaced with the stem ('%') part in a pattern rule. This works with
>     most of cases, but does not for explicit rules.
>
>     For example, arch/ia64/lib/Makefile reuses rule_as_o_S in its own
>     explicit rules, so $* will be empty, resulting in ignoring the per-file
>     AFLAGS.
>
>     I introduced a new variable, target-stem, which can be used also from
>     explicit rules.
>
>     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>     Acked-by: Marc Zyngier <maz@kernel.org>
>
>  arch/arm/kvm/Makefile                         |  5 +++--
>  arch/x86/entry/vdso/Makefile                  |  3 ++-
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile |  6 +++---
>  drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  2 +-
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 17 +++++++----------
>  drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  7 +++----
>  drivers/gpu/drm/i915/Makefile                 |  2 +-
>  scripts/Makefile.host                         | 22 +++++++++++-----------
>  scripts/Makefile.lib                          | 13 ++++++++-----
>  scripts/kconfig/Makefile                      |  8 ++++----
>  10 files changed, 43 insertions(+), 42 deletions(-)
> mator@ttip:~/linux-2.6$
>
>
> If someone wants to check how kernel compiles on sparc64, could use
> gcc compile farm machine (gcc202) to try on.

and i cannot test compile 54b8ae66ae1a3454a7645d159a482c31cd89ab33 as well :

~/linux-2.6$ git checkout 54b8ae66ae1a3454a7645d159a482c31cd89ab33
HEAD is now at 54b8ae66ae1a kbuild: change *FLAGS_<basetarget>.o to
take the path relative to $(obj)

~/linux-2.6$ make -j clean; make -j olddefconfig && nice make -j24
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --olddefconfig Kconfig
#
# No change to .config
#
scripts/kconfig/conf  --syncconfig Kconfig
{ command -v gcc; } >/dev/null 2>&1 && echo "n" || echo "y": Cannot
allocate memory
make[2]: *** [scripts/kconfig/Makefile:73: syncconfig] Error 1
make[1]: *** [Makefile:584: syncconfig] Error 2
make: *** [Makefile:695: include/config/auto.conf.cmd] Error 2
~/linux-2.6$



PS: unable to compile kernel makes its bisection impossible =(
