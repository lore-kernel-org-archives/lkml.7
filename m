Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E829ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B810920578
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQNTSRDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfJ1Xt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 19:49:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34231 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfJ1XtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:49:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id e4so3836543pgs.1;
        Mon, 28 Oct 2019 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sDVKctYQFPQQhndxFna9vtm7wSyOf2hUQLavep1crp4=;
        b=sQNTSRDsXZpa47r1mRwPnfJ/BlGNsD34hfuusH+Yr0xkBhZh0VRjQhIWl8hJwtheyG
         Gx1X7Uv+3Q4vgAC32/wwAmh52D564MMfAICCAk1FvUZpfTZqiAAnv0ylDhw1gj8ulPft
         psaa6COHOGy5HZyH2124EqIjdehs+b29LIKRVpEQ5bJOSjp1pjRGD/5g5T+1mYpWMX7T
         6vMJsw3qV7TaIXVCOuAbGSwo6bq+WvxFchucWVNTrkfMIP2H7o39DHEkrE7OaHHc2FpQ
         PkBCUBuyu2JyItPrmV2qUfwm0lWb36Llj+N2RPomWix5gpE2qdlfuvIk5RfgJd4JCRbs
         7vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sDVKctYQFPQQhndxFna9vtm7wSyOf2hUQLavep1crp4=;
        b=E8031P5DTBqt6lJN705mJ3WEUp1XqgFa19tgWAihIO8FhNfPwhxq9whdETuBUHxE+f
         jnJetqGkcw7EyX6mCaTinK6VCHvFJSCCmo/wKQneKcKDIXZWeumA2IeMi89r1nw0jfpt
         ybQ5bcKN4De/n49XwFUCmNRU+PQ4eF1L02y178IuKb+V71CdfIbnpBBwgXD6tbWK9kwy
         Vc+X+LG0SCg84f0byqyGd5BCu7qtJaNl6LufQNQhvxVBKA6lTUO9EH90diHzMK0o1fBg
         JJPkhNhJ2Vd35meileW5e0vRRWv3zQOYZJH0UmVodM4Z17euPRONb21N7EOHyfvkl0Bc
         GDBw==
X-Gm-Message-State: APjAAAWAcfZ/Qu1YVjJSSH9+dTO5e/8xu73zUJ/BeIHfXuAzK8FIFYBC
        iBMLwYAAtjfvWwQQzayRK6m6GiXv4qk=
X-Google-Smtp-Source: APXvYqwy/8Fn5H0ZgY1iNeuIidNJTniA7Oj3ADDkqWaznlUkhLyG/mH7kmTYIfVVrbAwiBkj7bPLwg==
X-Received: by 2002:a17:90a:d149:: with SMTP id t9mr2403813pjw.108.1572306564400;
        Mon, 28 Oct 2019 16:49:24 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::2:c0c7])
        by smtp.gmail.com with ESMTPSA id d4sm597119pjs.9.2019.10.28.16.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 16:49:23 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/3] hwmon: (pmbus) add BEL PFE3000 power supply driver
Date:   Mon, 28 Oct 2019 16:49:03 -0700
Message-Id: <20191028234904.12441-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028234904.12441-1-rentao.bupt@gmail.com>
References: <20191028234904.12441-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add the driver to support BEL PFE3000 which is 3000 Wat AC to DC power
supply. The chip has 8 pages.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/hwmon/pmbus/bel-pfe.c | 65 ++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
index 117f9af21bf3..7b6c90b056c9 100644
--- a/drivers/hwmon/pmbus/bel-pfe.c
+++ b/drivers/hwmon/pmbus/bel-pfe.c
@@ -10,9 +10,21 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/pmbus.h>
+
 #include "pmbus.h"
 
-enum chips {pfe1100};
+enum chips {pfe1100, pfe3000};
+
+/*
+ * Disable status check for pfe3000 devices, because some devices report
+ * communication error (invalid command) for VOUT_MODE command (0x20)
+ * although correct VOUT_MODE (0x16) is returned: it leads to incorrect
+ * exponent in linear mode.
+ */
+static struct pmbus_platform_data pfe3000_plat_data = {
+	.flags = PMBUS_SKIP_STATUS_CHECK,
+};
 
 static struct pmbus_driver_info pfe_driver_info[] = {
 	[pfe1100] = {
@@ -34,6 +46,45 @@ static struct pmbus_driver_info pfe_driver_info[] = {
 			   PMBUS_HAVE_STATUS_TEMP |
 			   PMBUS_HAVE_FAN12,
 	},
+
+	[pfe3000] = {
+		.pages = 8,
+		.format[PSC_VOLTAGE_IN] = linear,
+		.format[PSC_VOLTAGE_OUT] = linear,
+		.format[PSC_CURRENT_IN] = linear,
+		.format[PSC_CURRENT_OUT] = linear,
+		.format[PSC_POWER] = linear,
+		.format[PSC_TEMPERATURE] = linear,
+		.format[PSC_FAN] = linear,
+
+		/* Page 0: V1. */
+		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			   PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+			   PMBUS_HAVE_POUT | PMBUS_HAVE_FAN12 |
+			   PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
+			   PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
+			   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
+			   PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP |
+			   PMBUS_HAVE_VCAP,
+
+		/* Page 1: Vsb. */
+		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			   PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+			   PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
+			   PMBUS_HAVE_POUT,
+
+		/*
+		 * Page 2: V1 Ishare.
+		 * Page 4: V1 Cathode.
+		 * Page 5: Vsb Cathode.
+		 * Page 6: V1 Sense.
+		 * Page 3 and 7 are reserved.
+		 */
+		.func[2] = PMBUS_HAVE_VOUT,
+		.func[4] = PMBUS_HAVE_VOUT,
+		.func[5] = PMBUS_HAVE_VOUT,
+		.func[6] = PMBUS_HAVE_VOUT,
+	},
 };
 
 static int pfe_pmbus_probe(struct i2c_client *client,
@@ -42,11 +93,23 @@ static int pfe_pmbus_probe(struct i2c_client *client,
 	int model;
 
 	model = (int)id->driver_data;
+
+	/*
+	 * PFE3000-12-069RA devices may not stay in page 0 during device
+	 * probe which leads to probe failure (read status word failed).
+	 * So let's set the device to page 0 at the beginning.
+	 */
+	if (model == pfe3000) {
+		client->dev.platform_data = &pfe3000_plat_data;
+		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	}
+
 	return pmbus_do_probe(client, id, &pfe_driver_info[model]);
 }
 
 static const struct i2c_device_id pfe_device_id[] = {
 	{"pfe1100", pfe1100},
+	{"pfe3000", pfe3000},
 	{}
 };
 
-- 
2.17.1

