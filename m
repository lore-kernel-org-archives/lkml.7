Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92460C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6411F2465E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576556108;
	bh=gixdtZYQbYephnc08CdCIjqGTf2Z8q/HgtYJ8MHYVts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hTE0ru/ejMg/qSeR6+13CR+jctrHqqlOXko0coUHcU7ftyu73Jxzp9k3UvJdqYtnb
	 EwywAxHbhehFmLyh2o+nWd3bWPf3XZCHqH5xsazu8ERK20Dj7tgu5jBPzUEQ2Fkf1h
	 h+GolhvwrjCy08JNegVNHfYFgEqqfi8m5JW+cT2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfLQEPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:15:05 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49413 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfLQEOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:14:51 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xBH4EPAD024524;
        Tue, 17 Dec 2019 13:14:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xBH4EPAD024524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576556068;
        bh=+kyEsSfRk7GZ3DX/TzRbKlttag60tm9I4S84+8zbCx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8/BMaAZF29OOEhNNdaOjKpveXoD5EoyJM+CzsYHyOoYmlhoC6UdcPMeJ+1w3cDwo
         JjzR1NijZBBFs8L1nq9jqrAeP/PFqtuyHAaWKij+Z/agoA6U60NYkEkeYKgrvrpuWP
         wxxjzxJpNzgXRp1cUuA7L0SLCWxk1hDDhZZnAwTfHErNTplVYvFvOa2c9qqNKrx5PR
         81shUntBrtoJdJZEdQ8OP42JN0AD6X54MMxKtFQRfcKcM92xUMlWsnrx3RUZkuVe5G
         lJ/yzeOx3HbcLLV431gT0JHX+ifAk4xEqVLVr8+KkpB9GV9vmrPSYTQ5myFwNF4214
         wmSVHHnuYdIkg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] kconfig: drop T_WORD from the RHS of 'prompt' symbol
Date:   Tue, 17 Dec 2019 13:14:18 +0900
Message-Id: <20191217041424.29285-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217041424.29285-1-masahiroy@kernel.org>
References: <20191217041424.29285-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8636a1f9677d ("treewide: surround Kconfig file paths with double
quotes") killed use-cases to reduce an unquoted string into the 'prompt'
symbol.

Kconfig still allows to use an unquoted string in the context of menu,
source, or prompt.

So, you can omit quoting if the prompt is a single word:

    bool foo

..., but I do not think this is so useful.

Let's require quoting:

    bool "foo"

All the Kconfig files in the kernel are written in this way.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/parser.y | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 86e75ea74731..80585f04f590 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -445,9 +445,7 @@ prompt_stmt_opt:
 	menu_add_prompt(P_PROMPT, $1, $2);
 };
 
-prompt:	  T_WORD
-	| T_WORD_QUOTE
-;
+prompt:	  T_WORD_QUOTE
 
 end:	  T_ENDMENU T_EOL	{ $$ = "menu"; }
 	| T_ENDCHOICE T_EOL	{ $$ = "choice"; current_choice_menu = NULL; }
-- 
2.17.1

