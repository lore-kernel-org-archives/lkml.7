Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B44C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A95B22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1gLNEnEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfHURd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:33:27 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:47224 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfHURd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:33:26 -0400
Received: from grover.flets-west.jp (softbank126125143222.bbtec.net [126.125.143.222]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7LHXN4w001231;
        Thu, 22 Aug 2019 02:33:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7LHXN4w001231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566408803;
        bh=FWLOsLMyG8SdF1ynX91dJ+VEXKsmHh2Dx8rMCw1Xm3g=;
        h=From:To:Cc:Subject:Date:From;
        b=1gLNEnEYFhano6qbx1pMFBihVEp8LVQqQVKeLlZlm0bHtOI/1Hpn8pPvaQtVicSeC
         xxruAa0M0ZBG5XhrpWmzgGp7dA5bBKf6xSJVquT4TmZUuiI3eJ7pneYwDldVt5qdfx
         EcW52BVox9fOOSbqs6jnJJYZ35oaPelyPexpk3bFTMrx2X1fER3K3VVR0BQe6AEDYz
         LXuCjJ98ruXyHPlUeDajNWsrDX28zmBQC5o0FBE8wwkjg5CqDXTqAEvAUhRu4qCOIi
         E7IYpN+PwKNk3tvm2GceeWyOw9QkM7hRZDR9RufxHboZO7FFB1aNUpiDwS1r6WQiiB
         Q0jfK+uDC4U3g==
X-Nifty-SrcIP: [126.125.143.222]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unneeded dependency for $(DOC_TARGETS)
Date:   Thu, 22 Aug 2019 02:33:21 +0900
Message-Id: <20190821173321.15012-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 415008af3219 ("docs-rst: convert lsm from DocBook to ReST")
stopped using if_changed_rule. No more users of if_changed* for the
doc targets. Hence, fixdep is unneeded. Remove the dependency on
scripts_basic.

All the doc targets are phony. Depending on FORCE is odd.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c0be1a4dbfdd..7e54a821b4b0 100644
--- a/Makefile
+++ b/Makefile
@@ -1578,7 +1578,7 @@ $(help-board-dirs): help-%:
 DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
 	       linkcheckdocs dochelp refcheckdocs
 PHONY += $(DOC_TARGETS)
-$(DOC_TARGETS): scripts_basic FORCE
+$(DOC_TARGETS):
 	$(Q)$(MAKE) $(build)=Documentation $@
 
 # Misc
-- 
2.17.1

