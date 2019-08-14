Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C154CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955BE2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R7Kyn+eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfHNISH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:18:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42371 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfHNISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:18:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so4423157pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQ2pr3Cls72t2h2tsGZZ35CLiWwC2wgAdBlRAFpgySo=;
        b=R7Kyn+equxgntT6XPosUWdGuRy3AD+4jLQsjf6tSHnWD0lLbaHelvOeW5nhL2rJ87p
         tnXlsuUJW+q2AuzeoilkudENc95XbbKiHsz2pEXn9OPSq7CS+8WC51siM6fL1dXTyMNp
         gwQ7ALwj2I+COTYxyCGdA1QgusKda1euBkyHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQ2pr3Cls72t2h2tsGZZ35CLiWwC2wgAdBlRAFpgySo=;
        b=USMhCbuUtj/7eY4LEteV6kjVld6dlhZn4dUey4LURtlM5kJIFp6Nh7Zw93rAbZ/38I
         4lVkjNIp2kj+BuBlBHy3L3Q9upQTVbs7FeBdGB5J4N72FOJq51eZGiIk7H3W8KLFRYZd
         dHbHMIOJ6TeaONAOcpcTV4dtp3PBEppG1yBkwkazWJuJLF5aJufZn7MBPpu+un2WBPFZ
         4pLKvg3fn68clr1u6Aql6k9G6tkQe9iITZvtqVuB9DlxnowUZ21yQqeR2lHBufAGAcIf
         wOt7g67gJPwDeqvN+D2VV0TeRebEcQQYvkz+CKxNE4rSs9BzY5uzs3Z4flQjuDcFJxu/
         A47g==
X-Gm-Message-State: APjAAAWuXo36E/1tPk4Dew4C/MWK4V/9yvjVHLqg9lcnzWKClIdrF0b2
        0FNdaKjxfU5DXB46be0JVnfV8YR39Aw=
X-Google-Smtp-Source: APXvYqx4bPRXa+kR2ABoEbrdX4duOpckAD+9E+8PZMdTgBc4vZrv59GuyMr8gWbIQN/dGIuRmYpAxg==
X-Received: by 2002:a65:6284:: with SMTP id f4mr35970405pgv.416.1565770686132;
        Wed, 14 Aug 2019 01:18:06 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:e122:3674:c42c:2698])
        by smtp.gmail.com with ESMTPSA id q126sm74303369pfb.56.2019.08.14.01.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 01:18:05 -0700 (PDT)
From:   Yilun Lin <yllin@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     pihsun@chromium.org, Yilun Lin <yllin@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_rpmsg: Add host command AP sleep state support
Date:   Wed, 14 Aug 2019 16:17:57 +0800
Message-Id: <20190814081757.65056-1-yllin@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EC host command to inform EC of AP suspend/resume status.

Signed-off-by: Yilun Lin <yllin@chromium.org>
---

 drivers/platform/chrome/cros_ec_rpmsg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index 5d3fb2abad1d..6f34fe629e2c 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -236,6 +236,25 @@ static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
 	cancel_work_sync(&ec_rpmsg->host_event_work);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int cros_ec_rpmsg_suspend(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_suspend(ec_dev);
+}
+
+static int cros_ec_rpmsg_resume(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_resume(ec_dev);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(cros_ec_rpmsg_pm_ops, cros_ec_rpmsg_suspend,
+			 cros_ec_rpmsg_resume);
+
 static const struct of_device_id cros_ec_rpmsg_of_match[] = {
 	{ .compatible = "google,cros-ec-rpmsg", },
 	{ }
@@ -246,6 +265,7 @@ static struct rpmsg_driver cros_ec_driver_rpmsg = {
 	.drv = {
 		.name   = "cros-ec-rpmsg",
 		.of_match_table = cros_ec_rpmsg_of_match,
+		.pm	= &cros_ec_rpmsg_pm_ops,
 	},
 	.probe		= cros_ec_rpmsg_probe,
 	.remove		= cros_ec_rpmsg_remove,
-- 
2.23.0.rc1.153.gdeed80330f-goog

