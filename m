Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A3FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03320206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rshherKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfD0Ddw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:33:52 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:17157 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfD0Ddv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:33:51 -0400
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x3R3Xie7029345;
        Sat, 27 Apr 2019 12:33:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x3R3Xie7029345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556336024;
        bh=MTquuhRSUQKNTK42Xx9Gwp06/bDDMv+mmeZs+svCSU0=;
        h=From:To:Cc:Subject:Date:From;
        b=rshherKe8BwpbhuKrRWJ7n0lxdM4MPPVJe+ndSFXieNNeh+JQ5cLp6wigzeI5D/qw
         Crgknety+1vJjoxQQMAQFsXqI2Ng7ZxA/BOaO9/yV4AlidRtYsZdQJk4/xMzbNbF+R
         zAB3Y2iHeexYWbwAxudzsIo9j9TttFA8cWKvB2Rzi4PvSgDL9t6nW3ISi0ArXYLUZr
         Cynaz/5nbrnaZAFXEibPz7lV50FUqw9PbRfSRhBNPtXzCbaeSn42kDAqoFm7Nrhdjc
         0QMN3co11WT+WDDDuudiA4p16pV/FZ1k4cWI80xD5G+FsI9NlqaNIgVjzePdL/gnwn
         UJmnl3Q+95k6Q==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] kbuild: move samples/ to KBUILD_VMLINUX_OBJS
Date:   Sat, 27 Apr 2019 12:33:36 +0900
Message-Id: <1556336020-15634-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle samples/ like the other top-level directories to simplify
the Makefile.

Include include/config/auto.conf earlier to evaluate
drivers-$(CONFIG_SAMPLES).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile         | 18 ++++++++----------
 samples/Makefile |  2 +-
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 15e17b4..251ded5 100644
--- a/Makefile
+++ b/Makefile
@@ -598,20 +598,21 @@ endif
 
 export KBUILD_MODULES KBUILD_BUILTIN
 
+ifeq ($(dot-config),1)
+include include/config/auto.conf
+endif
+
 ifeq ($(KBUILD_EXTMOD),)
 # Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
 drivers-y	:= drivers/ sound/
+drivers-$(CONFIG_SAMPLES) += samples/
 net-y		:= net/
 libs-y		:= lib/
 core-y		:= usr/
 virt-y		:= virt/
 endif # KBUILD_EXTMOD
 
-ifeq ($(dot-config),1)
-include include/config/auto.conf
-endif
-
 # The all: target is the default when no target is given on the
 # command line.
 # This allow a user to issue only 'make' to build a kernel including modules
@@ -1005,7 +1006,7 @@ export KBUILD_VMLINUX_LIBS := $(libs-y1)
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 export LDFLAGS_vmlinux
 # used by scripts/package/Makefile
-export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Documentation include samples scripts tools)
+export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Documentation include scripts tools)
 
 vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
 
@@ -1042,11 +1043,8 @@ vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
 
 targets := vmlinux
 
-# Build samples along the rest of the kernel. This needs headers_install.
-ifdef CONFIG_SAMPLES
-vmlinux-dirs += samples
+# Some samples need headers_install.
 samples: headers_install
-endif
 
 # The actual objects are generated when descending,
 # make sure no implicit rule kicks in
@@ -1362,7 +1360,7 @@ MRPROPER_FILES += .config .config.old .version \
 #
 clean: rm-dirs  := $(CLEAN_DIRS)
 clean: rm-files := $(CLEAN_FILES)
-clean-dirs      := $(addprefix _clean_, . $(vmlinux-alldirs) Documentation samples)
+clean-dirs      := $(addprefix _clean_, . $(vmlinux-alldirs) Documentation)
 
 PHONY += $(clean-dirs) clean archclean vmlinuxclean
 $(clean-dirs):
diff --git a/samples/Makefile b/samples/Makefile
index b1142a9..50f8586 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -1,6 +1,6 @@
 # Makefile for Linux samples code
 
-obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
+obj-y			+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ \
 			   vfio-mdev/ statx/ qmi/ binderfs/
-- 
2.7.4

