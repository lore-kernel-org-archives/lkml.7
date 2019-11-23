Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F3DC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B2F204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IBzj/6q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfKWN2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:52 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39535 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKWN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:00 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkh000733;
        Sat, 23 Nov 2019 22:27:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkh000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515662;
        bh=yRF2y3vF9C7Zci91xsHHxMzbjmKu+VkByjExrmElrLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBzj/6q7RtiAFwtZwDOxwgbmWOQJxTLhfJ/YpLZW8YexI1LOIFB8mmvB17aYxaoLf
         XEinzqXo9GkOUyfQmjUPSSj8PgbjlS9pt8GuXQdl02fsGxZATqidDHd+B6nTBxTKfH
         3f2iTj/f4GPfMfvUi5YnurpMNdsriOPx830y+Hysphf19Z1LcTL6UO19y+IAmPXA5C
         zFNdcDVFspXn9IrR7KLIuukkRjf9FGYNj0WmN5vupnviOFnaNZUho5tVDRrMIk0Bfy
         2mqdQ2Htlvsn542ufSmpmYeSHRiZ1MBbYhA82VJvwJHM0UUJlmiRKSIaNQUvgxJTPp
         qM1oejpG0s14A==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] scripts/kallsyms: make find_token() return (unsigned char *)
Date:   Sat, 23 Nov 2019 22:27:19 +0900
Message-Id: <20191123132727.30151-9-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers of this function expect (unsigned char *). I do not see
a good reason to make this function return (void *).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index a007d901c3a5..c4f7f20ecfb7 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -489,7 +489,8 @@ static void build_initial_tok_table(void)
 	table_cnt = pos;
 }
 
-static void *find_token(unsigned char *str, int len, unsigned char *token)
+static unsigned char *find_token(unsigned char *str, int len,
+				 unsigned char *token)
 {
 	int i;
 
-- 
2.17.1

