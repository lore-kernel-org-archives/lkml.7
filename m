Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A02CC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DF52184E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PsLHerYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436507AbfHINee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:34:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38983 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407127AbfHINec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:34:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so8147267wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSA7ezdPPag+s30NiG1INKw2c+i3SxQK3zdXCLkhRcc=;
        b=PsLHerYoUVRKASnwTKpiAHQR0yPELiRX+g+NPh9prYQur1qyuSIfRI9PXP0Ob5CJp2
         HPSso9SxnVC7il0jzaoVV9lJC6Ex7sVcFdBqN/S3qOmWNjZMJ8rm0TEGcsqbB0CAcH5K
         fyZbwFQD3D/CnClOZa2uSp5cr/QjbAktrc4mFi1VK8uSKqaex2aNsIEgcg7+IdI7zYi0
         xJX5+xEAyIYNbHAARfShnXDBAftp15zQHxpDPB2AAU9xbMcZxVIVBcpC5QD1peeHs+TV
         oHBwA+QBhimbf9/kN9APXDT3/9VvtWTAOTgNcJVKr8OOeFTUSJjQNUsvDC3qBFv9B6Bf
         YYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSA7ezdPPag+s30NiG1INKw2c+i3SxQK3zdXCLkhRcc=;
        b=DU9+hlDr6F2SIFRqKmrdT/ATIAt0Brop6lA80DFiRaN5fXtHFwk8nndrDTEfI7Ps8C
         nexNkqDtv1b7fFhMH9c0Gbl9HpegZIN4P54goe24w66UOdXXlGANel9E5dI5uuX40Q/E
         4O67+arVS0tONU8rwRU42qOroPG8+FqmB5juoJFtBSm3cLsCV0oO9+VYdRwYf5g7Y6xP
         rDBxeW5zIIpGok3/zkQgqZ5YPsY2EPHr7uHrz6UmvNKbW2ybtlaaaGjdTC+azxUxO3cN
         UTDOSd0SopEZeMrCUSD2idw8Xv6u7TVD6UTSgYtuGz5yeLzzlcExQa6XTYPgmB6O8Naz
         DrWQ==
X-Gm-Message-State: APjAAAUnafcU0nLMe4vvTaxPPq7Fq2NHDQ9RrlVvepaBXSmFL3ouiQUq
        I5lUcpLfe1TfHDxuIzacYK0dJA==
X-Google-Smtp-Source: APXvYqwlUmqdetUDTyTK+lXVK3bZa3Ttblwj2qzFWoaZD/WRa1755r4Jj/b9Aq2U0IDNuwXtzb074g==
X-Received: by 2002:adf:f206:: with SMTP id p6mr24947252wro.216.1565357670593;
        Fri, 09 Aug 2019 06:34:30 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y18sm5674641wmi.23.2019.08.09.06.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:34:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/4] soundwire: core: add device tree support for slave devices
Date:   Fri,  9 Aug 2019 14:34:05 +0100
Message-Id: <20190809133407.25918-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
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
 drivers/soundwire/bus.c   |  2 ++
 drivers/soundwire/bus.h   |  1 +
 drivers/soundwire/slave.c | 44 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index fe745830a261..324c54dc52fb 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -77,6 +77,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	 */
 	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
 		ret = sdw_acpi_find_slaves(bus);
+	else if (IS_ENABLED(CONFIG_OF) && bus->dev->of_node)
+		ret = sdw_of_find_slaves(bus);
 	else
 		ret = -ENOTSUPP; /* No ACPI/DT so error out */
 
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
index f39a5815e25d..c0dd79fc4fc5 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -2,6 +2,7 @@
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/acpi.h>
+#include <linux/of.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
@@ -35,6 +36,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 
 	slave->dev.release = sdw_slave_release;
 	slave->dev.bus = &sdw_bus_type;
+	slave->dev.of_node = of_node_get(to_of_node(fwnode));
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
 	slave->dev_num = 0;
@@ -112,3 +114,45 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 }
 
 #endif
+
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
+	for_each_child_of_node(bus->dev->of_node, node) {
+		struct sdw_slave_id id;
+		const char *compat = NULL;
+		int unique_id, link_id, sdw_version, ret;
+
+		compat = of_get_property(node, "compatible", NULL);
+		if (!compat)
+			continue;
+
+		ret = sscanf(compat, "sdw%01x%01x%01x%04hx%04hx%02hhx",
+			     &link_id, &sdw_version, &unique_id, &id.mfg_id,
+			     &id.part_id, &id.class_id);
+
+		if (ret != 6) {
+			dev_err(dev, "Invalid compatible string found %s\n",
+				compat);
+			continue;
+		}
+
+		/* Check for link_id match */
+		if (link_id != bus->link_id)
+			continue;
+
+		id.sdw_version = sdw_version;
+		id.unique_id = unique_id;
+		sdw_slave_add(bus, &id, of_fwnode_handle(node));
+	}
+
+	return 0;
+}
-- 
2.21.0

