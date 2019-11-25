Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A98DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A16C20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqpuLa9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfKYWK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:10:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35256 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKYWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:10:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id k32so7895359pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uSk89rwk3LhruRumDT0sWFKtI2GO4i/0/5W+hrAVr8=;
        b=gqpuLa9V7M67zMfZifxpKgfiMf2jhG6/47Y77FtYSr+dqmdGU6cHFYhmk9xmTZkTTn
         lHOx4vu0wy3zLAA36VvKX4fyXJ5sdoEzvs4yGOKEX2LcgGEzfx3afomZalwfGlTUwJ5q
         l1kYIDL4TiLa6l1whm4GzsIde+nE86ieg8SFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uSk89rwk3LhruRumDT0sWFKtI2GO4i/0/5W+hrAVr8=;
        b=qHjAdnuVD4XeYA+Oby8RSETi7dQWuL9y33PEx1yyR2nYgY8YgSx0KrsdRvLCPqcst7
         LRYYYxu+d42nWHnzGkSepgnfro8jUdXlpxSTN6xZ0EnXZ4mHnwzq1NBd4f7s5KMZRlSy
         Z42gE+Fb7gzUPQ7r+ZCa5IbWJ6xo/+t+ZNo8VCHNTK2wfTVWuvv/miSuYgz5CZJUnBzo
         A1SY/Si8LD+pXBioM9H8ZK5tpY9PoxlZsykmC8UlgYlOnTfvKGjwBTm5p8SgmpxAGHFr
         RcPsOvKgYeIe4RNMxdOJUmydOCbM5lAuKkQw+oyfUe7kQCHoMTzJ0Dw12n7mYjxswxeh
         qcrw==
X-Gm-Message-State: APjAAAVYeAlxImI3mBhL2BvPg0exwUfv5AICUp+kTHPlcfK/nPLWuxC3
        qUs0Wtuof6ernGR3h5hG3RfhdtwEm3EZvQ==
X-Google-Smtp-Source: APXvYqyvgNTzIai+q2u6B6X+xm5pqCuMaQ9uQsBt3beHpfjzLpsoe4qoi1Oesgxs6Tu+NuvMfJqtLA==
X-Received: by 2002:a63:e44b:: with SMTP id i11mr34828226pgk.437.1574719855265;
        Mon, 25 Nov 2019 14:10:55 -0800 (PST)
Received: from yichengli2.mtv.corp.google.com ([2620:15c:202:201:900:2031:8afd:85a7])
        by smtp.gmail.com with ESMTPSA id 16sm9692768pgm.86.2019.11.25.14.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 14:10:54 -0800 (PST)
From:   Yicheng Li <yichengli@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, yichengli@chromium.org, gwendal@chromium.org,
        enric.balletbo@collabora.com
Subject: [PATCH v3] mfd / platform: cros_ec: Query EC protocol version if EC transitions between RO/RW
Date:   Mon, 25 Nov 2019 14:08:59 -0800
Message-Id: <20191125220859.91412-1-yichengli@chromium.org>
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
index 0d4e4aaed37a..a4b255937901 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -121,6 +121,8 @@ struct cros_ec_command {
  * @event_data: Raw payload transferred with the MKBP event.
  * @event_size: Size in bytes of the event data.
  * @host_event_wake_mask: Mask of host events that cause wake from suspend.
+ * @notifier_ready: The notifier_block to let the kernel re-query EC
+ * 	communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
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

