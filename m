Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A91C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FF72146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uBOqTUsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfELGaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 02:30:25 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:29228 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELGaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 02:30:25 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x4C6UHBd014888
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 15:30:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x4C6UHBd014888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557642618;
        bh=bL94uQAcYddVKe/QGZzldJoo8Owb4K3DuGZ6ufXdU+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uBOqTUswuL8d1fFAbQ5kTzfN1jkjIW2lCgRP03ocBomvZ94371gI4t6z+Ha0VmXp7
         jCiX1TV1pagLldY8cUnb+D+Wh25Fd3CCfTZ6ZsccaMl1EQUDO2ghKNIvKyX/z+r1aR
         ie+i8SRkUJ/Af9wPHoF6cCxyN2QKQFjQxVaUeX93XRAdXxO0lJXYoPhMI00VEIDCS3
         s2falu4GLdOmk50T1x+vIyqGU220bOnPp/YdV4Qfte7Q4cqPhD1vip1RU6pD3B9GMb
         ICbsNDGkvS3U4LUrB3cPM+JPYbXgredtzChqcSZmNrl0S3SyJo8ZZXsiOMTj3K3oK2
         fcso3+BrWp6GA==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id j184so6072529vsd.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 23:30:17 -0700 (PDT)
X-Gm-Message-State: APjAAAU1vy4FA19Iku2Y/NV9H7OkTUQWh6TS/qTmbA1+v+zZMssM3865
        oiwo+ZPH4DK5GdbEYGY/3V7O0qfFvPpPwIvBhQ8=
X-Google-Smtp-Source: APXvYqxTmSxmWVOuglAFsRz+1MuLlNhtt0fUjw2s0Qnxz4wQmXIajn/0+oeCGj6+28XE3mazSDVSGhNzSkgMsufHwZg=
X-Received: by 2002:a67:f443:: with SMTP id r3mr10493562vsn.179.1557642616428;
 Sat, 11 May 2019 23:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <874f34f9bfc840c39719707a2e12fed4-mfwitten@gmail.com>
In-Reply-To: <874f34f9bfc840c39719707a2e12fed4-mfwitten@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 12 May 2019 15:29:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATUu6pSzasKEoVJfh+fS0cEq839kxrCcCwWxfsoubnQcQ@mail.gmail.com>
Message-ID: <CAK7LNATUu6pSzasKEoVJfh+fS0cEq839kxrCcCwWxfsoubnQcQ@mail.gmail.com>
Subject: Re: The UAPI references Kconfig's CONFIG_* macros (variables)
To:     Michael Witten <mfwitten@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 1:28 PM Michael Witten <mfwitten@gmail.com> wrote:
>
> The  UAPI  headers  contain  references  to  Kconfig's  `CONFIG_'
> macros. Either this is a bug,  or there needs to be some standard
> way for users  to provide definitions for these  macros, in order
> to complete Linux's user-space API. Consider:


In fact, scripts/headers_check.pl has ability to check
CONFIG_ options leaked to user space,
but it has been disabled for a long time.

If you revert the following and run "make headers_check",
you will see lots.

In my understanding, we want to check this,
but it is _still_ too noisy.



commit 7e3fa56141175026136b392fd026d5d07c49720e
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Fri Jan 30 23:56:42 2009 +0100

    kbuild: drop check for CONFIG_ in headers_check

    The check for references to CONFIG_ symbols in exported headers turned
    out to be too agressive with the current state of affairs.
    After the work of Jaswinder to clean up all relevant cases we are down
    to almost pure noise.

    So lets drop the check for now - we can always add it back later
    should our headers be ready for that.

    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/scripts/headers_check.pl b/scripts/headers_check.pl
index db30fac..56f90a4 100644
--- a/scripts/headers_check.pl
+++ b/scripts/headers_check.pl
@@ -38,7 +38,7 @@ foreach my $file (@files) {
                &check_asm_types();
                &check_sizetypes();
                &check_prototypes();
-               &check_config();
+               # Dropped for now. Too much noise &check_config();
        }
        close FH;
 }









>
>   #!/bin/sh
>   cd "${linux_repo}"
>
>   # Careful!
>   #git reset --hard HEAD
>   #git clean -fdx
>
>   git checkout v5.1
>   #zcat /proc/config.gz >.config
>
>   mkdir -p /tmp/uapi/include
>   make INSTALL_HDR_PATH=3D/tmp/uapi headers_install
>
>   printf >/tmp/uapi/raw.c '%s\n%s\n' \
>     '#include <linux/raw.h>' \
>     'int main() { return MAX_RAW_MINORS; }'
>
> Then:
>
>   $ gcc -c -I/tmp/uapi/include /tmp/uapi/raw.c
>   In file included from /tmp/uapi/raw.c:1:0:
>   /tmp/uapi/raw.c: In function =E2=80=98main=E2=80=99:
>   /tmp/uapi/include/linux/raw.h:17:24: error: =E2=80=98CONFIG_MAX_RAW_DEV=
S=E2=80=99 undeclared (first use in this function)
>    #define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
>                           ^
>   /tmp/uapi/raw.c:2:21: note: in expansion of macro =E2=80=98MAX_RAW_MINO=
RS=E2=80=99
>    int main() { return MAX_RAW_MINORS; }
>                        ^~~~~~~~~~~~~~
>   /tmp/uapi/include/linux/raw.h:17:24: note: each undeclared identifier i=
s reported only once for each function it appears in
>    #define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
>                           ^
>   /tmp/uapi/raw.c:2:21: note: in expansion of macro =E2=80=98MAX_RAW_MINO=
RS=E2=80=99
>    int main() { return MAX_RAW_MINORS; }
>                        ^~~~~~~~~~~~~~
>
> As you can  see, the UAPI is actually incomplete;  there is not a
> valid  definition for  `MAX_RAW_MINORS'.  Indeed,  on my  system,
> `CONFIG_MAX_RAW_DEVS'  isn't   ever  defined   anywhere,  because
> `CONFIG_RAW_DRIVER' is not set:
>
>   $ git show v5.1:drivers/char/Kconfig | sed -n 467,469p
>   config MAX_RAW_DEVS
>           int "Maximum number of RAW devices to support (1-65536)"
>           depends on RAW_DRIVER
>   $ zcat /proc/config.gz | grep RAW_DRIVER
>   # CONFIG_RAW_DRIVER is not set
>
> Even if `CONFIG_RAW_DRIVER' were  set, the desired definition for
> the  macro  `CONFIG_MAX_RAW_DEVS'  would  only be  found  in  the
> following  header (generated  at  built-time),  which is  neither
> officially nor likely available to user space:
>
>   "${linux_repo}"/include/generated/autoconf.h
>
> Other  such  references to  `CONFIG_*'  macros  are seen  in  the
> following  (some  appear only  in  comments,  but perhaps  that's
> conceptually a mistake, too):
>
>   $ (cd /tmp/uapi/include && grep -R . -e \\bCONFIG_)
>   ./asm/mman.h:#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>   ./asm/auxvec.h:#if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X8=
6_64)
>   ./asm/e820.h: * kernel was built: MAX_NUMNODES =3D=3D (1 << CONFIG_NODE=
S_SHIFT),
>   ./asm/e820.h: * unless the CONFIG_X86_PMEM_LEGACY option is set.
>   ./asm/e820.h: * if CONFIG_INTEL_TXT is enabled, memory of this type wil=
l be
>   ./mtd/ubi-user.h: * default kernel value of %CONFIG_MTD_UBI_BEB_LIMIT w=
ill be used.
>   ./linux/pkt_cls.h:    TCA_FW_INDEV, /*  used by CONFIG_NET_CLS_IND */
>   ./linux/pkt_cls.h:    TCA_FW_ACT, /* used by CONFIG_NET_CLS_ACT */
>   ./linux/cm4000_cs.h: * member sizes. This leads to CONFIG_COMPAT breaka=
ge, since 32bit userspace
>   ./linux/eventpoll.h:#ifdef CONFIG_PM_SLEEP
>   ./linux/hw_breakpoint.h:#ifdef CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
>   ./linux/bpf.h: * has been built with CONFIG_EFFICIENT_UNALIGNED_ACCESS =
not set,
>   ./linux/bpf.h: *              the **CONFIG_CGROUP_NET_CLASSID** configu=
ration option set to
>   ./linux/bpf.h: *              **CONFIG_IP_ROUTE_CLASSID** configuration=
 option.
>   ./linux/bpf.h: *              with the **CONFIG_BPF_KPROBE_OVERRIDE** c=
onfiguration
>   ./linux/bpf.h: *              the CONFIG_FUNCTION_ERROR_INJECTION optio=
n. As of this writing,
>   ./linux/bpf.h: *              **CONFIG_XFRM** configuration option.
>   ./linux/bpf.h: *              the **CONFIG_BPF_LIRC_MODE2** configurati=
on option set to
>   ./linux/bpf.h: *              the **CONFIG_BPF_LIRC_MODE2** configurati=
on option set to
>   ./linux/bpf.h: *              **CONFIG_SOCK_CGROUP_DATA** configuration=
 option.
>   ./linux/bpf.h: *              **CONFIG_NET** configuration option.
>   ./linux/bpf.h: *              **CONFIG_NET** configuration option.
>   ./linux/bpf.h: *              the **CONFIG_BPF_LIRC_MODE2** configurati=
on option set to
>   ./linux/raw.h:#define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
>   ./linux/pktcdvd.h:#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
>   ./linux/flat.h:#ifdef CONFIG_BINFMT_SHARED_FLAT
>   ./linux/videodev2.h: * Only implemented if CONFIG_VIDEO_ADV_DEBUG is de=
fined.
>   ./linux/elfcore.h:#ifdef CONFIG_BINFMT_ELF_FDPIC
>   ./linux/atmdev.h:#ifdef CONFIG_COMPAT
>   ./asm-generic/bitsperlong.h: * both 32 and 64 bit user space must not r=
ely on CONFIG_64BIT
>   ./asm-generic/unistd.h:/* mm/, CONFIG_MMU only */
>   ./asm-generic/mman-common.h:#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
>   ./asm-generic/fcntl.h:#ifndef CONFIG_64BIT
>
> What is the correct way to think about this?
>
>   * Should the UAPI make no reference to build-time configurations?
>   * Should the UAPI headers include sanity checks on behalf of the user?
>   * Should there be a `/proc/config.h.gz' facility?
>
> Sincerely,
> Michael Witten



--=20
Best Regards
Masahiro Yamada
