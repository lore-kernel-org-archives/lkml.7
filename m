Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8453C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A225920854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dSKzYeBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfCSEDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 00:03:02 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:42725 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCSEDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 00:03:01 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x2J42e7u015125;
        Tue, 19 Mar 2019 13:02:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x2J42e7u015125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552968160;
        bh=O7MKbJr07lS9T3YK/shIxpPzOPu2EAAVm1smdUcASdI=;
        h=From:To:Cc:Subject:Date:From;
        b=dSKzYeBrbfEHDIILLh/qbP2cnACyREOIi+7Rd5Tes1YCpC/wu7ENUOig3dhxlnLNS
         SFSVopG/mkFkkyxcm22TYmTsaDt8w14s93uMhffsUgac0EeSHCPMTDQTdeyD4WNfze
         BxEELtTJ95611wpBiSCP221i8qx+WkQdkPG6GOmm+mgdrmfaPGuTuKVi/dcf4G5wxH
         JPOefhrXG3IcbUbC8hQUvsVyq5G9LjlBGgZ8SxLb9ZP0xswYc8kfB56vhGVQ1gB5W4
         0TcoHT3T4UTjV+O9fyvRCkQbdUxv/THTL2+bdlx9fdZXtiZz9WtErsS/GK4ICU5Dwa
         Uz7Jk0Ryzg9kw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Andreas Schwab <schwab@suse.de>,
        David Howells <dhowells@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: skip sub-make for in-tree build with GNU Make 4.x
Date:   Tue, 19 Mar 2019 13:02:36 +0900
Message-Id: <1552968156-3920-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2b50f7ab6368 ("kbuild: add workaround for Debian make-kpkg")
annoyed people who want to wrap the top Makefile with GNUmakefile
or something in order to customize it for their use.

On second thought, we do not need to run the sub-make for in-tree
build with Make 4.x because the 'MAKEFLAGS += -rR' issue only happens
on GNU Make 3.x.

With this commit, people will get back the workflow, and the Debian
make-kpkg will still work.

Fixes: 2b50f7ab6368 ("kbuild: add workaround for Debian make-kpkg")
Reported-by: Andreas Schwab <schwab@suse.de>
Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 99c0530..d9591f2 100644
--- a/Makefile
+++ b/Makefile
@@ -31,26 +31,12 @@ _all:
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
-# Ugly workaround for Debian make-kpkg:
-# make-kpkg directly includes the top Makefile of Linux kernel. In such a case,
-# skip sub-make to support debian_* targets in ruleset/kernel_version.mk, but
-# displays warning to discourage such abusage.
-ifneq ($(word 2, $(MAKEFILE_LIST)),)
-$(warning Do not include top Makefile of Linux Kernel)
-sub-make-done := 1
-MAKEFLAGS += -rR
-endif
-
 ifneq ($(sub-make-done),1)
 
 # Do not use make's built-in rules and variables
 # (this increases performance and avoids hard-to-debug behaviour)
 MAKEFLAGS += -rR
 
-# 'MAKEFLAGS += -rR' does not become immediately effective for old
-# GNU Make versions. Cancel implicit rules for this Makefile.
-$(lastword $(MAKEFILE_LIST)): ;
-
 # Avoid funny character set dependencies
 unexport LC_ALL
 LC_COLLATE=C
@@ -153,6 +139,7 @@ $(if $(KBUILD_OUTPUT),, \
 # 'sub-make' below.
 MAKEFLAGS += --include-dir=$(CURDIR)
 
+need-sub-make := 1
 else
 
 # Do not print "Entering directory ..." at all for in-tree build.
@@ -160,6 +147,15 @@ MAKEFLAGS += --no-print-directory
 
 endif # ifneq ($(KBUILD_OUTPUT),)
 
+ifneq ($(filter 3.%,$(MAKE_VERSION)),)
+# 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
+# We need to run sub-make to avoid implicit rules in the top Makefile.
+need-sub-make := 1
+# Cancel implicit rules for this Makefile.
+$(lastword $(MAKEFILE_LIST)): ;
+endif
+
+ifeq ($(need-sub-make),1)
 PHONY += $(MAKECMDGOALS) sub-make
 
 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
@@ -171,8 +167,11 @@ sub-make:
 	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
 
-else # sub-make-done
+endif # need-sub-make
+endif # sub-make-done
+
 # We process the rest of the Makefile if this is the final invocation of make
+ifeq ($(need-sub-make),)
 
 # Do not print "Entering directory ...",
 # but we want to display it when entering to the output directory
@@ -1757,7 +1756,7 @@ existing-targets := $(wildcard $(sort $(targets)))
 
 endif   # ifeq ($(config-targets),1)
 endif   # ifeq ($(mixed-targets),1)
-endif   # sub-make-done
+endif   # need-sub-make
 
 PHONY += FORCE
 FORCE:
-- 
2.7.4

