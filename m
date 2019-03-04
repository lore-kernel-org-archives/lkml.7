Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13682C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4C6206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfdYogFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCDUOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:14:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38954 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:14:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id g80so5464512ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUlkxofq07yuoGZYMgybyaCCQaxYUV/Kk8bLaqs1y0w=;
        b=vfdYogFr8MMLVpobD//o6pWn3EDAQeYaokC+M5XrrAUUWteEAn5184JcGX3JsplAWE
         ksDtg/7y3sAVGOxjU5c+gaXV87zkDOCiiGTr7jVxipYf4AWqWQDc6okQNYxN+EVb5YnZ
         rCN/Xh/kBMZq+lGxAg2FSnOAA4eAtuh739lEC2Rc60WhLarAFU9S6z2vR8/xQclQhCcU
         h6Z/uiAmyStEQ5NO/b70wTlyKTQYT4n3vrO3z4bF5I0RHBrWZCtzjqyL/L0Y7nTE+z06
         a3b8c9O0juOTrQrxpo0a30WTXMxBa78ut2x9+nHS4gGb2Zzy4vu6/lZnGol4TGiqLxDr
         dPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUlkxofq07yuoGZYMgybyaCCQaxYUV/Kk8bLaqs1y0w=;
        b=DzBCVEF7i1bThD/1QdaBqN6HAKKz2wRjbsxcIAHbHDF75CR3SsT0ivOZcLzl3q3JsA
         KMhBFJ2/xF43xI9ydl2BIlEcZm1PjYWpoh8LNEF02ow3XTFkQiHthkzoTB3h+o8gZGte
         GgSZ4otvyyuWM3akFIerf77aBK22FhnJesmOc2A5u7yOA1G9vySbx5/UqrKvTyEKtcn5
         2eoWtVbU6U69asusFLz4mVrWJEVfyr9Bb2R8z/d3nvqnaFUt0S57QY2aApbqJLwyOMJP
         MYXshbS5LTc16al4zwtVqXjJlNlnk0q3swn/1vQv5UdrIqn9x+881mcYRVWtF4vhKmOL
         3Q6g==
X-Gm-Message-State: APjAAAXgQCFF01kppdW77Swkzise5bGNbcRRuU8tQKW78Da4qtbRiZ8o
        SXsok3lSO8/TwcjpVqpje1KYdQ==
X-Google-Smtp-Source: APXvYqwc7hds8YpsZPwNQK9FeKBMUXBAXzvrbWmObP16oTr9gi1W2GwF0ZyQIHNqgVWJXF8Kkqr08w==
X-Received: by 2002:a2e:8003:: with SMTP id j3mr11613775ljg.17.1551730476691;
        Mon, 04 Mar 2019 12:14:36 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id m21sm1670242ljc.11.2019.03.04.12.14.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 04 Mar 2019 12:14:36 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcs404-evb: Change the compatible to distinguish platforms
Date:   Mon,  4 Mar 2019 21:14:24 +0100
Message-Id: <20190304201424.16951-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Khasim Syed Mohammed <khasim.mohammed@linaro.org>

The compatible flag should be different for each board to match
with the dtb and to let the bootloader pick the appropriate dtb.

Signed-off-by: Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts | 3 ++-
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
index 2c14903d808e..937eb4555ffe 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
@@ -7,5 +7,6 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. QCS404 EVB 1000";
-	compatible = "qcom,qcs404-evb";
+	compatible = "qcom,qcs404-evb-1000", "qcom,qcs404-evb",
+		     "qcom,qcs404";
 };
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
index 11269ad3de0d..da4ac896b56f 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
@@ -7,5 +7,6 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. QCS404 EVB 4000";
-	compatible = "qcom,qcs404-evb";
+	compatible = "qcom,qcs404-evb-4000", "qcom,qcs404-evb",
+		     "qcom,qcs404";
 };
-- 
2.20.1

