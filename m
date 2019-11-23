Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD667C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E87320719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="H7Kordq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKWN2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:38 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39539 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKWN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:00 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkd000733;
        Sat, 23 Nov 2019 22:27:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkd000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515660;
        bh=TgBBfAjF1gkWIAkBRfUA0hcVefTdXQgpgZ7bt3b2OO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7Kordq0Z3UH2HxIwpMry7Xy/ka2OwWKrm8/MbDl8o+VMj6UepLQG0Im0Ge2986cn
         LdjrPJvM9rw/X9NGSQXcA2zWxw5MlkTQhdSycp26sGeihRfHY/9nPY18veRTm50Tk6
         uxP2eEJt9NInF+3HypKPbS8G1xTByQBIOM7ZIdenaLjWmyaKdgXNFbmXikWE2u40JF
         uCGpo+RyQyfZ5yhhtfxj5W2XwztuW5wDUPlGUeFq5zzPsEHBfLTAfsJrBvYmEIr3WO
         /n+0ONRE+pJiO2Su9xcXjlYRUEFd8r9t/E+7NcovY0LeHx9nLYwUbw3THUEbKkk/r8
         eh+CNe5vWBn4g==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] scripts/kallsyms: remove redundant is_arm_mapping_symbol()
Date:   Sat, 23 Nov 2019 22:27:15 +0900
Message-Id: <20191123132727.30151-5-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6f00df24ee39 ("[PATCH] Strip local symbols from kallsyms"),
all symbols starting '$' are ignored.

is_arm_mapping_symbol() particularly ignores $a, $t, etc. but it is
redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 0959e1de381c..265475d3cffb 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -74,16 +74,6 @@ static void usage(void)
 	exit(1);
 }
 
-/*
- * This ignores the intensely annoying "mapping symbols" found
- * in ARM ELF files: $a, $t and $d.
- */
-static int is_arm_mapping_symbol(const char *str)
-{
-	return str[0] == '$' && strchr("axtd", str[1])
-	       && (str[2] == '\0' || str[2] == '.');
-}
-
 static int check_symbol_range(const char *sym, unsigned long long addr,
 			      struct addr_range *ranges, int entries)
 {
@@ -139,10 +129,13 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 			return -1;
 
 	}
-	else if (toupper(stype) == 'U' ||
-		 is_arm_mapping_symbol(sym))
+	else if (toupper(stype) == 'U')
 		return -1;
-	/* exclude also MIPS ELF local symbols ($L123 instead of .L123) */
+	/*
+	 * Ignore generated symbols such as:
+	 *  - mapping symbols in ARM ELF files ($a, $t, and $d)
+	 *  - MIPS ELF local symbols ($L123 instead of .L123)
+	 */
 	else if (sym[0] == '$')
 		return -1;
 	/* exclude debugging symbols */
-- 
2.17.1

