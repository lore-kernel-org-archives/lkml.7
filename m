Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A753C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324DB20659
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948462;
	bh=8RDZahehh86mUaLsL8w6c3B6FC/eAknSP6AsN0Pn2IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XFM0X4XkCLVExw3s3o92ZswaczVPZsOujAp9yb3pj2FRGBsJsVqk1fVSGF7VIqQK7
	 iaGBaNY0WPil+lgbiq1eSGmemaWfrn4wSkRCTgieKoy8VN4OPxddPLKmVyu296r9Rt
	 2L6UgeT+QHktS64GV45kLsUgVh7Gi9bREdSTz4kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfJAQrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390281AbfJAQp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:45:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F78205C9;
        Tue,  1 Oct 2019 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948327;
        bh=8RDZahehh86mUaLsL8w6c3B6FC/eAknSP6AsN0Pn2IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6XrJ5nf7oXRQWf+H3UGlxn6ydJlF/NKPuKgXQHlBXne1yWjpVcET60mG/MBXQepO
         BmJIJblhZlQzkBX/Z8xEUQ9jxW1LluvgfM2nYYh+I+IMNL/78nYdDnOzniYrHoDhA+
         kO74rpGB77kBjVVhykY4NbEwrvkp56f12mp3OFP0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 16/19] kernel/elfcore.c: include proper prototypes
Date:   Tue,  1 Oct 2019 12:45:02 -0400
Message-Id: <20191001164505.16708-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164505.16708-1-sashal@kernel.org>
References: <20191001164505.16708-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valdis Kletnieks <valdis.kletnieks@vt.edu>

[ Upstream commit 0f74914071ab7e7b78731ed62bf350e3a344e0a5 ]

When building with W=1, gcc properly complains that there's no prototypes:

  CC      kernel/elfcore.o
kernel/elfcore.c:7:17: warning: no previous prototype for 'elf_core_extra_phdrs' [-Wmissing-prototypes]
    7 | Elf_Half __weak elf_core_extra_phdrs(void)
      |                 ^~~~~~~~~~~~~~~~~~~~
kernel/elfcore.c:12:12: warning: no previous prototype for 'elf_core_write_extra_phdrs' [-Wmissing-prototypes]
   12 | int __weak elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/elfcore.c:17:12: warning: no previous prototype for 'elf_core_write_extra_data' [-Wmissing-prototypes]
   17 | int __weak elf_core_write_extra_data(struct coredump_params *cprm)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~
kernel/elfcore.c:22:15: warning: no previous prototype for 'elf_core_extra_data_size' [-Wmissing-prototypes]
   22 | size_t __weak elf_core_extra_data_size(void)
      |               ^~~~~~~~~~~~~~~~~~~~~~~~

Provide the include file so gcc is happy, and we don't have potential code drift

Link: http://lkml.kernel.org/r/29875.1565224705@turing-police
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/elfcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/elfcore.c b/kernel/elfcore.c
index e556751d15d94..a2b29b9bdfcb2 100644
--- a/kernel/elfcore.c
+++ b/kernel/elfcore.c
@@ -2,6 +2,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/binfmts.h>
+#include <linux/elfcore.h>
 
 Elf_Half __weak elf_core_extra_phdrs(void)
 {
-- 
2.20.1

