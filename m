Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20247C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCC52070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UkcU0Xtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfKVVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 16:30:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36393 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 16:30:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so3937537pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 13:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7t6M7j4eqiF4dAhaLb38TLT0fseDmfpNVbu55ek7TJs=;
        b=UkcU0XtuucvAShhb0pzKP6YFeq4hY9MgO+n6mEWZfPueG4LkIw8qA/WAhVfRd7v2mE
         ZmhEKbsTpCo64S5pwoid3Js7ErRM5+b5naWqAs2ECtx6og9T5GPgofcFR70vUsmai/tZ
         wUuheWp6w/Bv5y4QdnOLThkxxiHCSb/23IkmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7t6M7j4eqiF4dAhaLb38TLT0fseDmfpNVbu55ek7TJs=;
        b=lgGjgf1IAg4ym9IGqnYo8/bWiXxE2fu6K/BcnxQmxG8vHjJvTOsp8AFdLMyMVEfuue
         RBRE8ayfA1CyLESd4iHcGLK8O3bWZOGr0BDj9/e+VMKFxzZ/nS6vmUtMhwpxTF0djdzI
         0alO7Eltc9ERn77m8+zybmyMZAC3kg/0W8iPoREE+DJRctkXEsJVbj3+UoanJ8/HGpCn
         LlkvFQpamaaI14zCm23C4W3gM+BEaJYWMo9+REyRPqUr2fWEWODiTADyeysb3oneTP1z
         xHPobNZDrFEDOXle5v7WsBL+BYK7poFKu1XAfIOG+0+btFyTZmlB+Rc3r7d4GPQowdyX
         3/OQ==
X-Gm-Message-State: APjAAAV8SFUF6JSOEXfGLBPYrBVTlsSchRA5xPvSnpAOSluj6Iv00dvk
        I24qP5AUVjuVWfNAwt5kFloSY2tEqW8XyQ==
X-Google-Smtp-Source: APXvYqwiN/mWcSIoSkuvttbGyx3kyPi5/7BOGNQ2jQdusDflTn8/lXnX1PxEvK/e1tB66wnR/JRJog==
X-Received: by 2002:a65:68ce:: with SMTP id k14mr11031165pgt.374.1574458204763;
        Fri, 22 Nov 2019 13:30:04 -0800 (PST)
Received: from yichengli2.mtv.corp.google.com ([2620:15c:202:201:900:2031:8afd:85a7])
        by smtp.gmail.com with ESMTPSA id t15sm8019237pgb.0.2019.11.22.13.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 13:30:04 -0800 (PST)
From:   Yicheng Li <yichengli@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, yichengli@chromium.org, gwendal@chromium.org,
        enric.balletbo@collabora.com
Subject: [PATCH v2] mfd / platform: cros_ec: Query EC protocol version if EC transitions between RO/RW
Date:   Fri, 22 Nov 2019 13:29:05 -0800
Message-Id: <20191122212905.35679-1-yichengli@chromium.org>
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
---
 drivers/platform/chrome/cros_ec.c           | 23 +++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 9b2d07422e17..a72514ac3ce7 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -104,6 +104,22 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
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
+
+	return NOTIFY_DONE;
+}
+
 /**
  * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
  * @ec_dev: Device to register.
@@ -201,6 +217,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
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
index 0d4e4aaed37a..4b016d5dbf50 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -161,6 +161,11 @@ struct cros_ec_device {
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
+	/*
+	 * The notifier block to let the kernel re-query EC communication
+	 * protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
+	 */
+	struct notifier_block notifier_ready;
 
 	/* The platform devices used by the mfd driver */
 	struct platform_device *ec;
-- 
2.21.0

