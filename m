Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83E6C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9C722522
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578074387;
	bh=3O2oQvSBk+7BR0ZGuvlpb/SpotQyclTbejUPgtbX2xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YAr6foRJBKxuDe+y75Eplh10Z2uBDjYfY8jJUCFkL3GlInhYiO35pR+xlPqOxMtba
	 79E63jTj4a+bQLCj4mBkVHfXTSzKr732NA21CVUE4IE5wdNdRoo2IK9Y2Gbyl0kwqj
	 sixCnYcRz4FSP7Uh01RkASdZhGQdhTrBIWZpeKkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgACR7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:59:46 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64714 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgACR7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:59:40 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 003HxSJ5022724;
        Sat, 4 Jan 2020 02:59:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 003HxSJ5022724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578074371;
        bh=bHwr5zrMPtwj0Xjsz5tjllHBAG13FvggunbN5z1QbKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xd/MEXm8ioLojnsWB0ebtrQHArl9nr90m/Yi8CIVTgSI6GevZDIlVrzJ0YDnLFSXK
         vzQPuSJo/9vZkt+AAWIfRmGTcWlrZ3/aUd4Lh00uYJ897EdcWtAOlCT/UJqHipc5kE
         Cg1gxT5K+iQ1Hu3AFT6mCOPOJJ1IPl8p02wd4q48TL1ZfzDr/gbEz58nDBlO7i4m8b
         AeDeycIgEaQFrHxMZZbaFs/k2kfhtpJ4wSh4oTQDakeTLZaodxGW8X8H/+Jj//QRxj
         dvs4p6vRXeaF0b+M5TeT8O2ecxNcQ6Z6XzIjkM36QQL94nTi7F4J+4UdHXA5o50oum
         tXYgy5GwD0ddA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] initramfs: remove redundant dependency on BLK_DEV_INITRD
Date:   Sat,  4 Jan 2020 02:59:07 +0900
Message-Id: <20200103175915.26663-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103175915.26663-1-masahiroy@kernel.org>
References: <20200103175915.26663-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init/Kconfig includes usr/Kconfig inside the "if BLK_DEV_INITRD" ...
"endif" block:

    if BLK_DEV_INITRD

    source "usr/Kconfig"

    endif

Hence, all the defines in usr/Kconfig depend on BLK_DEV_INITRD.

Remove the redundant "depends on BLK_DEV_INITRD".

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 usr/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/usr/Kconfig b/usr/Kconfig
index a6b68503d177..72f50a21c051 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -54,7 +54,6 @@ config INITRAMFS_ROOT_GID
 
 config RD_GZIP
 	bool "Support initial ramdisk/ramfs compressed using gzip"
-	depends on BLK_DEV_INITRD
 	default y
 	select DECOMPRESS_GZIP
 	help
@@ -64,7 +63,6 @@ config RD_GZIP
 config RD_BZIP2
 	bool "Support initial ramdisk/ramfs compressed using bzip2"
 	default y
-	depends on BLK_DEV_INITRD
 	select DECOMPRESS_BZIP2
 	help
 	  Support loading of a bzip2 encoded initial ramdisk or cpio buffer
@@ -73,7 +71,6 @@ config RD_BZIP2
 config RD_LZMA
 	bool "Support initial ramdisk/ramfs compressed using LZMA"
 	default y
-	depends on BLK_DEV_INITRD
 	select DECOMPRESS_LZMA
 	help
 	  Support loading of a LZMA encoded initial ramdisk or cpio buffer
@@ -81,7 +78,6 @@ config RD_LZMA
 
 config RD_XZ
 	bool "Support initial ramdisk/ramfs compressed using XZ"
-	depends on BLK_DEV_INITRD
 	default y
 	select DECOMPRESS_XZ
 	help
@@ -91,7 +87,6 @@ config RD_XZ
 config RD_LZO
 	bool "Support initial ramdisk/ramfs compressed using LZO"
 	default y
-	depends on BLK_DEV_INITRD
 	select DECOMPRESS_LZO
 	help
 	  Support loading of a LZO encoded initial ramdisk or cpio buffer
@@ -100,7 +95,6 @@ config RD_LZO
 config RD_LZ4
 	bool "Support initial ramdisk/ramfs compressed using LZ4"
 	default y
-	depends on BLK_DEV_INITRD
 	select DECOMPRESS_LZ4
 	help
 	  Support loading of a LZ4 encoded initial ramdisk or cpio buffer
-- 
2.17.1

