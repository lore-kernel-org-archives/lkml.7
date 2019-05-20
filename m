Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3783C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A13120815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyWXseoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfETIb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:31:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42233 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfETIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:31:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id 145so6430502pgg.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWo8Uulihvaq9zy3I0w67p1cVDmaIdDDpV04dYtjBE8=;
        b=KyWXseoPwNWVph/2LYqJ7XtWB++4XFV14lGAlh0XyfkDC+WFnwSAVrpHZ7LnWmVHNE
         /+OJJm/I2OI/6rwUZL4YNI3DV3sZnUqWe4nbib6CR3PGfaFrxtjJA+ARiJLuKXPl3Phx
         +IV8YI7LAA1WxsrFW7o8lOnwnfdUpYfktee+Xfhf8BFt9z9OXSsOg2OTQufei6iVkOk5
         n0Hf31CIwq3xCOKdcff7Aa3ZMywrRrX0OuIoYetcoEBGCPpFNCPswN+wekoiwwKAsxbp
         g5VELbnAmdPMNGrjkCRCj4rg6G2ebRtzIxPjYaslK+2OBBXeC/3kod5v1EtN43HxCMJ9
         oLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OWo8Uulihvaq9zy3I0w67p1cVDmaIdDDpV04dYtjBE8=;
        b=eATqlhid33whmkKKsAOHoIhHQ0CgIEmdkvNQ4Ll5PO1/MMGOrObKvSFTJmXUB0Bs6z
         iixpfoB4oSnIYNcu32X1Qm8dKJk/V6EhX+j6ZH0u/ozB/N9c7UwSaqdthR/qVjm3Rg24
         2xkx8EoUzj6fzjBMeyLQWTBnaqx3aSCOVW7JbpKAPOy/7+QKR1vWK7ySZQGJR2rRzVBp
         O3QsbTygP1ISOWThhYcUCKaNSSqYp5v4dRC7gExnsiYNWS66LWa5wRfmmlEKq/WCsuo4
         PSeEuTUFHPMHpV2kbFae32HS1rqi22QG8RfWaMA8jcn7nonQFEvbahIS6IDifx3Y9/3O
         Hb4Q==
X-Gm-Message-State: APjAAAXR8051MaF2E1z7ocPyIGxmERyk1CPccWlySVSPqZNehViNN16f
        PmSfpJWki9DDvWPIOeCnidOu
X-Google-Smtp-Source: APXvYqwba4qh7qxpJyc9Shot/nunx5rmufZCNsCBbq7hfOm3Lnju8hTbLBzaiGhYCaJd7E7ncz5dew==
X-Received: by 2002:a63:e406:: with SMTP id a6mr75142659pgi.132.1558341087636;
        Mon, 20 May 2019 01:31:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7203:2717:7d22:7fdb:b76e:242c])
        by smtp.gmail.com with ESMTPSA id s72sm24068220pgc.65.2019.05.20.01.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:31:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        linux-gpio@vger.kernel.org, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/5] arm64: dts: bitmain: Modify pin controller memory map
Date:   Mon, 20 May 2019 14:00:58 +0530
Message-Id: <20190520083101.10229-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org>
References: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier, the PWM registers were included as part of the pinctrl memory
map, but this turned to be useless as the muxing is being handled by the
SoC pin controller itself. Hence, this commit removes the pwm register
mapping from the pinctrl node to make it more clean.

Fixes: af2ff87de413 ("arm64: dts: bitmain: Add pinctrl support for BM1880 SoC")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index ee7e6abcc813..b2497a090402 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -88,9 +88,9 @@
 			#size-cells = <1>;
 			ranges = <0x0 0x0 0x50010000 0x1000>;
 
-			pinctrl: pinctrl@50 {
+			pinctrl: pinctrl@400 {
 				compatible = "bitmain,bm1880-pinctrl";
-				reg = <0x50 0x4B0>;
+				reg = <0x400 0x120>;
 			};
 
 			rst: reset-controller@c00 {
-- 
2.17.1

