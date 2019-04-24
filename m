Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A96C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075E8214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZhPIGypC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfDXX3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:29:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46436 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbfDXX3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so10103858pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JI+Nu+xcqpFC0nohZ7Z3MWaaNBldWuyXtLqXzlnNSao=;
        b=ZhPIGypC3gQGyO8UujFuZPkYTPnpl3lcbh0ZDvLyxuDOoL5YEq2oYV4FmrddnqJdtm
         zMgGjd1mNj5EbMIsa4czfuKfaKYVyfHB9p2uvx38rHmrEcfgCQfq1w2pUDZMFiCHiAef
         e7tzWg4o07Gd1gsybmxgiLHTB3yVbn0nrRlWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JI+Nu+xcqpFC0nohZ7Z3MWaaNBldWuyXtLqXzlnNSao=;
        b=nlrLXmjCI8liIzRFRM4by0Oi8oEpRDlMmsp/zQLL/Gg+W/kS8UC8GoVSP4WSDm0nVN
         ymJ1BnfouiOpHoljqiMNUZ9lh2TrUT9JECdim7FvfPwndw4MreZU1HBs82UYcQMlABd/
         i6q6KFa6ypdtmA0B0ZMEi+QwPlXO2mdsLV+2p/OphBHgtDtb2dKZ3XmOqMzXV+m5d5yI
         ajnkDytMrB/ps3tSDmNPFVrgbEJNJ/lFsNivZUTIob+kiUt36n761+gItC+8Q25JzJU+
         ATWDdp5mjAJ8GBvaslUssITcfxSIXqencAl18PIV+HwaX/652Qyoen6h0JMWsIxQzSI7
         2O7A==
X-Gm-Message-State: APjAAAUDoI7mKDHeOaKIOKqx/hotyZ8hAA0q2yKc1CR75zKOjB+7Xg6L
        RswaY/O6B1yhQN4Ck56bH3b7Zw==
X-Google-Smtp-Source: APXvYqyh9u/ZlixerV0Srn1bkVEPPvl3avP+A4jHQSMIC/hJvxHqKWFIBeAGQR01W2KIVnWOCrjL1Q==
X-Received: by 2002:a63:6983:: with SMTP id e125mr31288537pgc.370.1556148579959;
        Wed, 24 Apr 2019 16:29:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id c127sm13207068pfc.132.2019.04.24.16.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:39 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 09/30] mfd: cros_ec: Remove zero-size structs
Date:   Wed, 24 Apr 2019 16:28:57 -0700
Message-Id: <20190424232918.243308-10-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Empty structure size is different between C and C++.
To prevent clang warning when compiling this include file in C++
programs, remove empty structures.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 33 +++++++++++++++-------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 67e15c29e083..2e5c93d858d8 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1510,10 +1510,14 @@ struct lightbar_program {
 struct ec_params_lightbar {
 	uint8_t cmd;		      /* Command (see enum lightbar_command) */
 	union {
-		struct {
-			/* no args */
-		} dump, off, on, init, get_seq, get_params_v0, get_params_v1,
-			version, get_brightness, get_demo, suspend, resume;
+		/*
+		 * The following commands have no args:
+		 *
+		 * dump, off, on, init, get_seq, get_params_v0, get_params_v1,
+		 * version, get_brightness, get_demo, suspend, resume
+		 *
+		 * Don't use an empty struct, because C++ hates that.
+		 */
 
 		struct __ec_todo_unpacked {
 			uint8_t num;
@@ -1567,11 +1571,13 @@ struct ec_response_lightbar {
 			uint8_t red, green, blue;
 		} get_rgb;
 
-		struct {
-			/* no return params */
-		} off, on, init, set_brightness, seq, reg, set_rgb,
-			demo, set_params_v0, set_params_v1,
-			set_program, manual_suspend_ctrl, suspend, resume;
+		/*
+		 * The following commands have no response:
+		 *
+		 * off, on, init, set_brightness, seq, reg, set_rgb,
+		 * set_params_v0, set_params_v1, set_program,
+		 * manual_suspend_ctrl, suspend, resume
+		 */
 	};
 } __ec_todo_packed;
 
@@ -2991,9 +2997,7 @@ enum charge_state_params {
 struct ec_params_charge_state {
 	uint8_t cmd;				/* enum charge_state_command */
 	union {
-		struct {
-			/* no args */
-		} get_state;
+		/* get_state has no args */
 
 		struct __ec_todo_unpacked {
 			uint32_t param;		/* enum charge_state_param */
@@ -3019,9 +3023,8 @@ struct ec_response_charge_state {
 		struct __ec_align4 {
 			uint32_t value;
 		} get_param;
-		struct {
-			/* no return values */
-		} set_param;
+
+		/* set_param returns no args */
 	};
 } __ec_align4;
 
-- 
2.21.0.593.g511ec345e18-goog

