Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA4C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC572084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfGMJHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 05:07:30 -0400
Received: from mailoutvs30.siol.net ([185.57.226.221]:37229 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726421AbfGMJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 05:07:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id ED7B85213B5;
        Sat, 13 Jul 2019 11:07:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IeTJI_Ae8HlN; Sat, 13 Jul 2019 11:07:26 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id A50F9521385;
        Sat, 13 Jul 2019 11:07:26 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 64CD45213B5;
        Sat, 13 Jul 2019 11:07:24 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     broonie@kernel.org, wens@csie.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 1/2] regulator: axp20x: fix DCDCA and DCDCD for AXP806
Date:   Sat, 13 Jul 2019 11:07:16 +0200
Message-Id: <20190713090717.347-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190713090717.347-1-jernej.skrabec@siol.net>
References: <20190713090717.347-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring of the driver introduced bugs in AXP806's DCDCA and DCDCD
regulator definitions.

In DCDCA case, AXP806_DCDCA_1120mV_STEPS was obtained by subtracting
0x47 and 0x33. This should be 0x14 (hex) and not 14 (dec).

In DCDCD case, axp806_dcdcd_ranges[] contains two ranges with same
start and end macros, which is clearly wrong. Second range starts at
1.6V so it should use AXP806_DCDCD_1600mV_[START|END] macros. They are
already defined but unused.

Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/regulator/axp20x-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
index 152053361862..c951568994a1 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -240,7 +240,7 @@
 #define AXP806_DCDCA_600mV_END		\
 	(AXP806_DCDCA_600mV_START + AXP806_DCDCA_600mV_STEPS)
 #define AXP806_DCDCA_1120mV_START	0x33
-#define AXP806_DCDCA_1120mV_STEPS	14
+#define AXP806_DCDCA_1120mV_STEPS	20
 #define AXP806_DCDCA_1120mV_END		\
 	(AXP806_DCDCA_1120mV_START + AXP806_DCDCA_1120mV_STEPS)
 #define AXP806_DCDCA_NUM_VOLTAGES	72
@@ -774,8 +774,8 @@ static const struct regulator_linear_range axp806_dcd=
cd_ranges[] =3D {
 			       AXP806_DCDCD_600mV_END,
 			       20000),
 	REGULATOR_LINEAR_RANGE(1600000,
-			       AXP806_DCDCD_600mV_START,
-			       AXP806_DCDCD_600mV_END,
+			       AXP806_DCDCD_1600mV_START,
+			       AXP806_DCDCD_1600mV_END,
 			       100000),
 };
=20
--=20
2.22.0

