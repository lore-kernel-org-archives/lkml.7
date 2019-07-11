Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2222C74A45
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C53921019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YCK5T9hS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfGKFqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 01:46:30 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:59531 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfGKFpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:45:55 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x6B5ip8N031345;
        Thu, 11 Jul 2019 14:44:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x6B5ip8N031345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562823894;
        bh=73BNt3XOxU/QtVB4UusmprlWYwd5Q4e7yWpAuZSG5uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCK5T9hStu+Tg1CcwBxF7RxNzvgQxSD8fZegCbPmyxjHMkTIzehtyWz21wLmdYItT
         0xnfiBXXycLrcGRTX7bFIiWTZ+xvl5CJww5/lQDoRO0M5pu40AXZsC6ioXz4S8+3S2
         iOKwUYQpMxAan67dXUrCZYmUVz1leCcEdb4f0zoKHRCRCIumcI+5iXgfj2U69fCJhh
         IbWA8/kyQjcW277Sr1/NHY6uTEYk4UkMUEgjJvhefpU+GOULQoA8dyCyPQkBTlkScH
         TfcniABve4vtENr0+/C0Oa6F1rPk+qbmog471lBrAha2kPWQviYShv0RhS9xAtNhr2
         smX6TrK+sS1xA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Nicolas Pitre <nico@fluxnic.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] kbuild: remove duplication from modules.order in sub-directories
Date:   Thu, 11 Jul 2019 14:44:26 +0900
Message-Id: <20190711054434.1177-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711054434.1177-1-yamada.masahiro@socionext.com>
References: <20190711054434.1177-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only the top-level modules.order drops duplicated entries.

The modules.order files in sub-directories potentially contain
duplication. To list out the paths of all modules, I want to use
modules.order instead of parsing *.mod files in $(MODVERDIR).

To achieve this, I want to rip off duplication from modules.order
of external modules too.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/Makefile.build | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f21d691c776a..98dede0b2ca8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -423,13 +423,10 @@ endif # builtin-target
 #
 # Create commands to either record .ko file or cat modules.order from
 # a subdirectory
-modorder-cmds =						\
-	$(foreach m, $(modorder),			\
-		$(if $(filter %/modules.order, $m),	\
-			cat $m;, echo $m;))
-
 $(modorder-target): $(subdir-ym) FORCE
-	$(Q)(cat /dev/null; $(modorder-cmds)) > $@
+	$(Q){ $(foreach m, $(modorder), \
+	$(if $(filter %/modules.order, $m), cat $m, echo $m);) :; } \
+	| $(AWK) '!x[$$0]++' - > $@
 
 #
 # Rule to compile a set of .o files into one .a file (with symbol table)
-- 
2.17.1

