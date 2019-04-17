Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877ABC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8B420872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jHGNxqXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfDQBU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:20:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35789 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDQBUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 21:20:55 -0400
Received: by mail-io1-f68.google.com with SMTP id p16so19296161iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 18:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gD/BsSIXH18Z+sWFAC2G3zG1HIoBmxYEWKn715GpjaE=;
        b=jHGNxqXu1EoNhT0vxl/t1liqeFiS+HuQhTAdhHZvmSCV0+hk6fnVsbfADcntDROzCB
         9MgnGOAPka8qwpqcWCmDvrtVeOit0dAUYPX+YDVbeHwLaOB3EY6AYB2DceWgjoh5O47h
         WGwT1r+P2ZjYf4TM58crAz7RzH22OYoGDMzNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gD/BsSIXH18Z+sWFAC2G3zG1HIoBmxYEWKn715GpjaE=;
        b=sd0dl41XDtx/POmkEXq2IdwoTq+azMXyicumv9oxeXt2hz3HmofexWtSSH7sENuEmp
         dW1mV8Rpb9P3OnC6IK1stgL6zTZYbt8QbocRLlZ87bgN2o7vQvN/QGQuw5wYFeK7CBAt
         igzXPxH0MVvGUGrc+e68NoeZpxX7+MSKhPd2z/FgO/uTS+pQyrMga8JtmGVmsVpVnToh
         cTULEqKrOzET6mLi0i3YZq1QUQgmW8tYgFaEBtLZhMq4Yyi6fky4dilLJV7m6sytMZCj
         ZQ4t2qtZxkSuZXeS7bkrYNatjggbaJIMEJGWkdYAcQqhyqE+arO7GpcuNgfK8BkHjEiq
         9Jyg==
X-Gm-Message-State: APjAAAXAV2xHyOfy6cGPLbPnm1RBm9R/XemdziWJD+wQ1Z28LbDX1NGs
        Vf8SmhYXpIZsIRPycwWwdai8/A==
X-Google-Smtp-Source: APXvYqx54QP/EzYrXDekQbC1ZdhdClfotxALa/e+ITUBK3z/0VufS3vLyNm6VxeTCbI1aboaYB5SAg==
X-Received: by 2002:a5d:8902:: with SMTP id b2mr6065079ion.267.1555464054606;
        Tue, 16 Apr 2019 18:20:54 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id s1sm19938530ioe.18.2019.04.16.18.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 18:20:54 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, dtor@google.com, sjg@chromium.org,
        bartfab@chromium.org, lamzin@google.com, jchwong@google.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v3 2/2] platform/chrome: wilco_ec: Add USB PowerShare Policy control
Date:   Tue, 16 Apr 2019 19:20:48 -0600
Message-Id: <20190417012048.87977-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417012048.87977-1-ncrews@chromium.org>
References: <20190417012048.87977-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB PowerShare is a policy which affects charging via the special
USB PowerShare port (marked with a small lightning bolt or battery icon)
when in low power states:
- In S0, the port will always provide power.
- In S0ix, if power_share is enabled, then power will be supplied to
  the port when on AC or if battery is > 50%. Else no power is supplied.
- In S5, if power_share is enabled, then power will be supplied to
  the port when on AC. Else no power is supplied.

v3 changes:
- Drop a silly blank line
- Use val > 1 instead of val != 0 && val != 1
v2 changes:
- Move documentation to Documentation/ABI/testing/sysfs-platform-wilco-ec
- Zero out reserved bytes in requests.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 .../ABI/testing/sysfs-platform-wilco-ec       | 16 ++++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 92 +++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
index e074c203cd32..0c07d5e0b737 100644
--- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
+++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
@@ -9,3 +9,19 @@ Description:
 		Input should be parseable by kstrtou8() to 0 or 1.
 		Output will be either "0\n" or "1\n".
 
+What:		/sys/bus/platform/devices/GOOG000C\:00/usb_power_share
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		Control the USB PowerShare Policy. USB PowerShare is a policy
+		which affects charging via the special USB PowerShare port
+		(marked with a small lightning bolt or battery icon) when in
+		low power states:
+		- In S0, the port will always provide power.
+		- In S0ix, if power_share is enabled, then power will be
+		  supplied to the port when on AC or if battery is > 50%.
+		  Else no power is supplied.
+		- In S5, if power_share is enabled, then power will be supplied
+		  to the port when on AC. Else no power is supplied.
+
+		Input should be either "0" or "1".
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 959b5da2eb16..14e1eee95d42 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -23,6 +23,26 @@ struct boot_on_ac_request {
 	u8 reserved7;
 } __packed;
 
+#define CMD_USB_POWER_SHARE 0x39
+
+enum usb_power_share_op {
+	POWER_SHARE_GET = 0,
+	POWER_SHARE_SET = 1,
+};
+
+struct usb_power_share_request {
+	u8 cmd;		/* Always CMD_USB_POWER_SHARE */
+	u8 reserved;
+	u8 op;		/* One of enum usb_power_share_op */
+	u8 val;		/* When setting, either 0 or 1 */
+} __packed;
+
+struct usb_power_share_response {
+	u8 reserved;
+	u8 status;	/* Set by EC to 0 on success, other value on failure */
+	u8 val;		/* When getting, set by EC to either 0 or 1 */
+} __packed;
+
 static ssize_t boot_on_ac_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
@@ -57,8 +77,80 @@ static ssize_t boot_on_ac_store(struct device *dev,
 
 static DEVICE_ATTR_WO(boot_on_ac);
 
+static int send_usb_power_share(struct wilco_ec_device *ec,
+				struct usb_power_share_request *rq,
+				struct usb_power_share_response *rs)
+{
+	struct wilco_ec_message msg;
+	int ret;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = rq;
+	msg.request_size = sizeof(*rq);
+	msg.response_data = rs;
+	msg.response_size = sizeof(*rs);
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+	if (rs->status)
+		return -EIO;
+
+	return 0;
+}
+
+static ssize_t usb_power_share_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct usb_power_share_request rq;
+	struct usb_power_share_response rs;
+	int ret;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.cmd = CMD_USB_POWER_SHARE;
+	rq.op = POWER_SHARE_GET;
+
+	ret = send_usb_power_share(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", rs.val);
+}
+
+static ssize_t usb_power_share_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct usb_power_share_request rq;
+	struct usb_power_share_response rs;
+	int ret;
+	u8 val;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+	if (val > 1)
+		return -EINVAL;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.cmd = CMD_USB_POWER_SHARE;
+	rq.op = POWER_SHARE_SET;
+	rq.val = val;
+
+	ret = send_usb_power_share(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(usb_power_share);
+
 static struct attribute *wilco_dev_attrs[] = {
 	&dev_attr_boot_on_ac.attr,
+	&dev_attr_usb_power_share.attr,
 	NULL,
 };
 
-- 
2.20.1

