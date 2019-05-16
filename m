Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A997C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13B020881
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfEPKiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:38:15 -0400
Received: from foss.arm.com ([217.140.101.70]:40892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbfEPKiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:38:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 313251A25;
        Thu, 16 May 2019 03:38:13 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA3BE3F703;
        Thu, 16 May 2019 03:38:11 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 07/16] objtool: special: Adapt special section handling
Date:   Thu, 16 May 2019 11:36:46 +0100
Message-Id: <20190516103655.5509-8-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516103655.5509-1-raphael.gault@arm.com>
References: <20190516103655.5509-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch abstracts the few architecture dependent tests that are
perform when handling special section and switch tables. It enables any
architecture to ignore a particular CPU feature or not to handle switch
tables.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/arch/arm64/Build                  |  1 +
 tools/objtool/arch/arm64/include/arch_special.h | 10 ++++++++--
 tools/objtool/arch/x86/Build                    |  1 +
 tools/objtool/arch/x86/include/arch_special.h   |  9 +++++++++
 tools/objtool/check.c                           | 15 +++++++++++++--
 tools/objtool/special.c                         |  9 ++-------
 tools/objtool/special.h                         |  3 +++
 7 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/arch/arm64/Build b/tools/objtool/arch/arm64/Build
index bf7a32c2b9e9..3d09be745a84 100644
--- a/tools/objtool/arch/arm64/Build
+++ b/tools/objtool/arch/arm64/Build
@@ -1,3 +1,4 @@
+objtool-y += arch_special.o
 objtool-y += decode.o
 objtool-y += orc_dump.o
 objtool-y += orc_gen.o
diff --git a/tools/objtool/arch/arm64/include/arch_special.h b/tools/objtool/arch/arm64/include/arch_special.h
index 63da775d0581..185103be8a51 100644
--- a/tools/objtool/arch/arm64/include/arch_special.h
+++ b/tools/objtool/arch/arm64/include/arch_special.h
@@ -30,7 +30,13 @@
 #define ALT_ORIG_LEN_OFFSET	10
 #define ALT_NEW_LEN_OFFSET	11
 
-#define X86_FEATURE_POPCNT (4 * 32 + 23)
-#define X86_FEATURE_SMAP   (9 * 32 + 20)
+static inline bool arch_should_ignore_feature(unsigned short feature)
+{
+	return false;
+}
 
+static inline bool arch_support_switch_table(void)
+{
+	return false;
+}
 #endif /* _ARM64_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 1f11b45999d0..63e167775bc8 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,3 +1,4 @@
+objtool-y += arch_special.o
 objtool-y += decode.o
 objtool-y += orc_dump.o
 objtool-y += orc_gen.o
diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
index 424ce47013e3..fce2b1193194 100644
--- a/tools/objtool/arch/x86/include/arch_special.h
+++ b/tools/objtool/arch/x86/include/arch_special.h
@@ -33,4 +33,13 @@
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
 
+static inline bool arch_should_ignore_feature(unsigned short feature)
+{
+	return feature == X86_FEATURE_POPCNT;
+}
+
+static inline bool arch_support_switch_table(void)
+{
+	return true;
+}
 #endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cd9cd26206d1..0ee3b781ddd8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -738,7 +738,7 @@ static int handle_group_alt(struct objtool_file *file,
 		last_orig_insn = insn;
 	}
 
-	if (next_insn_same_sec(file, last_orig_insn)) {
+	if (last_orig_insn && next_insn_same_sec(file, last_orig_insn)) {
 		fake_jump = malloc(sizeof(*fake_jump));
 		if (!fake_jump) {
 			WARN("malloc failed");
@@ -1054,6 +1054,17 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (find_symbol_containing(rodata_sec, table_offset))
 			continue;
 
+		/*
+		 * If we are on arm64 architecture, we now that we
+		 * are in presence of a switch table thanks to
+		 * the `br <Xn>` insn. but we can't retrieve it yet.
+		 * So we just ignore unreachable for this file.
+		 */
+		if (!arch_support_switch_table()) {
+			file->ignore_unreachables = true;
+			return NULL;
+		}
+
 		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
 		if (rodata_rela) {
 			/*
@@ -1853,7 +1864,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 	insn = first;
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
+	if (!insn->visited && insn->alt_group && list_empty(&insn->alts)) {
 		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
 			  sec, insn->offset);
 		return 1;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index fd7c928fa1d6..e33321637932 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -93,7 +93,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		 * feature path which is a "very very small percentage of
 		 * machines".
 		 */
-		if (feature == X86_FEATURE_POPCNT)
+		if (arch_should_ignore_feature(feature))
 			alt->skip_orig = true;
 
 		/*
@@ -105,12 +105,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		 * find paths that see the STAC but take the NOP instead of
 		 * CLAC and the other way around.
 		 */
-		if (feature == X86_FEATURE_SMAP) {
-			if (uaccess)
-				alt->skip_orig = true;
-			else
-				alt->skip_alt = true;
-		}
+		arch_force_alt_path(feature, uaccess, alt);
 	}
 
 	orig_rela = find_rela_by_dest(sec, offset + entry->orig);
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index d5c062e718ef..05f1e496bf7c 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -39,5 +39,8 @@ struct special_alt {
 };
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
+void arch_force_alt_path(unsigned short feature,
+			 bool uaccess,
+			 struct special_alt *alt);
 
 #endif /* _SPECIAL_H */
-- 
2.17.1

