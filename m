Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E74C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF43020678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6E2sZyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgAIKkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:40:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38645 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgAIKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:40:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so6858402wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bp25CRVVG4xHEOS95em3Nre/2TPPk/C1x96vQJbh9Jk=;
        b=B6E2sZyyT83Li9+yTlfUzvd8oeU/F/a7cQN2Gpk/HUgbqPLmDmln7XfxZPGJkoV8Qt
         2emd8pudFXY8yyk3LtdzhnE5a4NHIwiJ/HYizBrhk7MMqaPq5eKQ5QdyH6ruzvxy/l7n
         qGQnxqIWobH26WP1t28+YU7/AZKK6G4AO85ED1ZcW/32pd6AatvLKXdNk0SqK+W4XDAA
         WrE3RMft662GAHaM6DJFpqDZP0r5BgIvghI5Sl9WFzCWC2UE8oTwuVbVzYk92vdgNBFT
         2mErddkMN4ZaazC9gGl3rgblJPgGsox6QsZ9CtpfJ9ZJlzR13rIJ2hIRLx6EmwEFdlA5
         8ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bp25CRVVG4xHEOS95em3Nre/2TPPk/C1x96vQJbh9Jk=;
        b=erNuCwI8lOUfBVy2ibK+0O310OJiGH+tYIb1wu+ZwEcxwOMMUD82d9eEcAf//fAmyK
         MnA5zbYQYVbXk6mhBMh+2H07v7LLPtzCjcFvy43PtknckObLkGQWbXCOD2PxWB6s5twr
         Vc6Bh8hLmVwa23bI9TsSGmQanlEfH1FUc6U51Fb6QAI1Gp7SIFzx5U5uoR/TiuCQBovf
         DUaVMScNTovQq6qN9ZsW3O+Gaf3dzcN/1xJpEQzX4WZ0+6nR+MIyRxNm1vHky+oTxDiZ
         D9mjyeMOeJ3WRqKL+F/G5qXfuBdmHc7lbgpxf1YRTmBhvmXKJkKYXR8XIKXNNzUO3WMc
         PLEA==
X-Gm-Message-State: APjAAAUjLRwZtJOwnvLjk3e1zWOwFmWE+D9YAZsRCMkpYY/5tBGZd+KX
        pgvp9LCe89+pTNP2YgwTum9Eqg==
X-Google-Smtp-Source: APXvYqw8Cwtgl6xT02nENjye2+a1XJGJ9tfW3G97Il0UkvbBbx0owPV2nH96pKtj4xlPbxw5HjxqPw==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr10422689wrw.233.1578566429373;
        Thu, 09 Jan 2020 02:40:29 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b10sm7858576wrt.90.2020.01.09.02.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:40:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] nvmem: imx: scu: fix write SIP
Date:   Thu,  9 Jan 2020 10:40:14 +0000
Message-Id: <20200109104017.6249-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109104017.6249-1-srinivas.kandagatla@linaro.org>
References: <20200109104017.6249-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SIP number 0xC200000A is for reading, 0xC200000B is for writing.
And the following two args for write are word index, data to write.

Fixes: 885ce72a09d0 ("nvmem: imx: scu: support write")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp-scu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 03f1ab23ad51..455675dd8efe 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -15,8 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#define IMX_SIP_OTP			0xC200000A
-#define IMX_SIP_OTP_WRITE		0x2
+#define IMX_SIP_OTP_WRITE		0xc200000B
 
 enum ocotp_devtype {
 	IMX8QXP,
@@ -212,8 +211,7 @@ static int imx_scu_ocotp_write(void *context, unsigned int offset,
 
 	mutex_lock(&scu_ocotp_mutex);
 
-	arm_smccc_smc(IMX_SIP_OTP, IMX_SIP_OTP_WRITE, index, *buf,
-		      0, 0, 0, 0, &res);
+	arm_smccc_smc(IMX_SIP_OTP_WRITE, index, *buf, 0, 0, 0, 0, 0, &res);
 
 	mutex_unlock(&scu_ocotp_mutex);
 
-- 
2.21.0

