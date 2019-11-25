Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139FEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC93D20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AviB7ZG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKYWQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:16:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43838 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKYWQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:16:09 -0500
Received: by mail-pj1-f68.google.com with SMTP id a10so7249351pju.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 14:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2FzA9U/0kMzyDVMENZ9fqG7bwxFaEkKYL5q8/6pH/U=;
        b=AviB7ZG1CwpXNrCFxl4vaIWZoScolzPXgFrIjsZVyAIldCRN8E4G0LcOUXT70DPT6f
         On7X8Vv5S2F6TYajp5stdorneg5Q4UX+Q+smXUePUBtiJoH3adF0cj2/5no2A+jlVCGs
         KLPPYbuQLqk6muF8+z1UsVXni7+pjeEMPSWo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2FzA9U/0kMzyDVMENZ9fqG7bwxFaEkKYL5q8/6pH/U=;
        b=TptYmWGM2nLb+cMA51i7bzmHMg7c1bYCl/Ko26VS/C1ipKz/Zci6dvZbZJeTaGJus6
         faINaJXagkLbQ5ZT18mf4Arkfzi+B7RgyO2SmpObUlpaqJJwQb7AmoYyWjJqlX3FzJXg
         n11uZj8oO1pClmQjwBrbq4MwSrJNzehk2JYTS+oL+Yig/LcyQX4ywgz2rPRGp7NptQJP
         qtzjnf+MzcF2XacRjBouI0QpC48bXKRixrNeSh4i3VRxrVfWkt6OWNlbL3w59hrY4MNq
         zssdgNnZZrGofzwDesBrZWKPqrjPmKlTqf4jkH7+FSrghIUffForJ2J2Fa3M2SG4CRCt
         ZubQ==
X-Gm-Message-State: APjAAAVNDQWx5MS2DGMqzwmTD4/L026UrGElh5QvJg9+ikLfGcNzzaGX
        HfgJw6W/QnSmo4wjST1mDzq8k1/C3/KJ+w==
X-Google-Smtp-Source: APXvYqx4IqEglvEFxaArF2+MB5zygUteLeLlsw3SeHy8Cngmq7LVbsiN1+8gkHi3cFlrFZaubVxj+g==
X-Received: by 2002:a17:902:24e:: with SMTP id 72mr26023327plc.287.1574720167949;
        Mon, 25 Nov 2019 14:16:07 -0800 (PST)
Received: from yichengli2.mtv.corp.google.com ([2620:15c:202:201:900:2031:8afd:85a7])
        by smtp.gmail.com with ESMTPSA id o124sm9814844pfb.56.2019.11.25.14.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 14:16:07 -0800 (PST)
From:   Yicheng Li <yichengli@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, yichengli@chromium.org, gwendal@chromium.org,
        enric.balletbo@collabora.com
Subject: [PATCH v4] mfd / platform: cros_ec: Query EC protocol version if EC transitions between RO/RW
Date:   Mon, 25 Nov 2019 14:15:17 -0800
Message-Id: <20191125221517.91611-1-yichengli@chromium.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <0f223903-ec93-a5ec-e858-fa0e2e282cf3@collabora.com>
References: <0f223903-ec93-a5ec-e858-fa0e2e282cf3@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RO and RW of EC may have different EC protocol version. If EC transitions
between RO and RW, but AP does not reboot (this is true for fingerprint
microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
still uses the protocol version queried before transition, which can
cause problems. In the case of fingerprint microcontroller, this causes
AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
interrupt handler, which in turn prevents RO to clear the interrupt
line to AP, in an infinite loop.

Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
might have been a transition between RO and RW, so re-query the protocol.

Signed-off-by: Yicheng Li <yichengli@chromium.org>
---
 drivers/platform/chrome/cros_ec.c           | 24 +++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 9b2d07422e17..38ec1fb409a5 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 	return ret;
 }
 
+static int cros_ec_ready_event(struct notifier_block *nb,
+	unsigned long queued_during_suspend, void *_notify)
+{
+	struct cros_ec_device *ec_dev = container_of(nb, struct cros_ec_device,
+						     notifier_ready);
+	u32 host_event = cros_ec_get_host_event(ec_dev);
+
+	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
+		mutex_lock(&ec_dev->lock);
+		cros_ec_query_all(ec_dev);
+		mutex_unlock(&ec_dev->lock);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
 /**
  * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
  * @ec_dev: Device to register.
@@ -201,6 +218,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
 			err);
 
+	/* Register the notifier for EC_HOST_EVENT_INTERFACE_READY event. */
+	ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
+	err = blocking_notifier_chain_register(&ec_dev->event_notifier,
+					       &ec_dev->notifier_ready);
+	if (err)
+		return err;
+
 	dev_info(dev, "Chrome EC device registered\n");
 
 	return 0;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 0d4e4aaed37a..a1c545c464e7 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -121,6 +121,8 @@ struct cros_ec_command {
  * @event_data: Raw payload transferred with the MKBP event.
  * @event_size: Size in bytes of the event data.
  * @host_event_wake_mask: Mask of host events that cause wake from suspend.
+ * @notifier_ready: The notifier_block to let the kernel re-query EC
+ *      communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
  * @ec: The platform_device used by the mfd driver to interface with the
  *      main EC.
  * @pd: The platform_device used by the mfd driver to interface with the
@@ -161,6 +163,7 @@ struct cros_ec_device {
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
+	struct notifier_block notifier_ready;
 
 	/* The platform devices used by the mfd driver */
 	struct platform_device *ec;
-- 
2.21.0

