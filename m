Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441E1C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B83020851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtcRU9Yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCICcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 21:32:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46339 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfCICcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 21:32:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id a22so2942385pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 18:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dkuv/yR7ppliTMGT5ZXBw4fbuXLcHIGDFZQMu4+clIc=;
        b=ZtcRU9YnVUxk1XedGnfEHtBPvqN/h4iSjHZ0PY6jtXtvp/ix9GnTwUlGKAgAYZ7q8n
         bXaZQeqbh7UlYlPYNSCIxOx35ckOrDpOMZFnYIklI5RqXr3VuR1TBL2Sb47/EraT5Vtf
         6R5W7hvmSaJQZJSQciNHIAo3/+j36MZmg/ZSRaWoRA9kq8AUA13/8iKCRENiGhQkLzUh
         WVDIKAY4orXT5Rnf252mWowD7ImwnKfh8/VHjBFH5OJXSvVHu0I4LAF1poll0ucd5MJc
         KfTJZIZEjZw8DVreUxGG8+2kUrbNjAClNonaAAfTFdd+LIDPBBbjpysbwPSW5s+STslX
         R4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dkuv/yR7ppliTMGT5ZXBw4fbuXLcHIGDFZQMu4+clIc=;
        b=SkUI6bV7lzzhbVgVnENUqSpG7QLFOPn+k4PqJQpri9jn+XPZ56JTUTQQi5Fh5EtNMo
         vjKotEard4tuB1+x0DYAPI9Pxag6/fj2mjJRXATo9ixQ1xJUbqXd0TmLoScaq3aSStCq
         6yLUfbClTPVrO9+5//zC4MGr2yOlzAkmnFb2DagRxnpHoZrSaS7h4owAaVTtaZT06+iE
         8idquvVNLZEkyuvyKU3OJ0xzIFfv9HtC0aT1GFCTr1KIrzyTHRnSSaTpC/AYaMcOPITp
         qBnpVvsyuW2WoeYWe0ybwwPSCXAMe2l1pIDBKRd4BzNybz5UpNXs6b0kLPWbZjzA/8Zw
         pEKQ==
X-Gm-Message-State: APjAAAXo/A7Lx9F7MeCNeQ4SELe0RPamYTNJI5NldjrJ9zkpmAL/zE22
        +1xyfRn05uDoRrP8XckSOBU2
X-Google-Smtp-Source: APXvYqy7yDuwWwzHnnhfVCK/m5E7FGiqDI+MKI4wadFd3oiLYevDiVLzGEmToMN2fFbqdK+B1b/C0g==
X-Received: by 2002:a63:8bc8:: with SMTP id j191mr18573515pge.234.1552098744029;
        Fri, 08 Mar 2019 18:32:24 -0800 (PST)
Received: from localhost.localdomain ([2405:204:730b:185a:e100:cbb9:245b:912c])
        by smtp.gmail.com with ESMTPSA id b8sm13980285pfi.129.2019.03.08.18.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 18:32:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        a.tropschug@ebs-systart.com, m.bittner@ebs-systart.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] arm64: dts: freescale: Enable PCI-E controller for Oxalis board
Date:   Sat,  9 Mar 2019 08:02:09 +0530
Message-Id: <20190309023209.6741-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCI-E controller for Oxalis board based on NXP/Freescale LS1012a
SoC available as the Mini PCI-E connector on the bottom side.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
index 760a3e258c96..5f9cde402744 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
@@ -87,6 +87,10 @@
 	status = "okay";
 };
 
+&pcie {
+	status = "okay";
+};
+
 &sai2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 816f3a4537e3..d48b0df1da6d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -474,7 +474,7 @@
 			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pcie@3400000 {
+		pcie: pcie@3400000 {
 			compatible = "fsl,ls1012a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
-- 
2.17.1

