Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76162C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F562070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v/+rqumx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKWQF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:05:28 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49454 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKWQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:05:02 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xANG4l5K019106;
        Sun, 24 Nov 2019 01:04:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xANG4l5K019106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574525089;
        bh=NiWcGoRSkJ1ToZ+rAR8uqUuIB/kFxxkQ/T4OsoV5GoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/+rqumxnqCo8borqbNoOmcZ+UTQtLFg9D1qGgnjRgnSouqHHc8n+EmdrhMdd/HG1
         LTZG0bOtEcXsaKegzYSDoSJ9D6cBGbuDElcmL24fG9g8ERHI6eVZchYbdbMnEkOjr4
         Mz8qVFnTNoOExJsgK+Nw7rpQyTkVCH8TczsWzVdKRgYXpo6cZPAXkWByCJWKKfCDKF
         q1KwHmqmf8oBI8eC8AYyteryM5oIzT8fiyF5VdSd9CLAvMohFnyE1cQndL0HCn7m36
         AILp2k/NrjHd2qkW3lwRoRMFZ08O/XD9r673m7i8elxA+cizFjNIP0xR2ASKgmM1wJ
         tyj9amgzO1hQA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/16] scripts/kallsyms: shrink table before sorting it
Date:   Sun, 24 Nov 2019 01:04:31 +0900
Message-Id: <20191123160444.11251-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123160444.11251-1-yamada.masahiro@socionext.com>
References: <20191123160444.11251-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, build_initial_tok_table() trims unused symbols, which is
called after sort_symbol().

It is not efficient to sort the huge table that contains unused entries.
Shrink the table before sorting it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - New patch

 scripts/kallsyms.c | 49 +++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 79641874d860..de986eda41a6 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -268,6 +268,30 @@ static int symbol_valid(struct sym_entry *s)
 	return 1;
 }
 
+/* remove all the invalid symbols from the table */
+static void shrink_table(void)
+{
+	unsigned int i, pos;
+
+	pos = 0;
+	for (i = 0; i < table_cnt; i++) {
+		if (symbol_valid(&table[i])) {
+			if (pos != i)
+				table[pos] = table[i];
+			pos++;
+		} else {
+			free(table[i].sym);
+		}
+	}
+	table_cnt = pos;
+
+	/* When valid symbol is not registered, exit to error */
+	if (!table_cnt) {
+		fprintf(stderr, "No valid symbol.\n");
+		exit(1);
+	}
+}
+
 static void read_map(FILE *in)
 {
 	while (!feof(in)) {
@@ -475,23 +499,13 @@ static void forget_symbol(unsigned char *symbol, int len)
 		token_profit[ symbol[i] + (symbol[i + 1] << 8) ]--;
 }
 
-/* remove all the invalid symbols from the table and do the initial token count */
+/* do the initial token count */
 static void build_initial_tok_table(void)
 {
-	unsigned int i, pos;
+	unsigned int i;
 
-	pos = 0;
-	for (i = 0; i < table_cnt; i++) {
-		if ( symbol_valid(&table[i]) ) {
-			if (pos != i)
-				table[pos] = table[i];
-			learn_symbol(table[pos].sym, table[pos].len);
-			pos++;
-		} else {
-			free(table[i].sym);
-		}
-	}
-	table_cnt = pos;
+	for (i = 0; i < table_cnt; i++)
+		learn_symbol(table[i].sym, table[i].len);
 }
 
 static void *find_token(unsigned char *str, int len, unsigned char *token)
@@ -614,12 +628,6 @@ static void optimize_token_table(void)
 
 	insert_real_symbols_in_table();
 
-	/* When valid symbol is not registered, exit to error */
-	if (!table_cnt) {
-		fprintf(stderr, "No valid symbol.\n");
-		exit(1);
-	}
-
 	optimize_result();
 }
 
@@ -756,6 +764,7 @@ int main(int argc, char **argv)
 		usage();
 
 	read_map(stdin);
+	shrink_table();
 	if (absolute_percpu)
 		make_percpus_absolute();
 	if (base_relative)
-- 
2.17.1

