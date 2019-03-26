Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7629EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B1220828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xuSrWc+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfCZEDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:03:17 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:30443 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfCZEDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:03:17 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x2Q432PC025839;
        Tue, 26 Mar 2019 13:03:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x2Q432PC025839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553572982;
        bh=oXPMxPTih1gYh2eNNDYBxVlV1zOIAkdO4nQuUMiEzOI=;
        h=From:To:Cc:Subject:Date:From;
        b=xuSrWc+9gLR9RhjkYNCOWWIAhJ98RtZW7GyL8vglMiGz0CFeJFmmH27sGwvxF0MBT
         gWmYbX1RP9Pm3Ajvf7VA64l7YRQZYhSSAXzrBoIflPT4CvDzr5K0wt58ra9Bk748Gv
         vviBH6nLrx5qa8WT/kmY1Whua2DP6KSsR+3wlatSNO/ULLlmBww2yQXcqmbjRXniov
         nXddINu3n4qZH8NBJtWRlT37pUantma9cngGXEvC3KzvSsmetxhJL5UJiP51n5VpWQ
         VhTzM3AZWTNDWeTpO1Gp9sgdg/Z5z2a5IjP/Ph15DN5KIIwQD20V0CtZW3F857e7po
         RfxlVQTXTWgGw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: skip parsing pre sub-make code for recursion
Date:   Tue, 26 Mar 2019 13:02:19 +0900
Message-Id: <1553572939-18940-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Make recurses to the top Makefile with sub-make-done unset,
the code block surrounded by 'ifneq ($(sub-make-done),1) ... endif'
is parsed multiple times. This happens for in-tree building of
include/config/auto.conf, *-pkg, etc. with GNU Make 4.x.

This is a slight regression by commit 688931a5ad4e ("kbuild: skip
sub-make for in-tree build with GNU Make 4.x") in terms of performance
since that code block contains one $(shell ...) invocation.

Fix it by exporting the variable irrespective of sub-make being run.
I renamed it because GNU Make cannot properly export variables
containing hyphens. This is probably a bug of GNU Make, and the issue
in Kbuild had already been reported by commit 2bfbe7881ee0 ("kbuild:
Do not use hyphen in exported variable name").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 41b25b2..5fe5431 100644
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,7 @@ _all:
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
-ifneq ($(sub-make-done),1)
+ifneq ($(sub_make_done),1)
 
 # Do not use make's built-in rules and variables
 # (this increases performance and avoids hard-to-debug behaviour)
@@ -155,6 +155,8 @@ need-sub-make := 1
 $(lastword $(MAKEFILE_LIST)): ;
 endif
 
+export sub_make_done := 1
+
 ifeq ($(need-sub-make),1)
 
 PHONY += $(MAKECMDGOALS) sub-make
@@ -164,12 +166,12 @@ $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
 
 # Invoke a second make in the output directory, passing relevant variables
 sub-make:
-	$(Q)$(MAKE) sub-make-done=1 \
+	$(Q)$(MAKE) \
 	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
 
 endif # need-sub-make
-endif # sub-make-done
+endif # sub_make_done
 
 # We process the rest of the Makefile if this is the final invocation of make
 ifeq ($(need-sub-make),)
-- 
2.7.4

