Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AB0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB07E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkAOL4O/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfKYOZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:25:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44714 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfKYOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:25:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so10126436lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuFRcfNq3LsLJUbGBe/N0k0kxrqgC13hX5+2ejknKGs=;
        b=AkAOL4O//f/RtBY5VC03PxSWYUE6xfXln26RyI5bNloyd5gy7kJqQlMwwu91Oaz0ZO
         RHeLXkrD8E+/HVxzKXXpZ8Yg2m71+hIudIPVy9nlwgbwLaDUxhYOHoFMHeL5J/QYKI+O
         +1ko2kO8OHLBdd3Gn0NpIelexXRaE8FTXlGhEPWeqn7t3vTY0ogWRFyfyKBWX+P9Hunu
         /9y5p1pGDHOxWiwD0sklo209ARyQY1OjPi+FKaoCmMhR+SEa45qMXH9n2Ds335kHj/MU
         ioWhRFXJAjRiDvxzofqr3KDMrkX7UBPNRwXI7KnRUYWSK8Ypzqj38UNhhIIvXLnAHQfc
         2vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuFRcfNq3LsLJUbGBe/N0k0kxrqgC13hX5+2ejknKGs=;
        b=U65DfDLqulZfq0mhW2UzMzzp2VoIwqcKdt3W++1RAOTkdE0dSwqdeC2mZzQVUB+sRy
         ogeg0bv8rRInWmJxoCvXcTrB95WLCU7R9NJUVSPOxbhZ5Up3uQ/fiIl4TkKvkWcRislp
         vp8mgxsNT9IE8IA6qoTF2fJR3hIG8nHIDtetrmHH/34aSiJtXKg5GLN52Aw1uuk8xgfh
         H1zsaAtRrCnVYsZfPrG2Z41JahZFgft4g08YSOyutyjmsvzQKTDtlznHIcvcM4Hx2DPO
         10DRazt7LQp5XxxFpUmVvhxtI9Tuq97XF11VLd5rfEovVw5Pb5XTLdpsoOpvhk6IEc2s
         4U/Q==
X-Gm-Message-State: APjAAAXv+oXUlqyEmaWr4u6fwsdQE8p8h3cQX+c2C2uWLOFCpCXxI/se
        8aDm1bQB+5sYsYHM53OhX6Ssig==
X-Google-Smtp-Source: APXvYqzuq/eLmUxMrkGzcX3pUkJ6NfSsIbuDwa4XqpO40lHVmtRNc4qkwNjG1guC3iEzcehjjqVnkA==
X-Received: by 2002:ac2:5b0f:: with SMTP id v15mr10082682lfn.99.1574691916018;
        Mon, 25 Nov 2019 06:25:16 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id b28sm4595260ljp.9.2019.11.25.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:25:15 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] arm64: dts: qcom: qcs404: Add HFPLL node
Date:   Mon, 25 Nov 2019 15:25:07 +0100
Message-Id: <20191125142511.681149-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191125142511.681149-1-niklas.cassel@linaro.org>
References: <20191125142511.681149-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

The high frequency pll functionality is required to enable CPU
frequency scaling operation.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v1:
-None

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index f5f0c4c9cb16..78065fbb3626 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -904,6 +904,15 @@
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
 		watchdog@b017000 {
 			compatible = "qcom,kpss-wdt";
 			reg = <0x0b017000 0x1000>;
-- 
2.23.0

