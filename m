Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217BEC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86D52080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPRC/yHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfFKKlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:41:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46908 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387527AbfFKKlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:41:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so12390125wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJU4aHR0rVsdWBrGZXQ39RDqJgxX93qjHiD8SWybkaM=;
        b=RPRC/yHewHSIblBTN67aXej0xEEkdQgIhaXh2ybmwsLf+Cosr6xLs0PO0YCnzb4o9k
         hlOqYHb92RjF3YMh/W5dtVSKpxn1JWJgg4bgrkWwd0QG5AP7pmR+x9UINg0gQii3+2RW
         s/jWdAPSOCHS7BQT9tvgNRvplvmqo249sSbf4qNAGHLGchiXPe4LYcigmjeLns/Y2wC0
         qOAwzOhQmMREdx13qIPdtFt50qam581ngygcDOwI0c9qRZDQ7kbuWZI58J1g0iiiYwaW
         Rl7ycVEk7dq0+DngyU+xk7UQo+kQ/3liwt4BsZn//8XZxoAggzsOqjY5BRnMYPLuVhFe
         0UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJU4aHR0rVsdWBrGZXQ39RDqJgxX93qjHiD8SWybkaM=;
        b=DZI2SY0sWosV3F29p60Cc2EmoAjvctCOEG1hUjhDRFOXCe8HxuSHIMuVMytTWRgxMs
         GXbw06RmkFc1oMS0Cjg3vn6RS9LMsEbhuoviwezuk50t+ySyzi6FdSk4jEO1uZD9a34d
         0HfLIWLR4tIKYSyWVEJHq/pU/wkbnFT9PNBwvokjyIzBJgK5IoInFtkNZHB0eLZuqANH
         f5nMQrijHyU2srHF60GS+PjJQ36NaHtFlxjsZCy6pe3S9zEieC8VPXtLWyoR9Jo8LaE6
         fXparXb8qiOXiZKzIMKIAXqwJZm5fYNCOz1pY/4pD35SB1Cz7JlgbfYxfX/JQrA/h4/s
         Q0dg==
X-Gm-Message-State: APjAAAUKtIFQzGKM/KyTIo63i8tIhjjXfsRjPNdWhPwkWGa7sARRZGX4
        ViDO3kDGZulCO7qqO8anXmwyQQ==
X-Google-Smtp-Source: APXvYqzBWw1MjNjHAKzC6fJlE0R8arif02WUl3DHjCYY6cv3RJtRVXlhZ7RHFgMENqoxZfFsJf8Plw==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr48143892wrn.244.1560249660756;
        Tue, 11 Jun 2019 03:41:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c65sm2359614wma.44.2019.06.11.03.40.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 03:41:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 2/5] soundwire: core: add device tree support for slave devices
Date:   Tue, 11 Jun 2019 11:40:40 +0100
Message-Id: <20190611104043.22181-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to parsing device tree based
SoundWire slave devices.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/bus.c   |  2 +-
 drivers/soundwire/bus.h   |  1 +
 drivers/soundwire/slave.c | 54 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index fe745830a261..20f26cf4ba74 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -78,7 +78,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
 		ret = sdw_acpi_find_slaves(bus);
 	else
-		ret = -ENOTSUPP; /* No ACPI/DT so error out */
+		ret = sdw_of_find_slaves(bus);
 
 	if (ret) {
 		dev_err(bus->dev, "Finding slaves failed:%d\n", ret);
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 3048ca153f22..ee46befedbd1 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -15,6 +15,7 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
 }
 #endif
 
+int sdw_of_find_slaves(struct sdw_bus *bus);
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			  u64 addr, struct sdw_slave_id *id);
 
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index f39a5815e25d..6e7f5cfeb854 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -2,6 +2,7 @@
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/acpi.h>
+#include <linux/of.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
@@ -28,13 +29,14 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->dev.parent = bus->dev;
 	slave->dev.fwnode = fwnode;
 
-	/* name shall be sdw:link:mfg:part:class:unique */
+	/* name shall be sdw:link:mfg:part:class */
 	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
 		     bus->link_id, id->mfg_id, id->part_id,
 		     id->class_id, id->unique_id);
 
 	slave->dev.release = sdw_slave_release;
 	slave->dev.bus = &sdw_bus_type;
+	slave->dev.of_node = of_node_get(to_of_node(fwnode));
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
 	slave->dev_num = 0;
@@ -112,3 +114,53 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 }
 
 #endif
+
+#if IS_ENABLED(CONFIG_OF)
+/*
+ * sdw_of_find_slaves() - Find Slave devices in master device tree node
+ * @bus: SDW bus instance
+ *
+ * Scans Master DT node for SDW child Slave devices and registers it.
+ */
+int sdw_of_find_slaves(struct sdw_bus *bus)
+{
+	struct device *dev = bus->dev;
+	struct device_node *node;
+
+	if (!bus->dev->of_node)
+		return 0;
+
+	for_each_child_of_node(bus->dev->of_node, node) {
+		struct sdw_slave_id id;
+		const char *compat = NULL;
+		int unique_id, ret;
+		int ver, mfg_id, part_id, class_id;
+		compat = of_get_property(node, "compatible", NULL);
+		if (!compat)
+			continue;
+
+		ret = sscanf(compat, "sdw%x,%x,%x,%x",
+			     &ver, &mfg_id, &part_id, &class_id);
+		if (ret != 4) {
+			dev_err(dev, "Manf ID & Product code not found %s\n",
+				compat);
+			continue;
+		}
+
+		ret = of_property_read_u32(node, "sdw-instance-id", &unique_id);
+		if (ret) {
+			dev_err(dev, "Instance id not found:%d\n", ret);
+			continue;
+		}
+
+		id.sdw_version = ver - 0xF;
+		id.unique_id = unique_id;
+		id.mfg_id = mfg_id;
+		id.part_id = part_id;
+		id.class_id = class_id;
+		sdw_slave_add(bus, &id, of_fwnode_handle(node));
+	}
+	return 0;
+}
+
+#endif
-- 
2.21.0

