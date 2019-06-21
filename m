Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD6C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8596320673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EkbAXsmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFUK5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:57:46 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35410 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfFUK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:57:46 -0400
Received: by mail-pg1-f173.google.com with SMTP id s27so3211073pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LfS7OaPkDmyWohtCv6+omHOKQ0iNU10OGK6bYTnhcSo=;
        b=EkbAXsmiKWaXo7lR4QUiVCL3Qlcv5VjgIRJ0aK6NFuKAuTyEiZcnI5vTp9lBKiydzN
         xC6cvtuwUV1tyZvDArgTgmcBgirg3MR79RamUeHI3xMVLq3/7R4M+MpAfyvVGEYeJgbB
         PgwRRsU2ZoNIary8F1SjsWrxcWSY9vgdB9LcSLnOPck0160+E3v24EbE6LFUfKbFe29l
         R4CRTdtb5UzyEfPhQsBfPQ+9AIlDmOJAaZh1qXb9rJbiVMWQEQijVf75CF4IUZ7OnKvH
         HyLmU0RoHIVMnqj5BScwaEgx/hRKR1sUx6u8RRqdgnfJLVulA4vv4axkwpc17aFOdJzk
         YJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LfS7OaPkDmyWohtCv6+omHOKQ0iNU10OGK6bYTnhcSo=;
        b=LxaW+jvJQu8ScqOUsh3Rkqp1WhWWI3YmjXGVKekyhsg4HYaN0bCs1GR38RMYC6aPnz
         2YxpKGBdjaTbkolsK3PgOxZSZIpNHVcJjlh31ut3rXRVGbnWNGQfJIX2UozQAvBKnpvI
         XIbMHn62Ao0sjcX8KHbw4MpnZyODghuvnkcaSO3zEf78DPvgpDSm84+Bj2Cu7ic+tZVQ
         7dfccexZAArgxWXFE2FSCWE7yxajFZFQMwBPr1r1m5WK1L3PfBN+xULVsPyNLTeQzkUk
         4cKMj2doctCsmF0kfwx0qX/LnuZT4KHkurziloDBmRAU80Ur/maWCUohLe1gXcqiFyfN
         G2nw==
X-Gm-Message-State: APjAAAUg/6s5mol3bFy6NsMwmp/xPAMcf3iY+lul0ynxKGQyY/0fRtRO
        CVm72ROR4bJL2M7Mt6WNgnpokg==
X-Google-Smtp-Source: APXvYqzyg4P7NwGYnubvr8F2/xiaWS2z04jXSX8kI2HlZUYsAEErfBxzBhb5mkAaVXVwDLS01pWL+Q==
X-Received: by 2002:a63:f817:: with SMTP id n23mr17900412pgh.35.1561114665299;
        Fri, 21 Jun 2019 03:57:45 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id q63sm3889442pfb.81.2019.06.21.03.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 03:57:44 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet controller driver
Date:   Fri, 21 Jun 2019 16:23:49 +0530
Message-Id: <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561114429-29612-1-git-send-email-yash.shah@sifive.com>
References: <1561114429-29612-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 16 ++++++++++++++++
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 4e8fbde..c53b4ea 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -225,5 +225,21 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+		eth0: ethernet@10090000 {
+			compatible = "sifive,fu540-macb";
+			interrupt-parent = <&plic0>;
+			interrupts = <53>;
+			reg = <0x0 0x10090000 0x0 0x2000
+			       0x0 0x100a0000 0x0 0x1000>;
+			reg-names = "control";
+			status = "disabled";
+			local-mac-address = [00 00 00 00 00 00];
+			clock-names = "pclk", "hclk";
+			clocks = <&prci PRCI_CLK_GEMGXLPLL>,
+				 <&prci PRCI_CLK_GEMGXLPLL>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 	};
 };
diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 4da8870..d783bf2 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -63,3 +63,12 @@
 		disable-wp;
 	};
 };
+
+&eth0 {
+	status = "okay";
+	phy-mode = "gmii";
+	phy-handle = <&phy1>;
+	phy1: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
-- 
1.9.1

