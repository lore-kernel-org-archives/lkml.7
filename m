Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414D3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0902920449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PU7Tpr+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfDPSdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:33:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34344 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbfDPSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:33:16 -0400
Received: by mail-io1-f68.google.com with SMTP id n11so18481835ioh.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCg1+4C/3BXdYjyRhbyWaAnGRGTGFQ1Fry4WA2G26j8=;
        b=PU7Tpr+zhZjEs++hYXr1ScD7vT5qTwF4iKMM54vbh1iAZj7lEoQcejtgtaQhzuS/m4
         7ph6PU9mzpswJ/0piM1OfkTxjZEVdYXDUIgk6FJAXXqyk2er7UyajgIrCgY5CTodvohj
         Vs2f+81sG2Dt4EU5tnveamavMeTdrPSwmOM4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCg1+4C/3BXdYjyRhbyWaAnGRGTGFQ1Fry4WA2G26j8=;
        b=t/DV1eCHIZdNm/fy1T5mZPJH/TMi4xReHxlehlvs7v1saPkv5byzYdfYBx/fQW+qWX
         vRjRdP/eqYEcB99/gofVl1voYL82iaQJjA7zlYdCNzWC7ooTjglE3v7E90JqiC1BAurO
         ypy5sQrSha4QOmWAPRuM45DDBgcFvQLI1MJFw2y4En8RTZzKgZ7IKRVXlhNKa+K1RW4k
         9ZAafk/PADgPnJlESCdi9IhRKqJHBO4Y/xCGl/Pr4KTVF72Rvo7+ONPA/lirOtjRhY8n
         nXq1ZEQt0/Nirp/zONiLCZBxneLhbjgFCKFIk8avLg1KKx25F+lNMED/cHZS4H1kmIJX
         npGA==
X-Gm-Message-State: APjAAAXGRdvhoZVmVT3YFP5/psIAUHppttq7VpG0frTFvAS8XLvv+Glq
        RDMy4CuqynQfSraGYzvHyQGsWw==
X-Google-Smtp-Source: APXvYqxe51A2j3HQNDba4Y1SRCrfzq3onNi4ynJVohVbf4X4syGAVuNhE3mopOvgQvF7pjvzYVE5iw==
X-Received: by 2002:a6b:4e10:: with SMTP id c16mr9806791iob.18.1555439595207;
        Tue, 16 Apr 2019 11:33:15 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id k18sm19887735iob.60.2019.04.16.11.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:33:14 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     djkurtz@chromium.org, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/4] mmc: core: Add trace event for SD OCR response
Date:   Tue, 16 Apr 2019 12:32:56 -0600
Message-Id: <20190416183257.247902-4-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190416183257.247902-1-rrangel@chromium.org>
References: <20190416183257.247902-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example:
sd_ocr_request: mmc0: 0x0 []
sd_ocr_request: mmc0: 0x51200000 [SDHC or SDXC Supported (HCS) | Maximum Performance (XPC) | Switch to 1.8V (S18R) | 3.3 ~ 3.4]
sd_ocr_response: mmc0: 0xff8000 [2.7 ~ 2.8 | 2.8 ~ 2.9 | 2.9 ~ 3.0 | 3.0 ~ 3.1 | 3.1 ~ 3.2 | 3.2 ~ 3.3 | 3.3 ~ 3.4 | 3.4 ~ 3.5 | 3.5 ~ 3.6]

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/core/sd_ops.c  |  6 +++
 include/trace/events/mmc.h | 92 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 0bb0b8419016..4cf0f040f896 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -19,6 +19,8 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 
+#include <trace/events/mmc.h>
+
 #include "core.h"
 #include "sd_ops.h"
 
@@ -130,11 +132,15 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 		cmd.arg = ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
+	trace_sd_ocr_request(host, ocr);
+
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_app_cmd(host, NULL, &cmd);
 		if (err)
 			break;
 
+		trace_sd_ocr_response(host, cmd.resp[0]);
+
 		/* if we're just probing, do a single pass */
 		if (ocr == 0)
 			break;
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
index 463cf318d762..8d97810221cd 100644
--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -10,6 +10,98 @@
 #include <linux/mmc/host.h>
 #include <linux/tracepoint.h>
 
+
+#define SD_OCR_REQUEST \
+	{SD_OCR_CCS, "SDHC or SDXC Supported (HCS)"}, \
+	{SD_OCR_XPC, "Maximum Performance (XPC)"}, \
+	{SD_ROCR_S18A, "Switch to 1.8V (S18R)"}, \
+	{MMC_VDD_165_195, "1.65 - 1.95"}, \
+	{MMC_VDD_20_21, "2.0 ~ 2.1"}, \
+	{MMC_VDD_21_22, "2.1 ~ 2.2"}, \
+	{MMC_VDD_22_23, "2.2 ~ 2.3"}, \
+	{MMC_VDD_23_24, "2.3 ~ 2.4"}, \
+	{MMC_VDD_24_25, "2.4 ~ 2.5"}, \
+	{MMC_VDD_25_26, "2.5 ~ 2.6"}, \
+	{MMC_VDD_26_27, "2.6 ~ 2.7"}, \
+	{MMC_VDD_27_28, "2.7 ~ 2.8"}, \
+	{MMC_VDD_28_29, "2.8 ~ 2.9"}, \
+	{MMC_VDD_29_30, "2.9 ~ 3.0"}, \
+	{MMC_VDD_30_31, "3.0 ~ 3.1"}, \
+	{MMC_VDD_31_32, "3.1 ~ 3.2"}, \
+	{MMC_VDD_32_33, "3.2 ~ 3.3"}, \
+	{MMC_VDD_33_34, "3.3 ~ 3.4"}, \
+	{MMC_VDD_34_35, "3.4 ~ 3.5"}, \
+	{MMC_VDD_35_36, "3.5 ~ 3.6"} \
+
+TRACE_EVENT(sd_ocr_request,
+
+	TP_PROTO(struct mmc_host *host, u32 ocr),
+
+	TP_ARGS(host, ocr),
+
+	TP_STRUCT__entry(
+		__field(u32,			ocr)
+		__string(name,			mmc_hostname(host))
+	),
+
+	TP_fast_assign(
+		__entry->ocr = ocr;
+		__assign_str(name, mmc_hostname(host));
+	),
+
+	TP_printk("%s: %#x [%s]",
+		  __get_str(name),
+		  __entry->ocr,
+		  __print_flags(__entry->ocr, " | ", SD_OCR_REQUEST)
+	)
+);
+
+#define SD_OCR_RESPONSE \
+	{MMC_CARD_BUSY, "Ready"}, \
+	{SD_OCR_CCS, "SDHC or SDXC (CCS)"}, \
+	{(1<<29), "UHS-II Card"}, \
+	{SD_ROCR_S18A, "1.8V Accepted (S18A)"}, \
+	{MMC_VDD_165_195, "1.65 - 1.95"}, \
+	{MMC_VDD_20_21, "2.0 ~ 2.1"}, \
+	{MMC_VDD_21_22, "2.1 ~ 2.2"}, \
+	{MMC_VDD_22_23, "2.2 ~ 2.3"}, \
+	{MMC_VDD_23_24, "2.3 ~ 2.4"}, \
+	{MMC_VDD_24_25, "2.4 ~ 2.5"}, \
+	{MMC_VDD_25_26, "2.5 ~ 2.6"}, \
+	{MMC_VDD_26_27, "2.6 ~ 2.7"}, \
+	{MMC_VDD_27_28, "2.7 ~ 2.8"}, \
+	{MMC_VDD_28_29, "2.8 ~ 2.9"}, \
+	{MMC_VDD_29_30, "2.9 ~ 3.0"}, \
+	{MMC_VDD_30_31, "3.0 ~ 3.1"}, \
+	{MMC_VDD_31_32, "3.1 ~ 3.2"}, \
+	{MMC_VDD_32_33, "3.2 ~ 3.3"}, \
+	{MMC_VDD_33_34, "3.3 ~ 3.4"}, \
+	{MMC_VDD_34_35, "3.4 ~ 3.5"}, \
+	{MMC_VDD_35_36, "3.5 ~ 3.6"}
+
+TRACE_EVENT(sd_ocr_response,
+
+	TP_PROTO(struct mmc_host *host, u32 ocr),
+
+	TP_ARGS(host, ocr),
+
+	TP_STRUCT__entry(
+		__field(u32,			ocr)
+		__string(name,			mmc_hostname(host))
+	),
+
+	TP_fast_assign(
+		__entry->ocr = ocr;
+		__assign_str(name, mmc_hostname(host));
+	),
+
+	TP_printk("%s: %#x [%s]",
+		  __get_str(name),
+		  __entry->ocr,
+		  __print_flags(__entry->ocr, " | ", SD_OCR_RESPONSE)
+	)
+);
+
 #define SD_SCR_WIDTH_FLAGS		\
 	{SD_SCR_BUS_WIDTH_1, "1-BIT"},	\
 	{SD_SCR_BUS_WIDTH_4, "4-BIT"}
-- 
2.21.0.392.gf8f6787159e-goog

