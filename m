Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A65CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B7F205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="c2L2108s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfCDO1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:27:35 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:46398 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfCDO1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:27:35 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x24ERMeU012127;
        Mon, 4 Mar 2019 23:27:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x24ERMeU012127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551709643;
        bh=zuByr7KXlgH+8cYVUqgkSJdiXjub6312Zq4WsgHZgSM=;
        h=From:To:Cc:Subject:Date:From;
        b=c2L2108shYCZcg3iXZ7vqHOVmwg3bDPefFhrgL1FPqblHwrsYEjS4VxgbDRKJ5H1m
         QW90y41ZFTCbd58Lv2n83j+IwHXVo+SolJe26rndklK2ZOPT5AOU5IBtuqYY5vj5Wx
         izxTdRxXZmpQI3Qb7ym9bhG2fdEW6HSR6sq3OKueEjyf+VgxbDZSsym2gx3y4Q1Fiy
         2vSvN1bonDfRK8fB11cyucneNYK5gU/8mxbaMTmXqLuRTGGJymChpWdv8grlA4i2qM
         OG4dcZbo954LPSZmSspGJFkkOk9ozM9vqjl9xTFQwGiv7zMNNE1g6ZRUC/esRV8aPl
         Vai1wr4lmoMtQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove build target scripts/basic/%
Date:   Mon,  4 Mar 2019 23:27:19 +0900
Message-Id: <1551709639-14681-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This build rule was introduced by commit cd05e6bdc600 ("[PATCH]
kbuild: fix split-include dependency") to handle the dependency of
scripts/basic/split-include.

Now, fixdep is the only tool in scripts/basic/, and this rule is
no longer used.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index ade8709..cfb49aa 100644
--- a/Makefile
+++ b/Makefile
@@ -477,9 +477,6 @@ scripts_basic:
 	$(Q)$(MAKE) $(build)=scripts/basic
 	$(Q)rm -f .tmp_quiet_recordmcount
 
-# To avoid any implicit rule to kick in, define an empty command.
-scripts/basic/%: scripts_basic ;
-
 PHONY += outputmakefile
 # outputmakefile generates a Makefile in the output directory, if using a
 # separate output directory. This allows convenient use of make in the
-- 
2.7.4

