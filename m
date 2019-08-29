Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A3DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A41C2341B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkAfVlr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfH2OpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:45:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50983 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfH2OpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:45:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so4042481wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0y/VQ+YRgpX5o2wxlaY+4cXYuAJOmCwTGDSCpRsawzo=;
        b=NkAfVlr432msV3xiejrJCyjhA0VgLAduniaZbLpPM/u0czuJsdy92Lnf77knkplR0m
         dZKuZD7vEcceC66QCJQVbwtUKce/BRcvv2VgLcwP8kGTrHf6PB4IS6lxgPHup/REV7BO
         y3SdHAyWNGl4T8HXhXrAu3iy2nf/yslRwvGNqB/heA9Zeu3GkGCaUB53EbXjvadLXZlQ
         rjOaSfCQKlMOqVNf/ahb0pWn/rEKyYsNmEzbfJ/E84xbjhe7cuhxW1qSvC14i+PaEDFp
         X/UIOvzYNvSqtwX3I8hhWgTw4weJvEhoYblpGenKlJKfoJeeA3u3YuL7jVCFUSVYeaSD
         CpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0y/VQ+YRgpX5o2wxlaY+4cXYuAJOmCwTGDSCpRsawzo=;
        b=TDRrHN3esNal65eFcZAiaRCxgd6eM3sCd/nT5dOf+H3rJotwZK1SQ8YQ8VTcgrujS3
         z6A0efbnE13kwkBwyDVMx7xXZPmc6ZAKGZtRZsmykVNPwhWlyPjYAdEmhwtfOEWt8ZXK
         eBwqDBNOgEMJsy/qJbpGRAFB90TDAtKFvPGb4Dx20MqlzyrPWGBDCBmdeDRXfv6lMF8i
         LimvDLz8AwsIHcxuLFg0xNVe/woMZnjFubp/pdBG2gKqCYcMNOBgIHCqNLirxFRWMza9
         Zs17/+uHbuceiF1UPntUAjj/mWTKrDcfSHNUa7D+mgf3OGqT2LkDFmALuXCQd2EkdRzs
         BOVw==
X-Gm-Message-State: APjAAAUYFYrAprfUH2DfJgEhqqVwY6ojkH7VABtJIx3Dpbz5Kh3Cx5l9
        Ob4Ls/RiOhalwuAMbMsAE19WtA==
X-Google-Smtp-Source: APXvYqx/D6IG4hoWdIjJJtU9+t9EGGOobaU4WAT40fe4a30HBk3wxKjh4WRq9+JdHaet/zN1VPDmkg==
X-Received: by 2002:a05:600c:22c6:: with SMTP id 6mr3555569wmg.5.1567089901850;
        Thu, 29 Aug 2019 07:45:01 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p7sm3923492wmh.38.2019.08.29.07.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:45:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 2/4] soundwire: core: add device tree support for slave devices
Date:   Thu, 29 Aug 2019 15:44:40 +0100
Message-Id: <20190829144442.6210-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
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
 drivers/soundwire/slave.c | 52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 728db3ebad6e..d83d89b3b15a 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -79,6 +79,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	 */
 	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
 		ret = sdw_acpi_find_slaves(bus);
+	else if (IS_ENABLED(CONFIG_OF) && bus->dev->of_node)
+		ret = sdw_of_find_slaves(bus);
 	else
 		ret = -ENOTSUPP; /* No ACPI/DT so error out */
 
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 9d6ea7e447ff..cb482da914da 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -15,6 +15,7 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
 }
 #endif
 
+int sdw_of_find_slaves(struct sdw_bus *bus);
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			  u64 addr, struct sdw_slave_id *id);
 
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 4b522f6d1238..48a63ca130d2 100644
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
@@ -113,3 +115,53 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
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
+		int link_id, sdw_version, ret, len;
+		const char *compat = NULL;
+		struct sdw_slave_id id;
+		const __be32 *addr;
+
+		compat = of_get_property(node, "compatible", NULL);
+		if (!compat)
+			continue;
+
+		ret = sscanf(compat, "sdw%01x%04hx%04hx%02hhx", &sdw_version,
+			     &id.mfg_id, &id.part_id, &id.class_id);
+
+		if (ret != 4) {
+			dev_err(dev, "Invalid compatible string found %s\n",
+				compat);
+			continue;
+		}
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || (len < 2 * sizeof(u32))) {
+			dev_err(dev, "Invalid Link and Instance ID\n");
+			continue;
+		}
+
+		link_id = be32_to_cpup(addr++);
+		id.unique_id = be32_to_cpup(addr);
+		id.sdw_version = sdw_version;
+
+		/* Check for link_id match */
+		if (link_id != bus->link_id)
+			continue;
+
+		sdw_slave_add(bus, &id, of_fwnode_handle(node));
+	}
+
+	return 0;
+}
-- 
2.21.0

