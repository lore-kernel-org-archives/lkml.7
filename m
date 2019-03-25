Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2738C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77727205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q28Sq2XU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfCYGFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:05:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46650 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfCYGFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:05:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so5690514pgg.13;
        Sun, 24 Mar 2019 23:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+xpStCAm5+KqB9WkdPQRn7Ir+DpSVJA0QLNqt7/oEw=;
        b=Q28Sq2XUEgcaTJcwxxckkZWKTAytkpVpdRls9LHOvD9lQskNxUADGQcPDfb54E4ZUf
         1t4clNC9Nc/Wd8MSgpv/CmsfyGkFH1/gwwXcmxq1mAXx96SoA8dSnqHBGCGbxYavIIka
         UNBnAJ6GUnLyB2qGA2IlqbML1y0mEwdGTB/bIocp78FLPTT3KycCziysUxYojSIarv+e
         d4npvK249GckLUYus0xv8xLBCb+TqsbkRrMGcNha3OKwRuoprMh+Gl9oQsHmiyAMeELR
         rsFi+D6gBoM+7DifiHl0uC6JOoiUmZ4aUa9pa7k1KHhdCuhOronP3JzUftAxLPO1dP7w
         nj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+xpStCAm5+KqB9WkdPQRn7Ir+DpSVJA0QLNqt7/oEw=;
        b=PkkXRnskz4TuzjN4wp8Q6UvIFFLpXHpbg8c9dYyKJHln4qVwVv3zj1u5EwrFT/WsyD
         4EM8Jh84oG1PVUS4m7qX0xn3lAjwJobxMj0q/rB6CcheMSfjq94H2+QK0SMdzweny5ov
         oys3xf7Gxy98kMkTpnFLDbrSxuN3sZ9fr2iD+3pvVLaM449nzM2QurBG5BhmIkgt/Z7a
         6fd+0GmZQAcvncojZ6EH5spGYymnBP7rjfjwaTgFzW3ifd8pPaRpIxFCACkojuL5CN2T
         NpC+DH8WtlYVHQYjIOpcv7zakkf00Z/6pcccacnOzPEy6i67pQbzCU+9tPe0y8hUZYkc
         frYQ==
X-Gm-Message-State: APjAAAWnrKUNGiQBHrA7Ua0uT7gWsbxJXHDLSrsOCDErWwATzwk3tXO/
        xnr9H6u7aaZaJz9kHOYWuDs=
X-Google-Smtp-Source: APXvYqzMSY3gRxBRSywfQidmG96EAN7QjCHLwLjuGUdsN7BrTElN8NIefTvVxBsheUxWhV3wYBCNmw==
X-Received: by 2002:aa7:8ad4:: with SMTP id b20mr15624226pfd.249.1553493933529;
        Sun, 24 Mar 2019 23:05:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id m24sm16401479pgv.1.2019.03.24.23.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:05:33 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 10/11] thermal: intel: intel_soc_dts_iosf: Utilize for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:06:28 +0900
Message-Id: <02ebb522c3c07e9ed13b8e07559abd17e8648987.1553492741.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553492741.git.vilhelm.gray@gmail.com>
References: <cover.1553492741.git.vilhelm.gray@gmail.com>
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
index e0813dfaa278..832e74e5fbde 100644
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
+	bitmap_set_value8(&update_ptps, 32, temp_out & 0xFF, thres_index * 8);
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
+	out = bitmap_get_value8(&temp_raw, 32, dts->id * 8);
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
+	unsigned int i;
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

