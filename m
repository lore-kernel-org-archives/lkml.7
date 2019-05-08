Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4A3C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAAF2173B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H1jCf74H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfEHUig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:38:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40049 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfEHUid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:38:33 -0400
Received: by mail-it1-f195.google.com with SMTP id g71so6147177ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/pWq4NMffd2Goxyok0cFwj6OmMY5Es24yiMIZ4tAIzk=;
        b=H1jCf74HNYUbkblpIXMW/glrh729QmQPkXetwf8v37dxuTFy2OSTq6IExP4p54tv5G
         /6GlD0bHTvuxIlayFoqf+kibgMfi0zzK9E3Ix7WZFdtjgl8FmRhZ9qN9VyY5yR6nUV3Z
         jRw2WkIjkj6Bbb/ez7oEI+fsrs8vHXGFB5nLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pWq4NMffd2Goxyok0cFwj6OmMY5Es24yiMIZ4tAIzk=;
        b=KoQstvxSYFptMsgvlKLkYQsPOFPdQQBl516lCkio6Oo4hlkb2wNYFHgtsrh9EjuyqQ
         pWwdukDdboEf67Y1IJK16w2YuUZf4bKjNSYcr7wWq5hfsH13CQOlt31gq7aQ8oa92mk1
         TIt8EH+9rtgAAUMargukXgIO+8/OvZ+LEVpDLAdQYG5HPiEaDmxl5Af+qQvepnUXT0Ej
         9Vu8iIGiCtLkF1Bd77715/So26cn/0i8saDKWje/tNRNOxri33zl5hyQLaY7tCWTjglx
         S+/xnuII56Kx+/gwOqZRY8qqjuBbyAkHMYwhe4SemHYDorLVbY5pAtCKPPP2NZgww4Di
         1WZg==
X-Gm-Message-State: APjAAAU+Yp/JfhEDou1lIUePvfpe5w9wi7Vbkj4um5MZ1YHbt8WbL8yw
        uCOrJmdksWlLRdJg4NuWJv3OmQ==
X-Google-Smtp-Source: APXvYqwvbQIxXhuS0H3tkdEvh36ILxuRxU6HJUIlF6Ds6VrgC8t5dlljMlNkjvGhec6g+MxRUMjsLQ==
X-Received: by 2002:a24:9c47:: with SMTP id b68mr5136416ite.169.1557347912682;
        Wed, 08 May 2019 13:38:32 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id l129sm96060ioa.28.2019.05.08.13.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 May 2019 13:38:32 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org,
        tbroch@chromium.org, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v9 2/2] platform/chrome: wilco_ec: Add charging config device
Date:   Wed,  8 May 2019 14:38:26 -0600
Message-Id: <20190508203826.120741-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508203826.120741-1-ncrews@chromium.org>
References: <20190508203826.120741-1-ncrews@chromium.org>
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
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v9 changes:
-Split up adding the driver and adding the device.
v8 changes:
-Several documentation and comment fixups.
v6 changes:
-Remove CHARGE_MODE_ILLEGAL from enum charge_mode. It's not a
 public type, and error checking could be performed in other ways.
-Split up the commit so properties are added in a first commit
-Move CONFIG_CHARGER_WILCO to the power/supply Kconfig
-Use PTR_ERR_OR_ZERO() macro in probe()
v5 changes:
-Remove OP_SYNC, it has no immediate use case.
-Merge properties.h into wilco-ec.h
-Remove enum get_set_sync_op from the public interface,
 since without OP_SYNC they are irrelevant.
-Fix Kconfigs and Makefiles so they actually work
 with the v4 changes
-Tweak some formatting, spacing, and comments
-Fix validation of charge_type so illegal values
 can't be set. Before negative error codes were
 accidentally getting casted to positive numbers
-Remove more unneeded parentheses.
v4 changes:
-Use put_unaligned_le32() to store PID in request.
-Move implementation from
 drivers/platform/chrome/wilco_ec/charge_config.c to
 drivers/power/supply/wilco_charger.c
-Move drivers/platform/chrome/wilco_ec/properties.h to
 include/linux/platform_data/wilco-ec-properties.h
-Remove parentheses in switch statement in psp_val_to_charge_mode()
-Check for any negatvie return code from psp_val_to_charge_mode()
 instead of just -EINVAL so its less brittle
-Tweak comments in wilco-ec-properties.h
v3 changes:
-Add this changelog
-Fix commit message tags
v2 changes:
-Update Documentation to say KernelVersion 5.2
-Update Documentation to explain Trickle mode better.
-rename things from using *PCC* to *CHARGE*
-Split up conversions between POWER_SUPPLY_PROP_CHARGE_TYPE values
and Wilco EC codes
-Use devm_ flavor of power_supply_register(), which simplifies things
-Add extra error checking on property messages received from the EC
-Fix bug in memcpy() calls in properties.c
-Refactor fill_property_id()
-Add valid input checks to charge_type
-Properly convert charge_type when get()ting

 drivers/platform/chrome/wilco_ec/core.c | 13 +++++++++++++
 include/linux/platform_data/wilco-ec.h  |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..a8e3ef59f4ea 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -89,8 +89,20 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_debugfs;
 	}
 
+	/* Register child device to be found by charger config driver. */
+	ec->charger_pdev = platform_device_register_data(dev, "wilco-charger",
+							 PLATFORM_DEVID_AUTO,
+							 NULL, 0);
+	if (IS_ERR(ec->charger_pdev)) {
+		dev_err(dev, "Failed to create charger platform device\n");
+		ret = PTR_ERR(ec->charger_pdev);
+		goto unregister_rtc;
+	}
+
 	return 0;
 
+unregister_rtc:
+	platform_device_unregister(ec->rtc_pdev);
 unregister_debugfs:
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
@@ -102,6 +114,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	platform_device_unregister(ec->charger_pdev);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 50a21bd5fd44..66d9f177bec2 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -32,6 +32,7 @@
  * @data_size: Size of the data buffer used for EC communication.
  * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
  * @rtc_pdev: The child platform_device used by the RTC sub-driver.
+ * @charger_pdev: Child platform_device used by the charger config sub-driver.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -43,6 +44,7 @@ struct wilco_ec_device {
 	size_t data_size;
 	struct platform_device *debugfs_pdev;
 	struct platform_device *rtc_pdev;
+	struct platform_device *charger_pdev;
 };
 
 /**
-- 
2.20.1

