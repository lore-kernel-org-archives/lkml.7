Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69773C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3A2217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RPxSnOua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfEIVPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:15:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37148 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfEIVOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so1960787pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+h3ZCcM9MpDCep6vj98M9256/ZFO8iCeubysmTQphKw=;
        b=RPxSnOuaT+7NiAnWU9r2lkLt4O5o81vjUi5euxKDdMKugrsCE2PO3HyjiNWHXWobro
         JAuJTgafQ9RNgrozFxjdwHc1kWQfBcrGPHdytv4WtNPkGLt9GgUZ4PBrBEpEjCclkJcZ
         x5XJBT3pGWQw/ZdcC5V3Ca6RxmcMTyw5XlzZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+h3ZCcM9MpDCep6vj98M9256/ZFO8iCeubysmTQphKw=;
        b=g72fqWXuuyVYDcEF3m8450e3wKKmiNN+YFEq+JbCpFcUmZVvFXyxyFCKydBvx402Ug
         1J2D9V95RWIowBVacLJi45ExLOw6p94zx3BQdzREDxnOvihSjfVQRP2L1ZWwI+y/8EF7
         xN2jrEmLIClYsk18r6Pi/8EUrHFIbdj3ybedhA6B+2+vRJgteZZBAYj0Yoa1zHC2c41B
         JGlHAnFNjFH9OsejVDTM+sW5zuuBrZsyJmxBwD9gw54yyhbAyaV1GMSHtIucuSh8kumn
         8k+tQldpbSiYeZZYIfW3XfW6GU0bBQnphE0sLH6yG3TFvuk7rIPO2fY261MgSH0cqVjN
         XHlA==
X-Gm-Message-State: APjAAAV7uQhFf48xjS7FO36/gbaqxe5ZKcfhMXwDmd2pX7qmJLgEX1cW
        +73yFAVQXqJNjJOWagZLPLGvRA==
X-Google-Smtp-Source: APXvYqybvV1SDSpdMntWVGN1RGD3itiZ/UQtphKXBoQYbxE0T7Kq2owXdemONr3wy8wdfEMwbhF3ug==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr8645706pgl.66.1557436481339;
        Thu, 09 May 2019 14:14:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y10sm4787693pfm.27.2019.05.09.14.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:40 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 25/30] mfd: cros_ec: Add API for Touchpad support
Date:   Thu,  9 May 2019 14:13:48 -0700
Message-Id: <20190509211353.213194-26-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API to control touchpad presented by Embedded Controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 52fd9bfafc7f..1d0311df44d3 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5043,6 +5043,32 @@ struct ec_response_pd_chip_info_v1 {
 	};
 } __ec_align2;
 
+/*****************************************************************************/
+/* Touchpad MCU commands: range 0x0500-0x05FF */
+
+/* Perform touchpad self test */
+#define EC_CMD_TP_SELF_TEST 0x0500
+
+/* Get number of frame types, and the size of each type */
+#define EC_CMD_TP_FRAME_INFO 0x0501
+
+struct ec_response_tp_frame_info {
+	uint32_t n_frames;
+	uint32_t frame_sizes[0];
+} __ec_align4;
+
+/* Create a snapshot of current frame readings */
+#define EC_CMD_TP_FRAME_SNAPSHOT 0x0502
+
+/* Read the frame */
+#define EC_CMD_TP_FRAME_GET 0x0503
+
+struct ec_params_tp_frame_get {
+	uint32_t frame_index;
+	uint32_t offset;
+	uint32_t size;
+} __ec_align4;
+
 /*****************************************************************************/
 /* EC-EC communication commands: range 0x0600-0x06FF */
 
-- 
2.21.0.1020.gf2820cf01a-goog

