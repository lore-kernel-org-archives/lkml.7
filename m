Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9EFC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D4B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SeHvLBy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbfG3P7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:59:18 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:60066 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfG3P7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:59:14 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x6UFx3RY014915;
        Wed, 31 Jul 2019 00:59:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x6UFx3RY014915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564502344;
        bh=tmS7rnSw2i0wnICGgr8MtsDLTrDE/y5htkc0RewVGsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=SeHvLBy8UxNSSmSxw57UopL/v+/sDXCLCt5mURKX9QxblCFwEtObGcYs6AqFyWRae
         CQFOKPlz2LDf2LGVNZpY1vPVq5k5/r3rbWY6hR3+iVRPBJfn9lT+MV2AxbOo9L4+a6
         TEOg6HC/Qqd/bh8PhpM7UbwTclEpieW4lRQn4KlckotzuDiqNStImwH4HrQIGSLxk1
         58eIF1eqpAJ7qYM39BGpzRhVfkm75fltGTDCVc2fUIoZSs6EdFqDQK0KKlCcPpzM5w
         Iz8KZjhg3iXh8CpNY6pED7y2ZtyyGwTgZh1o2qP9mFFMHXzP7JPDBZsnY+rpZmdBs3
         CE7aY0cjYfpMA==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        stable@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 1/4] kbuild: modpost: include .*.cmd files only when targets exist
Date:   Wed, 31 Jul 2019 00:58:59 +0900
Message-Id: <20190730155902.5557-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A build rule fails, the .DELETE_ON_ERROR special target removes the
target, but does nothing for the .*.cmd file, which might be corrupted.
So, .*.cmd files should be included only when the corresponding targets
exist.

Commit 392885ee82d3 ("kbuild: let fixdep directly write to .*.cmd
files") missed to fix up this file.

Fixes: 392885ee82d3 ("kbuild: let fixdep directly write to .*.cmd")
Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.modpost | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 6b19c1a4eae5..ad4b9829a456 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -145,10 +145,8 @@ FORCE:
 # optimization, we don't need to read them if the target does not
 # exist, we will rebuild anyway in that case.
 
-cmd_files := $(wildcard $(foreach f,$(sort $(targets)),$(dir $(f)).$(notdir $(f)).cmd))
+existing-targets := $(wildcard $(sort $(targets)))
 
-ifneq ($(cmd_files),)
-  include $(cmd_files)
-endif
+-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
 
 .PHONY: $(PHONY)
-- 
2.17.1

