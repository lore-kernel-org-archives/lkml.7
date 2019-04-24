Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF0AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E281218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUKIcCWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfDXMDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:03:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43456 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfDXMDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:03:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so9275942pgu.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkf8vIpZ00F6RrSzW/UjkH840NiiAxYvHaDcdpXXCV8=;
        b=cUKIcCWZiemwHGyUgrTjHfbcTTzbkYg7rRUjqUBPF8evO2qQt3W9gtKvK+K9LxnqYh
         MJ/SqhAuVr/cgghG69GlI+BTeytOf9uYHemWoFRWO5O28dd0qhZEE/qO42yoSbw4JJgD
         +L2oMc7uGLfHDFLWcY8SHoiPvP6Q1Td0EMb0mDJsHGhywEZZ781nqOG7wkexOE+aZHU6
         z80UTO0DUyAioaVdTK5JJKbelb0uszqVhNfoZfv3yTgoSglBseQMWnDFxtWg82fDn06j
         1iBTIWaLRBfaH3NlfBNCnpDzFBMeQ52q2NlfoHb+1U4TqVUOb08l3A/gaHqK8XU/DACS
         dBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkf8vIpZ00F6RrSzW/UjkH840NiiAxYvHaDcdpXXCV8=;
        b=SUR4DEduPToUxI/KUzOL27kt7LmhuTH7QJ+9t3oKK5G6FpN7cytZ9jjGQ3SDNa/Ro8
         3r9jVhlniaK4woAB62rEqktvB8cF5/EFqMpXTB/3H9Si/rNKgV1QokmP/+B4AUdvpXLN
         RhkuL0hlAeFAZGvgi3vYLkcjtJ0bjClqd8wLbr9eI605F3DCVYMhyTo4QFEOx0FBwaXf
         bH8QsuCERWOId+sOqesidpJrcEv4ruESHdaAFS6JuU3ELAin18jQURIczGeUowMlgEPM
         j1l7dGZoQ+w50peogayD4W5oo1YaVdjLrQxsAFbplBKNgw3rkhnXUk+PRpXao/ur8PhX
         zj8w==
X-Gm-Message-State: APjAAAWr2yAjDVN5MttsMT96GzhBJiomYIvaPRqKRZ2GXMnJmRCs121T
        1BL3C2YNCi+uzSmhyD59B7wa
X-Google-Smtp-Source: APXvYqwGhBkUFgLcjDpG0PNofbfFr54KqPvYWZ+DORjV1Tfj6rHh/b6ZM2FGxPrbtVisbbuI2Eecyw==
X-Received: by 2002:a63:5466:: with SMTP id e38mr30817372pgm.340.1556107412805;
        Wed, 24 Apr 2019 05:03:32 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:711:bac8:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id j22sm25870840pfn.129.2019.04.24.05.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:03:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        linux-gpio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] arm64: dts: bitmain: Add UART pinctrl support for Sophon Edge
Date:   Wed, 24 Apr 2019 17:32:22 +0530
Message-Id: <20190424120224.22660-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl support for UARTs exposed on the Sophon Edge board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
index 6a3255597138..41da899963b2 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
+++ b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
@@ -34,17 +34,46 @@
 	};
 };
 
+&pinctrl {
+	pinctrl_uart0_default: pinctrl-uart0-default {
+		pinmux {
+			groups = "uart0_grp";
+			function = "uart0";
+		};
+	};
+
+	pinctrl_uart1_default: pinctrl-uart1-default {
+		pinmux {
+			groups = "uart1_grp";
+			function = "uart1";
+		};
+	};
+
+	pinctrl_uart2_default: pinctrl-uart2-default {
+		pinmux {
+			groups = "uart2_grp";
+			function = "uart2";
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 	clocks = <&uart_clk>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 &uart1 {
 	status = "okay";
 	clocks = <&uart_clk>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
 };
 
 &uart2 {
 	status = "okay";
 	clocks = <&uart_clk>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_default>;
 };
-- 
2.17.1

