Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D022C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D4A217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JpW4Ryw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEIVOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:14:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41102 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfEIVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id l132so1948735pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWvAY4K5cYu5xkAR+mJg2cVJek8r16jFV7NVls6qS9c=;
        b=JpW4Ryw8tqmPFPFAchXp1X9VT4fU2cbiQ0yBmM7ndRPotHYeBOZKfsSPNorkN5JNj/
         0KOUSxFVFO9NUTZwpAc+eWHb8oeSW2rxjUaX84f4sJrZLr4cf3xKCyVnTY72YV6/ZKoZ
         aJSIj+srJzho+5meGrzG3KMT73SBpeJy3StIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWvAY4K5cYu5xkAR+mJg2cVJek8r16jFV7NVls6qS9c=;
        b=WSNkS6vPvml65oue11I86Z3SMdy5f6y/+zwb2sR2Q1Y3BkeQ0x/T7zYrP1bSfIMSOP
         hWS7wq+oCgZdkpDCw/udWy0EqQVRWmoT6m8i9kCMA2jKQCgBLZe2/j9jV65NsE7TMjKY
         NQIeiVfLwtn5w5RBC0PL5VWjVre+LSZZukSCKy1mYGcgKVat+iC8cZFb0cWqke8mm/JX
         KtVLhibZ5JjOdkuN3soIY3DqJtL2tDyQ2hPJC8PAXy8AjRTjEZ7W6CxvMhyNWpwaNS/Z
         ClwCAYpEkYv6YSNOiBIJ/UCOWO1SY7YCcIFjSSdfAOkdrWHc0NH8Xo9Kko10CrkXcrRZ
         KXKg==
X-Gm-Message-State: APjAAAUhoOlm75CinDzx1bwcelkmHGlSHSzvjg8v+C+Bh5B0uUu3x69R
        7C3UovOQQlK+BG8eKZsSQRfLoQ==
X-Google-Smtp-Source: APXvYqx1Iq1e/sNoyrlAeNXcTzecx8lWKa66VICbey3qV9o32uy+N6ac81klOjDvLhAs0TAsGCsmhA==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr8570279pff.94.1557436473285;
        Thu, 09 May 2019 14:14:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id n15sm6777740pfb.111.2019.05.09.14.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:32 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 20/30] mfd: cros_ec: Add API for keyboard testing
Date:   Thu,  9 May 2019 14:13:43 -0700
Message-Id: <20190509211353.213194-21-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command to allow keyboard testing in factory.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index e05cdcb12481..cc054a0a4c4c 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3142,6 +3142,17 @@ struct ec_params_mkbp_simulate_key {
 	uint8_t pressed;
 } __ec_align1;
 
+#define EC_CMD_GET_KEYBOARD_ID 0x0063
+
+struct ec_response_keyboard_id {
+	uint32_t keyboard_id;
+} __ec_align4;
+
+enum keyboard_id {
+	KEYBOARD_ID_UNSUPPORTED = 0,
+	KEYBOARD_ID_UNREADABLE = 0xffffffff,
+};
+
 /* Configure keyboard scanning */
 #define EC_CMD_MKBP_SET_CONFIG 0x0064
 #define EC_CMD_MKBP_GET_CONFIG 0x0065
@@ -3390,6 +3401,13 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_TABLET_MODE	1
 #define EC_MKBP_BASE_ATTACHED	2
 
+/* Run keyboard factory test scanning */
+#define EC_CMD_KEYBOARD_FACTORY_TEST 0x0068
+
+struct ec_response_keyboard_factory_test {
+	uint16_t shorted;	/* Keyboard pins are shorted */
+} __ec_align2;
+
 /* Fingerprint events in 'fp_events' for EC_MKBP_EVENT_FINGERPRINT */
 #define EC_MKBP_FP_RAW_EVENT(fp_events) ((fp_events) & 0x00FFFFFF)
 #define EC_MKBP_FP_ERRCODE(fp_events)   ((fp_events) & 0x0000000F)
-- 
2.21.0.1020.gf2820cf01a-goog

