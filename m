Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21007233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hdh1e0vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfHVXi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:38:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35456 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfHVXiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:38:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id k2so6957796wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEysXn0BHtJ7BnPMP+dSrHUvSy8/goLl6VzMxecNkns=;
        b=Hdh1e0vdmHrJYBwIbbD5Lk9wGK6lz7Ln0Rumc29tiH3kGuxJc4cez410CygTt5ia79
         1qGOwO5JqHDlNYihAcM4LfArfFjrHJ7KMoy41e1BfMa0FreZb+4ZwB83/udYC3o0ce7f
         nTuNvc2XyCAZY99sKdEoNXSwXuHg+1ngQ0LxU7sOHytsV1RPiFhch4Xys2EOX1I0kPtH
         zoZpJ4/r+81lE4nsK0ZKPvcRIBMEun/4m7sp5iGSQIBYbJ+uGUrRZSQseALCx9mYMIT6
         MK2Jayx4cFOHWwHXOuD3e/evySK1baODNGro19U/e/hrXAXJoOs/AmupLx/q/QcW+a4w
         SLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEysXn0BHtJ7BnPMP+dSrHUvSy8/goLl6VzMxecNkns=;
        b=kkfnTp6FW/mVejlUKuDgJqUISmSD+CuCPd59b8aasW5tO1ks5PBiqoUYCzaKDpfUzj
         7ogWHZn7MP9lbdLfNZI4HG2V6alaP8RU5+RXQ3Q6x+ZRqj/Mn386xQZoUiI8o9JsHUsV
         y+SCDd26eZHDQ2VlmLAgE9gl2e0dTbIpeJm7hfWBbte54bYtEl9pUevHXPaGfHfOHxCI
         yR1J34lm9uKrzF4tjyFg/brjaqu5D5QjNOOKrOjutRqvpA6oc4i3o/ji6CAqC/nmyScI
         MP2HjY1SxBgU8PFb+SomLCKkwMLvIGKCu91gDXPWPammt1TGgm83UTpfMkiB5HsY2COX
         82tg==
X-Gm-Message-State: APjAAAWjEuBQHbWWosqWjnJvOHFljHulpRErhP7KUIrnso86JocwXezv
        OXNvIAiJ4dLaN3/a8zZeOJNyxA==
X-Google-Smtp-Source: APXvYqy83P7CXzVIXqtf/xuRyQ9zXOK5Yb6wPDfXGzBTGnR7D3RgJUz1NGon2hz3zt813+fCWo7YMw==
X-Received: by 2002:adf:dbcd:: with SMTP id e13mr1250035wrj.314.1566517102181;
        Thu, 22 Aug 2019 16:38:22 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f134sm1705157wmg.20.2019.08.22.16.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 16:38:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v4 2/4] soundwire: core: add device tree support for slave devices
Date:   Fri, 23 Aug 2019 00:37:57 +0100
Message-Id: <20190822233759.12663-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
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
index 49f64b2115b9..c2eaeb5c38ed 100644
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
index f39a5815e25d..3ef265d2ee89 100644
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
@@ -112,3 +114,53 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
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
+			dev_err(dev, "Invalid Instance and Link ID\n");
+			continue;
+		}
+
+		id.unique_id = be32_to_cpup(addr++);
+		link_id = be32_to_cpup(addr);
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

