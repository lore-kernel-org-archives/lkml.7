Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7828C32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7966421A4C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778579;
	bh=p/RHvbDV/1tIo8Or4RuVoQrBkcui4L3WwhNnxozAR/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zi+t37oZOO94Q6G4xBZ2vaT/aB6e6/TwliqB4F2/RqwiKfYmQAXQtSNYz7yJ4FWix
	 iMtxUyLRDmG4/mG7PLYsX8yNpyzlMuoUA75VWBCVoPC9yyxmN1Wvjf+T0P+1hYU33n
	 v93TUp8u4pqFxKbzobKqTmEFvDxXuabQa/YrlMWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfI2RgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfI2RgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:36:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5237421925;
        Sun, 29 Sep 2019 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778577;
        bh=p/RHvbDV/1tIo8Or4RuVoQrBkcui4L3WwhNnxozAR/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2cXsXTZHLItGsLQkD8zDMI8nae8l0qTCojHXcTfxGnVxeaGBBtOhOSt8n5zHebitm
         FVvj6AEv86/4TUwwR1OFF55Brz/bzh637KEg+usEPwx2qBj8xXsYHgclqyUgBwhq7c
         DCBJ31d7xyeL6s0rVR/ZlAyd4mzUmB4xEs5T/BHA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Thelen <gthelen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 21/23] kbuild: clean compressed initramfs image
Date:   Sun, 29 Sep 2019 13:35:31 -0400
Message-Id: <20190929173535.9744-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173535.9744-1-sashal@kernel.org>
References: <20190929173535.9744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 237a028693ce9..5f1bc5b23b14c 100644
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

