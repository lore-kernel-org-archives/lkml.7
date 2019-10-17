Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042D8FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C799E2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YXPnsMjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502247AbfJQMBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:01:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56251 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502217AbfJQMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:01:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so2258562wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rBnqrwfSTh2mbIWwZpd9b9hudXdXX3wV/WFEw1SJ2yw=;
        b=YXPnsMjKQyf8JYK0M4k0KOdyEWa1AMAmiDYLNlKXmtX/pwgtbFV2kT3BgtWZXFaJWm
         QboEGQHvToLotMwSll1BfBlLHNTm9atHIsl4LVjub+12SS8qdBgMfGSdLVTzDMc0U0OS
         T0iDaKu9JVuF39SdlZMs4CvAzIS7P1m36IKps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rBnqrwfSTh2mbIWwZpd9b9hudXdXX3wV/WFEw1SJ2yw=;
        b=UrhIlugFeGh19B4++GUOoMA1euHd0zTRZMosgF8bW9x3IWPLHHUKSSFXWUk+kpzGcl
         jWSy+Jk6lt0vqF3yjXvL+/t8GVfDcGscwX6K3WAebMxTj6CF9kPu+ncGcqeQF4IXTjLi
         K9wgyguGi06uMYaP3/47gYPZ+HihrZTAoNjGZOyM4FnU/UYtJJrUupCPcD3r/sMejcE2
         kfpB2qjcBltUPR8DYC826/P15QkYcpWGc7OyRT5mxVCI6qKwxFr+1G+o6fKktB+H8199
         kx01yr5AK5wBA56Ve+JhUh6nKHLFLFqLX4VjpzN++gPDvQ2RM9TLtUctjiuAJem18e8n
         ERLg==
X-Gm-Message-State: APjAAAUnLbo7D4tdaa98FocfBIntHv6DjnGpy9jJP51WviO7t/40IKGg
        6TqNzR6rWYar99MLdM8ExV4ceg==
X-Google-Smtp-Source: APXvYqx23GT/npHp/uYWt+AJRmhdQoQHvzH7clYBCIlLhux531SFUjxNmmlmWEatrMH9VYlmXtflMA==
X-Received: by 2002:a7b:c849:: with SMTP id c9mr2481040wml.70.1571313698937;
        Thu, 17 Oct 2019 05:01:38 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y1sm2317949wrw.6.2019.10.17.05.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 05:01:38 -0700 (PDT)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V2 2/3] bnxt_en: Add support to invoke OP-TEE API to reset firmware
Date:   Thu, 17 Oct 2019 17:31:21 +0530
Message-Id: <1571313682-28900-3-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571313682-28900-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1571313682-28900-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

In error recovery process when firmware indicates that it is
completely down, initiate a firmware reset by calling OP-TEE API.

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 13 +++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b4a8cf6..b60b24e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10581,14 +10581,23 @@ static void bnxt_fw_reset_writel(struct bnxt *bp, int reg_idx)
 static void bnxt_reset_all(struct bnxt *bp)
 {
 	struct bnxt_fw_health *fw_health = bp->fw_health;
-	int i;
+	int i, rc;
+
+	if (bp->fw_cap & BNXT_FW_CAP_ERR_RECOVER_RELOAD) {
+#ifdef CONFIG_TEE_BNXT_FW
+		rc = tee_bnxt_fw_load();
+		if (rc)
+			netdev_err(bp->dev, "Unable to reset FW rc=%d\n", rc);
+		bp->fw_reset_timestamp = jiffies;
+#endif
+		return;
+	}
 
 	if (fw_health->flags & ERROR_RECOVERY_QCFG_RESP_FLAGS_HOST) {
 		for (i = 0; i < fw_health->fw_reset_seq_cnt; i++)
 			bnxt_fw_reset_writel(bp, i);
 	} else if (fw_health->flags & ERROR_RECOVERY_QCFG_RESP_FLAGS_CO_CPU) {
 		struct hwrm_fw_reset_input req = {0};
-		int rc;
 
 		bnxt_hwrm_cmd_hdr_init(bp, &req, HWRM_FW_RESET, -1, -1);
 		req.resp_addr = cpu_to_le64(bp->hwrm_cmd_kong_resp_dma_addr);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d333589..0943715 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -25,6 +25,9 @@
 #include <net/dst_metadata.h>
 #include <net/xdp.h>
 #include <linux/dim.h>
+#ifdef CONFIG_TEE_BNXT_FW
+#include <linux/firmware/broadcom/tee_bnxt_fw.h>
+#endif
 
 struct page_pool;
 
-- 
1.9.1

