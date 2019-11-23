Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD0C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793E32071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GvWKc7iJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKWN2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:08 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39586 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfKWN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:01 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkl000733;
        Sat, 23 Nov 2019 22:27:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkl000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515664;
        bh=hAJ9FDYVP0u9Ii/HSaYqoI2vQAxjSnoxdt8vCxrWv6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvWKc7iJn6Qg4qrKwA8rfc9kTqAI7pL7QFgTbtm54DfJ+sod3xnhO8l0Pmz7DiBUl
         6FLfKsWxbGVLfyM1T05TTBWUgRu5lHE8zwcoplElM/HTJ6mLg+cPV/ZHKA4fJupevx
         k6KKCJ04Z1yLYL8eRiib6wNze/sWtTh/Qw2wGzqte45EQbVbA0ggVzd0GmeyW8SLtc
         mFwR9c47u3KfB9VG3jDk0E9OsPiCmFqsArNozuxw0NHmR3M94Y4mS0huqsTxxDKNNL
         nC2M4CkjVLJZ6kZ0RloUHvhv0Wgm/kTMSQDIbiExvSsoSkPl3dts5fHzCGCwelPefG
         lTtERlJWbZN/g==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] scripts/kallsyms: move ignored symbol types to is_ignored_symbol()
Date:   Sat, 23 Nov 2019 22:27:23 +0900
Message-Id: <20191123132727.30151-13-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect the ignored patterns to is_ignored_symbol().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 63473924d4de..21f4d347f371 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -137,6 +137,21 @@ static bool is_ignored_symbol(const char *name, char type)
 			return true;
 	}
 
+	if (type == 'U' || type == 'u')
+		return true;
+	/* exclude debugging symbols */
+	if (type == 'N' || type == 'n')
+		return true;
+
+	if (toupper(type) == 'A') {
+		/* Keep these useful absolute symbols */
+		if (strcmp(name, "__kernel_syscall_via_break") &&
+		    strcmp(name, "__kernel_syscall_via_epc") &&
+		    strcmp(name, "__kernel_sigtramp") &&
+		    strcmp(name, "__gp"))
+			return true;
+	}
+
 	return false;
 }
 
@@ -188,21 +203,6 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 	else if (check_symbol_range(sym, s->addr, text_ranges,
 				    ARRAY_SIZE(text_ranges)) == 0)
 		/* nothing to do */;
-	else if (toupper(stype) == 'A')
-	{
-		/* Keep these useful absolute symbols */
-		if (strcmp(sym, "__kernel_syscall_via_break") &&
-		    strcmp(sym, "__kernel_syscall_via_epc") &&
-		    strcmp(sym, "__kernel_sigtramp") &&
-		    strcmp(sym, "__gp"))
-			return -1;
-
-	}
-	else if (toupper(stype) == 'U')
-		return -1;
-	/* exclude debugging symbols */
-	else if (stype == 'N' || stype == 'n')
-		return -1;
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
-- 
2.17.1

