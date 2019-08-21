Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEB5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0FF22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CGTM9Ip8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfHUD4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:56:05 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:17936 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfHUDz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:55:56 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7L3tQp4016439;
        Wed, 21 Aug 2019 12:55:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7L3tQp4016439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566359729;
        bh=6fHkMxqT3+v0CE4zyYlxI6pTvIRPi8TKT8Z20L42FeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGTM9Ip8o61zeqHGDHeQK9RgclVA0dIXBS0WTjDmQzDmdx6VqjNALxNsUNKVlLh/s
         wQHaHeqEOTciWRofraKElz+DdJTipiVlPP50NKlLPgWLJrV9ny/9Ja7dAh5XudxAIS
         JLi3xQG00ucSqQwts31QadViT0zDqYJoUWEohMiDxynNpGmKR8ybqAmOOwlpnnFvQC
         cNe0MQsqEvIXeRP6yD7BTt+VM0yh9xgK6hIwDAyMoW8BmLBaKBw82B//jbgKYBBBTw
         oqx7PkXwOM93RByfRyHrPGHjRcRq4aEkjc7IKp0K7zrqekUX9s7dPUUr1Nga8nMRc1
         9Hr24AH+ql5mQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] video/logo: simplify cmd_logo
Date:   Wed, 21 Aug 2019 12:55:15 +0900
Message-Id: <20190821035517.21671-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821035517.21671-1-yamada.masahiro@socionext.com>
References: <20190821035517.21671-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the code. It still works in the same way.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/video/logo/Makefile | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 16f60c1e1766..7d672d40bf01 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -22,20 +22,15 @@ pnmtologo := scripts/pnmtologo
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
 quiet_cmd_logo = LOGO    $@
-	cmd_logo = $(pnmtologo) \
-			-t $(patsubst $*_%,%,$(notdir $(basename $<))) \
-			-n $(notdir $(basename $<)) -o $@ $<
+      cmd_logo = $(pnmtologo) -t $(lastword $(subst _, ,$*)) -n $* -o $@ $<
 
-$(obj)/%_mono.c: $(src)/%_mono.pbm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.pbm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
-$(obj)/%_vga16.c: $(src)/%_vga16.ppm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.ppm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
-$(obj)/%_clut224.c: $(src)/%_clut224.ppm $(pnmtologo) FORCE
-	$(call if_changed,logo)
-
-$(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.pgm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
 # generated C files
-- 
2.17.1

