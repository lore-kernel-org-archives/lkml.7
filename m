Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25413C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5521218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="II8uCwBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfCOREx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:04:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37958 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfCOREx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:04:53 -0400
Received: by mail-io1-f65.google.com with SMTP id v4so7832819ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VXjYOML74rODO2Pgrht5mdW4qPHSj01U2SY/QrNecg=;
        b=II8uCwBFQgKIgpIN3uiyVrlwPp7Jobs2sjcDctsX6/ITlg2Gz+ClrbA35t59XSgUtx
         cvuI3IhKcVYHtOIOWoY5tkf8409vWC/olWTrupRHZujQCRVC5K8WF43sGaoIpjGF/+oq
         zpmG3FeuueN8/W1OCxWUQvrkGbS2wAtzhFSKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VXjYOML74rODO2Pgrht5mdW4qPHSj01U2SY/QrNecg=;
        b=Fe/H1bqu7N594jAEQsuDPEUQhx40Ci5TGjf6GQFpJLDq5fv1wVs4/B3nC+od1da90/
         aKJRsJq2zi0qF+3hQDuKjx61N1K3NbopAX2WBRf1ofa5ExCYw2qEz8yIE5ZO2AEkz75m
         2rtjhgiiRLw7l8j1svorRqDGUnaxYOTBiHc9R5YI3a5QB07IU7BegEiYVa3HlMmr+ezz
         9RIKfrJJTC4U7J8wL2pAriwxuDzuMG4ZsTL/eLUj3iWj26Bpcyvnnl2pA1yxksmTHlIE
         zrp3O/2/SYUdUEQVBuKn58X2mtad80oa6C6P5bWjKhivtEaH5WSSE561lBO+QkNkAMPJ
         PyRA==
X-Gm-Message-State: APjAAAXADbAv9FKtFiHuH5tQC+RC53/SjDQaEFsi9XOuD0MWvBez++uj
        LGm5MPpu3pdQqGlLpk33GEHvOg==
X-Google-Smtp-Source: APXvYqyWZd//MwMHTENb8n7poFtLnqynCH1e5sof8heUWWTFft7q7ztD9332MLydL3Tve41ytEhrwA==
X-Received: by 2002:a5d:9053:: with SMTP id v19mr3058515ioq.49.1552669492313;
        Fri, 15 Mar 2019 10:04:52 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([2620:15c:183:200:3175:8c2d:44b6:cfea])
        by smtp.gmail.com with ESMTPSA id o129sm3363720ito.0.2019.03.15.10.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 10:04:51 -0700 (PDT)
From:   Tim Wawrzynczak <twawrzynczak@chromium.org>
To:     bleung@chromium.org
Cc:     olof@lixom.net, lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH] platform/chrome: mfd/cros_ec_sysfs: Add sysfs entry to retrieve EC uptime.
Date:   Fri, 15 Mar 2019 11:04:13 -0600
Message-Id: <20190315170413.108114-2-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315170413.108114-1-twawrzynczak@chromium.org>
References: <20190315170413.108114-1-twawrzynczak@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new sysfs node under the cros_ec device which contains the uptime
of the EC in milliseconds since boot.

Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 34 +++++++++++++++++++++++++
 include/linux/mfd/cros_ec_commands.h    | 15 +++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 5a6db3fe213a..7e5ca1e2900b 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -123,6 +123,38 @@ static ssize_t reboot_store(struct device *dev,
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
@@ -330,12 +362,14 @@ static DEVICE_ATTR_RW(reboot);
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
 
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index a8c882b5c222..38e7e6dcca97 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4697,6 +4697,21 @@ struct __ec_align4 ec_params_rwsig_action {
 	uint32_t action;
 };
 
+/* For getting EC uptime & AP reset information */
+#define EC_CMD_GET_UPTIME_INFO	0x0121
+
+struct __ec_align4 ec_response_uptime_info {
+	uint32_t time_since_ec_boot_ms;   /* uptime in ms */
+	uint32_t ap_resets_since_ec_boot; /* AP resets recorded by EC */
+	uint32_t ec_reset_flags;          /* RESET_* flags */
+	/* Empty log entries have cause and timestamp set to zero */
+	struct ap_reset_log_entry {
+		uint16_t reset_cause;     /* enum chipset_*_reason */
+		uint16_t reserved;        /* reserved for protocol growth */
+		uint32_t reset_time_ms;   /* time of reset assertion */
+	} recent_ap_reset[4];
+};
+
 /*****************************************************************************/
 /* The command range 0x200-0x2FF is reserved for Rotor. */
 
-- 
2.20.1

