Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BA6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29BE22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OCWv7bX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfHUJLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:11:52 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:18541 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfHUJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:11:51 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x7L9BLsk025020;
        Wed, 21 Aug 2019 18:11:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x7L9BLsk025020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566378682;
        bh=Y1VwZdO6Ru05gQk/29DwsFczvGNl4wiiOoEN8zKEUSA=;
        h=From:To:Cc:Subject:Date:From;
        b=OCWv7bX8zKjVb3P5hcq+uFD0oh1wi2o6X9ItcCPJPpgPh/MoHNGxniSEy5UDTnkn3
         2G3YS5UJVmEpZvr2x2/YbKCp+O7M+cKASteXh9YcatcXtsEdnQdzrFnxEl1x1iFvIh
         kSFmki8wWPfYPVw4n36rU+RzjTx8OVdP//DR3SPdBXvhnkiX2zjsu9xL24mTo/EZZV
         HkEsgXEB2CVROPQ8DIuuh42wO2jflyHpmUOZ8R1mbXUeJcqOs7Zo975iZjdERSOC7h
         8EV28AoOrKInvz225IqTCTL8Ol/ut5TnonFy/j3xq4Hk1HrT9DtJYYe6QPw8qQlc4U
         4AMTANgj88z8Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: add arch/arm64/Kbuild
Date:   Wed, 21 Aug 2019 18:11:17 +0900
Message-Id: <20190821091117.7310-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard obj-y form to specify the sub-directories under
arch/arm64/. No functional change intended.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/Kbuild   | 6 ++++++
 arch/arm64/Makefile | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/Kbuild

diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
new file mode 100644
index 000000000000..d6465823b281
--- /dev/null
+++ b/arch/arm64/Kbuild
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y			+= kernel/ mm/
+obj-$(CONFIG_NET)	+= net/
+obj-$(CONFIG_KVM)	+= kvm/
+obj-$(CONFIG_XEN)	+= xen/
+obj-$(CONFIG_CRYPTO)	+= crypto/
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index d4ed1869e536..fd6714a585f7 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -136,11 +136,7 @@ KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
 
 export	TEXT_OFFSET GZFLAGS
 
-core-y		+= arch/arm64/kernel/ arch/arm64/mm/
-core-$(CONFIG_NET) += arch/arm64/net/
-core-$(CONFIG_KVM) += arch/arm64/kvm/
-core-$(CONFIG_XEN) += arch/arm64/xen/
-core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
+core-y		+= arch/arm64/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-- 
2.17.1

