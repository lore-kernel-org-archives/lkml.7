Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39F1C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B972721881
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfFSPyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:54:07 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:34732 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727818AbfFSPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:54:03 -0400
Received: from faui06c.informatik.uni-erlangen.de (faui06c.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:202])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 80D532412DB;
        Wed, 19 Jun 2019 17:46:57 +0200 (CEST)
Received: by faui06c.informatik.uni-erlangen.de (Postfix, from userid 30063)
        id 7094EB00B74; Wed, 19 Jun 2019 17:46:57 +0200 (CEST)
From:   Lukas Schneider <lukas.s.schneider@fau.de>
To:     kim.jamie.bradley@gmail.com, pakki001@umn.edu,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Lukas Schneider <lukas.s.schneider@fau.de>,
        Jannik Moritz <jannik.moritz@fau.de>, linux-kernel@i4.cs.fau.de
Subject: [PATCH 3/4] rts5208: Fix usleep_range is preferred over udelay
Date:   Wed, 19 Jun 2019 17:46:47 +0200
Message-Id: <20190619154648.13840-3-lukas.s.schneider@fau.de>
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
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/rts5208/rtsx_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_chip.c b/drivers/staging/rts5208/rtsx_chip.c
index 76c35f3c0208..8cddfe542d56 100644
--- a/drivers/staging/rts5208/rtsx_chip.c
+++ b/drivers/staging/rts5208/rtsx_chip.c
@@ -1803,7 +1803,7 @@ void rtsx_exit_ss(struct rtsx_chip *chip)
 
 	if (chip->power_down_in_ss) {
 		rtsx_force_power_on(chip, SSC_PDCTL | OC_PDCTL);
-		udelay(1000);
+		usleep_range(1000, 1010);
 	}
 
 	if (RTSX_TST_DELINK(chip)) {
-- 
2.19.1

