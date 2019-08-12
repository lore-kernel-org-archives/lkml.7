Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DBAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3A3208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4SZO6J5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfHLPFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:05:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45991 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfHLPFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:05:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so14598816wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mw/C8Rv74Rs9Z8D8xgtIZbTZrAIiewQWsEQksFJ9Oxc=;
        b=Z4SZO6J55tcT2ZmWIyBqrjMv1mONKctnnAE4ILQAcZxQstHa+Wk1cbagSXu57FQMp9
         IoiJ6xGMm9IJGbEnxKoifCnuYujHbu8dISq6zezzED7b8AIzh4iM4yKjjkq9M9l2eFds
         CQLuReoG9vZjODg5wisvrJw/73CzG39vOjJbGefADv9LgbcoDxCMb1WyvjyfhgPMx3V4
         vr/8hlAnkiGr8pPXtYya7gEkbvjSmsGwuiUx6cwPvYICESeyumQ0GXc/Ikp5wQhGAEAV
         A1EJOE4XN9JYCMTNrWxFXViwLhOpR8oHKdZ49bMoOUq+/TsV8RCF7JWOxZc01DHs5IUX
         gA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mw/C8Rv74Rs9Z8D8xgtIZbTZrAIiewQWsEQksFJ9Oxc=;
        b=QevUW69WDf6X7lQGErbpz5sVkOpgDD4cxs000dtY/iCaBLwUrA0moQfOdqNRqpcGja
         y3+gRfHb21eFWkBxTPDRWRpGBeuDcP80g9nujXf/b6YDk0rX9UyTrLZ081kRZQy5dX/w
         Q3XpccHrOSq2RUPmZYUnlTPdQWjKBD6YYjMTtASJCLPO88gFg+9nU+lCcLT+oa/vFmuU
         hG3uHC6lupZwzSioRKgEqp1QLSeG7k+mdBh7JdDfiXt5QXtiTytP8Ff+pwyf3JiPCzkc
         cqvvii07aZLmZLlZ4bgOHvULNoab3BiqJVRGjWnZc4by/GQav1w8RFtkLUVdrBbFdcfv
         hgkw==
X-Gm-Message-State: APjAAAWxQfb2lX45fh3Q8TSLonGfZlIq9zWx220c0IJvMhCZP/Bi4tK3
        8jRgD9FjhyU/B6MujlVPNPW+vQ==
X-Google-Smtp-Source: APXvYqwWjxHx1e1BUKi8g6P9FEgS14HF2nq8EYmv7BaX864AqM/QgUxDzXI2ZtXnHL9JtFwyud2gqQ==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr8401919wrx.328.1565622319728;
        Mon, 12 Aug 2019 08:05:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:1c0e:f938:89a1:8e17])
        by smtp.gmail.com with ESMTPSA id h97sm31027269wrh.74.2019.08.12.08.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 08:05:19 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Narendra K <Narendra.K@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 5/5] efi: cper: print AER info of PCIe fatal error
Date:   Mon, 12 Aug 2019 18:04:52 +0300
Message-Id: <20190812150452.27983-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

AER info of PCIe fatal error is not printed in the current driver.
Because APEI driver will panic directly for fatal error, and can't
run to the place of printing AER info.

An example log is as following:
{763}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 11
{763}[Hardware Error]: event severity: fatal
{763}[Hardware Error]:  Error 0, type: fatal
{763}[Hardware Error]:   section_type: PCIe error
{763}[Hardware Error]:   port_type: 0, PCIe end point
{763}[Hardware Error]:   version: 4.0
{763}[Hardware Error]:   command: 0x0000, status: 0x0010
{763}[Hardware Error]:   device_id: 0000:82:00.0
{763}[Hardware Error]:   slot: 0
{763}[Hardware Error]:   secondary_bus: 0x00
{763}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10fb
{763}[Hardware Error]:   class_code: 000002
Kernel panic - not syncing: Fatal hardware error!

This issue was imported by the patch, '37448adfc7ce ("aerdrv: Move
cper_print_aer() call out of interrupt context")'. To fix this issue,
this patch adds print of AER info in cper_print_pcie() for fatal error.

Here is the example log after this patch applied:
{24}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 10
{24}[Hardware Error]: event severity: fatal
{24}[Hardware Error]:  Error 0, type: fatal
{24}[Hardware Error]:   section_type: PCIe error
{24}[Hardware Error]:   port_type: 0, PCIe end point
{24}[Hardware Error]:   version: 4.0
{24}[Hardware Error]:   command: 0x0546, status: 0x4010
{24}[Hardware Error]:   device_id: 0000:01:00.0
{24}[Hardware Error]:   slot: 0
{24}[Hardware Error]:   secondary_bus: 0x00
{24}[Hardware Error]:   vendor_id: 0x15b3, device_id: 0x1019
{24}[Hardware Error]:   class_code: 000002
{24}[Hardware Error]:   aer_uncor_status: 0x00040000, aer_uncor_mask: 0x00000000
{24}[Hardware Error]:   aer_uncor_severity: 0x00062010
{24}[Hardware Error]:   TLP Header: 000000c0 01010000 00000001 00000000
Kernel panic - not syncing: Fatal hardware error!

Fixes: 37448adfc7ce ("aerdrv: Move cper_print_aer() call out of interrupt context")
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
[ardb: put parens around terms of && operator]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/cper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 8fa977c7861f..addf0749dd8b 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -390,6 +390,21 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk(
 	"%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
 	pfx, pcie->bridge.secondary_status, pcie->bridge.control);
+
+	/* Fatal errors call __ghes_panic() before AER handler prints this */
+	if ((pcie->validation_bits & CPER_PCIE_VALID_AER_INFO) &&
+	    (gdata->error_severity & CPER_SEV_FATAL)) {
+		struct aer_capability_regs *aer;
+
+		aer = (struct aer_capability_regs *)pcie->aer_info;
+		printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",
+		       pfx, aer->uncor_status, aer->uncor_mask);
+		printk("%saer_uncor_severity: 0x%08x\n",
+		       pfx, aer->uncor_severity);
+		printk("%sTLP Header: %08x %08x %08x %08x\n", pfx,
+		       aer->header_log.dw0, aer->header_log.dw1,
+		       aer->header_log.dw2, aer->header_log.dw3);
+	}
 }
 
 static void cper_print_tstamp(const char *pfx,
-- 
2.17.1

