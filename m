Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948EDC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3A621BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMZZVlFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfGVGc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 02:32:56 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33676 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGVGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:32:55 -0400
Received: by mail-pg1-f202.google.com with SMTP id a21so16147265pgv.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 23:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RXBRbXvNr6tRw/HJYoEekoFp+zD43fwq/c77YhsjGw8=;
        b=mMZZVlFfQAe1tjwqVaYudx3cjPSQ86JqmSxMtj2unq9ifccJPtND+NpPrTwdhp6+/G
         NrwSEp1gKLojly8bUjNT2T1nvCv15A5X13nytWf7P2XCCHQs/8cK+CIkj68IKvtugJ99
         gi2Hr/LR/CycY6wugFki+N5/vmSJLxFCnBrkVXhYAc3B5Bljl2wxJGVtwbjNQuebboNd
         qy/YRXSrMTZbow7spZnBxhwZlOSGU78nMCRkR00PM7ThM/cRBps3XLQNQbuhUm04uKu3
         iAMtQJdDpclI8oyQsPhGOS3nSgJCfoXur3I3oxDvS4IyvaoJufs3FQ+wl9AyYjKO4Fg+
         h4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RXBRbXvNr6tRw/HJYoEekoFp+zD43fwq/c77YhsjGw8=;
        b=ZfnkuQ+5TDEUw4NsoEjK/cSFW30x0dtQ0xN8JqZgURokQVwKKAOhQ9n6x0qgiJ9XuZ
         xhTVuaOdWl3kvhGeqnwb1fY34wheen2NMK3qq5Egqm+jFUF+709xZ5iDXkbP+K7S6QFr
         YkBk+RdWDxJ719YjwXTxLO20EU789OcSSYzG9TgSrAcXls1fDeLKNxeE4jDXHGSv8wlW
         fL5iVdFq+usSr3dfXhkZ/r4V9GhdDCrvaB0MdUOS+UAEOwncxOJO4zauALoRh2UFyCwN
         0G/NElCYbClz+eeQnTPdMiMEdgBANppswB+Y0lkVhTiwu2PwMRhmCVfgivQe7kYb6hdC
         x/pQ==
X-Gm-Message-State: APjAAAXgRwenpYC4YBEa+Hfy4sDiQbaOTLk1rgInlbNsBQboC8m1Ijwz
        AI0X21i5n+gpgUOMLNStsPAXq3fV+2P4
X-Google-Smtp-Source: APXvYqyX6r9IEAcbjv43GzDHH0yzdynbPG4XS5hmanl8eHQOqITW/WUMBGuvEJjIlMDRM2jVOqWmxosJBpF/
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr10758799pgm.143.1563777174461;
 Sun, 21 Jul 2019 23:32:54 -0700 (PDT)
Date:   Sun, 21 Jul 2019 23:32:51 -0700
Message-Id: <20190722063251.55541-1-gthelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH] kbuild: clean compressed initramfs image
From:   Greg Thelen <gthelen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9e3596b0c653 ("kbuild: initramfs cleanup, set target from
Kconfig") "make clean" leaves behind compressed initramfs images.
Example:
  $ make defconfig
  $ sed -i 's|CONFIG_INITRAMFS_SOURCE=""|CONFIG_INITRAMFS_SOURCE="/tmp/ir.cpio"|' .config
  $ make olddefconfig
  $ make -s
  $ make -s clean
  $ git clean -ndxf | grep initramfs
  Would remove usr/initramfs_data.cpio.gz

clean rules do not have CONFIG_* context so they do not know which
compression format was used.  Thus they don't know which files to
delete.

Tell clean to delete all possible compression formats.

Once patched usr/initramfs_data.cpio.gz and friends are deleted by
"make clean".

Fixes: 9e3596b0c653 ("kbuild: initramfs cleanup, set target from Kconfig")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 usr/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/usr/Makefile b/usr/Makefile
index 6a89eb019275..e6f7cb2f81db 100644
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
2.22.0.657.g960e92d24f-goog

