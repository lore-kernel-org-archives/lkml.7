Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C928CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EA0214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DfCorwbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfDXXaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:30:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38007 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbfDXXaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:30:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so10120678pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mvbtagq0D/tLJgcfMjtUKJRrie6dzLoudWBgQDdY8Vw=;
        b=DfCorwbTINoifv2OOkCrFCFdxDaSse4Kqcej5IAYDR8x290hMmAPMT4XeBJrkFahs5
         5cyTktDHxLKa/IlqHXYGjU2zQa2xDGZDqp5nqpHZG99SrWP5OVXbbNCOeI9PZXiF5Tnq
         0zWhr7q8vPjUdonX1C9iPypvd9MxVctysOy1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mvbtagq0D/tLJgcfMjtUKJRrie6dzLoudWBgQDdY8Vw=;
        b=EX228SJLRc0zgPOAoo4haUJB53zILLsnN2iiXrTsY6nTeKmNGq8Ui6/RzfCYBh2Qjv
         g10MqfdEQjDgqUGmr5hOj9RyFjFY9zrPznqn8XvbVLl5OqsiX310nku1J4AJbWsHtL5V
         ZtASLq1MZnqkQt02jGHCZQuz8i9DfclVF50zsZ44JL6ilE3wG43vr2InNvzE2ObwAkv7
         PiVM/D1CJTfgdyNDH5Ziu4CVmTChtuU+mXk2zod1RnDWA+TzK6RubXOolQak3/Sw2xGa
         Js/hIT6x7V4HKKd2fwCgfMDaSOt+JjoSQIquo7rYe3TV1FaI7LCX+2RS6kAFGTtAAsG0
         oN6w==
X-Gm-Message-State: APjAAAVhTu/VaC7F6sgyQDvh1QN8GCdl5pnBG14XxkiKUBcAbGcGT+fU
        1sIplT3P4EVKMf654rIumeLv5w==
X-Google-Smtp-Source: APXvYqyDcxsK67MxCQBgA8MVC8bdlEgwtw6FPmiTCEI1LwBUBoqtHdHWil93nk0D5YSWPoQUoa7SwQ==
X-Received: by 2002:a63:f809:: with SMTP id n9mr32738765pgh.201.1556148602689;
        Wed, 24 Apr 2019 16:30:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h187sm35294962pfc.52.2019.04.24.16.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:30:02 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 26/30] mfd: cros_ec: Add API for Touchpad support
Date:   Wed, 24 Apr 2019 16:29:14 -0700
Message-Id: <20190424232918.243308-27-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API to control touchpad presented by Embedded Controller.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 32d3a4e07ea8..32599f28c936 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5039,6 +5039,32 @@ struct ec_response_pd_chip_info_v1 {
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
2.21.0.593.g511ec345e18-goog

