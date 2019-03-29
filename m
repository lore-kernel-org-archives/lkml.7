Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96157C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3322184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU8q5odC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfC2DGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:06:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35707 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfC2DGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:06:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so343286pfe.2;
        Thu, 28 Mar 2019 20:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnOm4aYIKD2kSQWsZFrlwKooGVBEjRhwfdK8IJWhQ7o=;
        b=gU8q5odCNLcZdQWnjVmacPohTRS/h05dCvrZiL8X0uJ621gTO6u2hIgw7/Oh6sWlZ2
         Lw2KuFLa85+sWiFHY4e7cIevoeS/G7rldztULoROImj79MQIQEZCJbMih6wib9yhQOi3
         7gybsY5ZAr+0MOxd3JbD90AMGsrv+HMWUpvUBqQ6KcSv7KhZ6eiDDRtzobjPplGIAzky
         cWpLetvioIJP8LozsOwG4RTVZfk/PM8+I+WdV16ZsxGX+ivV4x2MYdA3g/tOXbIJkWEU
         2AU2ov9vPFKyl2tfUtaYBQrcmaVlis4YNg4IfcXOf829KdwYfKYnJhfCD9kbWxkro5Uw
         UvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnOm4aYIKD2kSQWsZFrlwKooGVBEjRhwfdK8IJWhQ7o=;
        b=W4WAP9P0oYXJd+nYJnSjc9KuwyclJm+mI9vl1pyaKWX+ijp7qxGwwvgvo8MWXliSXY
         vZRQJBi75v1lYXBJ+RfU18rLHprl1eKFUZIcsRNHA57MKuLTOau2yoCOrX1soMs31m3Z
         DH9msQYXftz2xP8AA4z+NvL+Fm3RfwBdxTx401fFVkF4fyDKL3pLNphz4RCWUoKbLsFf
         ZYiQ9g2HBJz05fvKLAL7DenglcI5oGURKLSHBVQj80nJKlNfkvjASNuHsBK5Amp5OuWn
         kqCRlX+s1p/OzX/VuymOfbWTX8ZFb/Ms6SDPMjRn+yeLa95cOAnSXAqyHSluPGvwpvnZ
         uqlQ==
X-Gm-Message-State: APjAAAV2T7tG9917+ON8y70Stfxhs0FveHyNdrKQVRfdrMcCcQanV+3u
        U5+Y1L5X98PvUwhM4jdEL0I=
X-Google-Smtp-Source: APXvYqzJHHWccE6r/ABmxHutKRCH84tnwL+KcfETjAHgllfLu7rm9wgEsMXxht7qAhzQoRO7/zq50Q==
X-Received: by 2002:a62:14c3:: with SMTP id 186mr44794755pfu.21.1553828793350;
        Thu, 28 Mar 2019 20:06:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:ba2:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id k17sm660235pfk.166.2019.03.28.20.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:06:32 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v14 11/11] thermal: intel: intel_soc_dts_iosf: Utilize for_each_set_clump8 macro
Date:   Fri, 29 Mar 2019 12:07:26 +0900
Message-Id: <671029ab8c9f3a630e77b454b25d6697c8375f24.1553828158.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553828158.git.vilhelm.gray@gmail.com>
References: <cover.1553828158.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize for_each_set_clump8 macro, and the bitmap_set_value8 and
bitmap_get_value8 functions, where appropriate. In addition, remove the
now unnecessary temp_mask and temp_shift members of the
intel_soc_dts_sensor_entry structure.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c | 29 +++++++++++++---------
 drivers/thermal/intel/intel_soc_dts_iosf.h |  2 --
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index e0813dfaa278..2aa16b5262e9 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -15,6 +15,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
@@ -111,6 +112,7 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
 {
 	int status;
 	u32 temp_out;
+	unsigned long update_ptps;
 	u32 out;
 	u32 store_ptps;
 	u32 store_ptmc;
@@ -129,8 +131,9 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
 	if (status)
 		return status;
 
-	out = (store_ptps & ~(0xFF << (thres_index * 8)));
-	out |= (temp_out & 0xFF) << (thres_index * 8);
+	update_ptps = store_ptps;
+	bitmap_set_value8(&update_ptps, temp_out & 0xFF, thres_index * 8);
+	out = update_ptps;
 	status = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
 				SOC_DTS_OFFSET_PTPS, out);
 	if (status)
@@ -232,6 +235,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 	u32 out;
 	struct intel_soc_dts_sensor_entry *dts;
 	struct intel_soc_dts_sensors *sensors;
+	unsigned long temp_raw;
 
 	dts = tzd->devdata;
 	sensors = dts->sensors;
@@ -240,7 +244,8 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 	if (status)
 		return status;
 
-	out = (out & dts->temp_mask) >> dts->temp_shift;
+	temp_raw = out;
+	out = bitmap_get_value8(&temp_raw, dts->id * 8);
 	out -= SOC_DTS_TJMAX_ENCODING;
 	*temp = sensors->tj_max - out * 1000;
 
@@ -290,10 +295,13 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 {
 	char name[10];
 	int trip_count = 0;
+	int writable_trip_count = 0;
 	int trip_mask = 0;
 	u32 store_ptps;
 	int ret;
-	int i;
+	unsigned long i;
+	unsigned long trip;
+	unsigned long ptps;
 
 	/* Store status to restor on exit */
 	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
@@ -302,11 +310,10 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 		goto err_ret;
 
 	dts->id = id;
-	dts->temp_mask = 0x00FF << (id * 8);
-	dts->temp_shift = id * 8;
 	if (notification_support) {
 		trip_count = min(SOC_MAX_DTS_TRIPS, trip_cnt);
-		trip_mask = BIT(trip_count - read_only_trip_cnt) - 1;
+		writable_trip_count = trip_count - read_only_trip_cnt;
+		trip_mask = GENMASK(writable_trip_count - 1, 0);
 	}
 
 	/* Check if the writable trip we provide is not used by BIOS */
@@ -315,11 +322,9 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 	if (ret)
 		trip_mask = 0;
 	else {
-		for (i = 0; i < trip_count; ++i) {
-			if (trip_mask & BIT(i))
-				if (store_ptps & (0xff << (i * 8)))
-					trip_mask &= ~BIT(i);
-		}
+		ptps = store_ptps;
+		for_each_set_clump8(i, trip, &ptps, writable_trip_count * 8)
+			trip_mask &= ~BIT(i / 8);
 	}
 	dts->trip_mask = trip_mask;
 	dts->trip_count = trip_count;
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.h b/drivers/thermal/intel/intel_soc_dts_iosf.h
index 625e37bf93dc..d0362d7acdef 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.h
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.h
@@ -33,8 +33,6 @@ struct intel_soc_dts_sensors;
 
 struct intel_soc_dts_sensor_entry {
 	int id;
-	u32 temp_mask;
-	u32 temp_shift;
 	u32 store_status;
 	u32 trip_mask;
 	u32 trip_count;
-- 
2.21.0

