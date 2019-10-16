Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D7BECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F001220873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dD5ADPdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfJPFRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 01:17:08 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:16529 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfJPFRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:17:08 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x9G5FoQ3015921;
        Wed, 16 Oct 2019 14:15:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x9G5FoQ3015921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571202951;
        bh=7esRt800qRlkwyQ3paFYTyNUrseNp3QJ3LafPyce9PM=;
        h=From:To:Cc:Subject:Date:From;
        b=dD5ADPdMZFPpOjl0GTtVKjMRhAvvnHLxO0n78B3/rdszRxgz6FtAf+zFVVCM63bg3
         dEZwXv04YqdVFw7xkAzoyomMUwHwOcVo0I8imT8ZVEtsUsCMekaS23SVaIC8aY+L+n
         25LugesoShcNpDNyw525EwYAJ5OsE9LagO5oxzGxXXXqqWShkLa6KSdrhBuDgHgV6y
         fipLPoAOxmNPwBzjRZidnWVlThfWG2xyqtZFdS/H9+XliqV9LUGntIqWeQ5Fq01exI
         QPl9sK90ctqR5VxS1+qc35mzhkp3nxa7iw63wDGm1SOk5E+K99oiV35As3PDKVt+GA
         cXX0MsSPmzmFQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: reduce KBUILD_SINGLE_TARGETS as descending into subdirectories
Date:   Wed, 16 Oct 2019 14:15:46 +0900
Message-Id: <20191016051547.11399-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KBUILD_SINGLE_TARGETS does not need to contain all the targets.
Change it to keep track the targets only from the current directory
and its subdirectories.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a9e47953ca53..dcbb0124dac4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -469,15 +469,15 @@ targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
 
 ifdef single-build
 
+KBUILD_SINGLE_TARGETS := $(filter $(obj)/%, $(KBUILD_SINGLE_TARGETS))
+
 curdir-single := $(sort $(foreach x, $(KBUILD_SINGLE_TARGETS), \
 			$(if $(filter $(x) $(basename $(x)).o, $(targets)), $(x))))
 
 # Handle single targets without any rule: show "Nothing to be done for ..." or
 # "No rule to make target ..." depending on whether the target exists.
 unknown-single := $(filter-out $(addsuffix /%, $(subdir-ym)), \
-			$(filter $(obj)/%, \
-				$(filter-out $(curdir-single), \
-					$(KBUILD_SINGLE_TARGETS))))
+			$(filter-out $(curdir-single), $(KBUILD_SINGLE_TARGETS)))
 
 __build: $(curdir-single) $(subdir-ym)
 ifneq ($(unknown-single),)
-- 
2.17.1

