Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D890C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5799320896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mj6jSPmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfCYRDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:03:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40203 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:02:59 -0400
Received: by mail-io1-f66.google.com with SMTP id d201so8253213iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLoK6GXlNnGP4K5SxZmU2mM4NxfIC8P7/iZfrmZJlFY=;
        b=Mj6jSPmUpB5kL6Ipz3ma6OMrOYO2ZIWcsGpEXosoT+ncrmyiVYrYrai75tO+wxcKgK
         2QLWeTb27Y9EoXNk66PHYSubqM+5Ki+RIpUhTDlE9df29+aGK0tkmSJ/bP4r3TaJPYmV
         S19AzaTmmEeUqsLg/M4yG3SdSaUCL8yRnERVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLoK6GXlNnGP4K5SxZmU2mM4NxfIC8P7/iZfrmZJlFY=;
        b=UEKvofyilBOtJTkxn9+dIFGVhJDaEYORDW2YyjyCX3QIykxwrPqYew36Np1xjpu5zP
         V7L7cS2sUKPcVMprJMLyQahdeDV70+InAM4YHNT9BN4msPNBimrBtxbbRSIIQSC/zkUx
         iJUKG+V9s082uy0OU0BAgzIMtSxJ5E1rpKrwOyD07SGskLvEJH4P4UU5cy+LA1ysXPWN
         zU5AtR/F6xh7zusBQEdBIq42QLlc8KU6ZAOLv/7GDW15MW3FbuJy65xPnsb7Ey37NY8o
         VvipDuDTrcgEgkopQ9cGW9HvRXW4sCnsNVFLFRKKimsbx/W5Eum8gfTGBPocXhRGwR+0
         bOfQ==
X-Gm-Message-State: APjAAAXfWdORwwrDiQb7hg5f6QKJ8SUoBVYM5OBR7Lux6cf6v/Y5DAIq
        CsT+WE0PLbIeS8SvPWrR2LGHanE0ZFjwtA==
X-Google-Smtp-Source: APXvYqw6QVY/eQvuWDdCWNiXTdoo8BsTn3zXpkBesl8dARCXE6ELG2dQWuuSeAdLUf11b/51gFz6tg==
X-Received: by 2002:a5e:db48:: with SMTP id r8mr17770800iop.220.1553533378987;
        Mon, 25 Mar 2019 10:02:58 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([2620:15c:183:200:3175:8c2d:44b6:cfea])
        by smtp.gmail.com with ESMTPSA id t62sm5872797ita.35.2019.03.25.10.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 10:02:58 -0700 (PDT)
From:   twawrzynczak@chromium.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH v2] platform/chrome: mfd/cros_ec_sysfs: Add sysfs entry to retrieve EC uptime.
Date:   Mon, 25 Mar 2019 11:02:50 -0600
Message-Id: <20190325170250.2547-1-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Wawrzynczak <twawrzynczak@chromium.org>

The new sysfs entry 'uptime' is being made available to userspace so that
a userspace daemon can synchronize EC logs with host time.

Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
---
Enric, the use case for this is ChromeOS's userspace daemon, timberslide,
which collects the EC logs for sending bug reports, etc.  This is part of
a series of patches which is prefixing host timestamps before each EC
log line.  The daemon matches up the EC log lines' seconds-since-boot
with the time gotten from the new 'uptime' node and calculates the
host time that the log line was printed at.
---
 drivers/platform/chrome/cros_ec_sysfs.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index fe0b7614ae1b..b3915d3287c5 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -107,6 +107,38 @@ static ssize_t reboot_store(struct device *dev,
 	return count;
 }
 
+static ssize_t uptime_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct ec_response_uptime_info *resp;
+	struct cros_ec_command *msg;
+	int ret;
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
+	u32 time_since_ec_boot_ms;
+
+	msg = kmalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	/* Get EC uptime information */
+	msg->version = 0;
+	msg->command = EC_CMD_GET_UPTIME_INFO + ec->cmd_offset;
+	msg->insize = sizeof(*resp);
+	msg->outsize = 0;
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0) {
+		time_since_ec_boot_ms = 0;
+	} else {
+		resp = (struct ec_response_uptime_info *)msg->data;
+		time_since_ec_boot_ms = resp->time_since_ec_boot_ms;
+	}
+
+	ret = scnprintf(buf, PAGE_SIZE, "%u\n", time_since_ec_boot_ms);
+
+	kfree(msg);
+	return ret;
+}
+
 static ssize_t version_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -314,12 +346,14 @@ static DEVICE_ATTR_RW(reboot);
 static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_RO(flashinfo);
 static DEVICE_ATTR_RW(kb_wake_angle);
+static DEVICE_ATTR_RO(uptime);
 
 static struct attribute *__ec_attrs[] = {
 	&dev_attr_kb_wake_angle.attr,
 	&dev_attr_reboot.attr,
 	&dev_attr_version.attr,
 	&dev_attr_flashinfo.attr,
+	&dev_attr_uptime.attr,
 	NULL,
 };
 
-- 
2.20.1

