Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC070C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D442070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="F+eqeVkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfFVQHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:07:14 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:55076 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfFVQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:07:13 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x5MG77nd010140;
        Sun, 23 Jun 2019 01:07:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x5MG77nd010140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561219627;
        bh=ZlvLycAkHyzzpdCcUrLPWm4mf7P72IsMu/6F8p5QR30=;
        h=From:To:Cc:Subject:Date:From;
        b=F+eqeVkwJbBDQpFiYS0LUjvhR937paJpLi3Mg7OUZ6BnFxSsJrVNyxz4UQ1uFdIy7
         bicy+v9/R4hF+plAnn2R9aFKebyLhw/ciHdugHF6qQ1QAAsI9+YGmFYuQN3rjCREwl
         c862N90L9vS4gA7rhm8Rtf0kYg2fXDvSS4fzX2KDNV2NG5UbBBA9OZk1eYitIo/iav
         HUrQYD+50D5mKXcPITy5B5ae6WUfxtNrNGoW7cYsmsCMVDja40rMz6d5EM2XzwM9Bf
         k1AQYZFuZiEMgu1UbIi01Xz5lKuOHrJKLgVh48awQFzuDlW014a8PyW/IyVl/V0NbP
         GUqne8FqnkNpg==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: rename arg-check to cmd-check
Date:   Sun, 23 Jun 2019 01:07:03 +0900
Message-Id: <20190622160705.17071-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I prefer 'cmd-check' for consistency.

We have 'echo-cmd', 'cmd', 'cmd_and_fixdep', etc. in this file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index f641bb0aa63f..4bec04c89750 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -213,12 +213,12 @@ objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
 # See Documentation/kbuild/makefiles.txt for more info
 
 ifneq ($(KBUILD_NOCMDDEP),1)
-# Check if both arguments are the same including their order. Result is empty
+# Check if both commands are the same including their order. Result is empty
 # string if equal. User may override this check using make KBUILD_NOCMDDEP=1
-arg-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(cmd_$@))), \
+cmd-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(cmd_$@))), \
                          $(subst $(space),$(space_escape),$(strip $(cmd_$1))))
 else
-arg-check = $(if $(strip $(cmd_$@)),,1)
+cmd-check = $(if $(strip $(cmd_$@)),,1)
 endif
 
 # Replace >$< with >$$< to preserve $ when reloading the .cmd file
@@ -234,12 +234,12 @@ make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1))))
 any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
 
 # Execute command if command has changed or prerequisite(s) are updated.
-if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
+if_changed = $(if $(strip $(any-prereq) $(cmd-check)),                       \
 	$(cmd);                                                              \
 	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Execute the command and also postprocess generated .d dependencies file.
-if_changed_dep = $(if $(strip $(any-prereq) $(arg-check)),$(cmd_and_fixdep),@:)
+if_changed_dep = $(if $(strip $(any-prereq) $(cmd-check)),$(cmd_and_fixdep),@:)
 
 cmd_and_fixdep =                                                             \
 	$(cmd);                                                              \
@@ -249,7 +249,7 @@ cmd_and_fixdep =                                                             \
 # Usage: $(call if_changed_rule,foo)
 # Will check if $(cmd_foo) or any of the prerequisites changed,
 # and if so will execute $(rule_foo).
-if_changed_rule = $(if $(strip $(any-prereq) $(arg-check)),$(rule_$(1)),@:)
+if_changed_rule = $(if $(strip $(any-prereq) $(cmd-check)),$(rule_$(1)),@:)
 
 ###
 # why - tell why a target got built
@@ -275,7 +275,7 @@ why =                                                                        \
     $(if $(filter $@, $(PHONY)),- due to target is PHONY,                    \
         $(if $(wildcard $@),                                                 \
             $(if $(strip $(any-prereq)),- due to: $(any-prereq),             \
-                $(if $(arg-check),                                           \
+                $(if $(cmd-check),                                           \
                     $(if $(cmd_$@),- due to command line change,             \
                         $(if $(filter $@, $(targets)),                       \
                             - due to missing .cmd file,                      \
-- 
2.17.1

