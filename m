Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEBEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2082075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="be3Fe8QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKYUrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:47:42 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37971 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 15:47:40 -0500
Received: by mail-il1-f194.google.com with SMTP id u17so15507075ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 12:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RVUoyzWI+ClgLw+yLNLbFpVZV16gwYnq0IxFB2yqrU=;
        b=be3Fe8QAuYQfhcxedqWoYGcg7rYUqpbFoIpvui+efYAi9W3ZJRmEz3+2ICYkRAgbrv
         dIx8F38PJJkNBAFjh9UfAr5Ex/io/xOvgZMii1hNMUChTf6n5A8T9fggft6LW11XQGJY
         +bG3akePbZ62+mDBgYx+yfycM/e4NR9/NZ2Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RVUoyzWI+ClgLw+yLNLbFpVZV16gwYnq0IxFB2yqrU=;
        b=JbBwQdP6fxgnfMYqrYOffdQh9NH6VSfrY5GGAqWm8WdEzhmuBJbRmBRIVg/eDpxCnl
         t6chmYWPnyaK634kJTfvm9iECBRQRW1RT6KDFVDEkQMYZXiGbsG6wnNoSUvdZWywn1bU
         6Sc1+1cxVqV2yOjwc8l1prPsE5+ClIKeqAuH30+es+K9fQydAHlXWflyyTsjBs5L46n5
         KO5PkXaz7/CLFgf7+kx8voYsDJme8P1vMTCtenXTJh3MMfJeDpdIk/ZXk5Gzt+KJDquA
         /LfS9XP0SqDbbLYqvU3O+x440fPIaem+ua/E8ReJaqDXeSSbwVTp/e60OaGxB76csxNX
         p5LQ==
X-Gm-Message-State: APjAAAUU/mYp1rNJHq+dDb3LiwUvTbi5pJvNceh0PBNYotenpR7TnXQ2
        kwoeOwtvonxxJubhInquWZ1YLw==
X-Google-Smtp-Source: APXvYqz1BeMX+If73Rpyi1CaRPZOJMLIswE+iXRll4Pt6FvFzXm5QUQctFAfx3G5Vi0KSlxqP4ga9Q==
X-Received: by 2002:a92:c801:: with SMTP id v1mr31694050iln.253.1574714859866;
        Mon, 25 Nov 2019 12:47:39 -0800 (PST)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id d75sm2533111ilk.65.2019.11.25.12.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 12:47:39 -0800 (PST)
From:   Raul E Rangel <rrangel@chromium.org>
To:     enric.balletbo@collabora.com, Wolfram Sang <wsa@the-dreams.de>
Cc:     Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec: Pass firmware node to MFD device
Date:   Mon, 25 Nov 2019 13:47:29 -0700
Message-Id: <20191125134551.v2.1.I1fbda3ecf40f4631420cbb75ba830d2d3b3bac1e@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191125204730.187000-1-rrangel@chromium.org>
References: <20191125204730.187000-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_dev needs to have a firmware node associated with it so mfd
cells can be properly bound to the correct ACPI/DT nodes.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

Before this patch:
$ find /sys/bus/platform/devices/cros-ec-* -iname firmware_node -exec ls -l '{}' \;
<nothing>

After this patch:
$ find /sys/bus/platform/devices/cros-ec-dev.0.auto/ -iname firmware_node -exec ls -l '{}' \;
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-accel.1.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-chardev.7.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-debugfs.8.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-gyro.2.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-lid-angle.4.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-lightbar.9.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-pd-sysfs.10.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-ring.3.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-sysfs.11.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-usbpd-charger.5.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-usbpd-logger.6.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/firmware_node -> ../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00

Changes in v2:
- Extracted platform_device_info into its own variable.

 drivers/platform/chrome/cros_ec.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 51d76037f52a..bb11bc5f73fb 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -131,6 +131,15 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
 	int err = 0;
+	struct platform_device_info ec_platform_info = {
+		.parent = ec_dev->dev,
+		.name = "cros-ec-dev",
+		.id = PLATFORM_DEVID_AUTO,
+		.data = &ec_p,
+		.size_data = sizeof(struct cros_ec_platform),
+		.fwnode = ec_dev->dev->fwnode,
+		.of_node_reused = 1
+	};
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->event_notifier);
 
@@ -167,9 +176,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	}
 
 	/* Register a platform device for the main EC instance */
-	ec_dev->ec = platform_device_register_data(ec_dev->dev, "cros-ec-dev",
-					PLATFORM_DEVID_AUTO, &ec_p,
-					sizeof(struct cros_ec_platform));
+	ec_dev->ec = platform_device_register_full(&ec_platform_info);
+
 	if (IS_ERR(ec_dev->ec)) {
 		dev_err(ec_dev->dev,
 			"Failed to create CrOS EC platform device\n");
-- 
2.24.0.432.g9d3f5f5b63-goog

