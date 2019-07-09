Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020AAC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B1B20644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HzjW6hmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGIHPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:15:08 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:59393 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfGIHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:15:08 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x697ESep019286;
        Tue, 9 Jul 2019 16:14:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x697ESep019286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562656469;
        bh=0tb2WfkcAoePIPurQ/sqmPHgIwP8421Q7FxdbjzURyo=;
        h=From:To:Cc:Subject:Date:From;
        b=HzjW6hmkzFEYcxbgep9Z5Tf5hgi9iPSB3s1e7lxHXyGcScNehXBqCl+It4S7BWTke
         lHUBrcjdMA+vfJE+7uBpJ/qJM5bPDo05V4boQYjT8bsfbHuTXIuZS4v8lRMUKeQQYD
         6nMnrMxx1gCRduVjE7PiTc9vwAD69ByzmiRYwgvN3MhomguT51hqzUz3juEQ1mov9+
         8a/Edq1NgV3YkT9cAFaJns6bu5fmnBrMhiYZ7J2sQhFfYBJ3RWMsYlak3IXOPnJUn4
         KkaAmg68QnlG0azwQPRidUPR/Uh4nwNVms7B+RP/7Wl0f/2FurKeYZPnkFS1+p5lts
         D6pBiuEciabKg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 01/11] kbuild: do not create empty modules.order in the prepare stage
Date:   Tue,  9 Jul 2019 16:14:19 +0900
Message-Id: <20190709071419.17150-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, $(objtree)/modules.order is touched in two places.

In the 'prepare0' rule, scripts/Makefile.build creates an empty
modules.order while processing 'obj=.'

In the 'modules' rule, the top-level Makefile overwrites it with
the correct list of modules.

While this might be a good side-effect that modules.order is made
empty every time (probably this is not intended functionality),
I personally do not like this behavior.

Create modules.order only when it is sensible to do so.

Going forward, $(objtree)/modules.order lists the modules that
was built in the last successful build.

This also avoids creating pointless files:

  scripts/basic/modules.order
  scripts/dtc/modules.order
  scripts/gcc-plugins/modules.order
  scripts/genksyms/modules.order
  scripts/mod/modules.order
  scripts/modules.order
  scripts/selinux/genheaders/modules.order
  scripts/selinux/mdp/modules.order
  scripts/selinux/modules.order

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - inverted the logic "preparing" -> need-modorder
 

 Makefile               | 4 ++--
 scripts/Makefile.build | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 5c75ea7177f6..d8421d245f75 100644
--- a/Makefile
+++ b/Makefile
@@ -1076,7 +1076,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
 
 PHONY += $(vmlinux-dirs)
 $(vmlinux-dirs): prepare
-	$(Q)$(MAKE) $(build)=$@ need-builtin=1
+	$(Q)$(MAKE) $(build)=$@ need-builtin=1 need-modorder=1
 
 filechk_kernel.release = \
 	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
@@ -1611,7 +1611,7 @@ $(objtree)/Module.symvers:
 module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))
 PHONY += $(module-dirs) modules
 $(module-dirs): prepare $(objtree)/Module.symvers
-	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@)
+	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@) need-modorder=1
 
 modules: $(module-dirs)
 	@$(kecho) '  Building modules, stage 2.';
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 776842b7e6a3..e9b3d88257dd 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -63,7 +63,7 @@ ifneq ($(strip $(real-obj-y) $(need-builtin)),)
 builtin-target := $(obj)/built-in.a
 endif
 
-ifdef CONFIG_MODULES
+ifeq ($(CONFIG_MODULES)$(need-modorder),y1)
 modorder-target := $(obj)/modules.order
 endif
 
-- 
2.17.1

