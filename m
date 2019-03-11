Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0733C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916F42075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="e35+0hfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfCKPDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:03:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45468 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCKPDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:03:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id 125so4225141pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRsN4/xf8NDRNF3fBDlFEKVlusjxUG54otEp2OGoHtk=;
        b=e35+0hfd1N4Xe1tMiojhWAEnf5EkLPJKxuFvfvPoFUpqJ0sxfYhPFZR5ITOrlW6O8J
         X6R/s8xVK75Ro7K0QLCJv3OAIF9a/keeemb3yzokqSxIHFCNYE4pJ02BIhRahFssutUf
         7fWTYx5XsS9HE37WMd+mNWZNJmBWbI13Fe6GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRsN4/xf8NDRNF3fBDlFEKVlusjxUG54otEp2OGoHtk=;
        b=oAp1l5b3/IMzZvIrn4zktKupVkAlP1YV3d1rA+hyo1QTGGgVyPw6O93FiJfrN/wobN
         LV5u2cYDtVOmh40jI/w7YKB8ytJKJLgQollZki9d1ld6BBR7iHoRXMFy+VGCBY60SHRA
         9APbHUHUHLm1jMkfA92XxqPsotTerjHSip0FnODvzFV9XPhnFnHi9yljWy4nJvYgrDha
         7IHXXlMwxeUYVGskuKY6lLlNlAa/S0YO8CJzBt4gZAIqmLfJWtRArfROVM8N2Y8n4o4t
         rz0mDAR0CmSAmZ0dd9jSVZx+hIip0A7WfMaLcbm9ZrucM8TyOPG01urxawQUEQGVWLqJ
         e4jw==
X-Gm-Message-State: APjAAAXqCNt3T8Lj3AVVxTcHZhuMWnJPuo3uwUQP5iOr75FdQSWaKfjd
        +oQ9YVhKhaVEOoi675SN/psZ4Q==
X-Google-Smtp-Source: APXvYqw/vKymQuvj9QfqJjvC0hOBjv/TSSYLzHYDnu7emfKWXNBkVxsCTnaVrglO5JSaQy8hGmH41g==
X-Received: by 2002:a62:12d9:: with SMTP id 86mr32883128pfs.214.1552316632713;
        Mon, 11 Mar 2019 08:03:52 -0700 (PDT)
Received: from localhost.localdomain ([183.82.224.199])
        by smtp.gmail.com with ESMTPSA id x5sm7594531pgp.68.2019.03.11.08.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 08:03:52 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Akash Gajjar <akash@openedev.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: rk3399: rock960: Add 12V DCIN regulator
Date:   Mon, 11 Mar 2019 20:33:31 +0530
Message-Id: <20190311150332.19492-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190311150332.19492-1-jagan@amarulasolutions.com>
References: <20190311150332.19492-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12V DCIN regulator is root source supply for the rest of regulators
in Rock960 power diagram.

Add support for it and attach same to supply vcc5v0_sys.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Akash Gajjar <akash@openedev.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index a268ec9f6b5e..68ca3bf9ea2f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -18,6 +18,15 @@
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
 
+	vcc12v_dcin: vcc12v-dcin {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vcc1v8_s0: vcc1v8-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s0";
@@ -32,6 +41,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vcc3v3_sys: vcc3v3-sys {
-- 
2.18.0.321.gffc6fa0e3

