Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD0C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7BC20706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oxh5mWc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKWN2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:03 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39549 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfKWN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:00 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbke000733;
        Sat, 23 Nov 2019 22:27:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbke000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515661;
        bh=X/uShYh5Ocw7jutbX526YPdGr8N3XPBBqlaV1xcxg9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxh5mWc96I+dx8zaiAIm+RHL7+53qCiLu2kJsIbZgwwZGEI5K21EwDRaod0Rvdxu1
         i+714hNlRZrZW5gmzETRL/Ganlpv5XqVthtjwXxZpQ8BXrg1cLnT0a1JZMNNK9Apb0
         Ua6x2CSif+fVJ+IEJ2jmWFt5J8fx1jTmSYG/OT/HXEKcctl4GWAfzZacfiB5b2Z/Rv
         6H/Rhx2ydHc1clJEFyTnheUF46FAHcKguzHV5m6zdxvgK0fIscT81vvHDYshWQwQiw
         4h2MfWHf2jd5y6vv/5u3Iop7azUbqj8DqEsxihkaQPCBL+inIbBPVaPTwOFVCkxuKF
         Jwd/J43AiTqPA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/16] scripts/kallsyms: remove unneeded length check for prefix matching
Date:   Sat, 23 Nov 2019 22:27:16 +0900
Message-Id: <20191123132727.30151-6-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

l <= strlen(sym_name) is unnecessary for prefix matching.
strncmp() will do.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 265475d3cffb..d06f373b3a96 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -246,8 +246,7 @@ static int symbol_valid(struct sym_entry *s)
 	for (i = 0; special_prefixes[i]; i++) {
 		int l = strlen(special_prefixes[i]);
 
-		if (l <= strlen(sym_name) &&
-		    strncmp(sym_name, special_prefixes[i], l) == 0)
+		if (strncmp(sym_name, special_prefixes[i], l) == 0)
 			return 0;
 	}
 
-- 
2.17.1

