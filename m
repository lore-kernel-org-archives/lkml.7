Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4579C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0DA2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joOATH67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfDMKdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55710 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfDMKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so14187274wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQbO3RQJR5q3rIRo+rGVsOp5BrYMJJBTMFPT0KiS+M8=;
        b=joOATH67pmeKu/uSGKTqEeVy0e2p6CilMrpTUABtSJ+dJCpSbRA33z3RpBEoK7liKD
         fAFt0O7xMQbwBnNSlDI7pil5YoklNOjPvJXgsnjvAF863WXgfpkJGDlAvDZQTdgAOGE3
         peMgsJ5HdSKTszimTIXaXz8VHQKFzGwNwoDGBnGzU7IkWLPIJc2scDCvG8wg1Fz+1Ekl
         S2rtdlXkW42sEJNzDEDgQ6vHoVaw2FcwFWcNQtLIinB9kjsqVgRiVmQ69riuSDPCRaGA
         L1VWioy8Ng8oa9J03fIrf7/o2gjA4b9Jfmb8CqIzdX6p5j1qIgbHeBcGjXsGl4Rsgmoe
         ClVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQbO3RQJR5q3rIRo+rGVsOp5BrYMJJBTMFPT0KiS+M8=;
        b=UB1pZ1Is+IQ/LnMZHClRNbpXFswIpbIpsE0m++Ifz4Y138gwXnlVL5U4bX5gA7QKnV
         RH4B43NCOQdFUMzbnciHw4TyqlzpWE5cZCKQT4kxXMUBZnxlx9wkfhUOF0sGgiBe1pGh
         4rIbda8h79PveSxCFSSBMIBLl2sHR2PMd+DT/Cbf/7NISwcNtzZADfqmrkrCZoLjEtBl
         81efKBro6GJO+eSjTfzIXohaHwYPONLBR9PDprylOmGSG62G5t/9LNrW59tQULFodgZg
         5ER3qUfF5pYgwLjsyO81FG4MDuOC/34fzQBnOJ2jwT6DNTEK17EOmeWxV0Yzf1rEA78f
         5vjg==
X-Gm-Message-State: APjAAAXVjTgo4wp/h1RIKJlPqfiNvNrkhPofb7e71n0zOd6s4Oqg+vMc
        uy/2PrxNA2s3KZ69MqP2SmgejZpYZSA=
X-Google-Smtp-Source: APXvYqxOlg2FsW1qLadCszUrVhN8gkZFxSI5R93IdwSiqjcatvEN7T9581zNMMXrwg6FMgXuWaSk6Q==
X-Received: by 2002:a1c:4187:: with SMTP id o129mr14353788wma.57.1555151604777;
        Sat, 13 Apr 2019 03:33:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 17/20] nvmem: sunxi-sid: fix wrong description in kernel doc
Date:   Sat, 13 Apr 2019 11:33:02 +0100
Message-Id: <20190413103305.9576-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

qfprom->sunxi-sid

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index 99c4ba6a3f61..d37017e343b1 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -12,7 +12,7 @@ Required properties:
 - reg: Should contain registers location and length
 
 = Data cells =
-Are child nodes of qfprom, bindings of which as described in
+Are child nodes of sunxi-sid, bindings of which as described in
 bindings/nvmem/nvmem.txt
 
 Example for sun4i:
-- 
2.21.0

