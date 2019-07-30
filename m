Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46683C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D77C20651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWa6sMVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbfG3Jri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:47:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38459 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731948AbfG3Jre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:47:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so65027613wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=gd7PAH+qMyT8z8+OHzNs+/b1RDtORgMTHruHrzaE3Bs=;
        b=gWa6sMVZAoUWUpYA/znKhgtTVJBPy1kOvFx7UcPdxnGULf59kDA9tdseVlKGyXtoML
         ouwjWqPnompK+e4ZE7JxZgAEY9zH8mogxj1jL7Afs58htze2uTchGKLfzBE++i1YccEw
         PuBAf6uq5dWIkJujpCVwdt0dzq9UT/iT0t8IDtzChlhhinMAk4EY5JvTXE2AX1yPAuo/
         e2APizxgRJpMrif90QnMtbsZMeJ8KD+DVa46WQtKZMQhQOxxkMzntayY7JmP4tJIeb0l
         b6NyuHXCQHwAboRSj3qfXabWpNPaodP08ziHE1mOblBgZUjncf8PnTiBcRHYX/UocT8x
         qYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=gd7PAH+qMyT8z8+OHzNs+/b1RDtORgMTHruHrzaE3Bs=;
        b=p8A2AZAfxKF9iHlrpc5mY/+TGKZ8RtpA9jWp1IvwOzEjKOU2xw302hiJORpzhAWo1+
         Pp/lS1sCKeK1++z5TpkoOyGO3vMc6R/Uy0DMIo9A0HBJJJPIvKChUyVLlOICnyNa2NVJ
         HgEHTvjw5rLCKTxAWw1Fz9Uk5mgBS98DfMDVn7H/jPH+s8swCCJTvW30DOHcYazd9J6v
         iRnPM3w0YaJEya0UjCTXO9kv0jllP3+LkTTS/Cw8hkRzqwxUAF8xfvAyXf53fE61fN0t
         vy4nrpAYViZwl8c8e8IlQAqU/d/V/7LOKW01jSjXkMScG/9uL0hXWw7SPBuUZsZydUI2
         qZSA==
X-Gm-Message-State: APjAAAUIxvW/QXY5udfPoJ2hcFbEO6OrzkNwNF3if4WLfQ5MZi4RXrqn
        jRLBCANB2+QfQWcJ1o7RtA1MP6DXYSA=
X-Google-Smtp-Source: APXvYqx/rN7YPXz3N/bPwbxWBRSyKejmlJGzv/4LBERxbV7Mo4jwANEaWEEMEH4PYZUIhHgjtF+ZoA==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr52055990wrn.94.1564480051953;
        Tue, 30 Jul 2019 02:47:31 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k124sm105967360wmk.47.2019.07.30.02.47.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:47:31 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v2 3/7] habanalabs: show the process context dram usage
Date:   Tue, 30 Jul 2019 12:47:20 +0300
Message-Id: <20190730094724.18691-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730094724.18691-1-oded.gabbay@gmail.com>
References: <20190730094724.18691-1-oded.gabbay@gmail.com>
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

