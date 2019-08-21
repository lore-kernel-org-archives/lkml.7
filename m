Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF067C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C422F2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMojcc0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfHUMun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:50:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39412 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfHUMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:50:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so2019246wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1ZeBH6k7hXHTFCxcBeavggaz5+YUTkL68fy29AXhgQ=;
        b=sMojcc0WLz/UbOqVUepBFozrnGHOb2W4rwo0PDyUz4x/IGrtIQFqEBmuSNCwq47KOr
         y1/moqXT8NaOlWk1R6Vp1yEmOjmbf2X+eB93pV+7bL50mHBOCxT/4+8ubYLz/zE4iAXR
         3l8zAFhwXp8eDj5BzNi3bUsM7ztUfdqhC50uDBb6/rKBtXELxx8WOtOWRDNFxITGcnjH
         y0KaAA89zGlSGZMAAZK29rGGA6Jaz39g0UslMxBW3PhSmpOgzwXU4IdcGc7gjsDp7B1p
         x/VbCOri4Vcqi36+tTuRB+jCrKIAnwEYanNqodio3Cm+A/yy78OPr0HmJkXRwwt4XFQq
         czlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1ZeBH6k7hXHTFCxcBeavggaz5+YUTkL68fy29AXhgQ=;
        b=nbla9lQ0SRYxw+J4nd4AXTEGWWoWs5wM2e7IKnFzi/GgHpY1L3uWZeIVetZCDHYoxk
         7uwMQMyW51FQq+Fj1qcLSqFtivOSFhZcff8oscVLosUN+i/8jPAI+kos5p4qPbB9cnhb
         aov5FHJIwEODOQFNyH9p/pGTDh4raMkrYOzxsdMDCsOypGgIcUwo/RdGGZo1+/P7xc0L
         jH4Q1K+97Hdd2TumghV+iffYx4q/HGRr4fvihqnBX103ilQsVPKDiPw7GzmrimETV80y
         sP1aICMiPUq/9RB/11KYtAtPi+cRzMpRSGZ/9CvrAVLN2qAvUDfMPcyjqJFXDpS+fI/e
         zfTg==
X-Gm-Message-State: APjAAAXcnr73VecscR89y2RVs25Ccscsv470hiHXWMNCCYzbWp0weWfH
        LlWZTVWQq2gCVZcAlBjT1evIBQ==
X-Google-Smtp-Source: APXvYqzbpniP6/hX5IuqfoWXg2mDNQNg9FKJhXLse3/XokYGAy4A992gHe2IUNjAEDot+PyYABhIvQ==
X-Received: by 2002:a05:600c:114e:: with SMTP id z14mr5741330wmz.161.1566391841270;
        Wed, 21 Aug 2019 05:50:41 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id x20sm48439471wrg.10.2019.08.21.05.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 05:50:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: sdm845: add adsp and cdsp fastrpc nodes
Date:   Wed, 21 Aug 2019 13:50:35 +0100
Message-Id: <20190821125035.7616-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fastrpc compute context bank nodes to both cdsp and adsp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 74 ++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9be6acb0650e..9476e5f6e65f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -483,6 +483,25 @@
 			label = "lpass";
 			qcom,remote-pid = <2>;
 			mboxes = <&apss_shared 8>;
+			fastrpc {
+				compatible = "qcom,fastrpc";
+				qcom,glink-channels = "fastrpcglink-apps-dsp";
+				label = "adsp";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				compute-cb@3 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <3>;
+					iommus = <&apps_smmu 0x1823 0x0>;
+				};
+
+				compute-cb@4 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <4>;
+					iommus = <&apps_smmu 0x1824 0x0>;
+				};
+			};
 		};
 	};
 
@@ -512,6 +531,61 @@
 			label = "turing";
 			qcom,remote-pid = <5>;
 			mboxes = <&apss_shared 4>;
+			fastrpc {
+				compatible = "qcom,fastrpc";
+				qcom,glink-channels = "fastrpcglink-apps-dsp";
+				label = "cdsp";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				compute-cb@1 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <1>;
+					iommus = <&apps_smmu 0x1401 0x30>;
+				};
+
+				compute-cb@2 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <2>;
+					iommus = <&apps_smmu 0x1402 0x30>;
+				};
+
+				compute-cb@3 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <3>;
+					iommus = <&apps_smmu 0x1403 0x30>;
+				};
+
+				compute-cb@4 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <4>;
+					iommus = <&apps_smmu 0x1404 0x30>;
+				};
+
+				compute-cb@5 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <5>;
+					iommus = <&apps_smmu 0x1405 0x30>;
+				};
+
+				compute-cb@6 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <6>;
+					iommus = <&apps_smmu 0x1406 0x30>;
+				};
+
+				compute-cb@7 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <7>;
+					iommus = <&apps_smmu 0x1407 0x30>;
+				};
+
+				compute-cb@8 {
+					compatible = "qcom,fastrpc-compute-cb";
+					reg = <8>;
+					iommus = <&apps_smmu 0x1408 0x30>;
+				};
+			};
 		};
 	};
 
-- 
2.21.0

