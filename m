Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF61BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1479217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXDM/W1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfEIVPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:15:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33151 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfEIVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so1847291pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kndU7Xslh2hLi/DqA2dn0GioPk0zdFJqRn58k4JjEzA=;
        b=XXDM/W1tSNKpxoFI+18TDU3bZOG/87Pk6v8GCeAs16B75QQZVC7fXBA9jRV3riScD6
         Zi78CQfQMhPa/TYuIKQVsaAZG0mTIL6c8Qd+njt6gmFJR790tf4bGgeQsLM1fx5LkBjQ
         p9CRBfMAZqi65A6IjvvjSZ62RrlwCM25rLJjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kndU7Xslh2hLi/DqA2dn0GioPk0zdFJqRn58k4JjEzA=;
        b=FhF7rwgCu0cNgWzQXrRzERg5ovN2gL/vKQb8x4qvNWGfUi1jC9M6O+xEp/EerBgYvh
         0Z4iPT5+Ubmgc7gXXBGsReGHdE9cus/mdfj9YpHwpA0CHm1bweLnPYG2ulF+PkqtAnc6
         Z+sTyl6d/zanUKt4fMUQ1BHTtQaBmf7Pi8Ix0bt9hNvPUnkmdfOX1uci2XjnzvcxYfNx
         5jJkAkI458Tth6m4B73/lSsyB5ljqPHOY8YJl0h4T9br7YPv9n8bPcVHmg8kkbVmf9/j
         WL0ks/8UdkwAwZtUDc+YI/L/mwLkptj7I4mxUKDGeyOAHxHpAy/kdyLSMngY2WBay6op
         wB9g==
X-Gm-Message-State: APjAAAXoiprXJeK9oei1wV8ct578bKmlVqCabXMR8JuXMHZplx1HvIb9
        ucOG4cjtC9hJ+/8X6KqZvu8XaA==
X-Google-Smtp-Source: APXvYqyqQpbyug3xNASyR67esNzWvlSBWh2hPs6AEx8m/jqmlvUYfpHoe/718Hxhu55p6WgwvA/CdA==
X-Received: by 2002:a63:1055:: with SMTP id 21mr8550709pgq.200.1557436479918;
        Thu, 09 May 2019 14:14:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y68sm4422349pfy.28.2019.05.09.14.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:39 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 24/30] mfd: cros_ec: Add API for EC-EC communication
Date:   Thu,  9 May 2019 14:13:47 -0700
Message-Id: <20190509211353.213194-25-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow EC to talk to other ECs that are not presented to the host.
Neeed when EC are present in detachable keyboard.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 95 ++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 59ad6bae3f9b..52fd9bfafc7f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5043,6 +5043,101 @@ struct ec_response_pd_chip_info_v1 {
 	};
 } __ec_align2;
 
+/*****************************************************************************/
+/* EC-EC communication commands: range 0x0600-0x06FF */
+
+#define EC_COMM_TEXT_MAX 8
+
+/*
+ * Get battery static information, i.e. information that never changes, or
+ * very infrequently.
+ */
+#define EC_CMD_BATTERY_GET_STATIC 0x0600
+
+/**
+ * struct ec_params_battery_static_info - Battery static info parameters
+ * @index: Battery index.
+ */
+struct ec_params_battery_static_info {
+	uint8_t index;
+} __ec_align_size1;
+
+/**
+ * struct ec_response_battery_static_info - Battery static info response
+ * @design_capacity: Battery Design Capacity (mAh)
+ * @design_voltage: Battery Design Voltage (mV)
+ * @manufacturer: Battery Manufacturer String
+ * @model: Battery Model Number String
+ * @serial: Battery Serial Number String
+ * @type: Battery Type String
+ * @cycle_count: Battery Cycle Count
+ */
+struct ec_response_battery_static_info {
+	uint16_t design_capacity;
+	uint16_t design_voltage;
+	char manufacturer[EC_COMM_TEXT_MAX];
+	char model[EC_COMM_TEXT_MAX];
+	char serial[EC_COMM_TEXT_MAX];
+	char type[EC_COMM_TEXT_MAX];
+	/* TODO(crbug.com/795991): Consider moving to dynamic structure. */
+	uint32_t cycle_count;
+} __ec_align4;
+
+/*
+ * Get battery dynamic information, i.e. information that is likely to change
+ * every time it is read.
+ */
+#define EC_CMD_BATTERY_GET_DYNAMIC 0x0601
+
+/**
+ * struct ec_params_battery_dynamic_info - Battery dynamic info parameters
+ * @index: Battery index.
+ */
+struct ec_params_battery_dynamic_info {
+	uint8_t index;
+} __ec_align_size1;
+
+/**
+ * struct ec_response_battery_dynamic_info - Battery dynamic info response
+ * @actual_voltage: Battery voltage (mV)
+ * @actual_current: Battery current (mA); negative=discharging
+ * @remaining_capacity: Remaining capacity (mAh)
+ * @full_capacity: Capacity (mAh, might change occasionally)
+ * @flags: Flags, see EC_BATT_FLAG_*
+ * @desired_voltage: Charging voltage desired by battery (mV)
+ * @desired_current: Charging current desired by battery (mA)
+ */
+struct ec_response_battery_dynamic_info {
+	int16_t actual_voltage;
+	int16_t actual_current;
+	int16_t remaining_capacity;
+	int16_t full_capacity;
+	int16_t flags;
+	int16_t desired_voltage;
+	int16_t desired_current;
+} __ec_align2;
+
+/*
+ * Control charger chip. Used to control charger chip on the slave.
+ */
+#define EC_CMD_CHARGER_CONTROL 0x0602
+
+/**
+ * struct ec_params_charger_control - Charger control parameters
+ * @max_current: Charger current (mA). Positive to allow base to draw up to
+ *     max_current and (possibly) charge battery, negative to request current
+ *     from base (OTG).
+ * @otg_voltage: Voltage (mV) to use in OTG mode, ignored if max_current is
+ *     >= 0.
+ * @allow_charging: Allow base battery charging (only makes sense if
+ *     max_current > 0).
+ */
+struct ec_params_charger_control {
+	int16_t max_current;
+	uint16_t otg_voltage;
+	uint8_t allow_charging;
+} __ec_align_size1;
+
 /*****************************************************************************/
 /*
  * Reserve a range of host commands for board-specific, experimental, or
-- 
2.21.0.1020.gf2820cf01a-goog

