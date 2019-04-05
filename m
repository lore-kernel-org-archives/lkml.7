Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F11FC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB1D2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HA95B8Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDEUIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:08:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33082 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfDEUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:07:59 -0400
Received: by mail-io1-f65.google.com with SMTP id b6so6100238iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2a3fURBy7dkfNfeSPPf2f5gwo15tfCgK1ou82mscUMU=;
        b=HA95B8DwNRxRSylk5skeThfAue+EU2MlH2OHQhNYEcUGI0TMsmfTtpWVt54HoU7iqj
         SmuRJ7WlPCr3cqQn1CVV9Aab0oC9vhivGxcB60MTzs4WCMTnVjwAKFSbZsjnTI5+oMXc
         Sz6gMGB1vGxRVSZ2a/6QwpTRqhrb86UbvT/yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2a3fURBy7dkfNfeSPPf2f5gwo15tfCgK1ou82mscUMU=;
        b=RedFVbGQToR4bUbn13O9ZqevXud7G5kgbANKPvNeZlu/fHbsakQYXVyCx5zRc5wTV5
         GJvSZ/bXo8JsBoFmuT5Vw1kG2MUOlcxQW0Ff0g5pYisAwQIenqVrxD83b6Qbn5aTUx1/
         R1VlRPBnudldD2/gU6RWUnf1zk0mfcemO8XUKHUquuDKrpuK8X5sZqWbpioGdnOWFMiQ
         paZZZIoBhE8e/TzL9nNQyhnyyDg6HE0OJierc4nw4QqP98u5qR9S1LQmuxlNEhzcFbBl
         pdZBr0BLpopKZXfLJcVi7DW5ytVJxViZdNjQcEGSFz3sQTHMR6gUdgNIOhvk23Yz/G27
         fp4w==
X-Gm-Message-State: APjAAAXom/rwo4xe9BRZ0Y9XD066a30Ty4Kzej7iwse83ZsizrcIYwlD
        QgaTGhB1Ou7QW9x3sRJ3HFjoQQ==
X-Google-Smtp-Source: APXvYqzGr5X3CfVeoDV5ALDCaXACVsu8USsTh6t+lvB+/LiyflcX3dMDGIBQ9qUxHtOv9xxt4UrwnA==
X-Received: by 2002:a6b:fe07:: with SMTP id x7mr5725759ioh.3.1554494879218;
        Fri, 05 Apr 2019 13:07:59 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id v134sm1492748ita.16.2019.04.05.13.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Apr 2019 13:07:58 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        lamzin@google.com, sjg@gchromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH 3/3] platform/chrome: wilco_ec: Add Boot on AC support
Date:   Fri,  5 Apr 2019 14:07:42 -0600
Message-Id: <20190405200742.107973-3-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405200742.107973-1-ncrews@chromium.org>
References: <20190405200742.107973-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot on AC is a policy which makes the device boot from S5 when AC
power is connected. This is useful for users who want to run their
device headless or with a dock.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/sysfs.c | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index ec5211257a58..52cbdb1f30b6 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -5,6 +5,10 @@
  * Sysfs properties used to modify EC-controlled features on Wilco devices.
  * The entries will appear under /sys/bus/platform/devices/GOOG000C:00/
  *
+ * Boot on AC is a policy which makes the device boot from S5 when AC
+ * power is connected. This is useful for users who want to run their
+ * device headless or with a dock.
+ *
  * USB PowerShare is a policy which affects charging via the special
  * USB PowerShare port (marked with a small lightning bolt or battery icon)
  * when in low power states:
@@ -18,6 +22,18 @@
 #include <linux/platform_data/wilco-ec.h>
 #include <linux/sysfs.h>
 
+#define CMD_KB_CMOS			0x7C
+#define SUB_CMD_KB_CMOS_AUTO_ON		0x03
+
+struct boot_on_ac_request {
+	u8 cmd;			/* Always CMD_KB_CMOS */
+	u8 reserved1;
+	u8 sub_cmd;		/* Always SUB_CMD_KB_CMOS_AUTO_ON */
+	u8 reserved3to5[3];
+	u8 val;			/* Either 0 or 1*/
+	u8 reserved7;
+} __packed;
+
 #define CMD_USB_POWER_SHARE 0x39
 
 enum usb_power_share_op {
@@ -38,6 +54,41 @@ struct usb_power_share_response {
 	u8 val;		/* When getting, set by EC to either 0 or 1 */
 } __packed;
 
+static ssize_t boot_on_ac_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct boot_on_ac_request rq;
+	struct wilco_ec_message msg;
+	int ret;
+	u8 val;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.cmd = CMD_KB_CMOS;
+	rq.sub_cmd = SUB_CMD_KB_CMOS_AUTO_ON;
+	rq.val = val;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = &rq;
+	msg.request_size = sizeof(rq);
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(boot_on_ac);
+
 static int send_usb_power_share(struct wilco_ec_device *ec,
 				struct usb_power_share_request *rq,
 				struct usb_power_share_response *rs)
@@ -110,6 +161,7 @@ static ssize_t usb_power_share_store(struct device *dev,
 static DEVICE_ATTR_RW(usb_power_share);
 
 static struct attribute *wilco_dev_attrs[] = {
+	&dev_attr_boot_on_ac.attr,
 	&dev_attr_usb_power_share.attr,
 	NULL,
 };
-- 
2.20.1

