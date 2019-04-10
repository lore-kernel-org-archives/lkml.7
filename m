Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659BEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402AD20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbfDJPvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:51:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387507AbfDJPvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:51:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE533A5E1B;
        Wed, 10 Apr 2019 15:51:11 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96BF81062225;
        Wed, 10 Apr 2019 15:51:10 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 5/9] modpost: Integrate klp-convert
Date:   Wed, 10 Apr 2019 11:50:54 -0400
Message-Id: <20190410155058.9437-6-joe.lawrence@redhat.com>
In-Reply-To: <20190410155058.9437-1-joe.lawrence@redhat.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 10 Apr 2019 15:51:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Create cmd_klp_convert and hook it into scripts/Makefile.modpost.
cmd_klp_convert invokes klp-convert with the right arguments for the
conversion of unresolved symbols inside a livepatch.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Joao Moreira <jmoreira@suse.de>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/Kbuild.include   |  4 +++-
 scripts/Makefile.modpost | 16 +++++++++++++++-
 scripts/mod/modpost.c    |  6 +++++-
 scripts/mod/modpost.h    |  1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 7484b9d8272f..f8b7d12e44c9 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -236,6 +236,8 @@ endif
 # (needed for the shell)
 make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
 
+save-cmd = printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd
+
 # Find any prerequisites that is newer than target or that does not exist.
 # PHONY targets skipped in both cases.
 any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
@@ -243,7 +245,7 @@ any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
 # Execute command if command has changed or prerequisite(s) are updated.
 if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
 	$(cmd);                                                              \
-	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
+	$(save-cmd), @:)
 
 # Execute the command and also postprocess generated .d dependencies file.
 if_changed_dep = $(if $(strip $(any-prereq) $(arg-check)),$(cmd_and_fixdep),@:)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 6b7f354f189a..1e8bb7442689 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -124,8 +124,22 @@ quiet_cmd_ld_ko_o = LD [M]  $@
                  -o $@ $(real-prereqs) ;                                \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
+SLIST = $(objtree)/Symbols.list
+KLP_CONVERT = scripts/livepatch/klp-convert
+quiet_cmd_klp_convert = KLP     $@
+      cmd_klp_convert = mv $@ $(@:.ko=.klp.o);				\
+			$(KLP_CONVERT) $(SLIST) $(@:.ko=.klp.o) $@
+
+define rule_ld_ko_o
+	$(call echo-cmd,ld_ko_o) $(cmd_ld_ko_o) ;			\
+	$(call save-cmd,ld_ko_o) ;					\
+	$(if $(CONFIG_LIVEPATCH),					\
+	  $(if $(wildcard $(MODVERDIR)/$(basetarget).livepatch),	\
+	    $(call echo-cmd,klp_convert) $(cmd_klp_convert) ))
+endef
+
 $(modules): %.ko :%.o %.mod.o FORCE
-	+$(call if_changed,ld_ko_o)
+	+$(call if_changed_rule,ld_ko_o)
 
 targets += $(modules)
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f277e116e0eb..374b22c76ec5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1974,6 +1974,10 @@ static void read_symbols(const char *modname)
 		license = get_next_modinfo(&info, "license", license);
 	}
 
+	/* Livepatch modules have unresolved symbols resolved by klp-convert */
+	if (get_modinfo(&info, "livepatch"))
+		mod->livepatch = 1;
+
 	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
 		symname = remove_dot(info.strtab + sym->st_name);
 
@@ -2101,7 +2105,7 @@ static int check_exports(struct module *mod)
 		const char *basename;
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod) {
-			if (have_vmlinux && !s->weak) {
+			if (have_vmlinux && !s->weak && !mod->livepatch) {
 				if (warn_unresolved) {
 					warn("\"%s\" [%s.ko] undefined!\n",
 					     s->name, mod->name);
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 8453d6ac2f77..2acfaae064ec 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -118,6 +118,7 @@ struct module {
 	int skip;
 	int has_init;
 	int has_cleanup;
+	int livepatch;
 	struct buffer dev_table_buf;
 	char	     srcversion[25];
 	int is_dot_o;
-- 
2.20.1

