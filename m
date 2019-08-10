Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E37CC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3722089E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je3oqS+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfHJMjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:39:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55868 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfHJMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:39:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so8141051wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IEyzP5zJ5zGvpACzPsLzVOFkm5YXXQog+hyBUHaxYH4=;
        b=Je3oqS+4hXNykX2OnzqFegmwaL+lMZLKlUcaffbeExEdx8vCTJdhvCtB/yNOE6OWHJ
         6Y8k2pv+Z7621dvgqEqvZprp7SVdYtJHGf6/dbvAZQRzg7NFuytOE+/3L+tOqfon9hja
         uxtrf3uyRg47eYX5VBRdHRgCSWrDzwA5oYS3jcvWhj8lhN36fn4QlQli0VBEgTEZbqu1
         MqIj+ZvdMoFdD/8gI4qPiVw5HWcZgw8LhmxH0iRF/hMpJrZYsWiN589O0AEe1pYkusXP
         ToEjv6y1NexXmeiuqLHAIRVOg8fSSIUsUlatnFm+sEM9MJJjxJN6B22wtivauvMbuMV5
         5f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IEyzP5zJ5zGvpACzPsLzVOFkm5YXXQog+hyBUHaxYH4=;
        b=C49Nen8E5Pj7fqqdI3zCJjyKZtJeb3PcogZ15fprbbEEjYSLxnDiPFUcrBiNZG1rXI
         Yf3Z8+l8/+e05YrOjyV3FiCKDsXPI+Cs1db2wvXPyyld5Y7ZWs6ykuKhihNReWnZnhfx
         mDyAs7v6aqGW+Ij9pneUF3BthAG7W0fv7pqTQkDOec3+U8AGoFxl+NK6r/CpNTmZjikT
         FBAB0nPhxc2+te3stTl/3H/PD9rN1XS+pGmrdlYdPqUvLB/DLRlzQu2QhiKigtdUxDKj
         Q45pl4KcynJnECn62ZicGp2kcvT+RukgnYPIWz7btgBGnXWJvLm0TJTlcrPI1QbQIhWB
         50zg==
X-Gm-Message-State: APjAAAUE9La5bmIho//Pf3Kdp/lvON5xwoVOXfUwBpPRCDD/Kv9VOHEe
        QmOXoReKtvgXoBG7SNgmKZI28rZ+REo=
X-Google-Smtp-Source: APXvYqzoD6MVgNH+CJeXUz5LZFOh6q6DgNquXkPzJzNhjcFHzGxrGz/m9g0RUGuHRPdWrdUDqzaNMQ==
X-Received: by 2002:a1c:4d0c:: with SMTP id o12mr9636851wmh.62.1565440777787;
        Sat, 10 Aug 2019 05:39:37 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c1sm224106318wrh.1.2019.08.10.05.39.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 05:39:37 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, bpsegal20@gmail.com
Subject: [PATCH 1/2] habanalabs: replace __cpu_to_le32/64 with cpu_to_le32/64
Date:   Sat, 10 Aug 2019 15:39:34 +0300
Message-Id: <20190810123935.14011-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some files the code use __cpu_to_le32/64 while in other it use
cpu_to_le32/64. Replace all __cpu_to_le32/64 instances with
cpu_to_le32/64 for consistency.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c  | 12 ++++++------
 drivers/misc/habanalabs/hw_queue.c |  8 ++++----
 drivers/misc/habanalabs/hwmon.c    | 14 +++++++-------
 drivers/misc/habanalabs/irq.c      |  2 +-
 drivers/misc/habanalabs/sysfs.c    | 18 +++++++++---------
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 2b9bc1c41d40..87f37ac31ccd 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -29,7 +29,7 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_I2C_RD <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_I2C_RD <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.i2c_bus = i2c_bus;
 	pkt.i2c_addr = i2c_addr;
@@ -55,12 +55,12 @@ static int hl_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_I2C_WR <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_I2C_WR <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.i2c_bus = i2c_bus;
 	pkt.i2c_addr = i2c_addr;
 	pkt.i2c_reg = i2c_reg;
-	pkt.value = __cpu_to_le64(val);
+	pkt.value = cpu_to_le64(val);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					HL_DEVICE_TIMEOUT_USEC, NULL);
@@ -81,10 +81,10 @@ static void hl_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_LED_SET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_LED_SET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.led_index = __cpu_to_le32(led);
-	pkt.value = __cpu_to_le64(state);
+	pkt.led_index = cpu_to_le32(led);
+	pkt.value = cpu_to_le64(state);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						HL_DEVICE_TIMEOUT_USEC, NULL);
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index e3b5517897ea..509c6cb14d71 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -80,9 +80,9 @@ static void ext_queue_submit_bd(struct hl_device *hdev, struct hl_hw_queue *q,
 
 	bd = (struct hl_bd *) (uintptr_t) q->kernel_address;
 	bd += hl_pi_2_offset(q->pi);
-	bd->ctl = __cpu_to_le32(ctl);
-	bd->len = __cpu_to_le32(len);
-	bd->ptr = __cpu_to_le64(ptr);
+	bd->ctl = cpu_to_le32(ctl);
+	bd->len = cpu_to_le32(len);
+	bd->ptr = cpu_to_le64(ptr);
 
 	q->pi = hl_queue_inc_ptr(q->pi);
 	hdev->asic_funcs->ring_doorbell(hdev, q->hw_queue_id, q->pi);
@@ -249,7 +249,7 @@ static void ext_hw_queue_schedule_job(struct hl_cs_job *job)
 	len = job->job_cb_size;
 	ptr = cb->bus_address;
 
-	cq_pkt.data = __cpu_to_le32(
+	cq_pkt.data = cpu_to_le32(
 				((q->pi << CQ_ENTRY_SHADOW_INDEX_SHIFT)
 					& CQ_ENTRY_SHADOW_INDEX_MASK) |
 				(1 << CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT) |
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 77facd25c4a2..a4319c6fabe6 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -273,7 +273,7 @@ long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_TEMPERATURE_GET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEMPERATURE_GET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
@@ -299,7 +299,7 @@ long hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_VOLTAGE_GET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_VOLTAGE_GET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
@@ -325,7 +325,7 @@ long hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_CURRENT_GET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_CURRENT_GET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
@@ -351,7 +351,7 @@ long hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_FAN_SPEED_GET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_FAN_SPEED_GET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
@@ -377,7 +377,7 @@ long hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_PWM_GET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_PWM_GET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
@@ -403,11 +403,11 @@ void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_PWM_SET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_PWM_SET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
-	pkt.value = __cpu_to_le64(value);
+	pkt.value = cpu_to_le64(value);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SENSORS_PKT_TIMEOUT, NULL);
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index ea9f72ff456c..2c3dbfdf2722 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -195,7 +195,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 skip_irq:
 		/* Clear EQ entry ready bit */
 		eq_entry->hdr.ctl =
-			__cpu_to_le32(__le32_to_cpu(eq_entry->hdr.ctl) &
+			cpu_to_le32(__le32_to_cpu(eq_entry->hdr.ctl) &
 							~EQ_CTL_READY_MASK);
 
 		eq->ci = hl_eq_inc_ptr(eq->ci);
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 080da09cc3b0..4cd622b017b9 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -21,12 +21,12 @@ long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 	memset(&pkt, 0, sizeof(pkt));
 
 	if (curr)
-		pkt.ctl = __cpu_to_le32(ARMCP_PACKET_FREQUENCY_CURR_GET <<
+		pkt.ctl = cpu_to_le32(ARMCP_PACKET_FREQUENCY_CURR_GET <<
 						ARMCP_PKT_CTL_OPCODE_SHIFT);
 	else
-		pkt.ctl = __cpu_to_le32(ARMCP_PACKET_FREQUENCY_GET <<
+		pkt.ctl = cpu_to_le32(ARMCP_PACKET_FREQUENCY_GET <<
 						ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.pll_index = __cpu_to_le32(pll_index);
+	pkt.pll_index = cpu_to_le32(pll_index);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						SET_CLK_PKT_TIMEOUT, &result);
@@ -48,10 +48,10 @@ void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_FREQUENCY_SET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_FREQUENCY_SET <<
 					ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.pll_index = __cpu_to_le32(pll_index);
-	pkt.value = __cpu_to_le64(freq);
+	pkt.pll_index = cpu_to_le32(pll_index);
+	pkt.value = cpu_to_le64(freq);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SET_CLK_PKT_TIMEOUT, NULL);
@@ -70,7 +70,7 @@ u64 hl_get_max_power(struct hl_device *hdev)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_MAX_POWER_GET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_MAX_POWER_GET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
@@ -91,9 +91,9 @@ void hl_set_max_power(struct hl_device *hdev, u64 value)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_MAX_POWER_SET <<
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_MAX_POWER_SET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.value = __cpu_to_le64(value);
+	pkt.value = cpu_to_le64(value);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SET_PWR_PKT_TIMEOUT, NULL);
-- 
2.17.1

