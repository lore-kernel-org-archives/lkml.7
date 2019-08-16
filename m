Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B50CC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6E72133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfHPIiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:38:52 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:1960 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfHPIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:38:35 -0400
IronPort-SDR: TmISLMvP+cH8CB04Eyy0tzr4FT/0u7aLS+2XewAeKsOuKAagS37MRKFZ2T+I4Y2av00V5e4Rr4
 uA3DB56/PPATmxHFBHpNG/UyEz8PanL9q9vgq1rTZCPEl7fn07GJAAu5FjTSFP5EyTEKHDNV4X
 eNs0PBU3Z3OU6f8qPKjqt1BsZ5FoLCgXGqho0SIaA2uvD4CelU0xXhnMhd70MD2c5v2Krwcvrz
 U23Xy1FPXFWH5u9xpHs4YVVgVrcjmoVEASlShoXYrJDV4wZeR3bHl/aNOlN9m77aEK6PVd14t5
 PF0=
X-IronPort-AV: E=Sophos;i="5.64,391,1559548800"; 
   d="scan'208";a="40484314"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 16 Aug 2019 00:35:30 -0800
IronPort-SDR: tAvK5iOlp1y6IzwlqWlep0J6MsbnICLQPRRDIa6LGlttlaILcV1EnMssuq7SFRKJ8RL7OuImkl
 IypbLD/tWK0rhegmzuhFH57js6NiNfluevlsDM1jmIj7LrGTxeYKsH4LSNqSGiOQncZdGE8tBX
 jSkRw9ITtbRoWuSSOuKrvJmwc4ML3CMktK4RhRq8lQagGK1wOQ+HlgwPovPP4TeBFQE4tqp2Qk
 JjsfquqWJ43ZV5WCVlJTfmecPH9l3Fhx7cqzzPdmC6J/1mGS+4bicNRu9C79tT2xM+j4EpW/pf
 h+U=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>, <george_davis@mentor.com>
Subject: [PATCH v1 39/63] Input: touchscreen: Atmel: Add device tree support for T15 key array objects
Date:   Fri, 16 Aug 2019 17:35:01 +0900
Message-ID: <20190816083525.19071-5-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190816083525.19071-1-jiada_wang@mentor.com>
References: <20190816083525.19071-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gong <Zhanli.Gong@cn.bosch.com>

Signed-off-by: Daniel Gong <Zhanli.Gong@cn.bosch.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index be63002c2b31..3b9544c0a209 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -4143,10 +4143,12 @@ static int mxt_parse_device_properties(struct mxt_data *data)
 {
 	static const char keymap_property[] = "linux,gpio-keymap";
 	static const char gpios_property[] = "atmel,gpios";
+	static const char buttons_property[] = "atmel,key-buttons";
 	struct device *dev = &data->client->dev;
 	struct device_node *np = dev ? dev->of_node : NULL;
 	struct device_node *np_gpio;
 	u32 *keymap;
+	u32 *buttonmap;
 	int n_keys;
 	int error;
 
@@ -4181,6 +4183,33 @@ static int mxt_parse_device_properties(struct mxt_data *data)
 		data->t19_num_keys = n_keys;
 	}
 
+	if (device_property_present(dev, buttons_property)) {
+		n_keys = device_property_read_u32_array(dev, buttons_property,
+							NULL, 0);
+		if (n_keys <= 0) {
+			error = n_keys < 0 ? n_keys : -EINVAL;
+			dev_err(dev, "invalid/malformed '%s' property: %d\n",
+				buttons_property, error);
+			return error;
+		}
+
+		buttonmap = devm_kmalloc_array(dev, n_keys, sizeof(*buttonmap),
+					       GFP_KERNEL);
+		if (!buttonmap)
+			return -ENOMEM;
+
+		error = device_property_read_u32_array(dev, buttons_property,
+						       buttonmap, n_keys);
+		if (error) {
+			dev_err(dev, "failed to parse '%s' property: %d\n",
+				buttons_property, error);
+			return error;
+		}
+
+		data->t15_keymap = buttonmap;
+		data->t15_num_keys = n_keys;
+	}
+
 	device_property_read_u32(dev, "atmel,suspend-mode", &data->suspend_mode);
 
 	np_gpio = of_get_child_by_name(np, gpios_property);
-- 
2.19.2

