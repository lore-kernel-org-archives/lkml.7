Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F030C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1461623B00
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="juhs5Wdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfFCLIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:08:09 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:21981 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfFCLII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:08:08 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2019 07:08:00 EDT
X-IronPort-AV: E=Sophos;i="5.60,546,1549926000"; 
   d="scan'208";a="7665934"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Jun 2019 12:58:11 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 03 Jun 2019 12:58:12 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 03 Jun 2019 12:58:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1559559491; x=1591095491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ZLG5fX7UU9AzbSEEnsbZKEWE/R7gaNCrk+0uE58Tc7U=;
  b=juhs5WdzDM2DBEOm5b2EiUWdwABpa2u190ZtJk0AJaYgwkmMFUoagyLb
   nIenGCdGGIsEIOnls41TMpRKSzzsTlbwAQAECSOPkkweWxhP0AA5jKTgz
   L1JkD36A1oCeKC8Hqo9+RliSfb/JL/voucNluCyaeieWb8dBNvEvmAn3y
   9Bwxq2+godqdd72MLGjTE0krX2KjEqQmACYi58KAX/2u1jmeABp1kl2c5
   It2a4JBE0yKvS1OLpp60s0hPo+ldTVibgtQDrY2JMRPsK32NBN/0mZesT
   PcoMs29Z+YJXxpK0H0kLV8OLc1APOwtKprYpEV1rrZW9DzIv7bnqwqrkT
   g==;
X-IronPort-AV: E=Sophos;i="5.60,546,1549926000"; 
   d="scan'208";a="7665933"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Jun 2019 12:58:11 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id A18CA280077;
        Mon,  3 Jun 2019 12:58:15 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Russell King <linux@armlinux.org.uk>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH modules 2/2] ARM: module: recognize unwind exit sections
Date:   Mon,  3 Jun 2019 12:57:26 +0200
Message-Id: <20190603105726.22436-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
References: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the prefix ".exit", ".ARM.extab.exit" and ".ARM.exidx.exit"
must be recognizes as exit sections as well. Otherwise, loading modules can
fail without CONFIG_MODULE_UNLOAD depending on the memory layout, when
relocations for the unwind sections refer to the .exit.text section:

  imx_sdma: section 16 reloc 0 sym '': relocation 42 out of range
  (0x7f015260 -> 0xc0f5a5e8)

where 0x7F000000 is the module load area and 0xC0000000 is the vmalloc
area. Relocation 42 refers to R_ARM_PREL31, which is limited to signed
31bit offsets.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/include/asm/module.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 182163b55546..f3401758d711 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -4,6 +4,8 @@
 
 #include <asm-generic/module.h>
 
+#include <linux/string.h>
+
 struct unwind_table;
 
 #ifdef CONFIG_ARM_UNWIND
@@ -72,4 +74,13 @@ static inline unsigned long kallsyms_symbol_value(const Elf_Sym *sym)
 }
 #endif
 
+#define HAVE_ARCH_MODULE_EXIT_SECTION
+static inline bool module_exit_section(const char *name)
+{
+	return strstarts(name, ".exit") ||
+		strstarts(name, ".ARM.extab.exit") ||
+		strstarts(name, ".ARM.exidx.exit");
+
+}
+
 #endif /* _ASM_ARM_MODULE_H */
-- 
2.17.1

