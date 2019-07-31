Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAEFC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739EC206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIdxktZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfGaM7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:59:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33209 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfGaM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:59:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so1257857wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=gd7PAH+qMyT8z8+OHzNs+/b1RDtORgMTHruHrzaE3Bs=;
        b=ZIdxktZ7t+Xz7g7jUZmgA2Qow+2YGYAHcvBPMTFj1OHLC/AW+8qR09QSOe6BsqhZd2
         P9F0PJadQcFPHA0Z7Ygj+cvd6sRqokD/FfcVNVbKvGkvRcP0GHDteEZEE6lkqMW+PZgh
         NJusTzVkI0QvQjn6qsiZpdgU9c52LjjVj2PUcfNUi0oYOWH3cRn3z7yWHu1FZjBeGuC5
         +0izySBuTKjNg5SNyDQzEEqGBgn/MIHXx7RVrYye1JOjt2+6sCJKksZRFrTl1ee0ARbY
         fuMv5RAWSrPbM1i/OO1nZL2kpErSO5/N4OZtiyxL6Qd7DYT7yAkE0db/xIfbno9XUoqd
         iVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=gd7PAH+qMyT8z8+OHzNs+/b1RDtORgMTHruHrzaE3Bs=;
        b=lJg/ZCBGfaWfZs+Lp/WaAlIoMcwL+2v2sc0MCCL87fG9B9yPKBbguTS7xszT+XCJoy
         CRGg5HlwrJBWYLSQ7ATpxsBH3QpRQ5oKBLuCluGOPIxTs9l8Os2N516dVZK8EDp1yhoi
         aE9L6RKmxsx1+3p9QSCpY9aXSAd8uwpXYzgmLCDj7OJhS7co6J+HVMB++RiE7oWaJqTo
         OpKvG2jGkKfR6zIcDQBfPd2kTn+HG8dS7AY9KRLw5cjxYGMdAigR7tKIPowCN4vEYLEg
         UDdSMhrTHy/tlj3uXAmwfDhK8zuqKRP/bhWUBhwo6poQ7MS1fV5XSfuTSKfQ+9NQ+gcU
         yHYA==
X-Gm-Message-State: APjAAAXAI9TfCYWT5NzvSRGRTQ0uJhqQrmm0nvISMBYaoZqVNlBzqwlR
        cCsoyZeCGdrK7KBVPmdKeNfhHpmG/wI=
X-Google-Smtp-Source: APXvYqzTUBCscxWLbpN1qW3QfKdahWnA89Sjm5odREqCTK49CZP963PjiestAbf6ES8nY93FsZYZkg==
X-Received: by 2002:a1c:e183:: with SMTP id y125mr57931190wmg.140.1564577947867;
        Wed, 31 Jul 2019 05:59:07 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c6sm69247800wma.25.2019.07.31.05.59.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:59:07 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v3 3/7] habanalabs: show the process context dram usage
Date:   Wed, 31 Jul 2019 15:58:57 +0300
Message-Id: <20190731125901.20709-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731125901.20709-1-oded.gabbay@gmail.com>
References: <20190731125901.20709-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user query the dram usage of a context, show it the dram usage of
its context, not the user context that is currently running on the device.

This has no effect right now as we only have a single process and a single
context, but this makes the code more ready for multiple process support.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs_ioctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 07127576b3e8..c9a4799eb251 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -89,8 +89,9 @@ static int hw_events_info(struct hl_device *hdev, struct hl_info_args *args)
 	return copy_to_user(out, arr, min(max_size, size)) ? -EFAULT : 0;
 }
 
-static int dram_usage_info(struct hl_device *hdev, struct hl_info_args *args)
+static int dram_usage_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
+	struct hl_device *hdev = hpriv->hdev;
 	struct hl_info_dram_usage dram_usage = {0};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
@@ -104,7 +105,9 @@ static int dram_usage_info(struct hl_device *hdev, struct hl_info_args *args)
 				prop->dram_base_address);
 	dram_usage.dram_free_mem = (prop->dram_size - dram_kmd_size) -
 					atomic64_read(&hdev->dram_used_mem);
-	dram_usage.ctx_dram_mem = atomic64_read(&hdev->user_ctx->dram_phys_mem);
+	if (hpriv->ctx)
+		dram_usage.ctx_dram_mem =
+			atomic64_read(&hpriv->ctx->dram_phys_mem);
 
 	return copy_to_user(out, &dram_usage,
 		min((size_t) max_size, sizeof(dram_usage))) ? -EFAULT : 0;
@@ -218,7 +221,7 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	case HL_INFO_DRAM_USAGE:
-		rc = dram_usage_info(hdev, args);
+		rc = dram_usage_info(hpriv, args);
 		break;
 
 	case HL_INFO_HW_IDLE:
@@ -321,7 +324,7 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		cmd = ioctl->cmd;
 	} else {
 		dev_err(hdev->dev, "invalid ioctl: pid=%d, nr=0x%02x\n",
-			  task_pid_nr(current), nr);
+			task_pid_nr(current), nr);
 		return -ENOTTY;
 	}
 
-- 
2.17.1

