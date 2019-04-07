Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD2C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4F420B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AUGrk78a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDGKoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 06:44:24 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:31486 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDGKoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 06:44:23 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x37Ai14J006181;
        Sun, 7 Apr 2019 19:44:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x37Ai14J006181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554633842;
        bh=NqfLefqeMtb7bISR8Nkb4quVom6OPYx9k0dm6zvdMLo=;
        h=From:To:Cc:Subject:Date:From;
        b=AUGrk78a8R7x2eTQzU5epZhlT+BqblHxmJPpTWvx6eUB+Oj6xGWIKsUC59/iyilAW
         kJLOyj4RE1yflrmYAe8rXAcyRblLecycOVLCfAiRxvUQnQuWpduM0cdZZ1J3bzHvRa
         5d8Q/Yd48ar4sfbYQMUr1ua+ExMua8AcsN/vkfm00nqwGoLtXcVSTnCpMXCrdLrdj5
         dms7EHcZm/VdQnUe4SHg5vi3fysFbHUX8WY+u2LBqGfuFhyikjSML+dE/hXX6sj50Y
         7b/01YfFcJOzsm9qmh2nRU2RzmtKjZHGrUC6W17GoNOmS26Bgu5379uA2uGqr/PYh+
         kFtbPGl1wUBAg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: check arch/$(SRCARCH)/include/generated before out-of-tree build
Date:   Sun,  7 Apr 2019 19:43:51 +0900
Message-Id: <1554633831-10303-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After cross-compiling the kernel, "make mrproper" should be executed
with the proper ARCH= option. Otherwise, stale objects will remain
under arch/$(SRCARCH)/.

One bad scenario is like this:

  $ make ARCH=arm defconfig all   # cross-compile the kernel for arm
  $ make mrproper                 # mrproper for host-arch (i.e. x86)
  $ make ARCH=arm O=build_dir defconfig all

If you miss ARCH= for mrproper and cross-compile the kernel with O=
and ARCH= options, Kbuild will happily start to build, but may fail
due to stale objects in the srctree.

If $(srctree)/arch/$(SRCARCH)/include/generated/ exists, let's stop
the out-of-tree build. To detect this, mrproper should clean only
arch/$(SRCARCH)/include/generated/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 10643c3..17945ce 100644
--- a/Makefile
+++ b/Makefile
@@ -1091,7 +1091,9 @@ PHONY += prepare archprepare prepare1 prepare3
 prepare3: include/config/kernel.release
 ifneq ($(srctree),.)
 	@$(kecho) '  Using $(srctree) as source for kernel'
-	$(Q)if [ -f $(srctree)/.config -o -d $(srctree)/include/config ]; then \
+	$(Q)if [ -f $(srctree)/.config -o \
+		 -d $(srctree)/include/config -o \
+		 -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
 		echo >&2 "  $(srctree) is not clean, please run 'make mrproper'"; \
 		echo >&2 "  in the '$(srctree)' directory.";\
 		/bin/false; \
@@ -1350,7 +1352,7 @@ CLEAN_DIRS  += $(MODVERDIR) include/ksym
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config usr/include include/generated          \
-		  arch/*/include/generated .tmp_objdiff
+		  arch/$(SRCARCH)/include/generated .tmp_objdiff
 MRPROPER_FILES += .config .config.old .version \
 		  Module.symvers tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS \
 		  signing_key.pem signing_key.priv signing_key.x509	\
-- 
2.7.4

