Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01364C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72D2217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mxgVQSXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfGQGSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:18:48 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62971 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfGQGS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:18:26 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6H6I5Oo009435;
        Wed, 17 Jul 2019 15:18:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6H6I5Oo009435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563344294;
        bh=tV8Id8UQty/9yTwTbnWxEz0ZVA1NCDaDyk+FEo41GJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxgVQSXY/Pk6U50rixL3JiIl5umcvl3ak0EkcZYWJm2Bvw3YzLcQ+7+MW/rxVyEeb
         VMe1qVqxi8RvoAI+EOASzPXbD71nHD8vEc1f7NPQr67qFp2QVEdPtwGB4kBW2TtpEp
         dJrFbYjtJmfnAcdqbRnNQ+dxXvQutkdtYmPvolLDFG3ygku5QOVWeBcuMi8Drx0LIP
         Yc9ANZTaSgQGtKvu3P7RXCm55Zngn3oo27LQelPxYvrsAj6y4g2BsFpLq0g9Bpkpf3
         BaBcb+jikDZua+PlQULSUVSasuUixwZzQT1ROkdwOhKgBbImJfJKO5HjiT5pXdJx25
         /N4o4EtG/7VcA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/12] kbuild: split out *.mod out of {single,multi}-used-m rules
Date:   Wed, 17 Jul 2019 15:18:00 +0900
Message-Id: <20190717061800.10018-13-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717061800.10018-1-yamada.masahiro@socionext.com>
References: <20190717061800.10018-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, *.mod is created as a side-effect of obj-m.

Split out *.mod as a dedicated build rule, which allows to unify
the %.c -> %.o rule, and remove the single-used-m rule.

This also makes the incremental build of allmodconfig faster because
it saves $(NM) invocation when there is no change in the module.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 scripts/Makefile.build | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9f37f203882f..0d434d0afc0b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -67,8 +67,10 @@ ifeq ($(CONFIG_MODULES)$(need-modorder),y1)
 modorder-target := $(obj)/modules.order
 endif
 
+mod-targets := $(patsubst %.o, %.mod, $(obj-m))
+
 __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
-	 $(if $(KBUILD_MODULES),$(obj-m) $(modorder-target)) \
+	 $(if $(KBUILD_MODULES),$(obj-m) $(mod-targets) $(modorder-target)) \
 	 $(subdir-ym) $(always)
 	@:
 
@@ -261,7 +263,7 @@ endef
 
 # List module undefined symbols (or empty line if not enabled)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $@ | sed -n 's/^  *U //p' | xargs echo
+cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
 else
 cmd_undef_syms = echo
 endif
@@ -271,11 +273,15 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
-$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
-	$(call cmd,force_checksrc)
-	$(call if_changed_rule,cc_o_c)
-	@{ echo $@; \
-	   $(cmd_undef_syms); } > $(patsubst %.o,%.mod,$@)
+cmd_mod = { \
+	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
+	$(cmd_undef_syms); \
+	} > $@
+
+$(obj)/%.mod: $(obj)/%.o FORCE
+	$(call if_changed,mod)
+
+targets += $(mod-targets)
 
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
@@ -456,8 +462,6 @@ quiet_cmd_link_multi-m = LD [M]  $@
 
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
-	@{ echo $(filter %.o,$^); \
-	   $(cmd_undef_syms); } > $(patsubst %.o,%.mod,$@)
 $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
 
 targets += $(multi-used-m)
-- 
2.17.1

