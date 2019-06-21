Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC9C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5D2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ctO7hOId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfFUGKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:10:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45768 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfFUGKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:10:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so2450873plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 23:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xzioaCMOpZ9xQIhn8ZgZe3ezoCoNBuqDVW6enXrUWdI=;
        b=ctO7hOIdc1bJes6IfW+jMC3YvFiVSz45t+/wcP7nl8TQnixOumEuakVUduy54+D7vJ
         IdmjNUS/kNTfK7m3QaYMos3dbKCZRVWTfrJFCalZJNsrO1H1o/F7taY9HeBHZRisbRgf
         NjO/pdbW9rE9yRbiBiXHxrhud2JsVcugAKH+sg89svmnAcKH7fuQ0977VQ8x1qNV3YbE
         QthTsJiP1TuuIINMBQ3GV/EHrVuRwMj7SiMzRwunaN33CqyeO7qPgc4hmRVnbIFXtyop
         jL+FJiNe7n3XdJTacXjginoA/dKAYtF0soKm0PxiGhj2m7/NHDZNIXnV7rrH0Aosw6a0
         ZcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xzioaCMOpZ9xQIhn8ZgZe3ezoCoNBuqDVW6enXrUWdI=;
        b=LJ8+mB7pRam9x3H03UhWogeI9ePcWGDuXYwHWEJR3Qz/3UP/pMiz2gfwON9xMTH8as
         BeW/MKDaYKVttYnJbE8oMAiVw2XJkUC9hNTmqctgqOPXGwyWxT1x68pMrkjjre15UFrk
         ox2zlchGHbXAwwXrOjpHubcCSlFHY+3Dzty8aLIJbTwPi3h6Im2SXgWfvpdH57SLtfK5
         sEOIe81nghsCIIRRQdWcbZ8uHJueSPB18ArJ+FgpCI6aoUgxnnDnLpymS8EFwjZmFgiX
         m4E/MEeGq09U1CPqhcz9zRNSokrLCve+Mk/GxzKgoeHWC3kAmpZJjy0zqO262Tz+3R20
         tcBg==
X-Gm-Message-State: APjAAAXax4J0VpAFCqbS6lAX4x+9erWG4ZGWWlBmvZgeP+iA5C9s9Ag7
        kmnLExZg7a9RRIM0SN6sTMJgUA==
X-Google-Smtp-Source: APXvYqwNG2i/oMNUPGHebpRlmIa/kWkRWV3Ez3z7eWR9nYZaeTxX5aOLEn6fqpOIvgHIP0ZnhK13+w==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr77686806pls.261.1561097448592;
        Thu, 20 Jun 2019 23:10:48 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id x17sm1450053pgk.72.2019.06.20.23.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 23:10:47 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH] riscv: dts: Add DT node for SiFive FU540 Ethernet controller driver
Date:   Fri, 21 Jun 2019 11:40:22 +0530
Message-Id: <1561097422-25130-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561097422-25130-1-git-send-email-yash.shah@sifive.com>
References: <1561097422-25130-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 4e8fbde..584e737 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -225,5 +225,25 @@
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
+			local-mac-address = [00 00 00 00 00 00];
+			phy-mode = "gmii";
+			phy-handle = <&phy1>;
+			clock-names = "pclk", "hclk";
+			clocks = <&prci PRCI_CLK_GEMGXLPLL>,
+				 <&prci PRCI_CLK_GEMGXLPLL>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy1: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
 	};
 };
-- 
1.9.1

