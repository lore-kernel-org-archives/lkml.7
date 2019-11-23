Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD68C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A342071B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VwmXuzPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKWQFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:05:03 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49445 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKWQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:05:01 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xANG4l5P019106;
        Sun, 24 Nov 2019 01:04:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xANG4l5P019106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574525091;
        bh=5lggXg5IEg7tnVaBbwPVhFClDCwiRJJs4nnaP/eGSlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwmXuzPhD1uessmiV+Ruu8F6Y+D7MZ687YsdNBGIvHKg70mg4Cx3SfLSORXOhsTJv
         Xt6pGQ9lYlHZ0xdSJx03kM/pNj/PFozWAbmMrXm9S+lnwRAsDv4jHBoFj1YFjeCbto
         i/1MPAf1c4xLkNrE+HzM78xumNwG+c3Fo5UjVLZkTojpicyMZ5nZ9P/bGCknI05A6H
         qPkuQ6oNJTO0J6Q6kXy2/5IVMwM0Uai2H6LxNdL4D2WsQm6MdCgEqN4D3rV2uCRH3w
         N1MEH7SSDC7WI+BqjqZ7c49dYRM9Eevk3iPhm+V28EWvBQjbIVzBTEo0FcMOsHntDI
         dUS9rNz6/YCdw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/16] scripts/kallsyms: replace prefix_underscores_count() with strspn()
Date:   Sun, 24 Nov 2019 01:04:36 +0900
Message-Id: <20191123160444.11251-9-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123160444.11251-1-yamada.masahiro@socionext.com>
References: <20191123160444.11251-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can do equivalent things with strspn(). I do not see noticeable
performance difference.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/kallsyms.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index baa2fa5692b0..89cc7c098c51 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -661,16 +661,6 @@ static int may_be_linker_script_provide_symbol(const struct sym_entry *se)
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
@@ -699,8 +689,8 @@ static int compare_symbols(const void *a, const void *b)
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

