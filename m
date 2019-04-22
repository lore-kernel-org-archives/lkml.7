Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19437C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77D120685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEiytSOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfDVJZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:25:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37398 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDVJZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:25:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so3419750wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rREyvM1/n8Iob2B7zEd2UE96TXTnGsx6oeQXzgvH96s=;
        b=mEiytSOkWiKdAg3iHz/4L92AbLA4tL4sIMeXnwettyBLe7tZxtwi+0PDw75xMJU98O
         aI/Q3tj1TYzW1U2jW28m70ne/f8FcgBQpoi7bt+yoE6gBBaVrUHCvtboaFBQ/jb/QroT
         lPamWdU0lRGnREeTlSQ/3Kzhp1gW+H0ZHS0oG3qVOUKVfHwuRuUARI/5IeTZgc58aj39
         egwx7N2yDLPDYwElVxr+QiiGH8ULFtsZNzO8Pluif6GB8/6kyyab8f2N5Qj2FvJdzA2r
         x9M9LMDovk77BiPYFpk6ls7eYD4ZpjWNWqECJeHXhDIb6A6DPrISltsLhLMzlma+eRiw
         Z8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rREyvM1/n8Iob2B7zEd2UE96TXTnGsx6oeQXzgvH96s=;
        b=d+kPAEPM+Juw6WdEvqlTRbWtAyAAgKj03Ka3SyTHCpLwKufLnDtSn1KazJQStmKcUE
         sM8WwgMfS+fL4P/VBBNpeF0OyJh+sTlGbhJtgYP73kcRzUQ2kA7E7At9XXR0rpmzkl5d
         QhDgnvOaAFSPEnlcJC0dMRXR5NlIiRM0xp0EuUjXlC2H0T/F6qUypO4foQ3a+4QmmcX6
         p1djzTW2DRzystw1wk5aDqmfdew87tvFakZ5G/FuWxn39EKEjo6sVM6dCtHNVdaVzqX0
         hc1bpf1g/+DGTe4vLHzbNwgmsIKdyD3TzZ4He2REaUhnoAwpLGnaUI11CTDNSBody6eE
         NFsw==
X-Gm-Message-State: APjAAAWzPGQEVm15Ct/yIoTbl84vICQeroRsHKE87ZbR5nlLgc7Zgitr
        iw8nETD+c7vRXhYxxeut6xeAtg/R
X-Google-Smtp-Source: APXvYqw87n4f1F5qSklK6OfbLp6zCtFrYVs5t6BSiEi0LBz/z8w5Uh7XP5D2FvRAkXK82IG0tfOVag==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr12489703wrw.62.1555925134977;
        Mon, 22 Apr 2019 02:25:34 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h9sm9595984wmb.5.2019.04.22.02.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 02:25:34 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: use ASIC functions interface for rreg/wreg
Date:   Mon, 22 Apr 2019 12:25:32 +0300
Message-Id: <20190422092532.17381-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch slightly changes the macros of RREG32 and WREG32, which are
used when reading or writing from registers.

Instead of directly calling a function in the common code from these
macros, the new code calls a function from the ASIC functions interface.

This change allows us to share much more code between real ASICs and
simulators, which in turn reduces the maintenance burden and
the chances for forgetting to port code between the ASIC files.

The patch also implements the hl_poll_timeout macro, instead of calling
the generic readl_poll_timeout macro. This is required to allow use of
this macro in the simulator files.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  |  4 +++-
 drivers/misc/habanalabs/habanalabs.h | 32 ++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3f707e8c408a..49c4f02aa4e3 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4829,7 +4829,9 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_hw_state = goya_get_hw_state,
 	.pci_bars_map = goya_pci_bars_map,
 	.set_dram_bar_base = goya_set_ddr_bar_base,
-	.init_iatu = goya_init_iatu
+	.init_iatu = goya_init_iatu,
+	.rreg = hl_rreg,
+	.wreg = hl_wreg
 };
 
 /*
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 86bd5298efd6..e8bbaf0f26c1 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -489,6 +489,8 @@ enum hl_pll_frequency {
  * @pci_bars_map: Map PCI BARs.
  * @set_dram_bar_base: Set DRAM BAR to map specific device address.
  * @init_iatu: Initialize the iATU unit inside the PCI controller.
+ * @rreg: Read a register. Needed for simulator support.
+ * @wreg: Write a register. Needed for simulator support.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -564,6 +566,8 @@ struct hl_asic_funcs {
 	int (*pci_bars_map)(struct hl_device *hdev);
 	int (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
 	int (*init_iatu)(struct hl_device *hdev);
+	u32 (*rreg)(struct hl_device *hdev, u32 reg);
+	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
 };
 
 
@@ -1007,13 +1011,10 @@ struct hl_dbg_device_entry {
 u32 hl_rreg(struct hl_device *hdev, u32 reg);
 void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 
-#define hl_poll_timeout(hdev, addr, val, cond, sleep_us, timeout_us) \
-	readl_poll_timeout(hdev->rmmio + addr, val, cond, sleep_us, timeout_us)
-
-#define RREG32(reg) hl_rreg(hdev, (reg))
-#define WREG32(reg, v) hl_wreg(hdev, (reg), (v))
+#define RREG32(reg) hdev->asic_funcs->rreg(hdev, (reg))
+#define WREG32(reg, v) hdev->asic_funcs->wreg(hdev, (reg), (v))
 #define DREG32(reg) pr_info("REGISTER: " #reg " : 0x%08X\n",	\
-				hl_rreg(hdev, (reg)))
+			hdev->asic_funcs->rreg(hdev, (reg)))
 
 #define WREG32_P(reg, val, mask)				\
 	do {							\
@@ -1031,6 +1032,25 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	WREG32(mm##reg, (RREG32(mm##reg) & ~REG_FIELD_MASK(reg, field)) | \
 			(val) << REG_FIELD_SHIFT(reg, field))
 
+#define hl_poll_timeout(hdev, addr, val, cond, sleep_us, timeout_us) \
+({ \
+	ktime_t __timeout = ktime_add_us(ktime_get(), timeout_us); \
+	might_sleep_if(sleep_us); \
+	for (;;) { \
+		(val) = RREG32(addr); \
+		if (cond) \
+			break; \
+		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) { \
+			(val) = RREG32(addr); \
+			break; \
+		} \
+		if (sleep_us) \
+			usleep_range((sleep_us >> 2) + 1, sleep_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+
+
 #define HL_ENG_BUSY(buf, size, fmt, ...) ({ \
 		if (buf) \
 			snprintf(buf, size, fmt, ##__VA_ARGS__); \
-- 
2.17.1

