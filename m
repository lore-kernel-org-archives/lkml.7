Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8FBC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2794822D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k6ZdTrjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfHUJX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:23:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34499 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfHUJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:23:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so988875pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WXbOIV/PPnZXH5Oc2xbiQaU6gpzCgh5LD6kBid8zVsA=;
        b=k6ZdTrjOyX6/Zkg+v/eumDTkOMoX0cDzEk/+N+cSipXCBUg5Ewl+I/0l4ynujhqCze
         N4ohG9Ii1D8knSNi6L0Ec6olYpTIHsnQTKQwMgrD0IF4x91LPIAsOqVVYi3zOqB18jbH
         wrSyWUytB6HonPktkMHa2K9hd9dELtUJrBdEsxUVFu+JhUjBkXx9RENqcp2ncHHI06Hl
         DdL7PXSKO2tu5z9HmL2agE6Ktw1i6OMSMeOFUC2L/L1JrpISjas4YAoRJNS1rjsm6+v2
         CpjdbO2zACkVLoREccR+o0Y98SummfnKh258G9S0vOkRxtpKcp6oCjOfzn6NKlCJiHAP
         NV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WXbOIV/PPnZXH5Oc2xbiQaU6gpzCgh5LD6kBid8zVsA=;
        b=co+6K9kEpdDmiWVw/jxzoHS31wI43OBkMx/omOd32IpfZK4bLX4Lb6LgNaBXzsGmD7
         cM9skhcMUwHeUOK+rJboE1pAeRdlcSQStdH5PtaRTM0fMqOt3qFT2p9cpbVIJ0a4HgrF
         Dwc7b+SFwnFMK+eWzgnfPA6qVcAE2pWC0J8bdY1hwWk4wEUFkam+p8vpYLCM0oITEvOF
         qmWvnb02qAYjfK2xSAwqlzLGJUy0E+ylxFPASZHevsCICMiAdLukcsTccBfNWmH2VozP
         ZFIEgFoYSR84S/Px3tdeoTNzWQnG9HlnEi47Uof2THuPyT7XxTxviZOycUiHbHjU6YAt
         4/bw==
X-Gm-Message-State: APjAAAUXww3zN5X2cgUzLus50fbk1NA0UMHu5hjY7X+1rpto1ikndvAH
        zxaFip17m565ke4N0ypr+PmImw==
X-Google-Smtp-Source: APXvYqzunXgF31zpY1az1veH6ySJAQHsK32XBPJ//0IqOBTv828KbyMMDM8C1V6Iwrp5vB7Bf2/XWg==
X-Received: by 2002:a62:fb15:: with SMTP id x21mr35726157pfm.233.1566379437943;
        Wed, 21 Aug 2019 02:23:57 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id s7sm25721327pfb.138.2019.08.21.02.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 02:23:57 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, paul.walmsley@sifive.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, bmeng.cn@gmail.com,
        sagar.kadam@sifive.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH] riscv: dts: Add DT support for SiFive FU540 PWM driver
Date:   Wed, 21 Aug 2019 14:53:40 +0530
Message-Id: <1566379420-26762-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PWM DT node in SiFive FU540 soc-specific DT file.
Enable the PWM nodes in HiFive Unleashed board-specific DT file.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 19 +++++++++++++++++++
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 42b5ec2..bb422db 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -230,6 +230,25 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+		pwm0: pwm@10020000 {
+			compatible = "sifive,pwm0";
+			reg = <0x0 0x10020000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <42 43 44 45>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+		pwm1: pwm@10021000 {
+			compatible = "sifive,pwm0";
+			reg = <0x0 0x10021000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <46 47 48 49>;
+			reg-names = "control";
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
 
 	};
 };
diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 93d68cb..104d334 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -85,3 +85,11 @@
 		reg = <0>;
 	};
 };
+
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
-- 
1.9.1

