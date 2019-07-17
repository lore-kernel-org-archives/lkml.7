Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC7FC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E892C20818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Pv+5ZlUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGQGS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:18:29 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62970 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGQGS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:18:26 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6H6I5Oi009435;
        Wed, 17 Jul 2019 15:18:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6H6I5Oi009435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563344290;
        bh=NThCfRRReemUKwHcPVaeEGel1SdY7KDk5R0W8YGBelE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pv+5ZlUvWSf7GBEtyBfu9nBNVMty9Qf4wBQSYHkJE7ZwK3gcEYl7hjwG3KzuxNU2M
         rzzw31wyA1wR97Ce+lley7A8pyU2m2TVFdX9WwLfWUjYTCanT4mlCcxkms8YS/j350
         ZN9lVBjr0qG23nN6yiIkZstX7OAXLHcOrg9hXHhq6imK8EnxPEPpGfQtCkCaddaprm
         XGPknsCX6GeMD/OHA2id8kOebLfi/wmdhtlRm4cKFxAlu1vLuw6NKRa7B5bwSVckoT
         cs0Qp6+F9iKorbMg4rHBkAomHZLDMmTADN6FeUm7en4fdzxDIOhKc2foaB18VXwTrj
         BDRGHBAvX6QNQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/12] kbuild: modsign: read modules.order instead of $(MODVERDIR)/*.mod
Date:   Wed, 17 Jul 2019 15:17:54 +0900
Message-Id: <20190717061800.10018-7-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717061800.10018-1-yamada.masahiro@socionext.com>
References: <20190717061800.10018-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Towards the goal of removing MODVERDIR, read out modules.order to get
the list of modules to be signed. This is simpler than parsing *.mod
files in $(MODVERDIR).

The modules_sign target is only supported for in-kernel modules.
So, this commit does not take care of external modules.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 scripts/Makefile.modsign | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Makefile.modsign b/scripts/Makefile.modsign
index da56aa78d245..d7325cefe709 100644
--- a/scripts/Makefile.modsign
+++ b/scripts/Makefile.modsign
@@ -8,8 +8,7 @@ __modsign:
 
 include scripts/Kbuild.include
 
-__modules := $(sort $(shell grep -h '\.ko$$' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
-modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
+modules := $(sort $(shell cat modules.order))
 
 PHONY += $(modules)
 __modsign: $(modules)
-- 
2.17.1

