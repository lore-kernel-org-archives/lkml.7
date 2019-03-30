Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C431EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A746217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GUqfKCXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfC3ME3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:04:29 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:36041 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbfC3ME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 08:04:28 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x2UC4MsN021262;
        Sat, 30 Mar 2019 21:04:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x2UC4MsN021262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553947463;
        bh=FHNK6eyXi8sis+WrpzX624MLFcG4c9ZDVhLL5yNCvIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GUqfKCXumTTXXHmrKSXNdkpjrlJBkG7x90UZEWrqZMCQNCrtFkZk8Cz5dxb1s0Csh
         8DipHMZQ489U4bhE3BpLDCw3WfVHlzVFpntsxDOteSnrxM71lOkTggMPon8i9Y4kjL
         qbsqlGOnIhkPjP9uJvOwAOxQ4fjtOWEj0z0L1bLv2kvgYINVJf/5hpt/5TYNZIILoM
         c5swsIQFgUzBLDUiUtDQyNASRey+brKS6sQyU21BttCyOE5LVHpI/9UKKw0NcetzvG
         AAPlnGxpUqrSKGblny+79Kb8XPRMhr9RLWd6kkzhFZpOycEOO9Zz+Kaf02AsWDEt+t
         tuRk5sUmYOY3Q==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] kbuild: pass $(MAKECMDGOALS) to sub-make as is
Date:   Sat, 30 Mar 2019 21:04:13 +0900
Message-Id: <1553947458-8311-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manipulating $(MAKECMDGOALS) for sub-make seems odd to me.

[1] 'make O=foo sub-make' is turned into 'make O=foo', which builds
the default targets. It would make sense to terminate the build with:

  *** No rule to make target 'sub-make'.  Stop.

[2] 'make O=foo defconfig _all' is turned into 'make O=foo defconfig',
which changes the behavior.

Let's pass $(MAKECMDGOALS) as is.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 92ad066..9cbd367 100644
--- a/Makefile
+++ b/Makefile
@@ -168,7 +168,7 @@ $(filter-out _all sub-make $(lastword $(MAKEFILE_LIST)), $(MAKECMDGOALS)) _all:
 sub-make:
 	$(Q)$(MAKE) \
 	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
-	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
+	-f $(CURDIR)/Makefile $(MAKECMDGOALS)
 
 endif # need-sub-make
 endif # sub_make_done
-- 
2.7.4

