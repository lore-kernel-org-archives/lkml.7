Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DC5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8098A2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgIkqrGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfDZNe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:34:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33988 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:34:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id a6so3220648edv.1;
        Fri, 26 Apr 2019 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s7yGW1oAEvzaVAVPp1TsODJGu+RHIdNQkwk9BtfrXds=;
        b=PgIkqrGxoXs5m72i3li6FZ7Zwhy1T+v/Pspt1dDCGU1XtDC+T8ZqsHxC9Agt0pQSUd
         GuZ80Xq7olvYDkBPSPLYDmHtE0OYIFhow0LT9+U0Ty4fMW9/yZIVQgvh20D2ToyOZGb3
         tjM68FWVWrorbZAe1BfSlnUI8gGlOeJCi20JZTJhf2sjcSTsTIFSyVl66d+6Fz4gxFKy
         dxy6VKaOEzFkeBeetEfZbAJLhmM2to9XIwCxm7Wi67O0OFu2aL3vUptw9kRLEjg5iZ6K
         RtGubmqXNx7ij9ikYDz7fmMYWt4usXLbG4l4lyYmalznoCBZoosJ1DW2Tive+dM95CD4
         nf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s7yGW1oAEvzaVAVPp1TsODJGu+RHIdNQkwk9BtfrXds=;
        b=rTwVreV0Ya4qNk6d4xjQwiJ+KOp+2sHRzQT2mpAkzjorSj8q5eJK4CZRzqev/hqnU+
         FGwO8lMN6ALIMhzOk/zjc0R4i891OIkPAcGloQaOI8wuYwv6BUb9HKYs26CKb3cBYdHZ
         Cj9uilg4FRBQHWdyJ+94H9FJiAh0xsweuHLXLWWegyN5e7+b+IqYUlMiSBOiNrCKU0YZ
         ZGzB8qNJl/5NE/DfS9wpjMfjRoPNN4Z0A3X0N1HzXWID2zNlSdLQvy/5zD1V5MZU/CYz
         qjwa8ecqg3CqA3GN+GMdSpI9M43QIXN58Nkwa8Js3UBR8iRakOEx3VKb9q2gcinkcKvt
         2cQw==
X-Gm-Message-State: APjAAAU8Ofg2mnwKlHBRdsDWFI3vcyg3YSZu3JD+dzyxD8u1uok30Y79
        ae8n8yX2AO2wWbK8bYE0cmE=
X-Google-Smtp-Source: APXvYqwahS6TVVcfaOpbhZjnuPvri+L9hJyt1O3Kqdv//gfAED69MZhfZIwpx959xPq4So3sbqQAsg==
X-Received: by 2002:a17:906:2583:: with SMTP id m3mr15163448ejb.74.1556285665671;
        Fri, 26 Apr 2019 06:34:25 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id d56sm1152615edb.70.2019.04.26.06.34.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 06:34:24 -0700 (PDT)
Date:   Fri, 26 Apr 2019 06:34:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "andi.kleen@intel.com" <andi.kleen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "astrachan@google.com" <astrachan@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 4.14 09/69] x86: vdso: Use $LD instead of $CC to link
Message-ID: <20190426133422.GA8796@archlinux-i9>
References: <20190415183726.036654568@linuxfoundation.org>
 <20190415183728.632579553@linuxfoundation.org>
 <c9fc2241bb6687e6bfab50e329d81601ff6bc6bf.camel@nokia.com>
 <20190426124804.GA23970@archlinux-i9>
 <0dbe840a89d279be2b66d6c612d25eba4cc4c2e2.camel@nokia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <0dbe840a89d279be2b66d6c612d25eba4cc4c2e2.camel@nokia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2019 at 01:23:17PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> On Fri, 2019-04-26 at 05:48 -0700, Nathan Chancellor wrote:
> > On Fri, Apr 26, 2019 at 11:41:30AM +0000, Rantala, Tommi T. (Nokia -
> > FI/Espoo) wrote:
> > > On Mon, 2019-04-15 at 20:58 +0200, Greg Kroah-Hartman wrote:
> > > > commit 379d98ddf41344273d9718556f761420f4dc80b3 upstream.
> > > > 
> > > 
> > > Hi,
> > > 
> > > With this patch in 4.14.112 build-id is now missing in vdso32.so:
> > > 
> > > $ file arch/x86/entry/vdso/vdso*so*
> > > arch/x86/entry/vdso/vdso32.so:     ELF 32-bit LSB pie executable,
> > > Intel
> > > 80386, version 1 (SYSV), dynamically linked, stripped
> > > arch/x86/entry/vdso/vdso32.so.dbg: ELF 32-bit LSB pie executable,
> > > Intel
> > > 80386, version 1 (SYSV), dynamically linked, with debug_info, not
> > > stripped
> > > arch/x86/entry/vdso/vdso64.so:     ELF 64-bit LSB pie executable,
> > > x86-
> > > 64, version 1 (SYSV), dynamically linked,
> > > BuildID[sha1]=d80730a5b561a3161e488a369d1c76c250b584b4, stripped
> > > arch/x86/entry/vdso/vdso64.so.dbg: ELF 64-bit LSB pie executable,
> > > x86-
> > > 64, version 1 (SYSV), dynamically linked,
> > > BuildID[sha1]=d80730a5b561a3161e488a369d1c76c250b584b4, with
> > > debug_info, not stripped
> > > 
> > > 
> > > Based on quick check, "$(call ld-option, --build-id)" fails due to
> > > some
> > > 32/64 bit mismatch, so the --build-id linker flag is not used when
> > > linking vdso32.so
> > > 
> > > Perhaps scripts/Kbuild.include is missing some change in 4.14.y to
> > > make
> > > this work properly.
> > > 
> > 
> > Hi Tommi,
> > 
> > This appears to be fixed by commit 0294e6f4a000 ("kbuild: simplify
> > ld-option implementation") upstream. Could you test the attached
> > backport and make sure everything works on your end? Assuming that it
> > does, I will test the other stable releases and see if this is needed
> > and send those backports along.
> 
> Yes this patch fixes it. Many thanks!

Thanks for verifying!

Greg, attached are backports for that commit for 4.4, 4.9, and 4.14. It
appeared in 4.16 so it is not needed with a newer version.

Thanks,
Nathan

> 
> -Tommi
> 
> > Thanks and sorry for the trouble!
> > Nathan
> > 
> > > -Tommi
> > > 
> > > > The vdso{32,64}.so can fail to link with CC=clang when clang
> > > > tries to
> > > > find
> > > > a suitable GCC toolchain to link these libraries with.
> > > > 
> > > > /usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
> > > >   access beyond end of merged section (782)
> > > > 
> > > > This happens because the host environment leaked into the cross
> > > > compiler
> > > > environment due to the way clang searches for suitable GCC
> > > > toolchains.
> > > > 
> > > > Clang is a retargetable compiler, and each invocation of it must
> > > > provide
> > > > --target=<something> --gcc-toolchain=<something> to allow it to
> > > > find
> > > > the
> > > > correct binutils for cross compilation. These flags had been
> > > > added to
> > > > KBUILD_CFLAGS, but the vdso code uses CC and not KBUILD_CFLAGS
> > > > (for
> > > > various
> > > > reasons) which breaks clang's ability to find the correct linker
> > > > when
> > > > cross
> > > > compiling.
> > > > 
> > > > Most of the time this goes unnoticed because the host linker is
> > > > new
> > > > enough
> > > > to work anyway, or is incompatible and skipped, but this cannot
> > > > be
> > > > reliably
> > > > assumed.
> > > > 
> > > > This change alters the vdso makefile to just use LD directly,
> > > > which
> > > > bypasses clang and thus the searching problem. The makefile will
> > > > just
> > > > use
> > > > ${CROSS_COMPILE}ld instead, which is always what we want. This
> > > > matches the
> > > > method used to link vmlinux.
> > > > 
> > > > This drops references to DISABLE_LTO; this option doesn't seem to
> > > > be
> > > > set
> > > > anywhere, and not knowing what its possible values are, it's not
> > > > clear how
> > > > to convert it from CC to LD flag.
> > > > 
> > > > Signed-off-by: Alistair Strachan <astrachan@google.com>
> > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > > Acked-by: Andy Lutomirski <luto@kernel.org>
> > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: kernel-team@android.com
> > > > Cc: joel@joelfernandes.org
> > > > Cc: Andi Kleen <andi.kleen@intel.com>
> > > > Link: 
> > > > https://lkml.kernel.org/r/20180803173931.117515-1-astrachan@google.com
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  arch/x86/entry/vdso/Makefile | 22 +++++++++-------------
> > > >  1 file changed, 9 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/entry/vdso/Makefile
> > > > b/arch/x86/entry/vdso/Makefile
> > > > index 0a550dc5c525..0defcc939ab4 100644
> > > > --- a/arch/x86/entry/vdso/Makefile
> > > > +++ b/arch/x86/entry/vdso/Makefile
> > > > @@ -48,10 +48,8 @@ targets += $(vdso_img_sodbg)
> > > >  
> > > >  export CPPFLAGS_vdso.lds += -P -C
> > > >  
> > > > -VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
> > > > -			-Wl,--no-undefined \
> > > > -			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-
> > > > size=4096 \
> > > > -			$(DISABLE_LTO)
> > > > +VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --
> > > > no-
> > > > undefined \
> > > > +			-z max-page-size=4096 -z common-page-size=4096
> > > >  
> > > >  $(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
> > > >  	$(call if_changed,vdso)
> > > > @@ -103,10 +101,8 @@ CFLAGS_REMOVE_vvar.o = -pg
> > > >  #
> > > >  
> > > >  CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
> > > > -VDSO_LDFLAGS_vdsox32.lds = -Wl,-m,elf32_x86_64 \
> > > > -			   -Wl,-soname=linux-vdso.so.1 \
> > > > -			   -Wl,-z,max-page-size=4096 \
> > > > -			   -Wl,-z,common-page-size=4096
> > > > +VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-
> > > > vdso.so.1 \
> > > > +			   -z max-page-size=4096 -z common-page-
> > > > size=4096
> > > >  
> > > >  # 64-bit objects to re-brand as x32
> > > >  vobjs64-for-x32 := $(filter-out $(vobjs-nox32),$(vobjs-y))
> > > > @@ -134,7 +130,7 @@ $(obj)/vdsox32.so.dbg: $(src)/vdsox32.lds
> > > > $(vobjx32s) FORCE
> > > >  	$(call if_changed,vdso)
> > > >  
> > > >  CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> > > > -VDSO_LDFLAGS_vdso32.lds = -m32 -Wl,-m,elf_i386 -Wl,-
> > > > soname=linux-
> > > > gate.so.1
> > > > +VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
> > > >  
> > > >  # This makes sure the $(obj) subdirectory exists even though
> > > > vdso32/
> > > >  # is not a kbuild sub-make subdirectory.
> > > > @@ -180,13 +176,13 @@ $(obj)/vdso32.so.dbg: FORCE \
> > > >  # The DSO images are built using a special linker script.
> > > >  #
> > > >  quiet_cmd_vdso = VDSO    $@
> > > > -      cmd_vdso = $(CC) -nostdlib -o $@ \
> > > > +      cmd_vdso = $(LD) -nostdlib -o $@ \
> > > >  		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter
> > > > %.lds,$(^F))) \
> > > > -		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
> > > > +		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
> > > >  		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
> > > >  
> > > > -VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)
> > > > --hash-
> > > > style=both) \
> > > > -	$(call cc-ldoption, -Wl$(comma)--build-id) -Wl,-Bsymbolic
> > > > $(LTO_CFLAGS)
> > > > +VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
> > > > +	$(call ld-option, --build-id) -Bsymbolic
> > > >  GCOV_PROFILE := n
> > > >  
> > > >  #
> 

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.4-0294e6f4a000.patch"

From 42f440aaf2cc0d0a0061b4e0bb716f93a5f030b8 Mon Sep 17 00:00:00 2001
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Feb 2018 13:56:53 +0900
Subject: [PATCH 4.4] kbuild: simplify ld-option implementation

commit 0294e6f4a0006856e1f36b8cd8fa088d9e499e98 upstream.

Currently, linker options are tested by the coordination of $(CC) and
$(LD) because $(LD) needs some object to link.

As commit 86a9df597cdd ("kbuild: fix linker feature test macros when
cross compiling with Clang") addressed, we need to make sure $(CC)
and $(LD) agree the underlying architecture of the passed object.

This could be a bit complex when we combine tools from different groups.
For example, we can use clang for $(CC), but we still need to rely on
GCC toolchain for $(LD).

So, I was searching for a way of standalone testing of linker options.
A trick I found is to use '-v'; this not only prints the version string,
but also tests if the given option is recognized.

If a given option is supported,

  $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
  GNU ld (Linaro_Binutils-2017.11) 2.28.2.20170706
  $ echo $?
  0

If unsupported,

  $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
  GNU ld (crosstool-NG linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC 2013.04) 2.23.1
  aarch64-linux-gnu-ld: unrecognized option '--fix-cortex-a53-843419'
  aarch64-linux-gnu-ld: use the --help option for usage information
  $ echo $?
  1

Gold works likewise.

  $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-843419
  GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
  masahiro@pug:~/ref/linux$ echo $?
  0
  $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-999999
  GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
  aarch64-linux-gnu-ld.gold: --fix-cortex-a53-999999: unknown option
  aarch64-linux-gnu-ld.gold: use the --help option for usage information
  $ echo $?
  1

LLD too.

  $ ld.lld -v --gc-sections
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  0
  $ ld.lld -v --fix-cortex-a53-843419
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  0
  $ ld.lld -v --fix-cortex-a53-999999
  ld.lld: error: unknown argument: --fix-cortex-a53-999999
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  1

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
[nc: try-run-cached was added later, just use try-run, which is the
     current mainline state]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 scripts/Kbuild.include | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 5e9cf7d146f0..e61a5c29b08c 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -156,9 +156,7 @@ cc-ldoption = $(call try-run,\
 
 # ld-option
 # Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run,\
-	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -x c /dev/null -c -o "$$TMPO"; \
-	$(LD) $(LDFLAGS) $(1) "$$TMPO" -o "$$TMP",$(1),$(2))
+ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
-- 
2.21.0


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.9-0294e6f4a000.patch"

From e9376686d5827beee5a36c47753bf438952a6621 Mon Sep 17 00:00:00 2001
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Feb 2018 13:56:53 +0900
Subject: [PATCH 4.9] kbuild: simplify ld-option implementation

commit 0294e6f4a0006856e1f36b8cd8fa088d9e499e98 upstream.

Currently, linker options are tested by the coordination of $(CC) and
$(LD) because $(LD) needs some object to link.

As commit 86a9df597cdd ("kbuild: fix linker feature test macros when
cross compiling with Clang") addressed, we need to make sure $(CC)
and $(LD) agree the underlying architecture of the passed object.

This could be a bit complex when we combine tools from different groups.
For example, we can use clang for $(CC), but we still need to rely on
GCC toolchain for $(LD).

So, I was searching for a way of standalone testing of linker options.
A trick I found is to use '-v'; this not only prints the version string,
but also tests if the given option is recognized.

If a given option is supported,

  $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
  GNU ld (Linaro_Binutils-2017.11) 2.28.2.20170706
  $ echo $?
  0

If unsupported,

  $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
  GNU ld (crosstool-NG linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC 2013.04) 2.23.1
  aarch64-linux-gnu-ld: unrecognized option '--fix-cortex-a53-843419'
  aarch64-linux-gnu-ld: use the --help option for usage information
  $ echo $?
  1

Gold works likewise.

  $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-843419
  GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
  masahiro@pug:~/ref/linux$ echo $?
  0
  $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-999999
  GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
  aarch64-linux-gnu-ld.gold: --fix-cortex-a53-999999: unknown option
  aarch64-linux-gnu-ld.gold: use the --help option for usage information
  $ echo $?
  1

LLD too.

  $ ld.lld -v --gc-sections
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  0
  $ ld.lld -v --fix-cortex-a53-843419
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  0
  $ ld.lld -v --fix-cortex-a53-999999
  ld.lld: error: unknown argument: --fix-cortex-a53-999999
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  1

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
[nc: try-run-cached was added later, just use try-run, which is the
     current mainline state]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 scripts/Kbuild.include | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 7f430778f418..558dea61db11 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -166,9 +166,7 @@ cc-ldoption = $(call try-run,\
 
 # ld-option
 # Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run,\
-	$(CC) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -x c /dev/null -c -o "$$TMPO"; \
-	$(LD) $(LDFLAGS) $(1) "$$TMPO" -o "$$TMP",$(1),$(2))
+ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
-- 
2.21.0


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.14-0294e6f4a000.patch"

From 503a1f5b1bee2cea4c387178a830bd6ffb1d4cdf Mon Sep 17 00:00:00 2001
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Feb 2018 13:56:53 +0900
Subject: [PATCH 4.14] kbuild: simplify ld-option implementation

commit 0294e6f4a0006856e1f36b8cd8fa088d9e499e98 upstream.

Currently, linker options are tested by the coordination of $(CC) and
$(LD) because $(LD) needs some object to link.

As commit 86a9df597cdd ("kbuild: fix linker feature test macros when
cross compiling with Clang") addressed, we need to make sure $(CC)
and $(LD) agree the underlying architecture of the passed object.

This could be a bit complex when we combine tools from different groups.
For example, we can use clang for $(CC), but we still need to rely on
GCC toolchain for $(LD).

So, I was searching for a way of standalone testing of linker options.
A trick I found is to use '-v'; this not only prints the version string,
but also tests if the given option is recognized.

If a given option is supported,

  $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
  GNU ld (Linaro_Binutils-2017.11) 2.28.2.20170706
  $ echo $?
  0

If unsupported,

  $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
  GNU ld (crosstool-NG linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC 2013.04) 2.23.1
  aarch64-linux-gnu-ld: unrecognized option '--fix-cortex-a53-843419'
  aarch64-linux-gnu-ld: use the --help option for usage information
  $ echo $?
  1

Gold works likewise.

  $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-843419
  GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
  masahiro@pug:~/ref/linux$ echo $?
  0
  $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-999999
  GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
  aarch64-linux-gnu-ld.gold: --fix-cortex-a53-999999: unknown option
  aarch64-linux-gnu-ld.gold: use the --help option for usage information
  $ echo $?
  1

LLD too.

  $ ld.lld -v --gc-sections
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  0
  $ ld.lld -v --fix-cortex-a53-843419
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  0
  $ ld.lld -v --fix-cortex-a53-999999
  ld.lld: error: unknown argument: --fix-cortex-a53-999999
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  1

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
[nc: try-run-cached was added later, just use try-run, which is the
     current mainline state]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 scripts/Kbuild.include | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index a0ad87e869f9..a33fa1a91873 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -165,9 +165,7 @@ cc-ldoption = $(call try-run,\
 
 # ld-option
 # Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run,\
-	$(CC) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -x c /dev/null -c -o "$$TMPO"; \
-	$(LD) $(LDFLAGS) $(1) "$$TMPO" -o "$$TMP",$(1),$(2))
+ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
-- 
2.21.0


--YZ5djTAD1cGYuMQK--
