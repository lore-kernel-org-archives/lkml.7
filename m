Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12203C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6A220B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="q5Xy3O5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfFGKtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:49:43 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:44337 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfFGKtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:49:40 -0400
X-IronPort-AV: E=Sophos;i="5.60,562,1549926000"; 
   d="scan'208";a="7741352"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Jun 2019 12:49:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 07 Jun 2019 12:49:39 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 07 Jun 2019 12:49:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1559904579; x=1591440579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zT95b/achx15JXRT8jtCbEqeZxzU7o/BMcswA2iPOao=;
  b=q5Xy3O5MVHv287lIWXVkHKQb4YzZSGbEch60r4F9IzEHO7SXrL5E5iov
   4Hj+Yd42ZbXPCEEeuzFXXASh8cCtIoD7o7B18a9GXN2DewB8fccNewqBJ
   FZWF6wFoCII/DwrqdG24yo/y2sqN9yIy9w3zRog67jryJMLqLaM6BDSF3
   +O7m3UOV61zB8o6/AeeNVx3Je2cLl8ni46tQZYKHooybsbI3Fqr2OaLWn
   WlVOCM1pMKyskFrA9FWDpWxa2Rwd3NbHKbfnNB+KY6pvCjFgFpX3yHdWw
   I/yWEZHnLZIo/WwTJc0gZZKNi7GdRx85XP7UUPffqNobrq4TGp11LjD1k
   w==;
X-IronPort-AV: E=Sophos;i="5.60,562,1549926000"; 
   d="scan'208";a="7741351"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Jun 2019 12:49:39 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 7E995280075;
        Fri,  7 Jun 2019 12:49:46 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Russell King <linux@armlinux.org.uk>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH modules v2 2/2] ARM: module: recognize unwind exit sections
Date:   Fri,  7 Jun 2019 12:49:12 +0200
Message-Id: <20190607104912.6252-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607104912.6252-1-matthias.schiffer@ew.tq-group.com>
References: <20190607104912.6252-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the prefix ".exit", ".ARM.extab.exit" and ".ARM.exidx.exit"
must be recognized as exit sections as well. Otherwise, loading modules can
fail without CONFIG_MODULE_UNLOAD depending on the memory layout, when
relocations for the unwind sections refer to the .exit.text section:

  imx_sdma: section 16 reloc 0 sym '': relocation 42 out of range
  (0x7f015260 -> 0xc0f5a5e8)

where 0x7F000000 is the module load area and 0xC0000000 is the vmalloc
area. Relocation 42 refers to R_ARM_PREL31, which is limited to signed
31bit offsets.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
v2: Use __weak function as suggested by Jessica

 arch/arm/kernel/module.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 3ff571c2c71c..692001aabb0f 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -58,6 +58,13 @@ void *module_alloc(unsigned long size)
 }
 #endif
 
+bool module_exit_section(const char *name)
+{
+	return strstarts(name, ".exit") ||
+		strstarts(name, ".ARM.extab.exit") ||
+		strstarts(name, ".ARM.exidx.exit");
+}
+
 int
 apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 	       unsigned int relindex, struct module *module)
-- 
2.17.1

