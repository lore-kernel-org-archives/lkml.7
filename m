Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A5EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12E4217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EDS0NaQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfDYLmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:42:11 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58594 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbfDYLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:42:11 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3PBfl5j010199
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 20:41:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3PBfl5j010199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556192508;
        bh=PEyKvsigasIphtxPTOs11OBqRzrk+f+qGvaXFUVQNmM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EDS0NaQv5qxdGGpird/IXTdlEtKmdeKDKe7yOI06L1uyu3aCxA8x7ie4fx5khj7PZ
         I575DpT1BvFGZ76ZCXmZkFCQFAkAz2YSg+4u8KUGRQ6nsI2lic9rQwOah//IBXDIuG
         OCzaaHl8RvcAwByHs+DqVgv+gq2r/YpOYrv0ob1fuLTyPbMIAiTKg7PzfIcalby86r
         AkMGXZKBlhzjAU2Yf+XsL/L7n4b/OZ20r31iJyXiLxqKXAK782fPHCPZWOOZFEsLmZ
         MTTu58P9CPyV8aFvwQcQQhhv41xf12AnYppz6hfPQ6hLGxNd5xExXvUQJYu5+032fn
         MyyeKUa5mCdiQ==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id n16so7116518uae.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 04:41:47 -0700 (PDT)
X-Gm-Message-State: APjAAAWr06bBWdl/jsXdeQ5Mh+Ctx4NDrG0zAtsVWladknmiJ1Z1vx6U
        Igq7LexDL+xIg4pibSbUMZqzamC49dUG0NO4U2I=
X-Google-Smtp-Source: APXvYqzzXr6YqxV2J2i5qCTMKVmisezKDg4sPv7s/6K6MSd4kzvPbk/pPJD/P/VbM1o/vWUdRE4d4iqfWvo4avU+MfI=
X-Received: by 2002:ab0:7493:: with SMTP id n19mr6200372uap.121.1556192506815;
 Thu, 25 Apr 2019 04:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1403291930.git.luto@amacapital.net> <a424b189ce3ced85fe1e82d032a20e765e0fe0d3.1403291930.git.luto@amacapital.net>
In-Reply-To: <a424b189ce3ced85fe1e82d032a20e765e0fe0d3.1403291930.git.luto@amacapital.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 25 Apr 2019 20:41:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATXWYLovDGGn6cJgM61W1qF3d4RJfaiOJpH49WqTFPskQ@mail.gmail.com>
Message-ID: <CAK7LNATXWYLovDGGn6cJgM61W1qF3d4RJfaiOJpH49WqTFPskQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] x86,vdso: Create .build-id links for unstripped
 vdso files
To:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Josh Boyer <jwboyer@fedoraproject.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sat, Jun 21, 2014 at 4:23 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> With this change, doing 'make vdso_install' and telling gdb:
>
> set debug-file-directory /lib/modules/KVER/vdso
>
> will enable vdso debugging with symbols.  This is useful for
> testing, but kernel RPM builds will probably want to manually delete
> these symlinks or otherwise do something sensible when they strip
> the vdso/*.so files.
>
> If ld does not support --build-id, then the symlinks will not be
> created.
>
> Note that kernel packagers that use vdso_install may need to adjust
> their packaging scripts to accomdate this change.  For example,
> Fedora's scripts create build-id symlinks themselves in a different
> location, so the spec should probably be updated to remove the
> symlinks created by make vdso_install.
>
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> ---

I was looking into this, but
I am not familiar enough with this area.


Could you tell me how it works?


I use Ubuntu 18.04 LTS.
Luckily, it has build-id symlinks by default,
so I should be able to test it easily.



masahiro@pug:~$ uname -r
4.15.0-47-generic
masahiro@pug:~$ cd /lib/modules/4.15.0-47-generic/vdso/
masahiro@pug:/lib/modules/4.15.0-47-generic/vdso$ file vdso64.so
vdso64.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV),
dynamically linked,
BuildID[sha1]=d742540fb9ded5c3650dbe9ae20c0f39e386464c, with
debug_info, not stripped
masahiro@pug:/lib/modules/4.15.0-47-generic/vdso$ ls -l
.build-id/d7/42540fb9ded5c3650dbe9ae20c0f39e386464c.debug
lrwxrwxrwx 1 root root 15 Mar 13 13:37
.build-id/d7/42540fb9ded5c3650dbe9ae20c0f39e386464c.debug ->
../../vdso64.so


I dumped the vdso embedded in the kernel,
and I confirmed its build-id matches
to the one of unstripped vdso.


So, I expect the vdso with symbol info will be automatically loaded
by setting debug-file-directory to /lib/modules/4.15.0-47-generic/vdso.
Am I right?

If it works as expected, how should it look like?

I started gdb like this:

$ gdb date

Then, I did:

(gdb) set debug-file-directory
/usr/lib/debug:/lib/modules/4.15.0-47-generic/vdso
(gdb) show debug-file-directory
The directory where separate debug symbols are searched for is
"/usr/lib/debug:/lib/modules/4.15.0-47-generic/vdso".
(gdb) run


The list of shared library looks like follows:


(gdb) info sharedlibrary
From                To                  Syms Read   Shared Object Library
0x00007ffff7dd5f10  0x00007ffff7df4b20  Yes         /lib64/ld-linux-x86-64.so.2
0x00007ffff7a052d0  0x00007ffff7b7dc3c  Yes
/lib/x86_64-linux-gnu/libc.so.6
                                        No          linux-vdso.so.1



The first two shared objects shows "Yes" because debug info
is available under /usr/lib/debug/lib/x86_64-linux-gnu/
and associated by .gnu_debuglink.


linux-vdso.so.1 shows "No".
Does it mean no symbol was included ?


Thank you.

Masahiro Yamada




>  arch/x86/vdso/Makefile | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/vdso/Makefile b/arch/x86/vdso/Makefile
> index 2c1ca98..68a15c4 100644
> --- a/arch/x86/vdso/Makefile
> +++ b/arch/x86/vdso/Makefile
> @@ -169,14 +169,24 @@ quiet_cmd_vdso = VDSO    $@
>                  sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
>
>  VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)--hash-style=sysv) \
> -       -Wl,-Bsymbolic $(LTO_CFLAGS)
> +       $(call cc-ldoption, -Wl$(comma)--build-id) -Wl,-Bsymbolic $(LTO_CFLAGS)
>  GCOV_PROFILE := n
>
>  #
> -# Install the unstripped copies of vdso*.so.
> +# Install the unstripped copies of vdso*.so.  If our toolchain supports
> +# build-id, install .build-id links as well.
>  #
>  quiet_cmd_vdso_install = INSTALL $(@:install_%=%)
> -      cmd_vdso_install = cp $< $(MODLIB)/vdso/$(@:install_%=%)
> +define cmd_vdso_install
> +       cp $< "$(MODLIB)/vdso/$(@:install_%=%)"; \
> +       if readelf -n $< |grep -q 'Build ID'; then \
> +         buildid=`readelf -n $< |grep 'Build ID' |sed -e 's/^.*Build ID: \(.*\)$$/\1/'`; \
> +         first=`echo $$buildid | cut -b-2`; \
> +         last=`echo $$buildid | cut -b3-`; \
> +         mkdir -p "$(MODLIB)/vdso/.build-id/$$first"; \
> +         ln -sf "../../$(@:install_%=%)" "$(MODLIB)/vdso/.build-id/$$first/$$last.debug"; \
> +       fi
> +endef
>
>  vdso_img_insttargets := $(vdso_img_sodbg:%.dbg=install_%)
>
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Best Regards
Masahiro Yamada
