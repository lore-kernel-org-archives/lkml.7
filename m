Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD3FC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701E12075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfC0Xkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0Xkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:40:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B61D8307D98E;
        Wed, 27 Mar 2019 23:40:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 781635C582;
        Wed, 27 Mar 2019 23:40:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 01/68] kbuild: skip sub-make for in-tree build with GNU
 Make 4.x
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Andreas Schwab <schwab@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:40:43 +0000
Message-ID: <155373004377.7602.1209303093988055088.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 27 Mar 2019 23:40:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

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
Signed-off-by: David Howells <dhowells@redhat.com>
---

 Makefile |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index c0a34064c574..cd38d203e71a 100644
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

