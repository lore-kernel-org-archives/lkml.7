Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1201C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9610218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E27BVn1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbfB1IrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:47:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43309 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732030AbfB1IrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:47:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so20901688wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=MPDkNzqYBY8PABtXc4Jkty/0At7LlDxkC3ycIk6GHXs=;
        b=E27BVn1fyLIaHXlOyxzBWYQnaC/8cZc4dDbvyluVkOEEzHwVzIhxeVEPVWoBqgypcQ
         3/N4nM8XdnVvr9ggWCS25RJZz8tTyN3GmdOlyy+AKepVjXqQ40TajcR/Mdt24ruhB3vP
         z3d16eNd2FlxtViz6qCiNaEX3popx+AnxEyMiZpPqBSX8GrQJdMcQrB2plulqRd3jO5j
         Qh2eWS/rWxJYvES3cVj374+MP0/BQaUDZgkWQmSLZ9qFJSEC392xIp61JZ8RHHIqTNCm
         1+EcFWswepyjySiYq/XyWYVzR8uReBTZNNQArBZEzdyVfHt1iiNZetLCFcMD9wBHl00V
         6/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=MPDkNzqYBY8PABtXc4Jkty/0At7LlDxkC3ycIk6GHXs=;
        b=BLbGz38ADxc/xtzW0MIt12PrBe18AgUbbxfGGT+5+Jln+OfGqTDR1JiXbo/ddvJh8g
         gRFb7CVA/pOg44ALfDpMgATKIAuYdhbBuqTeyqbdPky1pfZPjr444uunkWGcdC9UpHux
         SET/cahuryPSfd2AKJaiDa3LE9wIroeJZ3sGeys3lmfVw9tESbr8YBmzSQ0+HFkwm/oE
         WdY20BN4DHsgxvaT5GPNcszyTKn+IsfApjc8aSw0TzbJ5dY0V99gBB7KIr8JDUrGxin4
         vogjr3g2aL6mKKVXZvhCOshSs9Gk4uAZZ/G/k0J7P3qeO2wbA5LFvWs/di1XqIPMH6fN
         ZP/A==
X-Gm-Message-State: APjAAAWOfljrmqlWmUA8zDjAhNmO/LdMRKvhnOKSzs30jGJYl4nnB0C3
        bh6fSc/G7Ko7HbuWioKqypHCHZOB
X-Google-Smtp-Source: APXvYqwIutgjq4qYCgwpMvZ87R60YgBIappa3J9pQA3zT0+LGCYV4oWSeAOMcNb5j+NdxUlPuDZSQA==
X-Received: by 2002:a5d:6641:: with SMTP id f1mr5458515wrw.279.1551343617027;
        Thu, 28 Feb 2019 00:46:57 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:56 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] habanalabs: fix little-endian<->cpu conversion warnings
Date:   Thu, 28 Feb 2019 10:46:24 +0200
Message-Id: <20190228084624.25288-16-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __cpu_to_le16/32/64 and __le16/32/64_to_cpu where needed according to
sparse.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c          | 15 ++++---
 drivers/misc/habanalabs/habanalabs_ioctl.c |  2 +-
 drivers/misc/habanalabs/hw_queue.c         | 23 +++++-----
 drivers/misc/habanalabs/hwmon.c            | 50 ++++++++++++----------
 drivers/misc/habanalabs/irq.c              |  8 ++--
 drivers/misc/habanalabs/sysfs.c            | 25 ++++++-----
 6 files changed, 70 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 1d2bbcf90f16..a53c12aff6ad 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -29,7 +29,8 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_I2C_RD << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_I2C_RD <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.i2c_bus = i2c_bus;
 	pkt.i2c_addr = i2c_addr;
 	pkt.i2c_reg = i2c_reg;
@@ -54,11 +55,12 @@ static int hl_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_I2C_WR << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_I2C_WR <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.i2c_bus = i2c_bus;
 	pkt.i2c_addr = i2c_addr;
 	pkt.i2c_reg = i2c_reg;
-	pkt.value = val;
+	pkt.value = __cpu_to_le64(val);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					HL_DEVICE_TIMEOUT_USEC, NULL);
@@ -79,9 +81,10 @@ static void hl_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_LED_SET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.led_index = led;
-	pkt.value = state;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_LED_SET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.led_index = __cpu_to_le32(led);
+	pkt.value = __cpu_to_le64(state);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						HL_DEVICE_TIMEOUT_USEC, NULL);
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 12408d3302e9..2c2739a3c5ec 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -39,7 +39,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.num_of_events = prop->num_of_events;
 	memcpy(hw_ip.armcp_version,
 		prop->armcp_info.armcp_version, VERSION_MAX_LEN);
-	hw_ip.armcp_cpld_version = prop->armcp_info.cpld_version;
+	hw_ip.armcp_cpld_version = __le32_to_cpu(prop->armcp_info.cpld_version);
 	hw_ip.psoc_pci_pll_nr = prop->psoc_pci_pll_nr;
 	hw_ip.psoc_pci_pll_nf = prop->psoc_pci_pll_nf;
 	hw_ip.psoc_pci_pll_od = prop->psoc_pci_pll_od;
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 68dfda59a875..67bece26417c 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -80,9 +80,9 @@ static void ext_queue_submit_bd(struct hl_device *hdev, struct hl_hw_queue *q,
 
 	bd = (struct hl_bd *) (uintptr_t) q->kernel_address;
 	bd += hl_pi_2_offset(q->pi);
-	bd->ctl = ctl;
-	bd->len = len;
-	bd->ptr = ptr + hdev->asic_prop.host_phys_base_address;
+	bd->ctl = __cpu_to_le32(ctl);
+	bd->len = __cpu_to_le32(len);
+	bd->ptr = __cpu_to_le64(ptr + hdev->asic_prop.host_phys_base_address);
 
 	q->pi = hl_queue_inc_ptr(q->pi);
 	hdev->asic_funcs->ring_doorbell(hdev, q->hw_queue_id, q->pi);
@@ -249,10 +249,11 @@ static void ext_hw_queue_schedule_job(struct hl_cs_job *job)
 	len = job->job_cb_size;
 	ptr = cb->bus_address;
 
-	cq_pkt.data = (q->pi << CQ_ENTRY_SHADOW_INDEX_SHIFT)
-					& CQ_ENTRY_SHADOW_INDEX_MASK;
-	cq_pkt.data |= 1 << CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT;
-	cq_pkt.data |= 1 << CQ_ENTRY_READY_SHIFT;
+	cq_pkt.data = __cpu_to_le32(
+				((q->pi << CQ_ENTRY_SHADOW_INDEX_SHIFT)
+					& CQ_ENTRY_SHADOW_INDEX_MASK) |
+				(1 << CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT) |
+				(1 << CQ_ENTRY_READY_SHIFT));
 
 	/*
 	 * No need to protect pi_offset because scheduling to the
@@ -267,7 +268,9 @@ static void ext_hw_queue_schedule_job(struct hl_cs_job *job)
 	cq_addr += cq->pi * sizeof(struct hl_cq_entry);
 
 	hdev->asic_funcs->add_end_of_cb_packets(cb->kernel_address, len,
-				cq_addr, cq_pkt.data, q->hw_queue_id);
+						cq_addr,
+						__le32_to_cpu(cq_pkt.data),
+						q->hw_queue_id);
 
 	q->shadow_queue[hl_pi_2_offset(q->pi)] = job;
 
@@ -292,8 +295,8 @@ static void int_hw_queue_schedule_job(struct hl_cs_job *job)
 	u64 *pi, *pbd = (u64 *) &bd;
 
 	bd.ctl = 0;
-	bd.len = job->job_cb_size;
-	bd.ptr = (u64) (uintptr_t) job->user_cb;
+	bd.len = __cpu_to_le32(job->job_cb_size);
+	bd.ptr = __cpu_to_le64((u64) (uintptr_t) job->user_cb);
 
 	pi = (u64 *) (uintptr_t) (q->kernel_address +
 		((q->pi & (q->int_queue_len - 1)) * sizeof(bd)));
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index af81084ef495..77facd25c4a2 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -26,7 +26,7 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 	int rc, i, j;
 
 	for (i = 0 ; i < ARMCP_MAX_SENSORS ; i++) {
-		type = sensors_arr[i].type;
+		type = __le32_to_cpu(sensors_arr[i].type);
 
 		if ((type == 0) && (sensors_arr[i].flags == 0))
 			break;
@@ -58,10 +58,10 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 	}
 
 	for (i = 0 ; i < arr_size ; i++) {
-		type = sensors_arr[i].type;
+		type = __le32_to_cpu(sensors_arr[i].type);
 		curr_arr = sensors_by_type[type];
 		curr_arr[sensors_by_type_next_index[type]++] =
-				sensors_arr[i].flags;
+				__le32_to_cpu(sensors_arr[i].flags);
 	}
 
 	channels_info = kcalloc(num_active_sensor_types + 1,
@@ -273,9 +273,10 @@ long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_TEMPERATURE_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.sensor_index = sensor_index;
-	pkt.type = attr;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_TEMPERATURE_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.sensor_index = __cpu_to_le16(sensor_index);
+	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			SENSORS_PKT_TIMEOUT, &result);
@@ -298,9 +299,10 @@ long hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_VOLTAGE_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.sensor_index = sensor_index;
-	pkt.type = attr;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_VOLTAGE_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.sensor_index = __cpu_to_le16(sensor_index);
+	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SENSORS_PKT_TIMEOUT, &result);
@@ -323,9 +325,10 @@ long hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_CURRENT_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.sensor_index = sensor_index;
-	pkt.type = attr;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_CURRENT_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.sensor_index = __cpu_to_le16(sensor_index);
+	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SENSORS_PKT_TIMEOUT, &result);
@@ -348,9 +351,10 @@ long hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_FAN_SPEED_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.sensor_index = sensor_index;
-	pkt.type = attr;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_FAN_SPEED_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.sensor_index = __cpu_to_le16(sensor_index);
+	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SENSORS_PKT_TIMEOUT, &result);
@@ -373,9 +377,10 @@ long hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_PWM_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.sensor_index = sensor_index;
-	pkt.type = attr;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_PWM_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.sensor_index = __cpu_to_le16(sensor_index);
+	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SENSORS_PKT_TIMEOUT, &result);
@@ -398,10 +403,11 @@ void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_PWM_SET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.sensor_index = sensor_index;
-	pkt.type = attr;
-	pkt.value = value;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_PWM_SET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.sensor_index = __cpu_to_le16(sensor_index);
+	pkt.type = __cpu_to_le16(attr);
+	pkt.value = __cpu_to_le64(value);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SENSORS_PKT_TIMEOUT, NULL);
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index d4c2077a3718..e69a09c10e3f 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -161,8 +161,8 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 
 	while (1) {
 		bool entry_ready =
-				((eq_base[eq->ci].hdr.ctl & EQ_CTL_READY_MASK)
-						>> EQ_CTL_READY_SHIFT);
+			((__le32_to_cpu(eq_base[eq->ci].hdr.ctl) &
+				EQ_CTL_READY_MASK) >> EQ_CTL_READY_SHIFT);
 
 		if (!entry_ready)
 			break;
@@ -194,7 +194,9 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 		}
 skip_irq:
 		/* Clear EQ entry ready bit */
-		eq_entry->hdr.ctl &= ~EQ_CTL_READY_MASK;
+		eq_entry->hdr.ctl =
+			__cpu_to_le32(__le32_to_cpu(eq_entry->hdr.ctl) &
+							~EQ_CTL_READY_MASK);
 
 		eq->ci = hl_eq_inc_ptr(eq->ci);
 
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 12c782112a8c..c900ab15cceb 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -21,12 +21,12 @@ long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 	memset(&pkt, 0, sizeof(pkt));
 
 	if (curr)
-		pkt.ctl = ARMCP_PACKET_FREQUENCY_CURR_GET <<
-						ARMCP_PKT_CTL_OPCODE_SHIFT;
+		pkt.ctl = __cpu_to_le32(ARMCP_PACKET_FREQUENCY_CURR_GET <<
+						ARMCP_PKT_CTL_OPCODE_SHIFT);
 	else
-		pkt.ctl = ARMCP_PACKET_FREQUENCY_GET <<
-						ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.pll_index = pll_index;
+		pkt.ctl = __cpu_to_le32(ARMCP_PACKET_FREQUENCY_GET <<
+						ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.pll_index = __cpu_to_le32(pll_index);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						SET_CLK_PKT_TIMEOUT, &result);
@@ -48,9 +48,10 @@ void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_FREQUENCY_SET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.pll_index = pll_index;
-	pkt.value = freq;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_FREQUENCY_SET <<
+					ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.pll_index = __cpu_to_le32(pll_index);
+	pkt.value = __cpu_to_le64(freq);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SET_CLK_PKT_TIMEOUT, NULL);
@@ -69,7 +70,8 @@ u64 hl_get_max_power(struct hl_device *hdev)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_MAX_POWER_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_MAX_POWER_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						SET_PWR_PKT_TIMEOUT, &result);
@@ -89,8 +91,9 @@ void hl_set_max_power(struct hl_device *hdev, u64 value)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_MAX_POWER_SET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.value = value;
+	pkt.ctl = __cpu_to_le32(ARMCP_PACKET_MAX_POWER_SET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.value = __cpu_to_le64(value);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 					SET_PWR_PKT_TIMEOUT, NULL);
-- 
2.17.1

