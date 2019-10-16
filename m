Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA1ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837FB2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hllW+l4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfJPFMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 01:12:24 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:21144 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfJPFMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:12:24 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x9G5CHcw024780;
        Wed, 16 Oct 2019 14:12:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x9G5CHcw024780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571202738;
        bh=XGGz+xUjWyeDryYMzH89z2BDTzgeTfKQG2Zjpz7zMVk=;
        h=From:To:Cc:Subject:Date:From;
        b=hllW+l4i9OYVhKIeZPqDCMgxTo74hUY/fyzsgBlu8CUf2QqQlKms51NLnil4QFHkO
         bH9hGtjzFqcFq+Y6EC4kchdV20uOw8+rm+xkf0mBmsMUjOSbXTfI7y3p/N6MSa9vCT
         p3W3A1CO7McrGmo7ciDob7v0lEFNjuaU2qUtENVY4qSsaI76oqjatiltSUl6xr27ug
         9qihZawfftptA2r1FIbhIjV0e4AXstV3+V0zx1pvvaFwzi5APyLnxeG1ymyH8s6eGx
         yeR+EFVWBrbARx6BDnp2fzn/I4Pu2CHvM3+xGiPuaHtSDvR/4dmI5Mdn32d6zjCUkD
         3NdzseBTSd0rA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unneeded variable, single-all
Date:   Wed, 16 Oct 2019 14:12:15 +0900
Message-Id: <20191016051215.10909-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When single-build is set, everything in $(MAKECMDGOALS) is a single
target. You can use $(MAKECMDGOALS) to list out the single targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ffd7a912fc46..710199f60c30 100644
--- a/Makefile
+++ b/Makefile
@@ -1764,11 +1764,9 @@ tools/%: FORCE
 
 ifdef single-build
 
-single-all := $(filter $(single-targets), $(MAKECMDGOALS))
-
 # .ko is special because modpost is needed
-single-ko := $(sort $(filter %.ko, $(single-all)))
-single-no-ko := $(sort $(patsubst %.ko,%.mod, $(single-all)))
+single-ko := $(sort $(filter %.ko, $(MAKECMDGOALS)))
+single-no-ko := $(sort $(patsubst %.ko,%.mod, $(MAKECMDGOALS)))
 
 $(single-ko): single_modpost
 	@:
-- 
2.17.1

