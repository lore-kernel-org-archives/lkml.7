Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C26C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78972084F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413379;
	bh=IJ+0jeSZb9ortcdzj9j4dxSaRyrGAGfxWZNhRfCNZIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vNwQhzLlmxjAzyjYPIn3OOpNz3XNO0f54MhI2DpGojB32KJ+BXN6yRuL1XOlheGLP
	 9PV8VgLgFOKr8dgGMfYH+tkJAgjId7d8jIM8mj2ZpL4XiV7CUZPOXWwx/wduTZmW9m
	 8W+hQd2Z3ECJHM4P/3n7jJ2rdZTtQLYeeGmiKOuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfLCWti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:49:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbfLCWth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:49:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F5EC20803;
        Tue,  3 Dec 2019 22:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413376;
        bh=IJ+0jeSZb9ortcdzj9j4dxSaRyrGAGfxWZNhRfCNZIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dh2nCtq3NxkcF2T+P8bBJ3pskQphlxfTiHfPSa2H06pvBIUjw0Fb3da2Bpadzcd4g
         rtQhDfqGIuHFrJsKYT1xFRWEbdPqt1XAsFhz5b2MX/VrYYgKdVtu1aBPxQFtkCndyS
         b6iPwwvInXhrKpSKIob8ZyiU8bU+SEeUp1Iz4Xww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 104/321] microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
Date:   Tue,  3 Dec 2019 23:32:50 +0100
Message-Id: <20191203223432.564066598@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 4722a3e6b716d9d4594c3cf3856b03bbd24a59a8 ]

This commit fixes some build issues.

The first issue is the breakage of linux.bin.ub target since commit
ece97f3a5fb5 ("microblaze: Fix simpleImage format generation")
because the addition of UIMAGE_{IN,OUT} affected it.

make ARCH=microblaze CROSS_COMPILE=microblaze-linux- linux.bin.ub
  [ snip ]
  OBJCOPY arch/microblaze/boot/linux.bin
  UIMAGE  arch/microblaze/boot/linux.bin.ub.ub
/usr/bin/mkimage: Can't open arch/microblaze/boot/linux.bin.ub: No such file or directory
make[1]: *** [arch/microblaze/boot/Makefile;14: arch/microblaze/boot/linux.bin.ub] Error 1
make: *** [arch/microblaze/Makefile;83: linux.bin.ub] Error 2

The second issue is the use of the "if_changed" multiple times for
the same target.

As commit 92a4728608a8 ("x86/boot: Fix if_changed build flip/flop bug")
pointed out, this never works properly. Moreover, generating multiple
images as a side-effect is confusing.

Let's split the build recipe for each image.

simpleImage.<dt>*.unstrip is just a copy of vmlinux.

simpleImage.<dt> and simpleImage.<dt>.ub are created in the same way
as linux.bin and linux.bin.ub, respectively.

I kept simpleImage.* recipes independent of linux.bin.* ones to not
change the behavior.

Lastly, this commit fixes "make ARCH=microblaze clean". Previously,
it only cleaned up the unstrip image. Now, all the simpleImage files
are cleaned.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/microblaze/Makefile      |  2 +-
 arch/microblaze/boot/Makefile | 19 +++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index b9808ddaf985f..548bac6c60f8c 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -86,7 +86,7 @@ linux.bin linux.bin.gz linux.bin.ub: vmlinux
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
 simpleImage.%: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot) $(addprefix $(boot)/$@., ub unstrip strip)
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
 define archhelp
diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index 96eefdca0d9b3..cff570a719461 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -3,7 +3,7 @@
 # arch/microblaze/boot/Makefile
 #
 
-targets := linux.bin linux.bin.gz linux.bin.ub simpleImage.%
+targets := linux.bin linux.bin.gz linux.bin.ub simpleImage.*
 
 OBJCOPYFLAGS := -R .note -R .comment -R .note.gnu.build-id -O binary
 
@@ -16,21 +16,20 @@ $(obj)/linux.bin.ub: $(obj)/linux.bin FORCE
 $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
 	$(call if_changed,gzip)
 
-quiet_cmd_cp = CP      $< $@$2
-	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
-
 quiet_cmd_strip = STRIP   $< $@$2
 	cmd_strip = $(STRIP) -K microblaze_start -K _end -K __log_buf \
 				-K _fdt_start $< -o $@$2
 
 UIMAGE_LOADADDR = $(CONFIG_KERNEL_BASE_ADDR)
-UIMAGE_IN = $@
-UIMAGE_OUT = $@.ub
 
-$(obj)/simpleImage.%: vmlinux FORCE
-	$(call if_changed,cp,.unstrip)
+$(obj)/simpleImage.$(DTB): vmlinux FORCE
 	$(call if_changed,objcopy)
+
+$(obj)/simpleImage.$(DTB).ub: $(obj)/simpleImage.$(DTB) FORCE
 	$(call if_changed,uimage)
-	$(call if_changed,strip,.strip)
 
-clean-files += simpleImage.*.unstrip linux.bin.ub
+$(obj)/simpleImage.$(DTB).unstrip: vmlinux FORCE
+	$(call if_changed,shipped)
+
+$(obj)/simpleImage.$(DTB).strip: vmlinux FORCE
+	$(call if_changed,strip)
-- 
2.20.1



