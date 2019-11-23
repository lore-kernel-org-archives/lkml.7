Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1311C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7671320706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hiCg3yvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKWN2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:51 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39536 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKWN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:00 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkg000733;
        Sat, 23 Nov 2019 22:27:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkg000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515662;
        bh=YReDcxfG08+KN/ys3qrGQn3f4QFwxWEt7XHh/6OsNjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hiCg3yvwtEG/PzPVSGTTU1RZvNrR30Q1AprIKE9IONc8dSnD4iIYhvVJKaj5F6ZiF
         /YThI0c9Vo12j5gg4J1+nnxnHq/AxZyU8ptViG4eQJKrCfSo6Vn9x4MVPndxNYT/u7
         rCsjOiR+98C6dMaNDtFAcCxY8up1TwoY3ktDLGoHenMMreco65ClIQJqxnukZmlpdI
         LX2mF+33j4FicRkzKIL/dXcijupEkxsJrfdl1z7NyES+CVNYHPE7B/eN+sMVxJQsue
         2/svM7js9DjmpU3VIV2WiJpT2zi+naJ6qS6o9OhMZ/a1qX4dY9u8/Rct657kkaMSff
         GykvGVGEB7KZA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] scripts/kallsyms: replace prefix_underscores_count() with strspn()
Date:   Sat, 23 Nov 2019 22:27:18 +0900
Message-Id: <20191123132727.30151-8-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can do equivalent with strspn(). I do not see noticeable performance
difference.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 7b00b4030be4..a007d901c3a5 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -653,16 +653,6 @@ static int may_be_linker_script_provide_symbol(const struct sym_entry *se)
 	return 0;
 }
 
-static int prefix_underscores_count(const char *str)
-{
-	const char *tail = str;
-
-	while (*tail == '_')
-		tail++;
-
-	return tail - str;
-}
-
 static int compare_symbols(const void *a, const void *b)
 {
 	const struct sym_entry *sa;
@@ -691,8 +681,8 @@ static int compare_symbols(const void *a, const void *b)
 		return wa - wb;
 
 	/* sort by the number of prefix underscores */
-	wa = prefix_underscores_count(sym_name(sa));
-	wb = prefix_underscores_count(sym_name(sb));
+	wa = strspn(sym_name(sa), "_");
+	wb = strspn(sym_name(sb), "_");
 	if (wa != wb)
 		return wa - wb;
 
-- 
2.17.1

