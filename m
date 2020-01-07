Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A50C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B443206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LQObYK7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgAGWH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:07:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42082 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGWH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:07:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so510316pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 14:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAKe0A0NI9z/zrTMrJJQukADk0aDuPSGWmIx5vCR8B8=;
        b=LQObYK7dHmhCe3OwuTyTylMpOVZ6ZXz3FhxMyEsp2rF56PU7I2PEv6CYuNoFKTkClB
         V0Pw9m8gsLtvwhQDJcEIwIBmDLK+xKEXA6osI/EzTG3jYCzsJv7lXlbz++TenzUYIba4
         Gj2Q0aEiFScRbnrzz6EBsr8jw7wkx6Mb3fWVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAKe0A0NI9z/zrTMrJJQukADk0aDuPSGWmIx5vCR8B8=;
        b=YIBOAyIsCMMiumBMqqi7eT1175nvMx8VmkShu7mnUhPMa+NdRIu340/SaJaN7cLery
         ttU4XsMSQehrF+EBYA/+LrDU1K83ONM6OA0SUd4U8YHz8WncVLqLOTfcYq753J5cnxRY
         sDDPqXk+scd11VgrCVf+fZaDv3OrOG68hZD6AhmIy+vr5vMiIVEB5j86TIaJKzNuphQS
         0OU6F8uhErhBUwb4cPiRMhoS8LnX2KNIa45tlUYyrjRYqGOg775vDrRuqrkmC/40DpBI
         Pe3ucp5TcNYgkHEFBZTRcZx4+RBQ5UpBcXh5U9Qu5p2JEP94/paMtV2vakJfUJNheCBZ
         UY0Q==
X-Gm-Message-State: APjAAAUpqOqUTqs0FSZHpGoXcpkbVvZyDg46Ay07w1QJwfGtM9mNG+nb
        LS70boQQ9rmaCQvFUV0wNHgg5IDfQe0=
X-Google-Smtp-Source: APXvYqwHfTYI3edQLbXOax9AEQjHKXwQus62qiOoMKTygl1Yh/09/0nOT0YYH6LWVmJnoJuJDPONYg==
X-Received: by 2002:a63:d411:: with SMTP id a17mr1804226pgh.333.1578434876245;
        Tue, 07 Jan 2020 14:07:56 -0800 (PST)
Received: from yichengli2.mtv.corp.google.com ([2620:15c:202:201:fd9f:cb79:f2f4:c8c7])
        by smtp.gmail.com with ESMTPSA id k1sm704787pgk.90.2020.01.07.14.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 14:07:55 -0800 (PST)
From:   Yicheng Li <yichengli@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, bleung@chromium.org,
        gwendal@chromium.org
Cc:     Yicheng Li <yichengli@chromium.org>
Subject: [PATCH v5] platform: cros_ec: Query EC protocol version if EC transitions between RO/RW
Date:   Tue,  7 Jan 2020 14:06:40 -0800
Message-Id: <20200107220640.834-1-yichengli@chromium.org>
X-Mailer: git-send-email 2.21.0
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

Change-Id: I49a51cc10d22a4ab9e75204a4c0c8819d5b3d282
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

