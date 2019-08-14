Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D356C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5E7206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfHNNY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:24:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:15870 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfHNNYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:24:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 06:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="194533757"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2019 06:24:22 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: typec: fusb302: Remove unused properties
Date:   Wed, 14 Aug 2019 16:24:17 +0300
Message-Id: <20190814132419.39759-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the deprecated fusb302 specific properties. There
are no more platforms using them.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index c524088246ee..074fbb17fa8b 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1670,29 +1670,6 @@ static int init_gpio(struct fusb302_chip *chip)
 	return 0;
 }
 
-static int fusb302_composite_snk_pdo_array(struct fusb302_chip *chip)
-{
-	struct device *dev = chip->dev;
-	u32 max_uv, max_ua;
-
-	chip->snk_pdo[0] = PDO_FIXED(5000, 400, PDO_FIXED_FLAGS);
-
-	/*
-	 * As max_snk_ma/mv/mw is not needed for tcpc_config,
-	 * those settings should be passed in via sink PDO, so
-	 * "fcs, max-sink-*" properties will be deprecated, to
-	 * perserve compatibility with existing users of them,
-	 * we read those properties to convert them to be a var
-	 * PDO.
-	 */
-	if (device_property_read_u32(dev, "fcs,max-sink-microvolt", &max_uv) ||
-		device_property_read_u32(dev, "fcs,max-sink-microamp", &max_ua))
-		return 1;
-
-	chip->snk_pdo[1] = PDO_VAR(5000, max_uv / 1000, max_ua / 1000);
-	return 2;
-}
-
 static int fusb302_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1701,7 +1678,6 @@ static int fusb302_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	const char *name;
 	int ret = 0;
-	u32 v;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
 		dev_err(&client->dev,
@@ -1721,11 +1697,10 @@ static int fusb302_probe(struct i2c_client *client,
 	chip->tcpc_dev.fwnode =
 		device_get_named_child_node(dev, "connector");
 
-	if (!device_property_read_u32(dev, "fcs,operating-sink-microwatt", &v))
-		chip->tcpc_config.operating_snk_mw = v / 1000;
-
 	/* Composite sink PDO */
-	chip->tcpc_config.nr_snk_pdo = fusb302_composite_snk_pdo_array(chip);
+	chip->snk_pdo[0] = PDO_FIXED(5000, 400, PDO_FIXED_FLAGS);
+
+	chip->tcpc_config.nr_snk_pdo = 1;
 	chip->tcpc_config.snk_pdo = chip->snk_pdo;
 
 	/*
-- 
2.20.1

