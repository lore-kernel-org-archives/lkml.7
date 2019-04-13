Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA92C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F43C2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llomm8oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfDMKeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:34:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39451 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfDMKdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so13872027wmk.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQo2bDCPCuVEHzhz8CzwPI4g2+nR4mRWEsoJO1u+zRM=;
        b=llomm8oRMPa9VM0z2O8jIBlUV+R6t25HnvNILlOmgqQQXJBRQhlP+J6syXBjJRPsi5
         MPLcN4HDxUKO6l9wfxBcTM1S2Dw8pp6RR+Ty7p4IqNmQGRLLBgxJCXCKDFpNeAzHX11o
         R4DoKrr9V8GajIebnWwaqWEonmCmHwNFqb5dHsdD5LT+86r2ZTR4B7Aqtk3UVsjuqzIT
         ynv5fOWRzbuyLeNYxO2+CNF+ZaP65gXH58Typ5OBepga0uoQpvFeNkCvZDYSNKZLz5DF
         V6eQHe1TR9BBZK6xNlWdcNI670QzzpYc1tuRO7N2spyxZxfL9Ld6iECLWvpjZr68UXhd
         ZFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQo2bDCPCuVEHzhz8CzwPI4g2+nR4mRWEsoJO1u+zRM=;
        b=CT0FS2O7WO2BHR4MphLSBbWKV5XMMVckm1gIo/sM0H8JuHv+KGQ356RLtajHAgVI9t
         l++KamZW3g+ppe0TUdRb2/kxiO1cVAN91Ymp+cic93C8GhehtOWRndXCZFjMJ/LMkU/e
         iCWTLXcgLBFGLZ5LFbYAhGIfjmLJWUAIrB/McE3bQHCnKhzwzTkUkBS2kHDgnRW0U5EY
         l4DtsEo491dwxFwF547RcNSoSXxFKYwDSvn58C06bBIEBqtwzGwy9P9buO3phdPK8pyH
         2VYRvJbiVVjyF/S6aY3+YTgZyYsZJNRXpLXS/ucQWzQ9seFuq06o0YddMi8+XV8dQIMo
         YqXg==
X-Gm-Message-State: APjAAAV8hjXePllKr3q2P0280RsOEy6NtLmdLHyfEAAqFYDO6vBNi/g+
        BsYDL1UlHZxYNZoQG99iv5wfV8BVBaM=
X-Google-Smtp-Source: APXvYqwv6KwzcNNG6BbkXuWBydEocd2aVOduiAcvTriUFigzy2rv7DjG7YmzwxSS6mkidsETq9BvuQ==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr14294612wml.108.1555151601807;
        Sat, 13 Apr 2019 03:33:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 14/20] nvmem: imx-ocotp: use devm_platform_ioremap_resource() to simplify code
Date:   Sat, 13 Apr 2019 11:32:59 +0100
Message-Id: <20190413103305.9576-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index e0b22b6c045b..4cf7b61e4bf5 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -467,7 +467,6 @@ MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 static int imx_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct ocotp_priv *priv;
 	struct nvmem_device *nvmem;
 
@@ -477,8 +476,7 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.21.0

