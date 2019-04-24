Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04261C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54B5218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvImkMX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfDXMD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:03:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46802 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfDXMD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:03:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id o7so6957353pll.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K9GlpFCd2DOdgM3fSdxL4T71FjdIxk/5Xu8NSCGxtGQ=;
        b=KvImkMX1Rd5Ulv3d/JOyrloTLqwwyZOiJlUX4mmAACZGmD7mYS8uxB8mCwtaW8CcZS
         6yMmf547hO97euAwcusstIgoAkMfssjQQTo69iNePnw7IqojK5QCFqAabbsyIKhjFUEE
         TdcyIfE8LctErMAzlfG/+q76vEW6LAEtJZaOnI2N29rw6gLxbn2zSVbeuoQxy+UPsz7H
         sxFBtgWaO0KGxOQ4DEw1Kjun0RC5kdkhQL7DinuYnWaQ+Yo83Wi6McZD6GZtr/BvKKga
         iWo0vhqv4rADc6Y/6qT7/pfuzNnScb//YcxNP+Zz0dd3GhGvJ5P3CW/Ow5AWR31LgnLI
         Oodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K9GlpFCd2DOdgM3fSdxL4T71FjdIxk/5Xu8NSCGxtGQ=;
        b=PN5YJJqxszJgfK039PbYmRrqZA1IxDaieGgo9wZFWiZXTCpjbc62FOd2KjIk+Ez3JF
         7Jxqbfr5jCBBb6Qh41vOWJpQFUsKAm0rZffhr7T/rPgKST3rmqqw5qokAlCvZNsplaN9
         0AhVLeRZHs05dtFrJQXb7VBxFaNFp3HP10SEkMnrQLh0GAFN5D5hxSSy+XV4ieMYLPy+
         eyBEs7AjZQTp6uZymXCjiTgxDLc9DDWT8f9F/hscFF2Mz2exMi92fTp9F52RrA7swbK4
         P9LM6k4FU/Dpw8zDFokc8883Pdel7nA9nOkHuv193FFFKJruee0js5Ehto3ZJkXi3rhU
         TyVQ==
X-Gm-Message-State: APjAAAXKGx2I+yjygoVzAsqp3gYdVum0HVOSEkSsSluztlDdTaW2B1U+
        wfmirflH9kzBrYc64lttT7DXX8wDIQ==
X-Google-Smtp-Source: APXvYqztBAhDkX1LBASqJHCQQEOisTHn12l8THdTG+X5PBBhmpDdL8RO8AskjojNIY0uMaH4WV32mQ==
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr14427599pln.144.1556107407620;
        Wed, 24 Apr 2019 05:03:27 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:711:bac8:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id j22sm25870840pfn.129.2019.04.24.05.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:03:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        linux-gpio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/5] arm64: dts: bitmain: Add pinctrl support for BM1880 SoC
Date:   Wed, 24 Apr 2019 17:32:21 +0530
Message-Id: <20190424120224.22660-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl support for Bitmain BM1880 SoC. This SoC only supports
pinmuxing and the pinctrl registers are part of the sctrl block.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index 55a4769e0de2..fdfdc65d29ef 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -80,6 +80,20 @@
 			#interrupt-cells = <3>;
 		};
 
+		sctrl: system-controller@50010000 {
+			compatible = "bitmain,bm1880-sctrl", "syscon",
+				     "simple-mfd";
+			reg = <0x0 0x50010000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x50010000 0x1000>;
+
+			pinctrl: pinctrl@50 {
+				compatible = "bitmain,bm1880-pinctrl";
+				reg = <0x50 0x4B0>;
+			};
+		};
+
 		uart0: serial@58018000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x58018000 0x0 0x2000>;
-- 
2.17.1

