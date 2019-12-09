Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1C6C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEBA205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575863563;
	bh=T6eTdZa2KInqaliZcJnFreUxOtLRdpEUkDDuak+e3zs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=q2Y14vR7Pu90tR14lYh5vA1l9o63JMUzwl6g3Z4uVpwyzJAGzQygboh3c0BDB0neL
	 DrrDCgPnRfearLfQ13OTJU8Flq5+qF7ilWZJ0645vhNPsmE/54LiLMDOJ/r7+W8NeA
	 dJXu87BwR3TJ3USLVWCWOl9xT4gczr6jzrWZOPsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLIDwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:52:42 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:21112 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfLIDwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:52:41 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xB93q5xf026282;
        Mon, 9 Dec 2019 12:52:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xB93q5xf026282
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575863526;
        bh=J4iM+2tRSGMAQWxhDFlX1MjDEl1t3wECpLumrWJGNrU=;
        h=From:To:Cc:Subject:Date:From;
        b=xCazK7KFE0CPUrpla9BovDQH4c7OGI7LDzhIWlodaDFyt63a9jWDeMrKIu+WxC5Zy
         TDYCuycPoJzySTgcUtX4tpr9pxQQIeP3e5Wd/sA6xWUY1szc3kKceF55JwfukQ2qd6
         ezeTrMGcg1K+iXJynSUWnoA9B4lRWjFErcDD+TWMM6poxIgwSQgesSVeo90TxyU5fu
         YxlmiFEz2xi2sLZfLiB+OoMZwp4fY/RM2BPg50zNx0BUvNCxwDrNSed1hxwGLeO7so
         YcIS/fEIeE3WTxn41BFeswVI8n34xZJHw6mxjRVFBVfWQIjwPRz9cAhW3xXoMHyzKH
         oiFy9V74or1UA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/kallsyms: fix offset overflow of kallsyms_relative_base
Date:   Mon,  9 Dec 2019 12:51:48 +0900
Message-Id: <20191209035148.17048-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 5e5c4fa78745 ("scripts/kallsyms: shrink table before
sorting it"), kallsyms_relative_base can be larger than _text, which
causes overflow when building the 32-bit kernel.

https://lkml.org/lkml/2019/12/7/156

This is because _text is, unless --all-symbols is specified, now
trimmed from the symbol table before record_relative_base() is called.

Handle the offset signedness also for kallsyms_relative_base. Introduce
a new helper, output_address(), to reduce the code duplication.

Fixes: 5e5c4fa78745 ("scripts/kallsyms: shrink table before sorting it")
Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index fb55f262f42d..94153732ec00 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -310,6 +310,15 @@ static void output_label(const char *label)
 	printf("%s:\n", label);
 }
 
+/* Provide proper symbols relocatability by their '_text' relativeness. */
+static void output_address(unsigned long long addr)
+{
+	if (_text <= addr)
+		printf("\tPTR\t_text + %#llx\n", addr - _text);
+	else
+		printf("\tPTR\t_text - %#llx\n", _text - addr);
+}
+
 /* uncompress a compressed symbol. When this function is called, the best table
  * might still be compressed itself, so the function needs to be recursive */
 static int expand_symbol(const unsigned char *data, int len, char *result)
@@ -360,19 +369,6 @@ static void write_src(void)
 
 	printf("\t.section .rodata, \"a\"\n");
 
-	/* Provide proper symbols relocatability by their relativeness
-	 * to a fixed anchor point in the runtime image, either '_text'
-	 * for absolute address tables, in which case the linker will
-	 * emit the final addresses at build time. Otherwise, use the
-	 * offset relative to the lowest value encountered of all relative
-	 * symbols, and emit non-relocatable fixed offsets that will be fixed
-	 * up at runtime.
-	 *
-	 * The symbol names cannot be used to construct normal symbol
-	 * references as the list of symbols contains symbols that are
-	 * declared static and are private to their .o files.  This prevents
-	 * .tmp_kallsyms.o or any other object from referencing them.
-	 */
 	if (!base_relative)
 		output_label("kallsyms_addresses");
 	else
@@ -380,6 +376,13 @@ static void write_src(void)
 
 	for (i = 0; i < table_cnt; i++) {
 		if (base_relative) {
+			/*
+			 * Use the offset relative to the lowest value
+			 * encountered of all relative symbols, and emit
+			 * non-relocatable fixed offsets that will be fixed
+			 * up at runtime.
+			 */
+
 			long long offset;
 			int overflow;
 
@@ -402,12 +405,7 @@ static void write_src(void)
 			}
 			printf("\t.long\t%#x\n", (int)offset);
 		} else if (!symbol_absolute(&table[i])) {
-			if (_text <= table[i].addr)
-				printf("\tPTR\t_text + %#llx\n",
-					table[i].addr - _text);
-			else
-				printf("\tPTR\t_text - %#llx\n",
-					_text - table[i].addr);
+			output_address(table[i].addr);
 		} else {
 			printf("\tPTR\t%#llx\n", table[i].addr);
 		}
@@ -416,7 +414,7 @@ static void write_src(void)
 
 	if (base_relative) {
 		output_label("kallsyms_relative_base");
-		printf("\tPTR\t_text - %#llx\n", _text - relative_base);
+		output_address(relative_base);
 		printf("\n");
 	}
 
-- 
2.17.1

