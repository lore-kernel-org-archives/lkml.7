Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3FAC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A7221897
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfGVR3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:29:21 -0400
Received: from sauhun.de ([88.99.104.3]:42116 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbfGVR0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:13 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 5DCBA4A1491;
        Mon, 22 Jul 2019 19:26:12 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: smm665: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:09 +0200
Message-Id: <20190722172611.3797-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172611.3797-1-wsa+renesas@sang-engineering.com>
References: <20190722172611.3797-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/hwmon/smm665.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
index d8c91c2cb8cf..6eff14fe395d 100644
--- a/drivers/hwmon/smm665.c
+++ b/drivers/hwmon/smm665.c
@@ -586,10 +586,10 @@ static int smm665_probe(struct i2c_client *client,
 
 	data->client = client;
 	data->type = id->driver_data;
-	data->cmdreg = i2c_new_dummy(adapter, (client->addr & ~SMM665_REGMASK)
+	data->cmdreg = i2c_new_dummy_device(adapter, (client->addr & ~SMM665_REGMASK)
 				     | SMM665_CMDREG_BASE);
-	if (!data->cmdreg)
-		return -ENOMEM;
+	if (IS_ERR(data->cmdreg))
+		return PTR_ERR(data->cmdreg);
 
 	switch (data->type) {
 	case smm465:
-- 
2.20.1

