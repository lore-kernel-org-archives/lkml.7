Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F49EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5E8206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q3Zptqq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfDCIhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:37:41 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:49898 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfDCIhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:37:40 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x338bLIC027479;
        Wed, 3 Apr 2019 17:37:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x338bLIC027479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554280642;
        bh=NXrOmhTOgezL4ubc/Y0MTBBLZoVfYe2kvigugO9+MJc=;
        h=From:To:Cc:Subject:Date:From;
        b=q3Zptqq6VUXcs7m7nyLAYRqWHTXrIkrQiPyPEMQVgsMqZPZ55GO34FopFgNmguoh4
         bxm46Uhqb1kp06t/DOh4u9BOB6tyBt1+jKVTuF2W6/xPK1wMnzFLonVHqVVdtpQqNk
         tTPObt20l0MQp3SCbCEuPfUqu+b/Q4AAQjm0F37JXldViTCfnsuCSrMPLF8EPAMzGH
         k8MRQ8AYTBjSeyy0rDOo440t197s+g36fdv34Q/XrF4m9rRQW7QbNui1m+dpdCfi/h
         JQHO7N8cfJU3PC9/vnIfwx6sKoDLQN6puUbexbC+dvVy5OAYah5mZ9+fp3cuPSLGg+
         sVkPgXP4vZdag==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nds32: vdso: fix and clean-up Makefile
Date:   Wed,  3 Apr 2019 17:37:13 +0900
Message-Id: <1554280633-11457-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- $(call if_changed,...) must have FORCE as a prerequisite

- vdso.lds is a generated file, so it should be prefixed with
  $(obj)/ instead of $(src)/.

- cmd_vdsosym is a one-liner rule, so the assignment with '='
  is simpler.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/nds32/kernel/vdso/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso/Makefile
index e6c50a7..01a9610 100644
--- a/arch/nds32/kernel/vdso/Makefile
+++ b/arch/nds32/kernel/vdso/Makefile
@@ -28,7 +28,7 @@ CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 $(obj)/vdso.o : $(obj)/vdso.so
 
 # Link rule for the .so file, .lds has to be first
-$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso)
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
 
 
@@ -40,9 +40,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 # Generate VDSO offsets using helper script
 gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
-define cmd_vdsosym
-	$(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
-endef
+      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
 include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
@@ -65,7 +63,7 @@ gettimeofday.o : gettimeofday.c FORCE
 
 # Actual build commands
 quiet_cmd_vdsold = VDSOL   $@
-      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
+      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $(real-prereqs) -o $@
 quiet_cmd_vdsoas = VDSOA   $@
       cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
 quiet_cmd_vdsocc = VDSOA   $@
-- 
2.7.4

