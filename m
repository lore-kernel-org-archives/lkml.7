Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DB2C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E7520673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NYPkL4TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392683AbfIXRDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:03:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58740 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403997AbfIXQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:42:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8OGgFLK054408;
        Tue, 24 Sep 2019 11:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569343335;
        bh=iTVrMjr1jpW2jGLDHpDluWhwBeMusQS6Cqz8cCy6Yzo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NYPkL4TFtfvQV/nq+u2xYW7vD8wU2Az7LWpDw1hvnIk/f61qnLDYlraLvOwsm8OQS
         tsNlA6bwHQT5g2OfKtpMy7I85/H0v2EYiO9bjP/m+rdtJqFUkQVI1b3V43BjpltJBW
         l3AvgtA2oUYT/RULR5hwMD4aZ2Frx5RSDHGOSa3g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8OGgFLk079041
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Sep 2019 11:42:15 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 24
 Sep 2019 11:42:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 24 Sep 2019 11:42:14 -0500
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8OGgCQT073229;
        Tue, 24 Sep 2019 11:42:14 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Prabhakar Lad <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: [Patch v3 1/8] media: i2c: ov2659: Fix for image wrap-around in lower resolution
Date:   Tue, 24 Sep 2019 11:44:07 -0500
Message-ID: <20190924164414.21897-2-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190924164414.21897-1-bparrot@ti.com>
References: <20190924164414.21897-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on recently found sensor configuration examples, it was
discovered that when scaling and binning are used for the lower
resolutions (i.e. 640x480, 320x240) the read offset has to be
increased otherwise the image appears to be wrapped around.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/media/i2c/ov2659.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index f4ded0669ff9..17573257097d 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -661,7 +661,7 @@ static struct sensor_register ov2659_vga[] = {
 	{ REG_TIMING_HORIZ_FORMAT, 0x01 },
 	{ 0x370a, 0x52 },
 	{ REG_VFIFO_READ_START_H, 0x00 },
-	{ REG_VFIFO_READ_START_L, 0x80 },
+	{ REG_VFIFO_READ_START_L, 0xa0 },
 	{ REG_ISP_CTRL02, 0x10 },
 	{ REG_NULL, 0x00 },
 };
@@ -709,7 +709,7 @@ static  struct sensor_register ov2659_qvga[] = {
 	{ REG_TIMING_HORIZ_FORMAT, 0x01 },
 	{ 0x370a, 0x52 },
 	{ REG_VFIFO_READ_START_H, 0x00 },
-	{ REG_VFIFO_READ_START_L, 0x80 },
+	{ REG_VFIFO_READ_START_L, 0xa0 },
 	{ REG_ISP_CTRL02, 0x10 },
 	{ REG_NULL, 0x00 },
 };
-- 
2.17.1

