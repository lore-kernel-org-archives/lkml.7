Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C533C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AEE20719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NQSJuzMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKWQFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:05:46 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49446 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKWQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:05:01 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xANG4l5Q019106;
        Sun, 24 Nov 2019 01:04:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xANG4l5Q019106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574525092;
        bh=ST5LRkJJeHH7On7Bbq1YlVG0Rs9L/Y4/DythexYfliU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQSJuzMyjfcrZ60At93JKcETtagGnDncoY8ShgTiWSEH3PwcQnMWfM9HSyaIwVt/+
         ooeDAihoomWwymaLfST4PPkx7zou4KtnMlCsbXXM2zjW7IqiPaOG/vKq6mss9QUx8N
         XKaAVfU1tYwz/tEeoR3GCGo5e+L9XS58/uZHwpMtQgQkZ56oWYZkoKZkh2hp6O8m1S
         xkJco+A9rwomJJH0w/zYJ9fCHkk5F0JIIKEvkUs5SKs+ncqYcmtI81PNKWNRHBya65
         j+Xqc0JhhFGsH5m5ozQpRjFDNWHcqgcnSPmhlybii0wLlP9IjGpktiMmORvhk1zex1
         Pnu0KkPAkgcjA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/16] scripts/kallsyms: make find_token() return (unsigned char *)
Date:   Sun, 24 Nov 2019 01:04:37 +0900
Message-Id: <20191123160444.11251-10-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123160444.11251-1-yamada.masahiro@socionext.com>
References: <20191123160444.11251-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers of this function expect (unsigned char *). I do not see
a good reason to make this function return (void *).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/kallsyms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 89cc7c098c51..274a77bfbd63 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -503,7 +503,8 @@ static void build_initial_tok_table(void)
 		learn_symbol(table[i].sym, table[i].len);
 }
 
-static void *find_token(unsigned char *str, int len, unsigned char *token)
+static unsigned char *find_token(unsigned char *str, int len,
+				 unsigned char *token)
 {
 	int i;
 
-- 
2.17.1

