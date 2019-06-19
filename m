Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143FFC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7CB2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfFSPyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:54:03 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:34740 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728671AbfFSPyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:54:02 -0400
Received: from faui06c.informatik.uni-erlangen.de (faui06c.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:202])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 0B4FD240A7B;
        Wed, 19 Jun 2019 17:46:57 +0200 (CEST)
Received: by faui06c.informatik.uni-erlangen.de (Postfix, from userid 30063)
        id EE86CB0084D; Wed, 19 Jun 2019 17:46:56 +0200 (CEST)
From:   Lukas Schneider <lukas.s.schneider@fau.de>
To:     kim.jamie.bradley@gmail.com, pakki001@umn.edu,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Lukas Schneider <lukas.s.schneider@fau.de>,
        Jannik Moritz <jannik.moritz@fau.de>
Subject: [PATCH 2/4] rts5208: Fix usleep_range is preferred over udelay
Date:   Wed, 19 Jun 2019 17:46:46 +0200
Message-Id: <20190619154648.13840-2-lukas.s.schneider@fau.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619154648.13840-1-lukas.s.schneider@fau.de>
References: <20190619154648.13840-1-lukas.s.schneider@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the issue reported by checkpatch:

CHECK: usleep_range is preferred over udelay;
see Documentation/timers/timers-howto.txt

It's save to sleep here instead of using busy waiting,
because we are not in an atomic context.

Signed-off-by: Lukas Schneider <lukas.s.schneider@fau.de>
Signed-off-by: Jannik Moritz <jannik.moritz@fau.de>
Cc <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/rts5208/rtsx_card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_card.c b/drivers/staging/rts5208/rtsx_card.c
index 294f381518fa..960e845133c3 100644
--- a/drivers/staging/rts5208/rtsx_card.c
+++ b/drivers/staging/rts5208/rtsx_card.c
@@ -679,7 +679,7 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
 	if (retval < 0)
 		return STATUS_ERROR;
 
-	udelay(10);
+	usleep_range(10, 20);
 	retval = rtsx_write_register(chip, CLK_CTL, CLK_LOW_FREQ, 0);
 	if (retval)
 		return retval;
@@ -797,7 +797,7 @@ int switch_normal_clock(struct rtsx_chip *chip, int clk)
 		return retval;
 
 	if (sd_vpclk_phase_reset) {
-		udelay(200);
+		usleep_range(200, 210);
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
 		if (retval)
@@ -806,7 +806,7 @@ int switch_normal_clock(struct rtsx_chip *chip, int clk)
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
 		if (retval)
 			return retval;
-		udelay(200);
+		usleep_range(200, 210);
 	}
 	retval = rtsx_write_register(chip, CLK_CTL, 0xFF, 0);
 	if (retval)
-- 
2.19.1

