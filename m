Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F6DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7F620862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvCOXy/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfJ1Xt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 19:49:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43868 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfJ1XtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:49:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id l24so8112934pgh.10;
        Mon, 28 Oct 2019 16:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KUGQ/r655QOzhF8y8PZXKFFUJNm6vbuBEcIikKPosIk=;
        b=gvCOXy/AmjPJG9Au95pDstcxJyiVgdnOiM7g6r9Mvoc7HQKAXyPdIcDaDZVNhbNMTu
         aeDUOQgXB/9BSiKMiDyFBQ8gei9wo1w34Il1GIcW0XX8VpojdcznlZzOC/Ucv+EfhMo2
         9NbmGKfhduldh/Gf3Xw4+Sm/uHGa/pFyesLWBbWwipUsE1cw9ohIi3JxJYc1gGnRiGT5
         67bYqTImcYLNOu9pasOq5qLNGOBYKt3VEKq0RHADaRlWNFPtJ5/KjOVg6iHRNknFqTGr
         MFsGlXwPr8Y/81bIATvsNgwkpoJvaaE+TjUA7a41c9e5MgN2pjNAVfyiIdaLdd0SG1wh
         4oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KUGQ/r655QOzhF8y8PZXKFFUJNm6vbuBEcIikKPosIk=;
        b=tj2gWLY+DEsTjHRdhlOyY3U42hV/4mDKr4kTs/6Xruk0znf7jCn7C8Gx/ePISD6ECz
         I5oIzZIxDsmr2rzX2I115K47LMFA+6vuws1qp0Pui8X4IsIwstd0CDf3aDec/K+T895N
         xx46cY5jlLFCB3Q+nhwehVBc96mHrHo2OIEgcj4S+mdYYR9Cugh01qjCAgiEWpnGbLa8
         6jrLuw7PGQI/b0v1Vzo2nz5bl/GsxRfPABPthRC4rGTc6UhJT7RnmnRzwnJuWyiCXQ2w
         JLkthwpRC2PFoTGToi8K+bnjpp4orOEpYB6gSvDtrzHFlro1Nwl1YhZbYsFw/u1wU1nB
         D+yg==
X-Gm-Message-State: APjAAAU5Wqs0+1XsiVBrShCasYJdpsloY8iAPMWsLKrmu8xJDOFwRDbV
        /6ajRw7FZcNKt9zou02KYRo=
X-Google-Smtp-Source: APXvYqyB/VIWUUD6euIc1wIAj7+Kw8nEW24WdP9LBMqAwLPwyQpm/OUafznT7RjIrvuNsjxE/Wnw0A==
X-Received: by 2002:a17:90a:7bcc:: with SMTP id d12mr2429491pjl.63.1572306563244;
        Mon, 28 Oct 2019 16:49:23 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::2:c0c7])
        by smtp.gmail.com with ESMTPSA id d4sm597119pjs.9.2019.10.28.16.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 16:49:22 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/3] hwmon: (pmbus) add BEL PFE1100 power supply driver
Date:   Mon, 28 Oct 2019 16:49:02 -0700
Message-Id: <20191028234904.12441-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028234904.12441-1-rentao.bupt@gmail.com>
References: <20191028234904.12441-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add the driver to support BEL PFE1100 which is 1100 Wat AC to DC power
supply. The chip has only 1 page.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/hwmon/pmbus/Kconfig   |  9 +++++
 drivers/hwmon/pmbus/Makefile  |  1 +
 drivers/hwmon/pmbus/bel-pfe.c | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/bel-pfe.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index d62d69bb7e49..59859979571d 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -36,6 +36,15 @@ config SENSORS_ADM1275
 	  This driver can also be built as a module. If so, the module will
 	  be called adm1275.
 
+config SENSORS_BEL_PFE
+	tristate "Bel PFE Compatible Power Supplies"
+	help
+	  If you say yes here you get hardware monitoring support for BEL
+	  PFE1100 and PFE3000 Power Supplies.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called bel-pfe.
+
 config SENSORS_IBM_CFFPS
 	tristate "IBM Common Form Factor Power Supply"
 	depends on LEDS_CLASS
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 03bacfcfd660..3f8c1014938b 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
+obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
 obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
 obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
new file mode 100644
index 000000000000..117f9af21bf3
--- /dev/null
+++ b/drivers/hwmon/pmbus/bel-pfe.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for BEL PFE family power supplies.
+ *
+ * Copyright (c) 2019 Facebook Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include "pmbus.h"
+
+enum chips {pfe1100};
+
+static struct pmbus_driver_info pfe_driver_info[] = {
+	[pfe1100] = {
+		.pages = 1,
+		.format[PSC_VOLTAGE_IN] = linear,
+		.format[PSC_VOLTAGE_OUT] = linear,
+		.format[PSC_CURRENT_IN] = linear,
+		.format[PSC_CURRENT_OUT] = linear,
+		.format[PSC_POWER] = linear,
+		.format[PSC_TEMPERATURE] = linear,
+		.format[PSC_FAN] = linear,
+
+		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			   PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+			   PMBUS_HAVE_POUT |
+			   PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
+			   PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
+			   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
+			   PMBUS_HAVE_STATUS_TEMP |
+			   PMBUS_HAVE_FAN12,
+	},
+};
+
+static int pfe_pmbus_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	int model;
+
+	model = (int)id->driver_data;
+	return pmbus_do_probe(client, id, &pfe_driver_info[model]);
+}
+
+static const struct i2c_device_id pfe_device_id[] = {
+	{"pfe1100", pfe1100},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pfe_device_id);
+
+static struct i2c_driver pfe_pmbus_driver = {
+	.driver = {
+		   .name = "bel-pfe",
+	},
+	.probe = pfe_pmbus_probe,
+	.remove = pmbus_do_remove,
+	.id_table = pfe_device_id,
+};
+
+module_i2c_driver(pfe_pmbus_driver);
+
+MODULE_AUTHOR("Tao Ren <rentao.bupt@gmail.com>");
+MODULE_DESCRIPTION("PMBus driver for BEL PFE Family Power Supplies");
+MODULE_LICENSE("GPL");
-- 
2.17.1

