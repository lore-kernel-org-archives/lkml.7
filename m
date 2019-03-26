Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B1AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36FD20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aCXgLcWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfCZGLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:11:23 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:59704 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZGLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:11:22 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x2Q6BFkG012588;
        Tue, 26 Mar 2019 15:11:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x2Q6BFkG012588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553580676;
        bh=Zw7uwaX5YIAaXoE1R4izq01ZBngP76ndRTfwlXDflu0=;
        h=From:To:Cc:Subject:Date:From;
        b=aCXgLcWS0eaQoRN9GuPWnpgPacWdryoda1pZ4ON6o5aF95wDqLtG7bfH9HVgyDz1f
         Xzz5r9efNaSstgOb8PF615eMpEL/eObD/WU/Su31cJgPt52AOOxwq5Ht+0DEJcZYf+
         yxyQyabLPmUnUUslP9w+Y1hcYvachW/ypFYRd+Ba0oxeWa1GQkI8m5/I1/PuNtP1G1
         9676BURA0CHhMSVKBN9PWiqQVrjggb/fjEud8SPhbLAGylFamyDb5xa/Qqw2Z5cq6Q
         4l592NDNNOlyb7DnCqT0ZztIqBh439znu+sb0pfqlfiQxMpKWQl0pfkhGlRMjH0QD1
         69UYvLmQzoaPA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: move RETPOLINE flags below config-targets
Date:   Tue, 26 Mar 2019 15:11:12 +0900
Message-Id: <1553580672-29551-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you run a "make *config" target, the retpoline compiler flags
are evaluated for nothing because the code is located above the
'ifeq ($(config-targets),1)'.

Move it a bit below to avoid unneeded computation in the Kconfig stage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 1b361bd..66a8e04 100644
--- a/Makefile
+++ b/Makefile
@@ -519,15 +519,6 @@ KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
 endif
 
-RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
-RETPOLINE_VDSO_CFLAGS_GCC := -mindirect-branch=thunk-inline -mindirect-branch-register
-RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
-RETPOLINE_VDSO_CFLAGS_CLANG := -mretpoline
-RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
-RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
-export RETPOLINE_CFLAGS
-export RETPOLINE_VDSO_CFLAGS
-
 # The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
 # Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
 # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
@@ -624,6 +615,15 @@ ifdef CONFIG_FUNCTION_TRACER
   CC_FLAGS_FTRACE := -pg
 endif
 
+RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
+RETPOLINE_VDSO_CFLAGS_GCC := -mindirect-branch=thunk-inline -mindirect-branch-register
+RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
+RETPOLINE_VDSO_CFLAGS_CLANG := -mretpoline
+RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
+RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
+export RETPOLINE_CFLAGS
+export RETPOLINE_VDSO_CFLAGS
+
 # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
 # values of the respective KBUILD_* variables
 ARCH_CPPFLAGS :=
-- 
2.7.4

