Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECED5C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9E420656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383685;
	bh=AFgKWp9fvl1W0XZX0ZIoBK7BnfWcWweB4vmsXjFfwUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uwNPcI0kqcQ4NOx+YSVkrY+GunzqWIl5Ps24AS2L9bGiPFd9dIzg71fbggkoZL5yv
	 HnmKZBK7JKsbr+zJTdB2zfbJVQFTBtKsJawymfFSmnSQxrA3ylwGDV6qiWSd2mwrch
	 +s7lw6ELwK5scXQPm29mNA2XJpeSM11M0N8HBxZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfDPDBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:01:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDPC4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/gWFlzwbR6HYl5rhJRTbpNy/TkHWVI1xXPnE+igvnpo=; b=YjjkDeWRJvYOSA6qaewMgLifox
        1GTTLcl1GX08iZFqwv5+kY5d5HOvmERwPzAf6Ean7K/WVlqzEA+Y898KJqkWAgCIx2OAk86+bn5Qb
        jcNSTV2rsteaOB28tf1QmkqgIw3AteWRp39OB0pgj/pn+vsCIvBdb9GbVfU75JLJbPq3nlO1KoTi9
        ib6fRlu0Ajx8XUoN+PWupDQYwUf9fuWlIx5OcVGk4UwPUTjKsvRzDBK5Y0upllhR86+bLcu+2Yf5P
        W+Ng37XK+3xvvSnEUPbEm16roOrdk0lzQYAtoKJdno5lqNoB0uSzO1fM94Feh/yGXc15CuTVWsqSt
        875LwDTQ==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGt-0007aM-Pn; Tue, 16 Apr 2019 02:56:31 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001pn-8S; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 49/57] docs: early-userspace: convert docs to ReST
Date:   Mon, 15 Apr 2019 23:56:14 -0300
Message-Id: <0702eb2b4814dc90abe163dd15c629927f9e4fff.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two files there describes a Kernel API feature, used to
support early userspace stuff. Prepare for moving them to
the kernel API book by converting to ReST format.

The conversion itself was quite trivial: just add/mark a few
titles as such, add a literal block markup, add a table markup
and a few blank lines, in order to make Sphinx to properly parse it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/early-userspace/README          |  3 +++
 .../early-userspace/buffer-format.txt         | 19 +++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/early-userspace/README b/Documentation/early-userspace/README
index 955d667dc87e..3deefb34046b 100644
--- a/Documentation/early-userspace/README
+++ b/Documentation/early-userspace/README
@@ -1,3 +1,4 @@
+=======================
 Early userspace support
 =======================
 
@@ -26,6 +27,7 @@ archive to be used as the image or have the kernel build process build
 the image from specifications.
 
 CPIO ARCHIVE method
+-------------------
 
 You can create a cpio archive that contains the early userspace image.
 Your cpio archive should be specified in CONFIG_INITRAMFS_SOURCE and it
@@ -34,6 +36,7 @@ CONFIG_INITRAMFS_SOURCE and directory and file names are not allowed in
 combination with a cpio archive.
 
 IMAGE BUILDING method
+---------------------
 
 The kernel build process can also build an early userspace image from
 source parts rather than supplying a cpio archive.  This method provides
diff --git a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.txt
index e1fd7f9dad16..7f74e301fdf3 100644
--- a/Documentation/early-userspace/buffer-format.txt
+++ b/Documentation/early-userspace/buffer-format.txt
@@ -1,8 +1,10 @@
-		       initramfs buffer format
-		       -----------------------
+=======================
+initramfs buffer format
+=======================
 
-		       Al Viro, H. Peter Anvin
-		      Last revision: 2002-01-13
+Al Viro, H. Peter Anvin
+
+Last revision: 2002-01-13
 
 Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
 getting {replaced/complemented} with the new "initial ramfs"
@@ -18,7 +20,8 @@ archive can be compressed using gzip(1).  One valid version of an
 initramfs buffer is thus a single .cpio.gz file.
 
 The full format of the initramfs buffer is defined by the following
-grammar, where:
+grammar, where::
+
 	*	is used to indicate "0 or more occurrences of"
 	(|)	indicates alternatives
 	+	indicates concatenation
@@ -49,7 +52,9 @@ hexadecimal ASCII numbers fully padded with '0' on the left to the
 full width of the field, for example, the integer 4780 is represented
 by the ASCII string "000012ac"):
 
+============= ================== ==============================================
 Field name    Field size	 Meaning
+============= ================== ==============================================
 c_magic	      6 bytes		 The string "070701" or "070702"
 c_ino	      8 bytes		 File inode number
 c_mode	      8 bytes		 File mode and permissions
@@ -65,6 +70,7 @@ c_rmin	      8 bytes		 Minor part of device node reference
 c_namesize    8 bytes		 Length of filename, including final \0
 c_chksum      8 bytes		 Checksum of data field if c_magic is 070702;
 				 otherwise zero
+============= ================== ==============================================
 
 The c_mode field matches the contents of st_mode returned by stat(2)
 on Linux, and encodes the file type and file permissions.
@@ -82,7 +88,8 @@ If the filename is "TRAILER!!!" this is actually an end-of-archive
 marker; the c_filesize for an end-of-archive marker must be zero.
 
 
-*** Handling of hard links
+Handling of hard links
+======================
 
 When a nondirectory with c_nlink > 1 is seen, the (c_maj,c_min,c_ino)
 tuple is looked up in a tuple buffer.  If not found, it is entered in
-- 
2.20.1

