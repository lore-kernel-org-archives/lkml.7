Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FF7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885F8218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dxL2Hgd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfJCKaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:30:01 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:49077 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfJCKaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:30:01 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x93ATIYx014338;
        Thu, 3 Oct 2019 19:29:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x93ATIYx014338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570098561;
        bh=97NLJz+Obv3dJt7wwiAspNiro8fFokgiiEuk+kW1mrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxL2Hgd7ThRlxe/hAyXRFVAIYJ7pIzTmj07XGOoFExkh7GsWFYfB1wqczggmwEWwy
         qnn4C8CgaUrtwnFspwyaj9jvMlZkfB2ocMhSQPdctSHENydAQ/R3q8uCmoECR4eRcP
         CIhcDNel3A8N6ngxz9pa/z4HLLm/uVUKE10iL5V4FWdU3HnVCSYAhhFoQzXbR7UZTa
         FXTvrKcekNT98MvNve0hrlBnSqCQ2PPbjQGuPIXkChdzLhjDQ4VzsZBoYdOWPtZyPM
         vcqYKF+eQyzuj6L2G8DhVQXev7LI2D2mOCH0Zglx8cdU/g9n2Js1gqz74zWV8KL5qS
         YrZv51rQxHpag==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] modpost: do not set ->preloaded for symbols from Module.symvers
Date:   Thu,  3 Oct 2019 19:29:15 +0900
Message-Id: <20191003102915.28301-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003102915.28301-1-yamada.masahiro@socionext.com>
References: <20191003102915.28301-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is no overwrap between symbols from ELF files and
ones from Module.symvers.

So, the 'exported twice' warning should be reported irrespective
of where the symbol in question came from. Only the exceptional case
is when __crc_<sym> symbol appears before __ksymtab_<sym>. This
typically occurs for EXPORT_SYMBOL in .S files.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5234555cf550..6ca38d10efc5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2457,7 +2457,6 @@ static void read_dump(const char *fname, unsigned int kernel)
 		s = sym_add_exported(symname, namespace, mod,
 				     export_no(export));
 		s->kernel    = kernel;
-		s->preloaded = 1;
 		s->is_static = 0;
 		sym_update_crc(symname, mod, crc, export_no(export));
 	}
-- 
2.17.1

