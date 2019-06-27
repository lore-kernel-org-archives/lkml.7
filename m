Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0065C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D29B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="B8IlS528"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfF0L5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:57:09 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:42419 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726429AbfF0L5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:57:09 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 45ZJKZ48Zfz8wLP;
        Thu, 27 Jun 2019 13:57:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561636626; bh=tLI6fN2m+RLQ4kM6V9C7P+ZlDKcDLKJqvXEJ6qUPnGs=;
        h=From:To:Cc:Subject:Date:From:To:CC:Subject;
        b=B8IlS5287rbLHHAaI7ACSQTrgBeHJkwvag98EN6ZSISoSC6yMjqpbxlYdXozGOak2
         hTEp4luN50bqS/18bN9LP7ZArwgqotXeY1T/kbYi5VWFpdNbP5eNfNcfBiQPvgIdHb
         stvxWrYmqE5fiL7cWbF4MbnVc0gUHFRbMxohYpYL4CIRlRpHA0/W1LUVSxaRJHiOwG
         6Wi3GgyTDrJ+P5s1Anmjfyx5+jTrqSQbqRB6DJtpGK5p2CGsaqu5AFVKnnz0MNn7RV
         M8oBgH1mM0bgMCaoeWn34ubCsSH1YYEJSmG3iig6W/dcHmWvD7jUWRS0WmmpYWc4sf
         EijH8FZjVzt0w==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.35.53
Received: from laptop.pool.uni-erlangen.de (faustud-010-021-035-053.pool.uni-erlangen.de [10.21.35.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18IgU6a1VjlMOGrCyBI/NzffopWKzLo6Vg=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 45ZJKX1G1zz8wMS;
        Thu, 27 Jun 2019 13:57:04 +0200 (CEST)
From:   Fabian Schindlatz <fabian.schindlatz@fau.de>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabian Schindlatz <fabian.schindlatz@fau.de>,
        =?UTF-8?q?Thomas=20R=C3=B6thenbacher?= 
        <thomas.roethenbacher@fau.de>, linux-kernel@i4.cs.fau.de
Subject: [PATCH] hwmon: Correct struct allocation style
Date:   Thu, 27 Jun 2019 13:56:45 +0200
Message-Id: <20190627115645.5077-1-fabian.schindlatz@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sizeof(*var) instead of sizeof(struct var_type) as argument to
kalloc() and friends to comply with the kernel coding style.

Co-developed-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
Signed-off-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/hwmon/acpi_power_meter.c | 2 +-
 drivers/hwmon/coretemp.c         | 4 ++--
 drivers/hwmon/fschmd.c           | 2 +-
 drivers/hwmon/sch56xx-common.c   | 2 +-
 drivers/hwmon/via-cputemp.c      | 4 ++--
 drivers/hwmon/w83793.c           | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 6ba1a08253f0..f20223e3579c 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -862,7 +862,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	if (!device)
 		return -EINVAL;
 
-	resource = kzalloc(sizeof(struct acpi_power_meter_resource),
+	resource = kzalloc(sizeof(*resource),
 			   GFP_KERNEL);
 	if (!resource)
 		return -ENOMEM;
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index fe6618e49dc4..0361115d25dd 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -433,7 +433,7 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
 {
 	struct temp_data *tdata;
 
-	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
+	tdata = kzalloc(sizeof(*tdata), GFP_KERNEL);
 	if (!tdata)
 		return NULL;
 
@@ -532,7 +532,7 @@ static int coretemp_probe(struct platform_device *pdev)
 	struct platform_data *pdata;
 
 	/* Initialize the per-zone data structures */
-	pdata = devm_kzalloc(dev, sizeof(struct platform_data), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index fa0c2f1fb443..d464dcbe5ac8 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -1090,7 +1090,7 @@ static int fschmd_probe(struct i2c_client *client,
 	int i, err;
 	enum chips kind = id->driver_data;
 
-	data = kzalloc(sizeof(struct fschmd_data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index 6c84780e358e..0d6d20814183 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -401,7 +401,7 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
 		return NULL;
 	}
 
-	data = kzalloc(sizeof(struct sch56xx_watchdog_data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return NULL;
 
diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index 8264e849e588..338b600716a5 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -114,7 +114,7 @@ static int via_cputemp_probe(struct platform_device *pdev)
 	int err;
 	u32 eax, edx;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct via_cputemp_data),
+	data = devm_kzalloc(&pdev->dev, sizeof(*data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -223,7 +223,7 @@ static int via_cputemp_online(unsigned int cpu)
 		goto exit;
 	}
 
-	pdev_entry = kzalloc(sizeof(struct pdev_entry), GFP_KERNEL);
+	pdev_entry = kzalloc(sizeof(*pdev_entry), GFP_KERNEL);
 	if (!pdev_entry) {
 		err = -ENOMEM;
 		goto exit_device_put;
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 46f5dfec8d0a..b37106c6f26d 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1669,7 +1669,7 @@ static int w83793_probe(struct i2c_client *client,
 	int files_pwm = ARRAY_SIZE(w83793_left_pwm) / 5;
 	int files_temp = ARRAY_SIZE(w83793_temp) / 6;
 
-	data = kzalloc(sizeof(struct w83793_data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		err = -ENOMEM;
 		goto exit;
-- 
2.20.1

