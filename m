Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A552175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MKieckhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbfDXXao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:30:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42811 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfDXX37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so10115715pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oy92067dWbj9N3+hyp2kskEPtGB0dQ/VazI9fk83WQs=;
        b=MKieckhJ/RI/qV3pFg//wy44XXfR2Dao5hJ31IuCYeOWraud8YSR6MUSaa13ZpCk3b
         d4A6DMkiwaZqUm1xekZMIfkmlKGicjLYUtvTBCmu4FqPdBq/DjHp53N+ALZfkxQPCH3m
         nZG0xLf4rPKDVJha+vXjKvMMO6uWC1UZSKQZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oy92067dWbj9N3+hyp2kskEPtGB0dQ/VazI9fk83WQs=;
        b=pX8ssRdd6btmDf8NOzSO96m/96H3TmtCRVpv+vPQkRPFc6Pma0v/qAdHXr0iZ0xuDg
         txnWB5PuDgDZsonwwpQje+PpxEUZ58fgr6IKIC09GClpQMwMY7J83RFQVx440i5HS58o
         pJElO4Da9l3/j9p3Rdt9nzuCT2pFPmZ4WetFmjWL86whhjwesui54Uptmpy+L05Q4LHI
         k4xhGwZVWEFN3MimRXT5uGQRgw8cHec2bV32Cu7+6DqoUAtoNrX574uyEt+OmtcrE76Q
         3c8L0ul+QHg/fLDzfJWkZTKw7eu0jbxQ9r5FfZ79QvReQ0zKgurPIkwLhqTiGs8UIwkp
         5K1w==
X-Gm-Message-State: APjAAAWaoSRlZiDGFCoeRrbe6aJfVM0IHqO2fHJQTVR6SdaWsdM5GeQp
        pb6OMoiR7eELI1Cc/dgTC0pDBw==
X-Google-Smtp-Source: APXvYqzi44BIrJJviC8aENR5DpJw2b+xw3B+jhWLkM2Q99jBZAxx5xNh2RwKqcX0ofWJRaLk0TKZVg==
X-Received: by 2002:a63:6a42:: with SMTP id f63mr33448435pgc.207.1556148598656;
        Wed, 24 Apr 2019 16:29:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id k9sm25023802pga.22.2019.04.24.16.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:58 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 23/30] mfd: cros_ec: Add I2C passthru protection API
Date:   Wed, 24 Apr 2019 16:29:11 -0700
Message-Id: <20190424232918.243308-24-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent direct i2c access to device behind EC when not in development mode.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 49ea905cfd18..59ad6bae3f9b 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4316,6 +4316,28 @@ struct ec_params_entering_mode {
 #define VBOOT_MODE_DEVELOPER 1
 #define VBOOT_MODE_RECOVERY  2
 
+/*****************************************************************************/
+/*
+ * I2C passthru protection command: Protects I2C tunnels against access on
+ * certain addresses (board-specific).
+ */
+#define EC_CMD_I2C_PASSTHRU_PROTECT 0x00B7
+
+enum ec_i2c_passthru_protect_subcmd {
+	EC_CMD_I2C_PASSTHRU_PROTECT_STATUS = 0x0,
+	EC_CMD_I2C_PASSTHRU_PROTECT_ENABLE = 0x1,
+};
+
+struct ec_params_i2c_passthru_protect {
+	uint8_t subcmd;
+	uint8_t port;		/* I2C port number */
+} __ec_align1;
+
+struct ec_response_i2c_passthru_protect {
+	uint8_t status;		/* Status flags (0: unlocked, 1: locked) */
+} __ec_align1;
+
+
 /*****************************************************************************/
 /*
  * HDMI CEC commands
-- 
2.21.0.593.g511ec345e18-goog

