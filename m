Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A089C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A7220656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2Wyve+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgAHUyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:54:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52778 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgAHUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so419736wmc.2;
        Wed, 08 Jan 2020 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FkAincxU/WJ7jOpQKMPlD5I4b01ffq84HO5Ml3sTj2c=;
        b=j2Wyve+5xk5Ov/0MKJBp0yTzWvnwBPmz5aL4zgsz/toTWaQE4FmCBO5aOE75VekrVx
         Krl0GTcgGv3bTnu91YJEmyZJkwfLcrKKuYI3UC2hEN5Liym58QmqPpOO5HDf6oHQgcXu
         D8iHhi0G7sQPBZjcqsYfsdWJAqsT42T08eZCqm1JTzvcE8IjzFs/iDYDCn91TyBzKfTf
         8mu6luihXQekKd4jzRESrQhX+TfEl+UeYXdYX6P52L7M+G/RThnjRfWY6X5Bwi36hfQ+
         FneyV4NFNDGH3lF9nw81DEK7+wsuF96u6+/VK/2aFwRQcGXaCQ0cnJSU6iHw9uBtoEOd
         H62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FkAincxU/WJ7jOpQKMPlD5I4b01ffq84HO5Ml3sTj2c=;
        b=pth3wabN5co+yCRC+N2XhOXbSHy5WDQ8a+PiZRUmzgsxRfkPS4aFPCFsgxbNZlAgyz
         TjHb7N2UnWuT68BzSZLUqNweObDGHq4duy+ejuokJIZY9OJWUNAEWeTBZQ7ncnaAOIoV
         ZU9zvafhSQxQ8gJjU7EYa+4ho3Q/i5vj2QudjELAqjKMAOL6vJNVd+W2YAnKVwu2KZh8
         PLdltk/xXyiaR0zmMN3Lbpap4BHIaXoeh6FFdw8Q6JBN9BkJwc8E0lgWi6GF+5+kjH9f
         9BLXCsXp0YaPFghgCxZ1y1gcgRkWVWuKk8QC61FOhragZArtzqbJ3DuXcEuhY9mch0Vk
         9BBg==
X-Gm-Message-State: APjAAAU0XFl03CJwwab/nLVuj2y3tHizPd0oXupWnaqHHZtQgreu5+NR
        aWLU4QcNbJCWC1gbUZwHVgk=
X-Google-Smtp-Source: APXvYqzVU6rte1v9V8nFFsc12GcEZAAxNc/vdUN0yEHJsTOtUlwZm6CkSPoIPzCh5PnqJKcAUpyCoQ==
X-Received: by 2002:a05:600c:244:: with SMTP id 4mr580221wmj.40.1578516835928;
        Wed, 08 Jan 2020 12:53:55 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:55 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 09/10] arm64: dts: rockchip: add nandc node for rk3368
Date:   Wed,  8 Jan 2020 21:53:37 +0100
Message-Id: <20200108205338.11369-10-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200108205338.11369-1-jbx6244@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyifeng <zyf@rock-chips.com>

Add nandc node for rk3368.

Signed-off-by: Zhaoyifeng <zyf@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index fd8618801..7dff2e221 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -25,6 +25,7 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		nandc0 = &nandc0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -508,6 +509,17 @@
 		status = "disabled";
 	};
 
+	nandc0: nand-controller@ff400000 {
+		compatible = "rockchip,nandc-v6";
+		reg = <0x0 0xff400000 0x0 0x4000>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_NANDC0>, <&cru HCLK_NANDC0>;
+		clock-names = "clk_nandc", "hclk_nandc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb@ff500000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xff500000 0x0 0x100>;
-- 
2.11.0

