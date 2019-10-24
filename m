Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3A2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF2D2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C6ZiTHOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfJXWNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:13:12 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45526 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJXWNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:13:11 -0400
Received: by mail-il1-f195.google.com with SMTP id u1so48442ilq.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCM3g32MITF4GHb+oh5v+TIhOkEpHsOH3vQSr3W0WRk=;
        b=C6ZiTHOvDC0V4jkrQAsPAEdtBcsu9ZwKqUbLE9FCZVGI5tXXBj0DUt1NGWBLfZhs+8
         u77WWAAaVC9PiH+n4VHAE32ahK7jEIuE5eKOkwS5f01OqEq2hUDrl3zoZSepsv753CWH
         n7ziRz0EYc4k48KacOoTAB0FLqKLIxEIbrCRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCM3g32MITF4GHb+oh5v+TIhOkEpHsOH3vQSr3W0WRk=;
        b=g56pF3GUNo1DQhiHwqT5ushpSPNQB+V8z9zasWdzqP5VCcyDwyZ09zcqahOTuQBOh1
         R3KIlfzaoZoxjIg+PNAeEcU9ko+mP1EuqYu/5CpGr535hhvJ/QoDbo09jIy3CxliOwL9
         hdLeKkZbcqzVvNlWbYD3HU57tr8Hpm1UeFjF4Kl+7tdDtjHP9xwKOpyL49ZFbOveogYe
         CedxWPLdqx0NYrV55+rdao9OVa2t04ZLWLvl4qY48BGqRclyIiv1H4w7dOvU/4w+hwwJ
         OEk9lDtKRxhrzTGDhptNKOAaP3lcT925q82feSRcYUqAgOvTD/7/O1CJWmEMj4C7RBBB
         mpkQ==
X-Gm-Message-State: APjAAAXaUHM8VL79QDmZlZx9TWr2GEareFL1bYuOfFVa5OWjSiP4YAX1
        F+WpCKlqkA5dljUZSDgIxG3FOw==
X-Google-Smtp-Source: APXvYqwoPQsWD5fMM+EAzlbBxmUZ72ucCAHQA5P8+gzn+gqW6IqIsE0Vqu15D1uB6FM4EWDjSYHGxw==
X-Received: by 2002:a92:9c94:: with SMTP id x20mr318365ill.149.1571955189638;
        Thu, 24 Oct 2019 15:13:09 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id k2sm67563ios.19.2019.10.24.15.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Oct 2019 15:13:09 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        weiyongjun1@huawei.com, dlaurie@chromium.org, djkurtz@chromium.org,
        dtor@google.com, sjg@chromium.org, groeck@chromium.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH 2/2] power_supply: platform/chrome: wilco_ec: Add charging config driver
Date:   Thu, 24 Oct 2019 16:12:34 -0600
Message-Id: <20191024221234.182693-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024221234.182693-1-ncrews@chromium.org>
References: <20191024221234.182693-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device to control the charging algorithm used on Wilco devices,
which will be picked up by the drivers/power/supply/wilco-charger.c
driver. See Documentation/ABI/testing/sysfs-class-power-wilco for the
userspace interface and other info.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/core.c | 15 ++++++++++++++-
 include/linux/platform_data/wilco-ec.h  |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 36c78e52ff3c..5210c357feef 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -98,6 +98,16 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_rtc;
 	}
 
+	/* Register child device to be found by charger config driver. */
+	ec->charger_pdev = platform_device_register_data(dev, "wilco-charger",
+							 PLATFORM_DEVID_AUTO,
+							 NULL, 0);
+	if (IS_ERR(ec->charger_pdev)) {
+		dev_err(dev, "Failed to create charger platform device\n");
+		ret = PTR_ERR(ec->charger_pdev);
+		goto remove_sysfs;
+	}
+
 	/* Register child device that will be found by the telemetry driver. */
 	ec->telem_pdev = platform_device_register_data(dev, "wilco_telem",
 						       PLATFORM_DEVID_AUTO,
@@ -105,11 +115,13 @@ static int wilco_ec_probe(struct platform_device *pdev)
 	if (IS_ERR(ec->telem_pdev)) {
 		dev_err(dev, "Failed to create telemetry platform device\n");
 		ret = PTR_ERR(ec->telem_pdev);
-		goto remove_sysfs;
+		goto unregister_charge_config;
 	}
 
 	return 0;
 
+unregister_charge_config:
+	platform_device_unregister(ec->charger_pdev);
 remove_sysfs:
 	wilco_ec_remove_sysfs(ec);
 unregister_rtc:
@@ -125,6 +137,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	platform_device_unregister(ec->charger_pdev);
 	wilco_ec_remove_sysfs(ec);
 	platform_device_unregister(ec->telem_pdev);
 	platform_device_unregister(ec->rtc_pdev);
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 0f7df3498a24..afede15a95bf 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -29,6 +29,7 @@
  * @data_size: Size of the data buffer used for EC communication.
  * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
  * @rtc_pdev: The child platform_device used by the RTC sub-driver.
+ * @charger_pdev: Child platform_device used by the charger config sub-driver.
  * @telem_pdev: The child platform_device used by the telemetry sub-driver.
  */
 struct wilco_ec_device {
@@ -41,6 +42,7 @@ struct wilco_ec_device {
 	size_t data_size;
 	struct platform_device *debugfs_pdev;
 	struct platform_device *rtc_pdev;
+	struct platform_device *charger_pdev;
 	struct platform_device *telem_pdev;
 };
 
-- 
2.21.0

