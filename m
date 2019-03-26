Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50661C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B933A2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jY03Xhum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfCZGqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:46:50 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:34210 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbfCZGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:43 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x2Q6WIMv022574;
        Tue, 26 Mar 2019 15:32:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x2Q6WIMv022574
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553581938;
        bh=H2NatzQB9WaXUPrKwAF3g9dVX3FEcZkArZ+BAwTDODg=;
        h=From:To:Cc:Subject:Date:From;
        b=jY03Xhum4/kqgmyHcyGk9bZ1XtOPc10eVoPZW4JDjph20GWq6VzxVPYzSJctIFdRQ
         UIXHfdB4hmPJCxtHI+ifIkuSuUVLJ3mmU1ab7Kqz1WxxXxgykH9ADG6Iflgb85JPrm
         NBts5k4UTiOkI3PpuWE5BeWyqwAZc1fpNos3ulTNLJ4aidZUMwwA6EsYbfvPny+Wut
         nAPtOy1eG9gTJNaCmXBliIhYk/i/58ALM7pvXEgX2onRP6DgCdDGBoqHt6Fp27qStf
         rabO7u3IN3P6jRtCrwicbAYCQhB0Fts6jkT14TgdTllxs0h0z9B8qNF8dD4KS+2TcW
         oZFxjmMi8H4EQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix warning "overriding recipe for target 'Makefile'"
Date:   Tue, 26 Mar 2019 15:32:16 +0900
Message-Id: <1553581936-6476-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you do "make Makefile" with GNU Make 3.x, the following warning
is displayed:

  $ make Makefile
  Makefile:165: warning: overriding recipe for target 'Makefile'
  Makefile:51: warning: ignoring old recipe for target 'Makefile'
  make[1]: Nothing to be done for 'Makefile'.
  make: Nothing to be done for 'Makefile'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 70fc778..1b361bd 100644
--- a/Makefile
+++ b/Makefile
@@ -161,7 +161,7 @@ ifeq ($(need-sub-make),1)
 
 PHONY += $(MAKECMDGOALS) sub-make
 
-$(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
+$(filter-out _all sub-make $(lastword $(MAKEFILE_LIST)), $(MAKECMDGOALS)) _all: sub-make
 	@:
 
 # Invoke a second make in the output directory, passing relevant variables
-- 
2.7.4

