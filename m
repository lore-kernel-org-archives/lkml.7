Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B6C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05BB2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLRNwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:52:35 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:44162 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbfLRNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:52:34 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihZke-0004yC-68; Wed, 18 Dec 2019 13:52:32 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1ihZkd-00Ax2A-Ts; Wed, 18 Dec 2019 13:52:31 +0000
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     ben.dooks@codethink.co.uk
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: renesas: rcar-rst: fix __iomem on configure call
Date:   Wed, 18 Dec 2019 13:52:30 +0000
Message-Id: <20191218135230.2610161-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configure call back takes a register pointer, so should
have been marked with __iomem. Add this to silence the
following sparse warnings:

rivers/soc/renesas/rcar-rst.c:33:22: warning: incorrect type in initializer (incompatible argument 1 (different address spaces))
drivers/soc/renesas/rcar-rst.c:33:22:    expected int ( *configure )( ... )
drivers/soc/renesas/rcar-rst.c:33:22:    got int ( * )( ... )
drivers/soc/renesas/rcar-rst.c:97:40: warning: incorrect type in argument 1 (different address spaces)
drivers/soc/renesas/rcar-rst.c:97:40:    expected void *base
drivers/soc/renesas/rcar-rst.c:97:40:    got void [noderef] <asn:2> *[assigned] base

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/soc/renesas/rcar-rst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index 14d05a070dd3..794d0a2659fe 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -21,7 +21,7 @@ static int rcar_rst_enable_wdt_reset(void __iomem *base)
 
 struct rst_config {
 	unsigned int modemr;		/* Mode Monitoring Register Offset */
-	int (*configure)(void *base);	/* Platform specific configuration */
+	int (*configure)(void __iomem *base);	/* Platform specific configuration */
 };
 
 static const struct rst_config rcar_rst_gen1 __initconst = {
-- 
2.24.0

