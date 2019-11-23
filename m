Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CBCC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB52620706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jze3904v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKWN2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:05 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39548 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKWN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:01 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkm000733;
        Sat, 23 Nov 2019 22:27:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkm000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515665;
        bh=GdWZ/Oaov377i0Vjzbhs1TEelv4AZ1oW6iHWPykbggE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jze3904vfDeLn5mblmlhroba0/JIdGcDdE1OoMG4Abr+vKKLGA+UPQ9QthOo4a+Ru
         VSKuxbQLs4SIewdIZcnAwU/ZSGOGeQm+91fa4UXTQO4JoS00dN1WkJImk/9/VkaAam
         B8y+xlYSTjb1if2pesUPLk/rTvZRwpEpfK9ezaxco4BqFSLC/4uk5X2LEgLubbaeHH
         dhe7hZ/lg59fL/VjkpkQcP6wZfQKTKp2UFLTbHrNw9hjHPGl9mDCsE5an3hAW/AlAl
         NcNYNJyQPYy+jYO09igX4CFgE9+nmRoZpi2BUwAKto3tcN4PLcxBhQ6ZHzGxC4hUqZ
         dxkVXFRt3yZ+Q==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/16] scripts/kallsyms: make check_symbol_range() void function
Date:   Sat, 23 Nov 2019 22:27:24 +0900
Message-Id: <20191123132727.30151-14-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no more reason to check the return value of
check_symbol_range().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 21f4d347f371..144f43363c4d 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -155,8 +155,8 @@ static bool is_ignored_symbol(const char *name, char type)
 	return false;
 }
 
-static int check_symbol_range(const char *sym, unsigned long long addr,
-			      struct addr_range *ranges, int entries)
+static void check_symbol_range(const char *sym, unsigned long long addr,
+			       struct addr_range *ranges, int entries)
 {
 	size_t i;
 	struct addr_range *ar;
@@ -166,14 +166,12 @@ static int check_symbol_range(const char *sym, unsigned long long addr,
 
 		if (strcmp(sym, ar->start_sym) == 0) {
 			ar->start = addr;
-			return 0;
+			return;
 		} else if (strcmp(sym, ar->end_sym) == 0) {
 			ar->end = addr;
-			return 0;
+			return;
 		}
 	}
-
-	return 1;
 }
 
 static int read_symbol(FILE *in, struct sym_entry *s)
@@ -200,9 +198,8 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 	/* Ignore most absolute/undefined (?) symbols. */
 	if (strcmp(sym, "_text") == 0)
 		_text = s->addr;
-	else if (check_symbol_range(sym, s->addr, text_ranges,
-				    ARRAY_SIZE(text_ranges)) == 0)
-		/* nothing to do */;
+
+	check_symbol_range(sym, s->addr, text_ranges, ARRAY_SIZE(text_ranges));
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
-- 
2.17.1

