Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30703C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0665A215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578074452;
	bh=6wRmEExRarJkLmBrIOi8mE+v+7mDbntHaGXjK7T8WRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0WuWcDVYU+kK1FCy28tmj6L9vIi7UGG2Ti4LCg6KNhLLy/oPEdf0kV16N+NjrtiCQ
	 zhZCaMY+VQWk+5yqHZ4ib7i+tq2iigEsAoYZL2G8dTiSPPGUVwWv0Kl3uxNjGhkAJE
	 AaoC+pDnBzOjm4QrnM2idJRd4ka8ccMePjVjsi8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgACSAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:00:38 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:16476 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgACSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:00:37 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 003HxSJ8022724;
        Sat, 4 Jan 2020 02:59:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 003HxSJ8022724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578074373;
        bh=aVtB2Rv+NyX9qUbly4Qthna7cERKkW7+WHgodTXdBR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGR92y+s2WkTTOI5sPh83az0Pv8eNaKr3/FY3MzlnUHM3GyWhLGVymfumcmWHutEb
         DIIQmQ42KKDIChA0Q3BJU9W9BTBs4j+WQa0MpVbVSpjNGvv7zOEJzZzBWAy8guYuWa
         12N3j0iEnj1EyVA67fxsdJaQtO/EfaBoAks3rRk/6c++E7Gko+3Bbht6rn2JZJlU5l
         arU/fslYNYGotbQdTKO4DPdSsfcz+w3tf/COA/uItVbA/GjaNOKEPPE6LiJr1YgJI6
         +GBMf0V2bbd3BylEPA+BnBT+8OmYRKvupGHUD1hp9rz5rizcKdPy2NGRfUFBExyaEz
         MI5W0U4ZwjMmw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] initramfs: specify $(src)/gen_initramfs.sh as a prerequisite in Makefile
Date:   Sat,  4 Jan 2020 02:59:10 +0900
Message-Id: <20200103175915.26663-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103175915.26663-1-masahiroy@kernel.org>
References: <20200103175915.26663-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the dependency directly in the Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 usr/Makefile         | 7 +++----
 usr/gen_initramfs.sh | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/usr/Makefile b/usr/Makefile
index e44a66b8c051..7df6559f0f30 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -24,7 +24,6 @@ $(obj)/initramfs_data.o: $(obj)/$(datafile_y) FORCE
 # Generate the initramfs cpio archive
 
 hostprogs-y := gen_init_cpio
-initramfs   := $(CONFIG_SHELL) $(srctree)/$(src)/gen_initramfs.sh
 ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
 			$(shell echo $(CONFIG_INITRAMFS_SOURCE)),-d)
 ramfs-args  := \
@@ -40,7 +39,7 @@ ifneq ($(wildcard $(obj)/$(datafile_d_y)),)
 endif
 
 quiet_cmd_initfs = GEN     $@
-      cmd_initfs = $(initramfs) -o $@ $(ramfs-args) $(ramfs-input)
+      cmd_initfs = $< -o $@ $(ramfs-args) $(ramfs-input)
 
 targets := $(datafile_y)
 
@@ -52,8 +51,8 @@ $(deps_initramfs): ;
 # 2) There are changes in which files are included (added or deleted)
 # 3) If gen_init_cpio are newer than initramfs_data.cpio
 # 4) Arguments to gen_initramfs.sh changes
-$(obj)/$(datafile_y): $(obj)/gen_init_cpio $(deps_initramfs) FORCE
-	$(Q)$(initramfs) -l $(ramfs-input) > $(obj)/$(datafile_d_y)
+$(obj)/$(datafile_y): $(src)/gen_initramfs.sh $(obj)/gen_init_cpio $(deps_initramfs) FORCE
+	$(Q)$< -l $(ramfs-input) > $(obj)/$(datafile_d_y)
 	$(call if_changed,initfs)
 
 subdir-$(CONFIG_UAPI_HEADER_TEST) += include
diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 1fd93414fb37..68b6ddfd5f96 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -235,7 +235,7 @@ arg="$1"
 case "$arg" in
 	"-l")	# files included in initramfs - used by kbuild
 		dep_list="list_"
-		echo "deps_initramfs := $0 \\"
+		echo "deps_initramfs := \\"
 		shift
 		;;
 	"-o")	# generate compressed cpio image named $1
-- 
2.17.1

