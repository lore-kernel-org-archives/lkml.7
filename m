Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50995C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226E8214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLcsG0Ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfDXX35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:29:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44147 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDXX3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id y12so7500407plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WlfCbbT7OTA5XgmosXtgfyWERHQq84J83MXacm4JxJM=;
        b=GLcsG0OvxWec4ZrR2LTxwMO93rOGm6pfhyvq8Minjh95zg7EkhDyN7X7wbpAlej0v5
         Bgxg9JZOGqzvUfTx8mzGFWBU3Hvj0Ke6AIU4CJ8SOr+/lJMi6SBeAr1Ckz2gXvl+VAEw
         YFyQLpZ7dO/E7YcCFLMhOY0icnpRl/7erAFQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WlfCbbT7OTA5XgmosXtgfyWERHQq84J83MXacm4JxJM=;
        b=fUvbXXsS1tHjPVNfcr6hijrMR6CLW4uyyG4Hrb1DzROCvd1EIIQkXo1C/4MTJG/bH6
         6rjx4iMq0PdRgIXODBW1qbwKtgMU5tfuaWpgCtAwVf/mSr21icET9mw75xNAvcbWD3U/
         1ohpjJfm4brl7qurquXdumWeucvFNN6+wZP4Xb3r84tIgNcnOtm1SsUkXpWb6zigih4x
         8qQxyId/GJK6ez2KEG9Ii3FYfUmotHwkLiuLj3wwGxF29qqieeNVdiiyc4GePKmPXgy2
         CAAQgv+nxZOEG4GS6cyPMrSqRKQ4ISe37jgfGcTcE+CifeQwy6QrOuaZ7+YVo9/4zcuF
         iV1Q==
X-Gm-Message-State: APjAAAUBEH/5NFfpjFli6IMe44ym5YMn225TOU0Cqv6v+zPVA9kz7DHX
        dAWt1boLcGXAzhdJI9FvqRaj7g==
X-Google-Smtp-Source: APXvYqzreulSL3h2Jl7kNM03ljobvMIECiOnXet6Cn71t8Oq33TXxOBaZFit1v7y76vDKxNNle+eQw==
X-Received: by 2002:a17:902:2a2b:: with SMTP id i40mr4284537plb.80.1556148594917;
        Wed, 24 Apr 2019 16:29:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id p66sm45139032pfb.4.2019.04.24.16.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:54 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 20/30] mfd: cros_ec: Add API for keyboard testing
Date:   Wed, 24 Apr 2019 16:29:08 -0700
Message-Id: <20190424232918.243308-21-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command to allow keyboard testing in factory.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 4784f3634793..88d08aa85738 100644
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
2.21.0.593.g511ec345e18-goog

