Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A713EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7714D21920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kxwvyHu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfIILEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:04:24 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:59911 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfIILEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:04:21 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x89B4CjN031800;
        Mon, 9 Sep 2019 20:04:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x89B4CjN031800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568027053;
        bh=AwcsD3ZLJ2Q2Scpzs7plI5pMSM3Ocr2iFmXNa65/pNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxwvyHu3BnCwEdbW0Qb5X1GnY64B8T9gRbB9fxOp7JraPaF2kxvsNO1Nt4CLZE1xh
         AbOnW26f+TQGQnRlIIZ71msSX3jU+FR3MDliwJFeAfwITkp/vQIPrGhsE3Vf95ptvB
         ekKCQ3Dr/k+7LTyBGOOamGD3GScz7bDi9bG2RZtfEjw0yB3tCkh6VvqdfnuBKqj6i4
         FNTUUWNfZQwEzm462OzkiKhtx9a7vPjaaQiARU2Bah0zaoznzYMbBE/wwiIt2PNeIt
         1ySkoQZNT6IUwAHRgYxWKCio30hi0wFdGcv5yql7GQVC25RoMIL8rJvOjXaayZwM/o
         +MZb92uSXb7mg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] module: move CONFIG_UNUSED_SYMBOLS to the sub-menu of MODULES
Date:   Mon,  9 Sep 2019 20:04:08 +0900
Message-Id: <20190909110408.21832-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190909110408.21832-1-yamada.masahiro@socionext.com>
References: <20190909110408.21832-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MODULES is disabled, CONFIG_UNUSED_SYMBOLS is pointless,
thus it should be invisible.

Instead of adding "depends on MODULES", I moved it to the sub-menu
"Enable loadable module support", which is a better fit. I put it
close to TRIM_UNUSED_KSYMS because it depends on !UNUSED_SYMBOLS.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 init/Kconfig      | 16 ++++++++++++++++
 lib/Kconfig.debug | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9e72cc6071f5..b3100aa3138f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2117,6 +2117,22 @@ config MODULE_COMPRESS_XZ
 
 endchoice
 
+config UNUSED_SYMBOLS
+	bool "Enable unused/obsolete exported symbols"
+	default y if X86
+	help
+	  Unused but exported symbols make the kernel needlessly bigger.  For
+	  that reason most of these unused exports will soon be removed.  This
+	  option is provided temporarily to provide a transition period in case
+	  some external kernel module needs one of these symbols anyway. If you
+	  encounter such a case in your module, consider if you are actually
+	  using the right API.  (rationale: since nobody in the kernel is using
+	  this in a module, there is a pretty good chance it's actually the
+	  wrong interface to use).  If you really need the symbol, please send a
+	  mail to the linux kernel mailing list mentioning the symbol and why
+	  you really need it, and what the merge plan to the mainline kernel for
+	  your module is.
+
 config TRIM_UNUSED_KSYMS
 	bool "Trim unused exported kernel symbols"
 	depends on !UNUSED_SYMBOLS
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..e0e14780a13d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -277,22 +277,6 @@ config READABLE_ASM
           to keep kernel developers who have to stare a lot at assembler listings
           sane.
 
-config UNUSED_SYMBOLS
-	bool "Enable unused/obsolete exported symbols"
-	default y if X86
-	help
-	  Unused but exported symbols make the kernel needlessly bigger.  For
-	  that reason most of these unused exports will soon be removed.  This
-	  option is provided temporarily to provide a transition period in case
-	  some external kernel module needs one of these symbols anyway. If you
-	  encounter such a case in your module, consider if you are actually
-	  using the right API.  (rationale: since nobody in the kernel is using
-	  this in a module, there is a pretty good chance it's actually the
-	  wrong interface to use).  If you really need the symbol, please send a
-	  mail to the linux kernel mailing list mentioning the symbol and why
-	  you really need it, and what the merge plan to the mainline kernel for
-	  your module is.
-
 config DEBUG_FS
 	bool "Debug Filesystem"
 	help
-- 
2.17.1

