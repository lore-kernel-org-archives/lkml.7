Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F790C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B392089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lczMtMDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391011AbfIILEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:04:20 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:59912 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfIILEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:04:20 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x89B4CjM031800;
        Mon, 9 Sep 2019 20:04:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x89B4CjM031800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568027053;
        bh=P3E0voZLBRNhBPs4jkIYDedlz8ZAEmB2TiQnO9CqZgo=;
        h=From:To:Cc:Subject:Date:From;
        b=lczMtMDHf1vv6d+PWh3dPjM1dhs7VxFW2MwYeA5IXKRuKXHOcUFqd43AVtr8zsSD9
         SemjxaIymis38wDJsp1VQKsKMjWAH2sJVtqXUc4yfl5hBwx2pPh4l8KrGJaUMXJPOA
         od8mfZEJZOlW4XIOeAuzL/5IA/bp850IEVkgEj2e36wz71p8P1cft7tgHBexJEOUfA
         yZ8n9BMtBRNS4yIO6hFhL37TcBOzmvIf2yp9JqgBMNCcd+ArIIoNg9WukNH19xIVfe
         rhF2grerYJIpOQ5qkH+hlh0NBRAHK+pUNJttuNHCXA629OK9A4n8DNVcy8CkxDnjsq
         4+if6chVMZD4g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] module: remove redundant 'depends on MODULES'
Date:   Mon,  9 Sep 2019 20:04:07 +0900
Message-Id: <20190909110408.21832-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are located in the 'if MODULES' ... 'endif' block.

Remove the redundant dependencies.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 init/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..9e72cc6071f5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2006,7 +2006,6 @@ config MODULE_SRCVERSION_ALL
 
 config MODULE_SIG
 	bool "Module signature verification"
-	depends on MODULES
 	select SYSTEM_DATA_VERIFICATION
 	help
 	  Check modules for valid signatures upon load: the signature
@@ -2083,7 +2082,6 @@ config MODULE_SIG_HASH
 
 config MODULE_COMPRESS
 	bool "Compress modules on installation"
-	depends on MODULES
 	help
 
 	  Compresses kernel modules when 'make modules_install' is run; gzip or
@@ -2121,7 +2119,7 @@ endchoice
 
 config TRIM_UNUSED_KSYMS
 	bool "Trim unused exported kernel symbols"
-	depends on MODULES && !UNUSED_SYMBOLS
+	depends on !UNUSED_SYMBOLS
 	help
 	  The kernel and some modules make many symbols available for
 	  other modules to use via EXPORT_SYMBOL() and variants. Depending
-- 
2.17.1

