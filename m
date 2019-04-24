Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E34C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD09A21908
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126333;
	bh=YQOdLFHXVpWPlJJ98yXTD12UNE/hUOMPXd0bX1kjtEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JEYDFFQmt1dasdJ9W0v7uOJREc4ZXe+Un7tMAi/4qPt3e46oadZ7v2Tm/tD4HWQbS
	 AQdHFs8Q6Y3672sqUQjFjqJ+gJ8GqXjVygpcsc6Xw3a0MOCECO7CcvnjrZyrAmxC1v
	 RZW/nkzTSHucEvNNTUMX2K46mXrpGoAlRkjf+pIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbfDXRSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388208AbfDXRSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:18:44 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6E621908;
        Wed, 24 Apr 2019 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126323;
        bh=YQOdLFHXVpWPlJJ98yXTD12UNE/hUOMPXd0bX1kjtEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8FmDZHmqzxK4KuKckNu4VzFLwq80cO/4wml8Ss+BrZ2MVkQOZ1arZk5nF/qX/YBc
         ILXPkGgGbuNtm24xAGRLV6yZRkXtfE005WC7HJmUGqgLLXISUi52y1pIobZvunQyW7
         WdhrzZRH9MvooxrIpQ+gWulGOj7owFfFMsfYTbhI=
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
Subject: [PATCH 4.4 072/168] x86: vdso: Use $LD instead of $CC to link
Date:   Wed, 24 Apr 2019 19:08:36 +0200
Message-Id: <20190424170927.981145923@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 379d98ddf41344273d9718556f761420f4dc80b3 upstream.

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
index 265c0ed68118..84c4a7105c2a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -41,10 +41,8 @@ targets += $(vdso_img_sodbg)
 
 export CPPFLAGS_vdso.lds += -P -C
 
-VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
-			-Wl,--no-undefined \
-			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
-			$(DISABLE_LTO)
+VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
+			-z max-page-size=4096 -z common-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
@@ -90,10 +88,8 @@ CFLAGS_REMOVE_vvar.o = -pg
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
@@ -121,7 +117,7 @@ $(obj)/vdsox32.so.dbg: $(src)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdso32.lds = -m32 -Wl,-m,elf_i386 -Wl,-soname=linux-gate.so.1
+VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
 # This makes sure the $(obj) subdirectory exists even though vdso32/
 # is not a kbuild sub-make subdirectory.
@@ -157,13 +153,13 @@ $(obj)/vdso32.so.dbg: FORCE \
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



