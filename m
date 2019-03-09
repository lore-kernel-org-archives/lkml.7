Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D39EC10F0C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7532081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYTsujj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCIB7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:59:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35546 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfCIB7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 20:59:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id j5so15419839pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 17:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hmQkxeVs4MCB6oMpxb4sXYFHVbv88QBQBaECu3FhUAw=;
        b=gYTsujj3IR8Pl11nrtaVLSL9KoRCtQ1YNf6qgMRX41MSoB31tWEJZLHK/iC9eAyvKA
         1kPMtCkFwm229UcPcr8iGsIIXOScpGIozaXOxr87oU3A3mJWa54+dKyedQ1BYcA9Aws4
         ehH4UiAvMnQM4dnjWglyU+yzKf7A69E459uYiZsK9V1bcgpV5bMUvItwDinNlhwFlXTK
         OfirSjnDP6LSUqPuQTha6wznbz4bIBsakCCXDN1wY9ZcKZqH9kLjYtuH6BapTM9RWwqR
         W9bJ70BbTvpLqmI1lWDYvu0M/IJuGUlcE9EiET5ppx15ng9cnhSyi1xeIoFDFL5fBAnW
         cdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hmQkxeVs4MCB6oMpxb4sXYFHVbv88QBQBaECu3FhUAw=;
        b=koMC1Xi9U/rrtGzirhZ7M/lpfELIPE5Fm39Sau78Ex5dgWUb6veRFAhYf9pRtqCUwT
         yh3freoWgBKiuaGctoFFhAJZU/1IUw4gPGHJFR9TfxWriZfC0RLiRHakz85Lu0xQjkR0
         jfrFoOT3nXdBwderhUVBs7gfKalJQFCYSGAbyPy1Ov7/5Q9vHjSCIvXN2udeIPGDAUKS
         G5M8PSfe+7SQpWlJxfnvixeTJ6yrQP53eyIBXgybD2+8GVtQvS+53wHZLEkjgx6nvOwL
         BroNoyHlB23XxO7yvWkj7XaqBfkYp3tn6F6HS0nappPWBY7XmxcYfZ/8HXsXUIuEyH1p
         y/tA==
X-Gm-Message-State: APjAAAUk+ltJJCCtHo4kzbHjsbZVGvMOMhlfxRTIA7bnhoG3rjvTW5nY
        NtiLt4Ol/HnYdO7Ngmr7mq7YndktEw==
X-Google-Smtp-Source: APXvYqwNdosm94HFVwy9qMED0Rvapt+HF86uLidQQxpq6GgNVTKGvnULVQu2/o7LF6sXWa5bEbwbyA==
X-Received: by 2002:a63:6a88:: with SMTP id f130mr19376393pgc.114.1552096742200;
        Fri, 08 Mar 2019 17:59:02 -0800 (PST)
Received: from localhost.localdomain ([157.51.75.198])
        by smtp.gmail.com with ESMTPSA id b65sm16040201pfm.127.2019.03.08.17.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 17:59:01 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux@armlinux.org.uk, xuwei5@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, daniel.thompson@linaro.org,
        peter.griffin@linaro.org, guodong.xu@linaro.org,
        haojian.zhuang@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] amba: Take device out of reset before reading pid and cid values
Date:   Sat,  9 Mar 2019 07:26:34 +0530
Message-Id: <20190309015635.5401-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
References: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the AMBA Primecell devices having the reset lines wired, it is
necessary to take them out of reset before reading the pid and cid values.
Earlier we were dependent on the bootloader to do this but a more cleaner
approach would be to do it in the kernel itself. Hence, this commit
deasserts the reset line just before reading the pid and cid values.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/amba/bus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 41b706403ef7..da8f1aac5315 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -21,6 +21,7 @@
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #include <asm/irq.h>
 
@@ -352,6 +353,7 @@ static void amba_device_release(struct device *dev)
 
 static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 {
+	struct reset_control *rst;
 	u32 size;
 	void __iomem *tmp;
 	int i, ret;
@@ -388,6 +390,13 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	if (ret == 0) {
 		u32 pid, cid;
 
+		/* De-assert the reset line to take the device out of reset */
+		rst = reset_control_get_optional_exclusive(&dev->dev, NULL);
+		if (IS_ERR(rst))
+			return PTR_ERR(rst);
+
+		reset_control_deassert(rst);
+
 		/*
 		 * Read pid and cid based on size of resource
 		 * they are located at end of region
-- 
2.17.1

