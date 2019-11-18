Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F57C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8803206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T0R/trUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKRUAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:00:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36379 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfKRUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:00:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id d7so10379074pls.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 12:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaDQj3BXS9cxTEMFxSvnVLBYAYGeKUm8GiNDIQ/febk=;
        b=T0R/trUSE8u3LKfkRyrHiaUcFfQ9XxR9qXqS4g9bqE7AUsbSOb1Dr4AycFxH+O35h4
         XZx2ib3rnHYZhf/lO3L3C1l+n8cbbhz5SoX3FHrk670TyXo2Xact4cAmxyQsDA8a5KE3
         DE9FBR1McU14LrsSCbVNMqMSuyjqke+qrHdbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaDQj3BXS9cxTEMFxSvnVLBYAYGeKUm8GiNDIQ/febk=;
        b=kHaqfydzS0POsvVFAv3mL16Wi5jW30Jy1E62hqHKOBWasIcjWGtFQTlbjGDY6C7bq6
         pEuT5eSKFr+CtuAt0c6vuXcHxDaxYk2Ph8vdco6iT8VLFWEamBBIlS3OXGAJ5mliqZnC
         1HMUBw/6GOmHzX17K/AcAXGvBc97rdVWTHHdtBr513C8XVADfvxIZ0jglOPc17J57QkR
         7GD7ysKdo48mOApaT+G7pd2A/2qyPSog/naZvSzcLTqGG6t9iEDFpimUXQ71TkphQCCQ
         Gi3cvV+6LOxDtpJV5Z8uCB5KHldWiXCsw19vv9OkWcbgZGej6gUwNyiXJLo2cTooH2d6
         HuWQ==
X-Gm-Message-State: APjAAAU+NaV1Mijx/mdTS3wwzgCzQaeLEkUgNer05IQi3qpJxzQus4Oq
        mFqvyJ2Kaoz6y/Cyy0FRsKJkxXIH96xvPg==
X-Google-Smtp-Source: APXvYqw1lF6dgyG3REbJwyzKdyVrbkDu2ttqxKs3TsZDwMXArnakS9c8mnTFPNrx6lDm+C/t6IbAdg==
X-Received: by 2002:a17:902:449:: with SMTP id 67mr30839624ple.20.1574107246505;
        Mon, 18 Nov 2019 12:00:46 -0800 (PST)
Received: from yichengli2.mtv.corp.google.com ([2620:15c:202:201:900:2031:8afd:85a7])
        by smtp.gmail.com with ESMTPSA id x2sm21230509pfn.167.2019.11.18.12.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 12:00:45 -0800 (PST)
From:   Yicheng Li <yichengli@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, yichengli@chromium.org, gwendal@chromium.org,
        enric.balletbo@collabora.com
Subject: [PATCH] mfd / platform: cros_ec: Query EC protocol version if EC transitions between RO/RW
Date:   Mon, 18 Nov 2019 12:00:00 -0800
Message-Id: <20191118200000.35484-1-yichengli@chromium.org>
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

Signed-off-by: Yicheng Li <yichengli@chromium.org>

Change-Id: Ib58032ff4a8e113bdbd07212e8aff42807afff38
Series-to: LKML <linux-kernel@vger.kernel.org>
Series-cc: Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec.c           | 24 +++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 9b2d07422e17..0c910846d99d 100644
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
+	} else {
+		return NOTIFY_DONE;
+	}
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
+	if (err < 0)
+		dev_warn(ec_dev->dev, "Failed to register notifier\n");
+
 	dev_info(dev, "Chrome EC device registered\n");
 
 	return 0;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 0d4e4aaed37a..9840408c0b01 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -161,6 +161,7 @@ struct cros_ec_device {
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
+	struct notifier_block notifier_ready;
 
 	/* The platform devices used by the mfd driver */
 	struct platform_device *ec;
-- 
2.21.0

