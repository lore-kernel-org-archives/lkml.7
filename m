Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C5BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902F4216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PO3TjmdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEIGrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 02:47:24 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:21626 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfEIGrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 02:47:24 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x496kbIt007196;
        Thu, 9 May 2019 15:46:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x496kbIt007196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557384398;
        bh=HgsrgIqjVdLF7UB2xpTSRSKdtXu7HsAgcng7Ba+OpTA=;
        h=From:To:Cc:Subject:Date:From;
        b=PO3TjmdBxpjxqRVYjOTtcotfTke1egGnqQSICQ1xOKcFhMZl7V9h4LnT6P4aACZuz
         jgDx1drcBH0hGoY2n6qd5Iu3HQ9xZ6uZoPTEWregf7vvtGfPmVdhRK6yTrvihvsM76
         6NNkt994VYhdlsEUeSgliaewR8jBa56YR1FyZQaSGOG38JWIkA/FM85u2+zaxSVFzp
         zmgvoWlBdhbv/3+fy1WQq5LuoP8fTqkqqna2lPsssk9bmYRNN0f5Va+E8JW82Zh8g1
         BS2GuX9uatxnhEds55n/Xc2med5nGKIjytqgsHlNdoO6XAvsrkMs/8YPL2bp4MceJP
         VxrtGpHOsyPEg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: add some extra warning flags unconditionally
Date:   Thu,  9 May 2019 15:46:35 +0900
Message-Id: <20190509064635.1445-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These flags are documented in the GCC 4.6 manual, and recognized by
Clang as well. Let's rip off the cc-option / cc-disable-warning switches.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.extrawarn | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 523c4cafe2dc..3ab8d1a303cd 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -23,15 +23,16 @@ warning-  := $(empty)
 warning-1 := -Wextra -Wunused -Wno-unused-parameter
 warning-1 += -Wmissing-declarations
 warning-1 += -Wmissing-format-attribute
-warning-1 += $(call cc-option, -Wmissing-prototypes)
+warning-1 += -Wmissing-prototypes
 warning-1 += -Wold-style-definition
-warning-1 += $(call cc-option, -Wmissing-include-dirs)
+warning-1 += -Wmissing-include-dirs
 warning-1 += $(call cc-option, -Wunused-but-set-variable)
 warning-1 += $(call cc-option, -Wunused-const-variable)
 warning-1 += $(call cc-option, -Wpacked-not-aligned)
 warning-1 += $(call cc-option, -Wstringop-truncation)
-warning-1 += $(call cc-disable-warning, missing-field-initializers)
-warning-1 += $(call cc-disable-warning, sign-compare)
+# The following turn off the warnings enabled by -Wextra
+warning-1 += -Wno-missing-field-initializers
+warning-1 += -Wno-sign-compare
 
 warning-2 := -Waggregate-return
 warning-2 += -Wcast-align
@@ -39,8 +40,8 @@ warning-2 += -Wdisabled-optimization
 warning-2 += -Wnested-externs
 warning-2 += -Wshadow
 warning-2 += $(call cc-option, -Wlogical-op)
-warning-2 += $(call cc-option, -Wmissing-field-initializers)
-warning-2 += $(call cc-option, -Wsign-compare)
+warning-2 += -Wmissing-field-initializers
+warning-2 += -Wsign-compare
 warning-2 += $(call cc-option, -Wmaybe-uninitialized)
 warning-2 += $(call cc-option, -Wunused-macros)
 
-- 
2.17.1

