Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0790BC04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 21:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C061B205F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 21:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENCHixr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfEDV5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 17:57:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52853 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfEDV5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 17:57:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so38853wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0aiiUSlKWk1zRxgyzOUd6WjEOUD1U9slmEAtOBZxokE=;
        b=ENCHixr8kvbFs69ag0VlxSqslNcwxX0TA6M0wm51QM1wU7SbvXjIrTNn5V8rSHWFOv
         xJSnAH/sSXdvDntndKHPv5YrobLTZInGrSVYRY68DSGsiI7g2seAqbaystvKqfOQPkvG
         dDU7TccLhE1bVbIPfRnO35l4sU4gT/Eb9YFPNr8/VJSopLIqUQiqYMJjBI9omqa9t0lf
         uyKMvpavApvDezuy8RMM4EeZ7yE6UIYW58V2ZMk8NnwGt2nl4vWwdPA9JKIY2Xi4MPtS
         Mg9ln7LWcpzLZPmkFEZkbLkofxvY2ObpTWBxjYk16G8VwH+11ayL2b4FudVlmR33MYTI
         Kcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0aiiUSlKWk1zRxgyzOUd6WjEOUD1U9slmEAtOBZxokE=;
        b=sYl5KCRC5GDbJ4ms9IYv8/ah5C/PDlAcZqdTzoApzDsrPJOWC5v/qtCsbEpu/DOa0Q
         pnaDtGfZYAk+NBmSLXUBBPwN6dAjqxoGWOcXrUKKVL6Bm6GYpgXy1C6esgH/hoM0s1px
         ePseQ+NCB2JrhIcead0b5F70BAUDjdH2HZ2Qoxu6hbs5wCaHinKNyDepvYZ1dRUHyQJI
         8RPaXia0XkBnyUuyQO4i6jLiR7P7xzCh6m38njLTYEfP+aZdkrV4slV/2sv8/uvvS6I9
         A+yudqLBDAGtkY4xjabbG+WDfRmMPUPu2BfUQ5OMwWf5P7VqoVpMBP+jFuEEO6Yf0UUS
         AqjA==
X-Gm-Message-State: APjAAAVVFpBZNrKomrrBQ2Pc6vhku2YWLQ/fZ8hHRF1T9c7sO1wonw9C
        h+b89xbgpgGu2+ZlebxBlBaLGbrq
X-Google-Smtp-Source: APXvYqwjx6mC/ZiEgi0mztjWdydVL+eNZPJAxYfPs3028a+B5I8gf7fiddCpvz8yYPhz1zd5RziKaw==
X-Received: by 2002:a7b:cb16:: with SMTP id u22mr11152616wmj.60.1557007061855;
        Sat, 04 May 2019 14:57:41 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o6sm11649237wre.60.2019.05.04.14.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 14:57:41 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 1/2] habanalabs: halt debug engines on user process close
Date:   Sun,  5 May 2019 00:57:32 +0300
Message-Id: <20190504215733.12823-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch fix a potential bug where a user's process has closed
unexpectedly without disabling the debug engines. In that case, the debug
engines might continue running but because the user's MMU mappings are
going away, we will get page fault errors.

This behavior is also opposed to the general rule where nothing runs on
the device after the user process closes.

The patch stops the debug H/W engines upon process termination and thus
makes sure nothing runs on the device after the process goes away.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/context.c             |  6 ++++++
 drivers/misc/habanalabs/goya/goya.c           |  3 ++-
 drivers/misc/habanalabs/goya/goyaP.h          |  1 +
 drivers/misc/habanalabs/goya/goya_coresight.c | 17 +++++++++++++++++
 drivers/misc/habanalabs/habanalabs.h          |  2 ++
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 4804cdcf4c48..f4c92f110a72 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -26,6 +26,12 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		dma_fence_put(ctx->cs_pending[i]);
 
 	if (ctx->asid != HL_KERNEL_ASID_ID) {
+		/*
+		 * The engines are stopped as there is no executing CS, but the
+		 * Coresight might be still working by accessing addresses
+		 * related to the stopped engines. Hence stop it explicitly.
+		 */
+		hdev->asic_funcs->halt_coresight(hdev);
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
 	}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a582e29c1ee4..02d116b01a1a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4819,7 +4819,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.set_dram_bar_base = goya_set_ddr_bar_base,
 	.init_iatu = goya_init_iatu,
 	.rreg = hl_rreg,
-	.wreg = hl_wreg
+	.wreg = hl_wreg,
+	.halt_coresight = goya_halt_coresight
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 14e216cb3668..c83cab0d641e 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -202,6 +202,7 @@ void goya_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
 int goya_armcp_info_get(struct hl_device *hdev);
 int goya_debug_coresight(struct hl_device *hdev, void *data);
+void goya_halt_coresight(struct hl_device *hdev);
 
 void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
 int goya_mmu_clear_pgt_range(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 1ac951f52d1e..49b5efb3a912 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -626,3 +626,20 @@ int goya_debug_coresight(struct hl_device *hdev, void *data)
 
 	return rc;
 }
+
+void goya_halt_coresight(struct hl_device *hdev)
+{
+	struct hl_debug_params params = {0};
+	int i, rc;
+
+	for (i = GOYA_ETF_FIRST ; i <= GOYA_ETF_LAST ; i++) {
+		params.reg_idx = i;
+		rc = goya_config_etf(hdev, &params);
+		if (rc)
+			dev_err(hdev->dev, "halt ETF failed, %d/%d\n", rc, i);
+	}
+
+	rc = goya_config_etr(hdev, &params);
+	if (rc)
+		dev_err(hdev->dev, "halt ETR failed, %d\n", rc);
+}
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 71243b319920..adef7d9d7488 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -501,6 +501,7 @@ enum hl_pll_frequency {
  * @init_iatu: Initialize the iATU unit inside the PCI controller.
  * @rreg: Read a register. Needed for simulator support.
  * @wreg: Write a register. Needed for simulator support.
+ * @halt_coresight: stop the ETF and ETR traces.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -578,6 +579,7 @@ struct hl_asic_funcs {
 	int (*init_iatu)(struct hl_device *hdev);
 	u32 (*rreg)(struct hl_device *hdev, u32 reg);
 	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
+	void (*halt_coresight)(struct hl_device *hdev);
 };
 
 
-- 
2.17.1

