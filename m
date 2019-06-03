Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F25C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB7126E66
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PxfEqanv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfFCSfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:35:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45541 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfFCSer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:34:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so11084329pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11H9eJ6PsDChSyARkFGWtgFkqyq4bAPSq9amltsDDFQ=;
        b=PxfEqanv/PRY0M/VY4e1O9gn4s07yciX2RzwRkNeh2FKLAo974fldUJFmzbdHU2msY
         K3lfwXtSqyTQ4zAiun8HPxjjxJrltz8yAHX07HNCkwUY0jfcMtNFSEFkGliOFj5oLdeF
         P9dZuni3OAWZrcPdCd1G1IhAEd9Zk+/7Sbpw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11H9eJ6PsDChSyARkFGWtgFkqyq4bAPSq9amltsDDFQ=;
        b=O18QqfaF4dUPzPS5/RbClI1nVYNN2KTzjJY8iQyOX7siRIlkT8evKPMDkl9TqIRWQw
         ksIn3w60hNz1occe69Ev0uuNtDR7o8pda0wxUEdqou7nvYcgn1+VZI0BeXBJbzx13PVv
         AIrh/C/KQGnp1eLfX7b33aIxz3ZNlMjUi/QGDTVMC8r0jHdB+X/EmP+HIZtI5j6ghrBn
         DVDVcMJnoizfAxx9VsNGuQHpntE1jRFR14zsJed7zUm4QESeoV04qE1Af9Tlp0HuMyPi
         geFWaRUuje0PjwL8PPCmS3o0DBA/qcsQD7H/iQ4d7nOOYlvbOBEOJVbTdPow7RqDSeqV
         ptlQ==
X-Gm-Message-State: APjAAAXUR7y+RXzvfJuFLyB0tMhQEnf+QieZDpkR28pOtYUsWfqBSsbn
        GyYV4B9otYkmn5Baga+oP1vDlw==
X-Google-Smtp-Source: APXvYqwuAAvudQpkCNvX1FttFw+zwQdqr4m3Inozl8aJNBtybkzM7fS5SzEiIecujKL7X9T3XIFYuQ==
X-Received: by 2002:a62:a508:: with SMTP id v8mr32386909pfm.87.1559586886463;
        Mon, 03 Jun 2019 11:34:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 12sm5195115pfi.60.2019.06.03.11.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:45 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 25/30] mfd: cros_ec: Add API for Touchpad support
Date:   Mon,  3 Jun 2019 11:33:56 -0700
Message-Id: <20190603183401.151408-26-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API to control touchpad presented by Embedded Controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
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

