Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0512C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22F7206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="otT/vRdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfHUENW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 00:13:22 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:47118 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfHUENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:13:21 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7L4CeQC002060;
        Wed, 21 Aug 2019 13:12:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7L4CeQC002060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566360762;
        bh=rG1uzD+ZsouFnScMd+YS+lbLIqKukipCyXFlBuBls/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otT/vRdpFvNnROJNxtb+yU1E8OIA+ohk3ZhRjZVkvdwKeQK3pyBNLr257cnxw4aV9
         BY5C3ijhHysdD8e1TMUJwFmlzkA3oV2Tl5bHUtGSQusH1VGiKzzjsIRP9+2T5teMNK
         iRvkAMXe6eY38W2otcXUIRKhHcq3Mt/8Et9sKxWb6gIM/FH0qTFIo8bXRs6oom2mAA
         77iz3S6axA0pmj66S+0HDqul4F81OSvxXXymEbMlUJdAlzGzWrRVILuHMmtYpA+eLQ
         MN1GGOfFzrLdEa7pLkv0w7/xYT9H2Xua4SqWnoWrC9wymBHG2hth4SaTF9NtDHLq2y
         8Kh4660PXf+Yw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] video/logo: do not generate unneeded logo C files
Date:   Wed, 21 Aug 2019 13:12:35 +0900
Message-Id: <20190821041237.23197-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821041237.23197-1-yamada.masahiro@socionext.com>
References: <20190821041237.23197-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all the logo C files are generated irrespective of the
CONFIG options. Adding them to extra-y is wrong. What we need to do
here is to add them to 'targets' so that if_changed works properly.

Files listed in 'targets' are cleaned, so clean-files is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix commit log

 drivers/video/logo/Makefile | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 10b75ce3ce09..16f60c1e1766 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -18,23 +18,6 @@ obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o
 
 # How to generate logo's
 
-# Use logo-cfiles to retrieve list of .c files to be built
-logo-cfiles = $(notdir $(patsubst %.$(2), %.c, \
-              $(wildcard $(srctree)/$(src)/*$(1).$(2))))
-
-
-# Mono logos
-extra-y += $(call logo-cfiles,_mono,pbm)
-
-# VGA16 logos
-extra-y += $(call logo-cfiles,_vga16,ppm)
-
-# 224 Logos
-extra-y += $(call logo-cfiles,_clut224,ppm)
-
-# Gray 256
-extra-y += $(call logo-cfiles,_gray256,pgm)
-
 pnmtologo := scripts/pnmtologo
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
@@ -55,5 +38,5 @@ $(obj)/%_clut224.c: $(src)/%_clut224.ppm $(pnmtologo) FORCE
 $(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
-# Files generated that shall be removed upon make clean
-clean-files := *_mono.c *_vga16.c *_clut224.c *_gray256.c
+# generated C files
+targets += *_mono.c *_vga16.c *_clut224.c *_gray256.c
-- 
2.17.1

