Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D0C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E876B2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbfFJJwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:52:37 -0400
Received: from sauhun.de ([88.99.104.3]:39680 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388033AbfFJJw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:52:29 -0400
Received: from localhost (p54B33062.dip0.t-ipconnect.de [84.179.48.98])
        by pokefinder.org (Postfix) with ESMTPSA id D6CB12C78FF;
        Mon, 10 Jun 2019 11:52:27 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: lm90: simplify getting the adapter of a client
Date:   Mon, 10 Jun 2019 11:51:54 +0200
Message-Id: <20190610095157.11814-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190610095157.11814-1-wsa+renesas@sang-engineering.com>
References: <20190610095157.11814-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Reported-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/hwmon/lm90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index e562a578f20e..2ebcab8b0a9b 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1718,7 +1718,7 @@ static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	struct i2c_adapter *adapter = to_i2c_adapter(dev->parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct hwmon_channel_info *info;
 	struct regulator *regulator;
 	struct device *hwmon_dev;
-- 
2.19.1

