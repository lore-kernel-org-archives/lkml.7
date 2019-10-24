Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EB52166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CQIX5upX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfJXW2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:28:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33129 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfJXW2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:28:16 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so184928ior.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCM3g32MITF4GHb+oh5v+TIhOkEpHsOH3vQSr3W0WRk=;
        b=CQIX5upXSRilRWi+FpGPGzoOCwHajz0fPbjaVlJXT/KmgvGoSlcegf5VNYl0nUgVMT
         q6aH41GxKDkzusd1pbPLpEm5jCPIJ/z+R5vHL/ywKHTyrneke0Jd6jsvdtphrbpfHs9L
         2IKPP2M6Q87pcpqPMEXdN0SLYiYNOg4Rsz0gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCM3g32MITF4GHb+oh5v+TIhOkEpHsOH3vQSr3W0WRk=;
        b=qKf9RV2GkDl51SO26Gj4HeWN5Fr7lIQKZ8B4/kffp6fXLYr64Sa/66njJADsF+H1sd
         q0Dh5EyAUqWqw2C7VH0kPyyrktiwpEzHUc9wZbn55mzFpcSTK28JkBzOeHukucZp6qSu
         RDXniuZ6nzixPXK4O/rpxgunLqPxqgbq2A9L64Z/UK8GZyT9oWhUQ8MO74Wm56T1GhPJ
         5bDYPZtYyIC+1cZH08pjGdNbGbjbaFXAvg2LKWpXGqgHp8AnL89yQN5D6CP3IFxAfZeg
         yY0NEMHjTykZgUuF103WjOJhDWayMsVZoFIC6akgFG5qGa9BIWuab26IcT3ynYR5zr3w
         bfvQ==
X-Gm-Message-State: APjAAAWPkyTmP1nDsHfvX5BKGU0drtGtDskRlj/cZqu6cCRPHRCxZQMc
        D/O3si8feaXLoX6ihf1997oTnQ==
X-Google-Smtp-Source: APXvYqzCtCM9LXmGJHOpfuVQbx7JXeVeBo6muUo9JY0O3BjIG8W/jual4SeOzAnCgTLtWn7xJQzncQ==
X-Received: by 2002:a02:2244:: with SMTP id o65mr696073jao.118.1571956095197;
        Thu, 24 Oct 2019 15:28:15 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id x64sm39042ill.75.2019.10.24.15.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Oct 2019 15:28:14 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        weiyongjun1@huawei.com, dlaurie@chromium.org, djkurtz@chromium.org,
        dtor@google.com, sjg@chromium.org, groeck@chromium.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v8 2/2] power_supply: platform/chrome: wilco_ec: Add charging config driver
Date:   Thu, 24 Oct 2019 16:28:05 -0600
Message-Id: <20191024222805.183642-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024222805.183642-1-ncrews@chromium.org>
References: <20191024222805.183642-1-ncrews@chromium.org>
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

