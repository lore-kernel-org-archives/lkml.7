Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902EC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A91E21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XoHSJH3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfGQGTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:19:08 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62963 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfGQGS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:18:26 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6H6I5Od009435;
        Wed, 17 Jul 2019 15:18:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6H6I5Od009435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563344287;
        bh=voAuv5qPBHPc/k/dyjB+W0Xau4XgwmjU5jtBPFVJyF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoHSJH3Nzc2u1kjNx0kOh8OywZ9B4vO80mxko2a2YUKt83wRCgExPt8JCkpK6oHa1
         XCSbkNlFY5N6bucKXjA85n7aDSoqeVGxbao77NLi8OICi/NYPCTvHhtea1FjPNTHby
         VFfSjnz0z650Lnq6l6PDx4eH++3iT1kOanAGJ/z8NT7BYmYlFVE7iwh4c65uSq5Qt5
         WQ8/3ieUrvBn7J9mwDMmlVEtvYAj0Rj85+L2l1ODyP7t/89+ab/7ERTis+ItvwoyrR
         4pCZj4zYu5oRZR8cUa1Y3lOaUifJuNFaoENx75zvj96wfyIKiVSxHmQKM5AkgHlJzO
         J3aNWuDV5joKQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/12] kbuild: do not create empty modules.order in the prepare stage
Date:   Wed, 17 Jul 2019 15:17:49 +0900
Message-Id: <20190717061800.10018-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717061800.10018-1-yamada.masahiro@socionext.com>
References: <20190717061800.10018-1-yamada.masahiro@socionext.com>
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

This avoids creating the following pointless files:

  scripts/basic/modules.order
  scripts/dtc/modules.order
  scripts/gcc-plugins/modules.order
  scripts/genksyms/modules.order
  scripts/mod/modules.order
  scripts/modules.order
  scripts/selinux/genheaders/modules.order
  scripts/selinux/mdp/modules.order
  scripts/selinux/modules.order

Going forward, $(objtree)/modules.order lists the modules that
was built in the last successful build.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - inverted the logic "preparing" -> need-modorder

 Makefile               | 4 ++--
 scripts/Makefile.build | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index e43285786102..b74a6e9cefc8 100644
--- a/Makefile
+++ b/Makefile
@@ -1072,7 +1072,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
 
 PHONY += $(vmlinux-dirs)
 $(vmlinux-dirs): prepare
-	$(Q)$(MAKE) $(build)=$@ need-builtin=1
+	$(Q)$(MAKE) $(build)=$@ need-builtin=1 need-modorder=1
 
 filechk_kernel.release = \
 	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
@@ -1616,7 +1616,7 @@ $(objtree)/Module.symvers:
 module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))
 PHONY += $(module-dirs) modules
 $(module-dirs): prepare $(objtree)/Module.symvers
-	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@)
+	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@) need-modorder=1
 
 modules: $(module-dirs)
 	@$(kecho) '  Building modules, stage 2.';
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5829ccbc7dd0..631bb89524de 100644
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

