Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1193C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F6D2133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383071;
	bh=IyDHnK8MqzATXg9wnBUtcvenpx8QuaAiwj+xpIBD9tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7cXcP25RqS5KSTzC+zmRRLCnVfiaxXof30dsRPB1tP7uQDHyfYqu46mKxclm+Z8s
	 Pbjb11kHdrpKN23mtrMNsWfcIu13e+PJzQyOXCo3yls1fSn+zB2Y72xATBeILO6O4K
	 BLslpxZArNa8zLQsDqfx0Wms9pfWLFf6+E48wl68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfJFRbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbfJFRbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:31:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECA822087E;
        Sun,  6 Oct 2019 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383062;
        bh=IyDHnK8MqzATXg9wnBUtcvenpx8QuaAiwj+xpIBD9tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akUdzhvaJlDZX1+W4AXq1vxE0Y7jlMlUNab6smC58RIwf8rpTh6vInkZSwdn7UNWk
         1m1KHDMsjB2lIrQJoYdIH1wqehOAttQsh/XuQ/cfA3yaqTFXUAcZAjG5OiUHA5vduA
         gsrFqjgDLVdWM6NdMQHiWS8Tp7c3CZe6uqOcfvH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Thelen <gthelen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/106] kbuild: clean compressed initramfs image
Date:   Sun,  6 Oct 2019 19:21:17 +0200
Message-Id: <20191006171153.095314377@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Thelen <gthelen@google.com>

[ Upstream commit 6279eb3dd7946c69346a3b98473ed13d3a44adb5 ]

Since 9e3596b0c653 ("kbuild: initramfs cleanup, set target from Kconfig")
"make clean" leaves behind compressed initramfs images.  Example:

  $ make defconfig
  $ sed -i 's|CONFIG_INITRAMFS_SOURCE=""|CONFIG_INITRAMFS_SOURCE="/tmp/ir.cpio"|' .config
  $ make olddefconfig
  $ make -s
  $ make -s clean
  $ git clean -ndxf | grep initramfs
  Would remove usr/initramfs_data.cpio.gz

clean rules do not have CONFIG_* context so they do not know which
compression format was used.  Thus they don't know which files to delete.

Tell clean to delete all possible compression formats.

Once patched usr/initramfs_data.cpio.gz and friends are deleted by
"make clean".

Link: http://lkml.kernel.org/r/20190722063251.55541-1-gthelen@google.com
Fixes: 9e3596b0c653 ("kbuild: initramfs cleanup, set target from Kconfig")
Signed-off-by: Greg Thelen <gthelen@google.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 usr/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/usr/Makefile b/usr/Makefile
index 748f6a60bb1e0..138c18cefb529 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -11,6 +11,9 @@ datafile_y = initramfs_data.cpio$(suffix_y)
 datafile_d_y = .$(datafile_y).d
 AFLAGS_initramfs_data.o += -DINITRAMFS_IMAGE="usr/$(datafile_y)"
 
+# clean rules do not have CONFIG_INITRAMFS_COMPRESSION.  So clean up after all
+# possible compression formats.
+clean-files += initramfs_data.cpio*
 
 # Generate builtin.o based on initramfs_data.o
 obj-$(CONFIG_BLK_DEV_INITRD) := initramfs_data.o
-- 
2.20.1



