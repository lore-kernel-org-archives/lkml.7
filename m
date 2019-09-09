Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2936C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A7821924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CE+ErZ08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404184AbfIILjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:39:23 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:20811 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404163AbfIILjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:39:23 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x89BdDLv014382;
        Mon, 9 Sep 2019 20:39:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x89BdDLv014382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568029153;
        bh=OT0rnJF7dq+ePoqnTB+VvCbR+w2qZCS92xCRxsoGZeM=;
        h=From:To:Cc:Subject:Date:From;
        b=CE+ErZ08u+H/63niCo518H1RrRIMPHzxKVtsaOhSeBwqAtFm9YeoXOekM5pfjgk1b
         aIrJyDEXbknTlSH0+dhr57MFJGiqDCSL+JXO6mMdvTl8SpANyIDmaVxixoPsielUvp
         LGxM5xrcsDAb0cd4joZkIXNYtBJnDfPIJ6hqEAFX0quzwIJBNsZb2D27XtrnvSdTgs
         BrFARt5ugIEx5pCRGp+xW4hma0VNACQRVHsYxKpnm29l7bY3EI0kpUp4PEg42pPysR
         TI3Kr1bOrmIu6fJOvOe069UeYv1hXaYL7IfBmQsQH5WNhkpFqezDBowo1LElJ9EB+H
         MC5qEzaZfLYSA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: remove unneeded casts in cmp_name()
Date:   Mon,  9 Sep 2019 20:39:02 +0900
Message-Id: <20190909113902.3096-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can pass opaque pointers directly.

I also renamed 'va' and 'vb' into more meaningful arguments.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 kernel/module.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 62e49ead0237..a2db612d039e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -544,12 +544,9 @@ static const char *kernel_symbol_name(const struct kernel_symbol *sym)
 #endif
 }
 
-static int cmp_name(const void *va, const void *vb)
+static int cmp_name(const void *name, const void *sym)
 {
-	const char *a;
-	const struct kernel_symbol *b;
-	a = va; b = vb;
-	return strcmp(a, kernel_symbol_name(b));
+	return strcmp(name, kernel_symbol_name(sym));
 }
 
 static bool find_exported_symbol_in_section(const struct symsearch *syms,
-- 
2.17.1

