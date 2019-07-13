Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447E1C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E43620850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfGMJHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 05:07:32 -0400
Received: from mailoutvs25.siol.net ([185.57.226.216]:37247 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727626AbfGMJHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 05:07:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 2FE0A521342;
        Sat, 13 Jul 2019 11:07:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3sEoT0nUKPK7; Sat, 13 Jul 2019 11:07:28 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id E3CDA520F68;
        Sat, 13 Jul 2019 11:07:28 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id A908D5213CE;
        Sat, 13 Jul 2019 11:07:26 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     broonie@kernel.org, wens@csie.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 2/2] regulator: axp20x: fix DCDC5 and DCDC6 for AXP803
Date:   Sat, 13 Jul 2019 11:07:17 +0200
Message-Id: <20190713090717.347-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190713090717.347-1-jernej.skrabec@siol.net>
References: <20190713090717.347-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring of axp20x driver introduced a bug in AXP803's DCDC6
regulator definition. AXP803_DCDC6_1120mV_STEPS was obtained by
subtracting 0x47 and 0x33. This should be 0x14 (hex) and not 14
(dec).

Refactoring also carried over a bug in DCDC5 regulator definition.
Number of possible voltages must be for 1 bigger than maximum valid
voltage index, because 0 is also valid and it means lowest voltage.

Fixes: 1dbe0ccb0631 ("regulator: axp20x-regulator: add support for AXP803=
")
Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/regulator/axp20x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
index c951568994a1..989506bd90b1 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -174,14 +174,14 @@
 #define AXP803_DCDC5_1140mV_STEPS	35
 #define AXP803_DCDC5_1140mV_END		\
 	(AXP803_DCDC5_1140mV_START + AXP803_DCDC5_1140mV_STEPS)
-#define AXP803_DCDC5_NUM_VOLTAGES	68
+#define AXP803_DCDC5_NUM_VOLTAGES	69
=20
 #define AXP803_DCDC6_600mV_START	0x00
 #define AXP803_DCDC6_600mV_STEPS	50
 #define AXP803_DCDC6_600mV_END		\
 	(AXP803_DCDC6_600mV_START + AXP803_DCDC6_600mV_STEPS)
 #define AXP803_DCDC6_1120mV_START	0x33
-#define AXP803_DCDC6_1120mV_STEPS	14
+#define AXP803_DCDC6_1120mV_STEPS	20
 #define AXP803_DCDC6_1120mV_END		\
 	(AXP803_DCDC6_1120mV_START + AXP803_DCDC6_1120mV_STEPS)
 #define AXP803_DCDC6_NUM_VOLTAGES	72
--=20
2.22.0

