Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2263CC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0615420851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbfFMPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:54:34 -0400
Received: from sauhun.de ([88.99.104.3]:41948 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390102AbfFMPy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:54:27 -0400
Received: from localhost (p5486CF99.dip0.t-ipconnect.de [84.134.207.153])
        by pokefinder.org (Postfix) with ESMTPSA id F3DF44A12B1;
        Thu, 13 Jun 2019 17:54:25 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] media: zd1301_demod: don't check retval after our own assignemt
Date:   Thu, 13 Jun 2019 17:54:20 +0200
Message-Id: <20190613155421.16408-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613155421.16408-1-wsa+renesas@sang-engineering.com>
References: <20190613155421.16408-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to check a retval after we assigned a constant to it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/dvb-frontends/zd1301_demod.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/zd1301_demod.c b/drivers/media/dvb-frontends/zd1301_demod.c
index 96adbba7a82b..bbabe6a2d4f4 100644
--- a/drivers/media/dvb-frontends/zd1301_demod.c
+++ b/drivers/media/dvb-frontends/zd1301_demod.c
@@ -421,8 +421,7 @@ static int zd1301_demod_i2c_master_xfer(struct i2c_adapter *adapter,
 	} else {
 		dev_dbg(&pdev->dev, "unknown msg[0].len=%u\n", msg[0].len);
 		ret = -EOPNOTSUPP;
-		if (ret)
-			goto err;
+		goto err;
 	}
 
 	return num;
-- 
2.20.1

