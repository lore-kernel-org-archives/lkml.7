Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C3AC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3625220850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nDun/VpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDJWwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:52:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34817 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDJWw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:52:26 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so6356052itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdk3qCh/XH01SXNaXPWq/nsfFyJp7JmgO9CXXq8/E8Q=;
        b=nDun/VpABC8rjB1bMKRnJF6Mo3bUZc7ekAcg8lshAZtiSIMsqdi8l3OVJuznqkiGGa
         Q1UBtXavNafbPxIUKl9JspM302m7RoY4+pWa2PmrYPpkuIMUtsQCzHH8BxA5qfW79Isv
         eKbRaGZLJtSCpg+i2dVgkRUf6CWmYIxKjpLZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdk3qCh/XH01SXNaXPWq/nsfFyJp7JmgO9CXXq8/E8Q=;
        b=JgKdMIV0XgWS9qjW+KM7xsUFV+t2GklLTMxvZcJx9txD076LMHHAwzysb0LAYsKftK
         r7TH3n5rKZ4EIWPjKM3P3syyt9TMwP1+7RoIkxIqr3aaKf+Yd4eHX9VdltIzmaG/Izpi
         ynqTLAZiyMyqVTStE9p6U9Ln92xYpccdGVaDhZLXK6dMsNsQu/F0cL3eR7vE1G8CeXBl
         ku5vA27q5beuwt98p9qNNWcY4rgC9xw4qPKN15Ni5aurc+AkbdaSWYiwoy1/98QAXobv
         bptXctZ6VZQKC7+PvjoMuf0nCNrAc+0kAQfl5/VoZspwT4jU9fAJtmlu+IziV7MdkVip
         AL8Q==
X-Gm-Message-State: APjAAAXiucL0Ei56OFNfb4gCynjxHfq2iK8WW+q+t+tKnrf+mM6xK+kx
        Wl+oPqDY5ALP64c+/T7p64PvEHbAauo=
X-Google-Smtp-Source: APXvYqzntU8pAyTyOMrI938M19AynrQIHBxsEmfbmEowxFL/JeYrz7hIkYhX8yVoq17iOGAfuoi3LA==
X-Received: by 2002:a24:298b:: with SMTP id p133mr5820234itp.81.1554936745482;
        Wed, 10 Apr 2019 15:52:25 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id f126sm1594873ita.31.2019.04.10.15.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 15:52:24 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        sjg@chromium.org, bartfab@chromium.org, lamzin@google.com,
        jchwong@google.com, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v2 2/2] platform/chrome: wilco_ec: Add USB PowerShare Policy control
Date:   Wed, 10 Apr 2019 16:52:11 -0600
Message-Id: <20190410225211.125025-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410225211.125025-1-ncrews@chromium.org>
References: <20190410225211.125025-1-ncrews@chromium.org>
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

v2 changes:
- Move documentation to Documentation/ABI/testing/sysfs-platform-wilco-ec
- Zero out reserved bytes in requests.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 .../ABI/testing/sysfs-platform-wilco-ec       | 16 ++++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 93 +++++++++++++++++++
 2 files changed, 109 insertions(+)

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
index d1dbd4d2e6db..03dedf87ea1b 100644
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
@@ -57,8 +77,81 @@ static ssize_t boot_on_ac_store(struct device *dev,
 
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
+
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
+	if (val != 0 && val != 1)
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

