Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D0BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D54B214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XWHOJvgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbfDXXaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:30:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34008 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDXXaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:30:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so10185277pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMiOYTkO22Q32aX+6oWp/pTsdu+gQfC+LZ5wgVYEafk=;
        b=XWHOJvgVzwJdgchx5g5UDIsfRMphvkEQn0OFfjK1N46jcYs0Ylnwj+fflNrCeK2t6C
         PZcjYbwXn3l/FmNI7fmB2Wp9eavAqHLSOl8uGSx/U+SUYLRedDlOCp4ob9tGtzRnJQ8H
         QNrLH66HmK5ljHkYS7q2MXCuBZI2zlaez1d00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMiOYTkO22Q32aX+6oWp/pTsdu+gQfC+LZ5wgVYEafk=;
        b=AfzUAokAt+STgX9zdasIAMQ/q/BpJKkOeqrg+X6c/Qat9EBTtAsZEq1JPz89/Vlpur
         q7fmDwTSYjroLm27nlrLNgcb93biqfAykUirsJz4oRwk6cKOKsxDvG9rgJGQj1Em3O6N
         bhL9GOVna4lBMk5YJ6ApZtR1umVSJe/KKTGeqAQO9KoZec1LrSvuofmSc6uQU/0Lzi3Z
         I/LoGX1G11vpxedqjXqUEZS8vjwAiQ6HaXeS/oYdbc5b+SNWCg+HF+W2k4wxYL5EyL61
         zGLoqpslMTDLOHfQSz3IBsqDISMwDMhlgfHhbO8kOvyu1mxIT8KzABVtByNEKH057Up5
         CVkw==
X-Gm-Message-State: APjAAAW/FacTYAv7EuXiHTyEgU3/vlS/hLPx4KIQ8kkJ0fnJMyPD0cyL
        c0u6Cr2HUaiJigZuQcZppnhmrw==
X-Google-Smtp-Source: APXvYqz4I/CiRP7ZG3hvpUyd+7tDrohst+wcMCNBpNlpNQWl2pFELtvQZbDr2KsqtoO9G17GOg8U9Q==
X-Received: by 2002:a62:69c2:: with SMTP id e185mr36215145pfc.119.1556148605304;
        Wed, 24 Apr 2019 16:30:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 10sm57265397pft.100.2019.04.24.16.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:30:04 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 28/30] mfd: cros_ec: Add API for rwsig
Date:   Wed, 24 Apr 2019 16:29:16 -0700
Message-Id: <20190424232918.243308-29-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command to retrieve signature of image stored in the RW memory
slot(s).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 1b60e009d1d7..51f75cab0608 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5039,6 +5039,32 @@ struct ec_response_pd_chip_info_v1 {
 	};
 } __ec_align2;
 
+/* Run RW signature verification and get status */
+#define EC_CMD_RWSIG_CHECK_STATUS	0x011C
+
+struct ec_response_rwsig_check_status {
+	uint32_t status;
+} __ec_align4;
+
+/* For controlling RWSIG task */
+#define EC_CMD_RWSIG_ACTION	0x011D
+
+enum rwsig_action {
+	RWSIG_ACTION_ABORT = 0,		/* Abort RWSIG and prevent jumping */
+	RWSIG_ACTION_CONTINUE = 1,	/* Jump to RW immediately */
+};
+
+struct ec_params_rwsig_action {
+	uint32_t action;
+} __ec_align4;
+
+/* Run verification on a slot */
+#define EC_CMD_EFS_VERIFY	0x011E
+
+struct ec_params_efs_verify {
+	uint8_t region;		/* enum ec_flash_region */
+} __ec_align1;
+
 /*****************************************************************************/
 /* Fingerprint MCU commands: range 0x0400-0x040x */
 
-- 
2.21.0.593.g511ec345e18-goog

