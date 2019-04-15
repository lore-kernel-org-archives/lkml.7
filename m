Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A37C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA7A218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353917;
	bh=dKiKhBwfxln1skxiM/F2Hvx38E5pV60JRLASeoFUhLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zdvZMWz5Jc4HEmZMzmLYX5fBLjlKP6V1W1SZq13LtGGi5j9tfy1CCPp490Dc+xyRG
	 Zmt5hxtHyPFx041w7vbaXw0nDPtf3vuo1fe3G7yM8j4vzAPaCt3F9/XYEkydJfdf8M
	 HrgMhHLXLGuX4GaoU8AkpCyL5PMjn95eGuXq3jVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfDOSpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbfDOSpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 709F02073F;
        Mon, 15 Apr 2019 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353909;
        bh=dKiKhBwfxln1skxiM/F2Hvx38E5pV60JRLASeoFUhLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9DB6Jz+lGLmejh/IxrtQQBQAt+x4z4HXHMregBCfI4Xvbb3Qk53vKQ4aAD7gY956
         AFE0z2gs089OOLLDa+J2xhnEI2hep/DCyoX8V3+a3T6uR/kZGuhmNJDVBKP2M3zkNv
         6TP3j1K8Uo/a5IG0IqVWDdyYk3fZO5oQf6KjU2/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alistair Strachan <astrachan@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel-team@android.com,
        joel@joelfernandes.org, Andi Kleen <andi.kleen@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 07/76] x86: vdso: Use $LD instead of $CC to link
Date:   Mon, 15 Apr 2019 20:43:31 +0200
Message-Id: <20190415183709.105524388@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdso{32,64}.so can fail to link with CC=clang when clang tries to find
a suitable GCC toolchain to link these libraries with.

/usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
  access beyond end of merged section (782)

This happens because the host environment leaked into the cross compiler
environment due to the way clang searches for suitable GCC toolchains.

Clang is a retargetable compiler, and each invocation of it must provide
--target=<something> --gcc-toolchain=<something> to allow it to find the
correct binutils for cross compilation. These flags had been added to
KBUILD_CFLAGS, but the vdso code uses CC and not KBUILD_CFLAGS (for various
reasons) which breaks clang's ability to find the correct linker when cross
compiling.

Most of the time this goes unnoticed because the host linker is new enough
to work anyway, or is incompatible and skipped, but this cannot be reliably
assumed.

This change alters the vdso makefile to just use LD directly, which
bypasses clang and thus the searching problem. The makefile will just use
${CROSS_COMPILE}ld instead, which is always what we want. This matches the
method used to link vmlinux.

This drops references to DISABLE_LTO; this option doesn't seem to be set
anywhere, and not knowing what its possible values are, it's not clear how
to convert it from CC to LD flag.

Signed-off-by: Alistair Strachan <astrachan@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-team@android.com
Cc: joel@joelfernandes.org
Cc: Andi Kleen <andi.kleen@intel.com>
Link: https://lkml.kernel.org/r/20180803173931.117515-1-astrachan@google.com
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index d5409660f5de..2ae92c6b1de6 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -47,10 +47,8 @@ targets += $(vdso_img_sodbg)
 
 export CPPFLAGS_vdso.lds += -P -C
 
-VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
-			-Wl,--no-undefined \
-			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
-			$(DISABLE_LTO)
+VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
+			-z max-page-size=4096 -z common-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
@@ -96,10 +94,8 @@ CFLAGS_REMOVE_vvar.o = -pg
 #
 
 CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdsox32.lds = -Wl,-m,elf32_x86_64 \
-			   -Wl,-soname=linux-vdso.so.1 \
-			   -Wl,-z,max-page-size=4096 \
-			   -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
+			   -z max-page-size=4096 -z common-page-size=4096
 
 # 64-bit objects to re-brand as x32
 vobjs64-for-x32 := $(filter-out $(vobjs-nox32),$(vobjs-y))
@@ -127,7 +123,7 @@ $(obj)/vdsox32.so.dbg: $(src)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdso32.lds = -m32 -Wl,-m,elf_i386 -Wl,-soname=linux-gate.so.1
+VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
 # This makes sure the $(obj) subdirectory exists even though vdso32/
 # is not a kbuild sub-make subdirectory.
@@ -165,13 +161,13 @@ $(obj)/vdso32.so.dbg: FORCE \
 # The DSO images are built using a special linker script.
 #
 quiet_cmd_vdso = VDSO    $@
-      cmd_vdso = $(CC) -nostdlib -o $@ \
+      cmd_vdso = $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
+		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
-VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)--hash-style=both) \
-	$(call cc-ldoption, -Wl$(comma)--build-id) -Wl,-Bsymbolic $(LTO_CFLAGS)
+VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
+	$(call ld-option, --build-id) -Bsymbolic
 GCOV_PROFILE := n
 
 #
-- 
2.19.1



