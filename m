Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A9BC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6AE24650
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578150239;
	bh=SbRQ7kz7dE+QDtdPnCVbfXmAGXo+/HxZv3FQVwI9CGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qoBWa41qrHVuQtO/MLjXIbDfZeHJUOWfFOofp91vnz/5SawCZqu5J2lQPDT/zFSEL
	 8l8QdNIUc7lnL+KYdL6jFsabHyygO7Lcr7ekeQmnfgUocckawuYokT8y/qH2fD6eUe
	 ZCzEas6RheZGuaJGfkOc1UgfHSGM+zWte0MNrc98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgADPD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:03:58 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:54705 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgADPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:03:54 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 004F2gca018492;
        Sun, 5 Jan 2020 00:02:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 004F2gca018492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578150169;
        bh=FbaClWwqiWtKYH2Zb4LtEPVGB1SiRsdW/Otx4py+kiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sW1J5iwCvdypLA15s2Otlmhu6Fc/yORhyvi9YOAfndsaS3n39PoJKChZ9yZQ5XU+Y
         f/qvUwF+yz6xlg5tfB4XP7F2ZBK5L8zjgLLs9icqXX3Vq+QSJxEL7fWrkW9MPlHYsx
         Y0RHUGNR4Xb/H7F+3AivP2zJ/ZYF5gtxeXyxJZSpfOTWAcOVamBfwTJ5eYD1k7mJD/
         QB7bimGgHbjJFNVRI5Qw4Ygo6Q7ICV/MjfKuX/oC0E6IJ5G6jcMG1Af8hbK8yMfnwi
         K3vt7eDh4JQyGbzuMj54RmV43xK8JfBLjyHMKgkwBu4Ip9nfc3gIfjvTYzmuwWEGWQ
         BeeZC1As4pI5A==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] initramfs: add default_cpio_list, and delete -d option support
Date:   Sun,  5 Jan 2020 00:02:35 +0900
Message-Id: <20200104150238.19834-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104150238.19834-1-masahiroy@kernel.org>
References: <20200104150238.19834-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_INITRAMFS_SOURCE is empty, the Makefile passes the -d
option to gen_initramfs.sh to create the default initramfs, which
contains /dev, /dev/console, and /root.

This commit simplifies the default behavior; remove the -d option,
and add the default cpio list.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 usr/Makefile          |  2 +-
 usr/default_cpio_list |  6 ++++++
 usr/gen_initramfs.sh  | 16 ----------------
 3 files changed, 7 insertions(+), 17 deletions(-)
 create mode 100644 usr/default_cpio_list

diff --git a/usr/Makefile b/usr/Makefile
index 3ae8b45bfc61..9256a5b189ee 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -25,7 +25,7 @@ $(obj)/initramfs_data.o: $(obj)/$(datafile_y) FORCE
 
 hostprogs-y := gen_init_cpio
 ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
-			$(shell echo $(CONFIG_INITRAMFS_SOURCE)),-d)
+			$(shell echo $(CONFIG_INITRAMFS_SOURCE)),$(srctree)/$(src)/default_cpio_list)
 ramfs-args  := \
         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
         $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))
diff --git a/usr/default_cpio_list b/usr/default_cpio_list
new file mode 100644
index 000000000000..37b3864066e8
--- /dev/null
+++ b/usr/default_cpio_list
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# This is a very simple, default initramfs
+
+dir /dev 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+dir /root 0700 0 0
diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 49a4e22147b5..e6808a8c3b2b 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -28,7 +28,6 @@ $0 [-o <file>] [-l <dep_list>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
 	<cpio_source>  File list or directory for cpio archive.
 		       If <cpio_source> is a .cpio file it will be used
 		       as direct input to initramfs.
-	-d             Output the default cpio list.
 
 All options except -o and -l may be repeated and are interpreted
 sequentially and immediately.  -u and -g states are preserved across
@@ -43,18 +42,6 @@ field() {
 	shift $1 ; echo $1
 }
 
-default_initramfs() {
-	cat <<-EOF >> ${output}
-		# This is a very simple, default initramfs
-
-		dir /dev 0755 0 0
-		nod /dev/console 0600 0 0 c 5 1
-		dir /root 0700 0 0
-		# file /kinit usr/kinit/kinit 0755 0 0
-		# slink /init kinit 0755 0 0
-	EOF
-}
-
 filetype() {
 	local argv1="$1"
 
@@ -263,9 +250,6 @@ while [ $# -gt 0 ]; do
 			[ "$root_gid" = "-1" ] && root_gid=$(id -g || echo 0)
 			shift
 			;;
-		"-d")	# display default initramfs list
-			default_initramfs
-			;;
 		"-h")
 			usage
 			exit 0
-- 
2.17.1

