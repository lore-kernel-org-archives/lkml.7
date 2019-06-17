Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6BEC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318F921995
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfFQHn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:43:58 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:42054 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFQHn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:43:58 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id Rjji2000G3XaVaC01jjiki; Mon, 17 Jun 2019 09:43:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcmIo-0000TT-2k; Mon, 17 Jun 2019 09:43:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcmIo-0003Kr-0l; Mon, 17 Jun 2019 09:43:42 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] initramfs: Fix populate_initrd_image() section mismatch
Date:   Mon, 17 Jun 2019 09:43:40 +0200
Message-Id: <20190617074340.12779-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-4.6.3:

    WARNING: vmlinux.o(.text.unlikely+0x140): Section mismatch in reference from the function populate_initrd_image() to the variable .init.ramfs.info:__initramfs_size
    The function populate_initrd_image() references
    the variable __init __initramfs_size.
    This is often because populate_initrd_image lacks a __init
    annotation or the annotation of __initramfs_size is wrong.

    WARNING: vmlinux.o(.text.unlikely+0x14c): Section mismatch in reference from the function populate_initrd_image() to the function .init.text:unpack_to_rootfs()
    The function populate_initrd_image() references
    the function __init unpack_to_rootfs().
    This is often because populate_initrd_image lacks a __init
    annotation or the annotation of unpack_to_rootfs is wrong.

    WARNING: vmlinux.o(.text.unlikely+0x198): Section mismatch in reference from the function populate_initrd_image() to the function .init.text:xwrite()
    The function populate_initrd_image() references
    the function __init xwrite().
    This is often because populate_initrd_image lacks a __init
    annotation or the annotation of xwrite is wrong.

Indeed, if the compiler decides not to inline populate_initrd_image(), a
warning is generated.

Fix this by adding the missing __init annotations.

Fixes: 7c184ecd262fe64f ("initramfs: factor out a helper to populate the initrd image")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 init/initramfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 178130fd61c25d58..c47dad0884f7f10d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -617,7 +617,7 @@ static inline void clean_rootfs(void)
 #endif /* CONFIG_BLK_DEV_RAM */
 
 #ifdef CONFIG_BLK_DEV_RAM
-static void populate_initrd_image(char *err)
+static void __init populate_initrd_image(char *err)
 {
 	ssize_t written;
 	int fd;
@@ -637,7 +637,7 @@ static void populate_initrd_image(char *err)
 	ksys_close(fd);
 }
 #else
-static void populate_initrd_image(char *err)
+static void __init populate_initrd_image(char *err)
 {
 	printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 }
-- 
2.17.1

