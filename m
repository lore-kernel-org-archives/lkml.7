Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4BA20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Jbb3q2jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfDDKRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:17:32 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:17070 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfDDKRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554373049; x=1585909049;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=D5COnaEMj1dSrN3bUntCS2/3FFeeDpM05/t1O4kXNR0=;
  b=Jbb3q2jfv5qK9q6DbrLxkSVAOmuCNTZ0fdmAiI5qTQ8fA5Z8HnYF2bvE
   AIG0QIgS+Qihi+O8c8p86Wrc6RUbwplegQfZCMY63tulet+S6U5FxOTSB
   EOP91gLur97VD/wCI1HoxKFwAxpX7Js8PmcLqYd4UstFZKMQLDhedwDZQ
   g=;
X-IronPort-AV: E=Sophos;i="5.60,308,1549929600"; 
   d="scan'208";a="725984711"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Apr 2019 10:17:28 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x34AHOml008449
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 4 Apr 2019 10:17:27 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 4 Apr 2019 10:17:26 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.69) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 4 Apr 2019 10:17:20 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <talel@amazon.com>, <robh@kernel.org>, <edubezval@gmail.com>,
        <dwmw@amazon.co.uk>, <jonnyc@amazon.com>, <rui.zhang@intel.com>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <hanochu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/2] thermal: Introduce Amazon's Annapurna Labs Thermal Driver
Date:   Thu, 4 Apr 2019 13:16:56 +0300
Message-ID: <1554373016-1442-3-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554373016-1442-1-git-send-email-talel@amazon.com>
References: <1554373016-1442-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13D25UWC003.ant.amazon.com (10.43.162.129) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a generic thermal driver for simple MMIO sensors, of which
amazon,al-thermal is one.

This device uses a single MMIO transaction to read the temperature and
report it to the thermal subsystem.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 MAINTAINERS                    |   6 ++
 drivers/thermal/Kconfig        |  10 ++++
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/thermal_mmio.c | 129 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 drivers/thermal/thermal_mmio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 955463f..262cb2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -727,6 +727,12 @@ S:	Supported
 F:	Documentation/networking/ena.txt
 F:	drivers/net/ethernet/amazon/
 
+AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
+M:	Talel Shenhar <talel@amazon.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
+F:	drivers/thermal/thermal_mmio.c
+
 AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 M:	Gary Hook <gary.hook@amd.com>
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 1775d44..96d9236 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -199,6 +199,16 @@ config THERMAL_EMULATION
 	  because userland can easily disable the thermal policy by simply
 	  flooding this sysfs node with low temperature values.
 
+config THERMAL_MMIO
+	tristate "Generic Thermal MMIO driver"
+	depends on OF || COMPILE_TEST
+	help
+	  This option enables the generic thermal MMIO driver that will use
+	  memory-mapped reads to get the temperature.  Any HW/System that
+	  allows temperature reading by a single memory-mapped reading, be it
+	  register or shared memory, is a potential candidate to work with this
+	  driver.
+
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82bb50d..d4c9ae7 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -29,6 +29,7 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
 # platform thermal drivers
 obj-y				+= broadcom/
+obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
new file mode 100644
index 0000000..de3ccee
--- /dev/null
+++ b/drivers/thermal/thermal_mmio.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+struct thermal_mmio {
+	void __iomem *mmio_base;
+	u32 (*read_mmio)(void __iomem *mmio_base);
+	u32 mask;
+	int factor;
+};
+
+static u32 thermal_mmio_readb(void __iomem *mmio_base)
+{
+	return readb(mmio_base);
+}
+
+static int thermal_mmio_get_temperature(void *private, int *temp)
+{
+	int t;
+	struct thermal_mmio *sensor =
+		(struct thermal_mmio *)private;
+
+	t = sensor->read_mmio(sensor->mmio_base) & sensor->mask;
+	t *= sensor->factor;
+
+	*temp = t;
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops thermal_mmio_ops = {
+	.get_temp = thermal_mmio_get_temperature,
+};
+
+static int thermal_mmio_probe(struct platform_device *pdev)
+{
+	struct resource *resource;
+	struct thermal_mmio *sensor;
+	int (*sensor_init_func)(struct platform_device *pdev,
+				struct thermal_mmio *sensor);
+	struct thermal_zone_device *thermal_zone;
+	int ret;
+	int temperature;
+
+	sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
+
+	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (IS_ERR(resource)) {
+		dev_err(&pdev->dev,
+			"fail to get platform memory resource (%ld)\n",
+			PTR_ERR(resource));
+		return PTR_ERR(resource);
+	}
+
+	sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
+	if (IS_ERR(sensor->mmio_base)) {
+		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
+			PTR_ERR(sensor->mmio_base));
+		return PTR_ERR(sensor->mmio_base);
+	}
+
+	sensor_init_func = device_get_match_data(&pdev->dev);
+	if (sensor_init_func) {
+		ret = sensor_init_func(pdev, sensor);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to initialize sensor (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	thermal_zone = devm_thermal_zone_of_sensor_register(&pdev->dev,
+							    0,
+							    sensor,
+							    &thermal_mmio_ops);
+	if (IS_ERR(thermal_zone)) {
+		dev_err(&pdev->dev,
+			"failed to register sensor (%ld)\n",
+			PTR_ERR(thermal_zone));
+		return PTR_ERR(thermal_zone);
+	}
+
+	thermal_mmio_get_temperature(sensor, &temperature);
+	dev_info(&pdev->dev,
+		 "thermal mmio sensor %s registered, current temperature: %d\n",
+		 pdev->name, temperature);
+
+	return 0;
+}
+
+static int al_thermal_init(struct platform_device *pdev,
+			   struct thermal_mmio *sensor)
+{
+	sensor->read_mmio = thermal_mmio_readb;
+	sensor->mask = 0xff;
+	sensor->factor = 1000;
+
+	return 0;
+}
+
+static const struct of_device_id thermal_mmio_id_table[] = {
+	{ .compatible = "amazon,al-thermal", .data = al_thermal_init},
+	{}
+};
+MODULE_DEVICE_TABLE(of, thermal_mmio_id_table);
+
+static struct platform_driver thermal_mmio_driver = {
+	.probe = thermal_mmio_probe,
+	.driver = {
+		.name = "thermal-mmio",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(thermal_mmio_id_table),
+	},
+};
+
+module_platform_driver(thermal_mmio_driver);
+
+MODULE_AUTHOR("Talel Shenhar <talel@amazon.com>");
+MODULE_DESCRIPTION("Thermal MMIO Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

