Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB7C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6C121744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oq5Zt5pX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfEIVOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:14:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36686 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfEIVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so1963768pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BA6nxer66GBmENOs0aI/8rHE+lNpwyhVsQAtDrFHwnE=;
        b=Oq5Zt5pXXBhBa5qfIIuRxBfr9w0fqGToXsZdvP9UGx8Qw53++zEtPTjuGRO4NY6L5Y
         UfQI9mCyOhL1U1IdVWgDksFl7c8EIvXA0JN3qbpXdz4zy+JndfokR2RiSDrbMmGwgPmF
         UN4y3t4Hj084/MJx0DvjNmpHz0zxiA3oAqfN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BA6nxer66GBmENOs0aI/8rHE+lNpwyhVsQAtDrFHwnE=;
        b=muojVumSqOY8iqRP5yXaUx5PSkBs3hUEX/qKF+1nqftPl8dvQh0dXNvQRdB4doU7Cm
         xJLt9jjZZ7juZPvPjC642AiEVcntj+P7f6jNJ+uL7Fo8qStn7JORTRkt5vN8Hzvmau7d
         PBQ5w7Q0DwRCR/qoIWi6z+Tu6codiQIgwe822vnJrzYWtsrfNJZqvl24v2RXnEpzWYw4
         ceV8mDVP8uJaSUZQn3nQ/j3/2vgde2bcmoSjioX57YmGuUs6pwaKaYDU1l5oBOxyF1gc
         iiWYmJ9UORmCfbgb8UvXX3H0S/8iBP7JmPi6RW7ANeyzd6wRzLrGfQN+OOltJrXQzSD0
         PUVQ==
X-Gm-Message-State: APjAAAUuna0yr6wEbkmYR130WDkifsH3SlQGKlgJurNBc3v5FL1VYtuc
        oSwFbrG3fBN6nTXRqXE8dX63QQ==
X-Google-Smtp-Source: APXvYqwcQs+/urXHKHgb1CDEjmYyDjXoe7r92gFjo7lVXhhKeh1fbrPg27K7X+1AhPRVEleKUhO5ow==
X-Received: by 2002:a63:9dc8:: with SMTP id i191mr8490866pgd.91.1557436468948;
        Thu, 09 May 2019 14:14:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y17sm4703860pfb.161.2019.05.09.14.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:28 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 17/30] mfd: cros_ec: Add fingerprint API
Date:   Thu,  9 May 2019 14:13:40 -0700
Message-Id: <20190509211353.213194-18-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for fingerprint sensors managed by embedded controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 51fe65170ce6..d5d07a9957ec 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3339,6 +3339,40 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_TABLET_MODE	1
 #define EC_MKBP_BASE_ATTACHED	2
 
+/* Fingerprint events in 'fp_events' for EC_MKBP_EVENT_FINGERPRINT */
+#define EC_MKBP_FP_RAW_EVENT(fp_events) ((fp_events) & 0x00FFFFFF)
+#define EC_MKBP_FP_ERRCODE(fp_events)   ((fp_events) & 0x0000000F)
+#define EC_MKBP_FP_ENROLL_PROGRESS_OFFSET 4
+#define EC_MKBP_FP_ENROLL_PROGRESS(fpe) (((fpe) & 0x00000FF0) \
+					 >> EC_MKBP_FP_ENROLL_PROGRESS_OFFSET)
+#define EC_MKBP_FP_MATCH_IDX_OFFSET 12
+#define EC_MKBP_FP_MATCH_IDX_MASK 0x0000F000
+#define EC_MKBP_FP_MATCH_IDX(fpe) (((fpe) & EC_MKBP_FP_MATCH_IDX_MASK) \
+					 >> EC_MKBP_FP_MATCH_IDX_OFFSET)
+#define EC_MKBP_FP_ENROLL               BIT(27)
+#define EC_MKBP_FP_MATCH                BIT(28)
+#define EC_MKBP_FP_FINGER_DOWN          BIT(29)
+#define EC_MKBP_FP_FINGER_UP            BIT(30)
+#define EC_MKBP_FP_IMAGE_READY          BIT(31)
+/* code given by EC_MKBP_FP_ERRCODE() when EC_MKBP_FP_ENROLL is set */
+#define EC_MKBP_FP_ERR_ENROLL_OK               0
+#define EC_MKBP_FP_ERR_ENROLL_LOW_QUALITY      1
+#define EC_MKBP_FP_ERR_ENROLL_IMMOBILE         2
+#define EC_MKBP_FP_ERR_ENROLL_LOW_COVERAGE     3
+#define EC_MKBP_FP_ERR_ENROLL_INTERNAL         5
+/* Can be used to detect if image was usable for enrollment or not. */
+#define EC_MKBP_FP_ERR_ENROLL_PROBLEM_MASK     1
+/* code given by EC_MKBP_FP_ERRCODE() when EC_MKBP_FP_MATCH is set */
+#define EC_MKBP_FP_ERR_MATCH_NO                0
+#define EC_MKBP_FP_ERR_MATCH_NO_INTERNAL       6
+#define EC_MKBP_FP_ERR_MATCH_NO_TEMPLATES      7
+#define EC_MKBP_FP_ERR_MATCH_NO_LOW_QUALITY    2
+#define EC_MKBP_FP_ERR_MATCH_NO_LOW_COVERAGE   4
+#define EC_MKBP_FP_ERR_MATCH_YES               1
+#define EC_MKBP_FP_ERR_MATCH_YES_UPDATED       3
+#define EC_MKBP_FP_ERR_MATCH_YES_UPDATE_FAILED 5
+
+
 /*****************************************************************************/
 /* Temperature sensor commands */
 
-- 
2.21.0.1020.gf2820cf01a-goog

