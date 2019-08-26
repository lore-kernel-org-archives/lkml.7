Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78856C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFCD21852
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiPY2VmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbfHZQsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:48:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36199 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733180AbfHZQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:48:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so16004357wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aBjlsqiqqTgtzhykCGPDbSLi9lpwGSk1XF7w3yerKo=;
        b=WiPY2VmOXE2RfOnc7RuUSWUISdyh0kDQACH6it3uiL+kBd9CDRojW1+O52q/0G/GcP
         D7svA43QS+VHwNxAcKEEsbwZTbgyPcbqmAd0TK5Zu8K2tQf+svofB6BtYgbtRArhefVy
         ykf1eE6i++k/AqZIYazKoYNOwaEwTLci5TlsC2cBZl05TASDWrv71e/Wb7o3/oQ55mPR
         Gc3j5GF1+FuGGHmJV4CddZpZV7zLvH6ACHCgZkwN9I64kPjqvbXnZ+sANkkq4JwBT0gL
         SS5X1mP2pHHz6BXEf2cPi+PSeznAFwkEFR32mcpmXGDZAgG1y3cj71u+SUu3jZRXFGLc
         UbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aBjlsqiqqTgtzhykCGPDbSLi9lpwGSk1XF7w3yerKo=;
        b=iBM3PMF7F1F6tUzgH3hItMWw+TLjcMvX9OEULuBnxpUyzkwt8Z+Kj9kKOJdgGO9cny
         HpE1aJUUtRQQ1+jH24agKaGVUL0JysJFr8H/PbB7+tUox/TQ722sPwytnM66nZAoPUG0
         L/1+WRIM/Obw/Hq1qBH48ufHYvrIG14DicsNLSK5Ps3TgH95ot37CXXRWKf0wvysmWW4
         3Zct4AkbT5OaDxoGMiQJEbs9QqaFpmSPEAKPq1UpmdnvWJYhYPWS/YKmqmoBRQYkPIy9
         CRsfCjsO02wr9d79tROVF+c8ED4kCnvdK39vSYWr56QDe6ONQQyHoBlyFvPdosvOgBzw
         lnFA==
X-Gm-Message-State: APjAAAWQm1C0yF6ip5GY8WC+/NmL3V0FX+aUacLNzUJNK/GduLIavpV8
        0d3kYKeF6VPqeWbGhMDInwwYVA==
X-Google-Smtp-Source: APXvYqw3p4P3r0H+9quDr52MsyRO8FZmUmK1/r9o83Uq5Q16H5ZoPaWVLV8HDV6+oKSknAjuK5OvOw==
X-Received: by 2002:adf:cd11:: with SMTP id w17mr20629210wrm.297.1566838092355;
        Mon, 26 Aug 2019 09:48:12 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id o14sm21800076wrg.64.2019.08.26.09.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 09:48:11 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com
Cc:     niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: qcom: qcs404: Add HFPLL node
Date:   Mon, 26 Aug 2019 18:48:04 +0200
Message-Id: <20190826164807.7028-3-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826164807.7028-1-jorge.ramirez-ortiz@linaro.org>
References: <20190826164807.7028-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high frequency pll functionality is required to enable CPU
frequency scaling operation.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index a97eeb4569c0..75ea356a3fb0 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -869,6 +869,15 @@
 			#mbox-cells = <1>;
 		};
 
+		apcs_hfpll: clock-controller@b016000 {
+			compatible = "qcom,hfpll";
+			reg = <0x0b016000 0x30>;
+			#clock-cells = <0>;
+			clock-output-names = "apcs_hfpll";
+			clocks = <&xo_board>;
+			clock-names = "xo";
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.22.0

