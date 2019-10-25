Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F286BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D425521D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393554AbfJYLxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:53:08 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:37464 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732846AbfJYLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:53:08 -0400
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id Hnt6210045USYZQ06nt6lR; Fri, 25 Oct 2019 13:53:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNy9S-0004EO-1n; Fri, 25 Oct 2019 13:53:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNy9R-0002Zm-VW; Fri, 25 Oct 2019 13:53:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] kconfig: Extend defconfig field size from 24 to 27
Date:   Fri, 25 Oct 2019 13:53:05 +0200
Message-Id: <20191025115305.9769-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 6 defconfigs with names longer than 24 characters, breaking
alignment in "make help".

The "winner" is "ecovec24-romimage_defconfig", counting in at 27
characters.

Extend the defconfig field size to 27 to restore alignment.
Don't use a larger value, to not encourage people to create even longer
defconfig names.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
v2:
  - Add Acked-by,
  - Reduce from 32 to 27, now avr32 and its long defconfigs have been
    removed,
  - Update statistics.
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5a1ef8db2cec69f6..a0934f3d0328b06c 100644
--- a/Makefile
+++ b/Makefile
@@ -1512,7 +1512,7 @@ help:
 	@echo  ''
 	@$(if $(boards), \
 		$(foreach b, $(boards), \
-		printf "  %-24s - Build for %s\\n" $(b) $(subst _defconfig,,$(b));) \
+		printf "  %-27s - Build for %s\\n" $(b) $(subst _defconfig,,$(b));) \
 		echo '')
 	@$(if $(board-dirs), \
 		$(foreach b, $(board-dirs), \
-- 
2.17.1

