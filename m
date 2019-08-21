Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10420C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EC322CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Wa3+nU5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfHUDz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:55:56 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:17893 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHUDzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:55:54 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7L3tQp3016439;
        Wed, 21 Aug 2019 12:55:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7L3tQp3016439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566359728;
        bh=xvzRaJpfAiuO+5/j+Hz3YB5Qx9ImeceBGGq+CyKuQ7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wa3+nU5BGO15eyxz0lR5bIn9rwZ+2mjRIYim+iLMokOLIkpJs39HjD4Myi/Ao98hq
         x6P5m2dqGM4Xs0ynb4eSTpu4eZsabnZi25M6MOLBeSNSHbW+ltJYl0ZKKi1WC/nswO
         FWDm5tNeP5UZkEWbjqdkmoQ2LNBTw9iLkQPVKpL0YVte6K6Sri3igN7yzfqCEn6LHB
         oQlnxf/gVIikOijXjjvndkr7dj1LJg3ci3pfshNAIIVPjKftzdxGc7wuB9etDJENDI
         IbufhIOK0fj85Nb9hHEaxwiA9YWkA1ks0y+m+H6wZP9RTuPnkXwfrFhBqWvxKmO9pr
         JKUI+JjrERlkA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] video/logo: fix unneeded generation of font C files
Date:   Wed, 21 Aug 2019 12:55:14 +0900
Message-Id: <20190821035517.21671-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821035517.21671-1-yamada.masahiro@socionext.com>
References: <20190821035517.21671-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all the font C files are generated irrespective of CONFIG
options. Adding them to extra-y is wrong. What we need to do here is
to add them to 'targets' so that if_changed works properly.

All files listed in 'targets' are cleaned, so clean-files is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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

