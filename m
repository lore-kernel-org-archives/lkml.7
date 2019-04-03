Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A248C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A97421473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="j8x0x39I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfDCIs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:48:57 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:28829 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfDCIs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:48:57 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x338mVFi008617;
        Wed, 3 Apr 2019 17:48:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x338mVFi008617
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554281312;
        bh=lB6EpHoutTwpWA7wUE6ivp4ZeV0huU5L0NNkqfszzLo=;
        h=From:To:Cc:Subject:Date:From;
        b=j8x0x39Ihsj879zA8Ysekq2G3b/CjwYKIVmpGbsSc1sghEDq1tPFxf/kXq+4MWtvQ
         hp8/y8lD5n2nYFX1Xzd+zkwKlNieUJVEwvRcpTXTrV65/kzZYOe5EmPGn3L+Rw6Iqj
         ICXTnXNAKrKUuGV6CHj3x4Ngq1Bt7gEnDBwKOcviqGDASgYonwpTlZ7sug2q7yau4p
         l8EDGVXRY6d/cAefWBJ5K9DCxIWjrKM7ayyvypCy8GgyFeMVZZ086hqk7KnRb0bVf4
         DYN5V4Ezpl5BUV22ZETsa9T+2zwkaf33m1wIZZWw2QxSfQl4aIO/+WiYejlQnuOXw+
         Oa6+LrvXzVDrA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: vdso: fix and clean-up Makefile
Date:   Wed,  3 Apr 2019 17:48:22 +0900
Message-Id: <1554281302-21105-1-git-send-email-yamada.masahiro@socionext.com>
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

 arch/arm64/kernel/vdso/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index b801ee5..c9ad9aa 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -31,7 +31,7 @@ CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 $(obj)/vdso.o : $(obj)/vdso.so
 
 # Link rule for the .so file, .lds has to be first
-$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso)
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
 
 # Strip rule for the .so file
@@ -42,9 +42,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 # Generate VDSO offsets using helper script
 gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
-define cmd_vdsosym
-	$(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
-endef
+      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
 include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
@@ -55,7 +53,7 @@ $(obj-vdso): %.o: %.S FORCE
 
 # Actual build commands
 quiet_cmd_vdsold = VDSOL   $@
-      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
+      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $(real-prereqs) -o $@
 quiet_cmd_vdsoas = VDSOA   $@
       cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
 
-- 
2.7.4

