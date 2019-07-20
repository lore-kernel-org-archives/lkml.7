Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7840CC76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D59B2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 16:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NxOBzB80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfGTQ1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 12:27:50 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:52416 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGTQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 12:27:49 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6KGRfOs009136;
        Sun, 21 Jul 2019 01:27:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6KGRfOs009136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563640062;
        bh=uYu3VJ6J2qsvZ4CUEzwqQcj7TCaHdD1WcbA0oBYilBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxOBzB80zpfhtzZD/sLrD6crVhdzRlsP4w2a7u7fLE+4u69dS+fqmHrNbIxlZZUME
         DwU0fFzTBzfExAmdmrAaHYp21mp4BUHeH/II+JAi0ZvhvKht6sQj1lE5vaviFAlfil
         9j7VO1OK//S5aKiHZfXW5pl8aPvlkD8t0DlQdcQrRGCMDoSWbN1DH9UdahBM97Vx/P
         xumd4gOBfD8R+KA7oYMUUKWVMBnNeyYmm5JLDawPlB+TnO3R3z9WsIVZQYR0KQfTcA
         C2S/29a5Mn9JIdgle60b3CHDWwYlxTztzn/JWlq+9YlLmg1VEhh0KtyNYEBZKhEY8e
         zS5Rc1edLE/hQ==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kbuild: move flex and bison rules to Makefile.host
Date:   Sun, 21 Jul 2019 01:27:40 +0900
Message-Id: <20190720162740.4292-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190720162740.4292-1-yamada.masahiro@socionext.com>
References: <20190720162740.4292-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flex and bison are used for kconfig, dtc, genksyms, all of which are
host programs. I never imagine the kernel embeds a parser or a lexer.

Move the flex and bison rules to scripts/Makefile.host. This file is
included only when hostprogs-y etc. is present in the Makefile in the
directory. So, parsing these rules are skipped in most of directories.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.host | 17 +++++++++++++++++
 scripts/Makefile.lib  | 16 ----------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 2208ebbd8c4c..b402c619147d 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -1,4 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# LEX
+# ---------------------------------------------------------------------------
+quiet_cmd_flex = LEX     $@
+      cmd_flex = $(LEX) -o$@ -L $<
+
+$(obj)/%.lex.c: $(src)/%.l FORCE
+	$(call if_changed,flex)
+
+# YACC
+# ---------------------------------------------------------------------------
+quiet_cmd_bison = YACC    $(basename $@).[ch]
+      cmd_bison = $(YACC) -o $(basename $@).c --defines=$(basename $@).h -t -l $<
+
+$(obj)/%.tab.c $(obj)/%.tab.h: $(src)/%.y FORCE
+	$(call if_changed,bison)
+
 # ==========================================================================
 # Building binaries on the host system
 # Binaries are used during the compilation of the kernel, for example
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 6c4a2332f6d6..4d65172cdcd4 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -189,22 +189,6 @@ $(foreach m, $(notdir $1), \
 	$(addprefix $(obj)/, $(foreach s, $3, $($(m:%$(strip $2)=%$(s)))))))
 endef
 
-# LEX
-# ---------------------------------------------------------------------------
-quiet_cmd_flex = LEX     $@
-      cmd_flex = $(LEX) -o$@ -L $<
-
-$(obj)/%.lex.c: $(src)/%.l FORCE
-	$(call if_changed,flex)
-
-# YACC
-# ---------------------------------------------------------------------------
-quiet_cmd_bison = YACC    $(basename $@).[ch]
-      cmd_bison = $(YACC) -o $(basename $@).c --defines=$(basename $@).h -t -l $<
-
-$(obj)/%.tab.c $(obj)/%.tab.h: $(src)/%.y FORCE
-	$(call if_changed,bison)
-
 # Shipped files
 # ===========================================================================
 
-- 
2.17.1

