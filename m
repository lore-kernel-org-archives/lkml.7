Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809E5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 04:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529C520720
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 04:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="skfsE1Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfKRExR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 23:53:17 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53165 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRExQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 23:53:16 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xAI4qv3K018061;
        Mon, 18 Nov 2019 13:52:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xAI4qv3K018061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574052778;
        bh=JqcQcrWHEKB4b6nUF5HXLGCoOUkjTbW3JcEhYDjVfdA=;
        h=From:To:Cc:Subject:Date:From;
        b=skfsE1FbazFZKPnozb4i7LA1ii+BGQQV/3tMDid014eL028KXf3PYNzwXeaVnDALo
         xOcEekAqEli2irj6/Lx1LSL8Kjz6fq2h9NjoRsQmy1w+gguRVgjUuyOUodOUoq/Xn6
         zqaOY9m9813Kl+h0wvTlJZIFFfv3dr7H3D2ubp7/l2b4cA/ls/UdWp8MjhN/3k5Vzb
         R7IiMlo6Y2j+EDhxIOHHT+sGxILC2YL73OX2wHCpGIURc6CINwYRpbpX16cHaLzONf
         bRaaeY3xdm24MSDSeGhR1kQ23zzVvBkzkvCueteOntgca2Ekr9vD+zOhRvwbFGiopP
         P2DIZ3GUcorPw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: make single target builds even faster
Date:   Mon, 18 Nov 2019 13:52:47 +0900
Message-Id: <20191118045247.14082-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2dffd23f81a3 ("kbuild: make single target builds much faster")
made the situation much better.

To improve it even more, apply the similar idea to the top Makefile.
Trim unrelated directories from build-dirs.

The single build code must be moved above the 'descend' target.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 90 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/Makefile b/Makefile
index 99470c19c158..345b8f2e2a9e 100644
--- a/Makefile
+++ b/Makefile
@@ -1633,6 +1633,50 @@ help:
 PHONY += prepare
 endif # KBUILD_EXTMOD
 
+# Single targets
+# ---------------------------------------------------------------------------
+# To build individual files in subdirectories, you can do like this:
+#
+#   make foo/bar/baz.s
+#
+# The supported suffixes for single-target are listed in 'single-targets'
+#
+# To build only under specific subdirectories, you can do like this:
+#
+#   make foo/bar/baz/
+
+ifdef single-build
+
+# .ko is special because modpost is needed
+single-ko := $(sort $(filter %.ko, $(MAKECMDGOALS)))
+single-no-ko := $(sort $(patsubst %.ko,%.mod, $(MAKECMDGOALS)))
+
+$(single-ko): single_modpost
+	@:
+$(single-no-ko): descend
+	@:
+
+ifeq ($(KBUILD_EXTMOD),)
+# For the single build of in-tree modules, use a temporary file to avoid
+# the situation of modules_install installing an invalid modules.order.
+MODORDER := .modules.tmp
+endif
+
+PHONY += single_modpost
+single_modpost: $(single-no-ko)
+	$(Q){ $(foreach m, $(single-ko), echo $(extmod-prefix)$m;) } > $(MODORDER)
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
+
+KBUILD_MODULES := 1
+
+export KBUILD_SINGLE_TARGETS := $(addprefix $(extmod-prefix), $(single-no-ko))
+
+# trim unrelated directories
+build-dirs := $(foreach d, $(build-dirs), \
+			$(if $(filter $(d)/%, $(KBUILD_SINGLE_TARGETS)), $(d)))
+
+endif
+
 # Handle descending into subdirectories listed in $(build-dirs)
 # Preset locale variables to speed up the build process. Limit locale
 # tweaks to this spot to avoid wrong language settings when running
@@ -1641,7 +1685,9 @@ endif # KBUILD_EXTMOD
 PHONY += descend $(build-dirs)
 descend: $(build-dirs)
 $(build-dirs): prepare
-	$(Q)$(MAKE) $(build)=$@ single-build=$(single-build) need-builtin=1 need-modorder=1
+	$(Q)$(MAKE) $(build)=$@ \
+	single-build=$(if $(filter-out $@/, $(single-no-ko)),1) \
+	need-builtin=1 need-modorder=1
 
 clean-dirs := $(addprefix _clean_, $(clean-dirs))
 PHONY += $(clean-dirs) clean
@@ -1744,48 +1790,6 @@ tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
-# Single targets
-# ---------------------------------------------------------------------------
-# To build individual files in subdirectories, you can do like this:
-#
-#   make foo/bar/baz.s
-#
-# The supported suffixes for single-target are listed in 'single-targets'
-#
-# To build only under specific subdirectories, you can do like this:
-#
-#   make foo/bar/baz/
-
-ifdef single-build
-
-# .ko is special because modpost is needed
-single-ko := $(sort $(filter %.ko, $(MAKECMDGOALS)))
-single-no-ko := $(sort $(patsubst %.ko,%.mod, $(MAKECMDGOALS)))
-
-$(single-ko): single_modpost
-	@:
-$(single-no-ko): descend
-	@:
-
-ifeq ($(KBUILD_EXTMOD),)
-# For the single build of in-tree modules, use a temporary file to avoid
-# the situation of modules_install installing an invalid modules.order.
-MODORDER := .modules.tmp
-endif
-
-PHONY += single_modpost
-single_modpost: $(single-no-ko)
-	$(Q){ $(foreach m, $(single-ko), echo $(extmod-prefix)$m;) } > $(MODORDER)
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
-
-KBUILD_MODULES := 1
-
-export KBUILD_SINGLE_TARGETS := $(addprefix $(extmod-prefix), $(single-no-ko))
-
-single-build = $(if $(filter-out $@/, $(single-no-ko)),1)
-
-endif
-
 # FIXME Should go into a make.lib or something
 # ===========================================================================
 
-- 
2.17.1

