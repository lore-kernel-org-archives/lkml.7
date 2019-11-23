Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE8BC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71CD20719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GCR/49nO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfKWN2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:11 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39588 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfKWN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:02 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkf000733;
        Sat, 23 Nov 2019 22:27:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkf000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515661;
        bh=ypUpU2nBI/A1XdRJXgUsR35+rlaygjU5MVZjZEkz4gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCR/49nO3EdI/2Iw7QoHmt7RCHQZWY6McY+mNOJ1elseV+MByzbfA/ec1KTtMtrug
         3qZO9+XsmRI/HkAbjgkR61ULTJz4UgIJfQ7q01zF4uw+sAypOI2DaMFOZ2sZIY2PL6
         Ifd5TOhpSiT6IT8bh8V13ioJXFwakDN8OmbiWVxFyBFtoM8Ljc9kOARSPGar4JCthx
         iMxFWeW+qL1S+W2hyRpFotA6tEyQ60sNNLtPhqOKFgDyABivO07PDNLwvEuuEm3EDm
         FH8b7bvp9UxTpU2cGc+YqCroL3aqWPbPsZR4KRoUYilIvixzLe+qONzA/FcQDa19sj
         oL2+XYyhhQC9A==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/16] scripts/kallsyms: add sym_name() to mitigate cast ugliness
Date:   Sat, 23 Nov 2019 22:27:17 +0900
Message-Id: <20191123132727.30151-7-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sym_entry::sym is (unsigned char *) instead of (char *) because
kallsyms exploits the MSB for compression, and the characters are
used as the index of token_profit array.

However, it requires casting (unsigned char *) to (char *) in some
places since standard library functions such as strcmp(), strlen()
expect (char *).

Introduce a new helper, sym_name(), which advances the given pointer
by 1 and casts it to (char *).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index d06f373b3a96..7b00b4030be4 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -74,6 +74,11 @@ static void usage(void)
 	exit(1);
 }
 
+static char *sym_name(const struct sym_entry *s)
+{
+	return (char *)s->sym + 1;
+}
+
 static int check_symbol_range(const char *sym, unsigned long long addr,
 			      struct addr_range *ranges, int entries)
 {
@@ -154,7 +159,7 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 			"unable to allocate required amount of memory\n");
 		exit(EXIT_FAILURE);
 	}
-	strcpy((char *)s->sym + 1, sym);
+	strcpy(sym_name(s), sym);
 	s->sym[0] = stype;
 
 	s->percpu_absolute = 0;
@@ -215,7 +220,7 @@ static int symbol_valid(struct sym_entry *s)
 		NULL };
 
 	int i;
-	char *sym_name = (char *)s->sym + 1;
+	const char *name = sym_name(s);
 
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
@@ -230,30 +235,28 @@ static int symbol_valid(struct sym_entry *s)
 		 * rules.
 		 */
 		if ((s->addr == text_range_text->end &&
-				strcmp(sym_name,
-				       text_range_text->end_sym)) ||
+		     strcmp(name, text_range_text->end_sym)) ||
 		    (s->addr == text_range_inittext->end &&
-				strcmp(sym_name,
-				       text_range_inittext->end_sym)))
+		     strcmp(name, text_range_inittext->end_sym)))
 			return 0;
 	}
 
 	/* Exclude symbols which vary between passes. */
 	for (i = 0; special_symbols[i]; i++)
-		if (strcmp(sym_name, special_symbols[i]) == 0)
+		if (strcmp(name, special_symbols[i]) == 0)
 			return 0;
 
 	for (i = 0; special_prefixes[i]; i++) {
 		int l = strlen(special_prefixes[i]);
 
-		if (strncmp(sym_name, special_prefixes[i], l) == 0)
+		if (strncmp(name, special_prefixes[i], l) == 0)
 			return 0;
 	}
 
 	for (i = 0; special_suffixes[i]; i++) {
-		int l = strlen(sym_name) - strlen(special_suffixes[i]);
+		int l = strlen(name) - strlen(special_suffixes[i]);
 
-		if (l >= 0 && strcmp(sym_name + l, special_suffixes[i]) == 0)
+		if (l >= 0 && strcmp(name + l, special_suffixes[i]) == 0)
 			return 0;
 	}
 
@@ -618,7 +621,7 @@ static void optimize_token_table(void)
 /* guess for "linker script provide" symbol */
 static int may_be_linker_script_provide_symbol(const struct sym_entry *se)
 {
-	const char *symbol = (char *)se->sym + 1;
+	const char *symbol = sym_name(se);
 	int len = se->len - 1;
 
 	if (len < 8)
@@ -688,8 +691,8 @@ static int compare_symbols(const void *a, const void *b)
 		return wa - wb;
 
 	/* sort by the number of prefix underscores */
-	wa = prefix_underscores_count((const char *)sa->sym + 1);
-	wb = prefix_underscores_count((const char *)sb->sym + 1);
+	wa = prefix_underscores_count(sym_name(sa));
+	wb = prefix_underscores_count(sym_name(sb));
 	if (wa != wb)
 		return wa - wb;
 
-- 
2.17.1

