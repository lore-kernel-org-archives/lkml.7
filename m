Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3573BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB92A20818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cIRUpNYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKLNUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:20:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43193 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfKLNUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:20:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id q5so6793642lfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKIBvY0x1yD+bD+aWV0JUrzlsZTikuF2aQL24o02BNY=;
        b=cIRUpNYVEGfnB4/ePtiAKp638xTywK5olGdZniL8LqHCeTTnZP6CM6JV2Ms3GrXRRk
         AqCiiJuz0X+oxu5/+deCblXULlE5Tkm2SG7JtZFx1fYH/5HPrn5ZW9YDBVfBzofobcwy
         k6zuthunUE9C/THVN4JviAwdYW2x0a0efbMF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKIBvY0x1yD+bD+aWV0JUrzlsZTikuF2aQL24o02BNY=;
        b=IqSRup/dLpU9zAVl9y9W1GfoJwwBOtRKAWnejTEpL+9SUZOprUqshsXh4ZNuBB2YR8
         wrxiAFiAjlW6YZTnnBxH4CJr6/WypODR1+2vK9i0kv9XhdSjTZuLCu6SEZ4AY2/gpFj0
         uxxJNahTG8LoI+c/ppqraWFzCY6Eg3eDZf36VmUQCJF5IbW3mwkjK72OgkfETEkTroeC
         ekXgDX7XElIkzM3PFu2K2oiouLUMi1TcLLq7c1d3EVAH63svm47GAk74evJs5CmU7Nui
         7ybP+h6j9twJXi3GEHXvK6f19YjuOhX7BvW8n7/Cbrw0YUHJXGjbZTmNnIy7B2URunVi
         ox2Q==
X-Gm-Message-State: APjAAAUFqvSNM+NUDF1f6DUeO5GVAEWbDdURqgoyOpEULoc57CAX9Uxo
        zLWASHdQTvc2mmKl+pzZ/cZ2EA==
X-Google-Smtp-Source: APXvYqx9C+B7+dzh+DExhVDk9zF6QbqRPQQJ9ESPQGY6lCuTE2m4r60+gVHrE26XPfc47YPvGhzkIQ==
X-Received: by 2002:ac2:5deb:: with SMTP id z11mr6866390lfq.35.1573564817247;
        Tue, 12 Nov 2019 05:20:17 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f20sm869050lfc.75.2019.11.12.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 05:20:16 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: ls1021a-tsn: Use interrupts for the SGMII PHYs
Date:   Tue, 12 Nov 2019 14:20:10 +0100
Message-Id: <20191112132010.18274-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191112132010.18274-1-linux@rasmusvillemoes.dk>
References: <20191112132010.18274-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

On the LS1021A-TSN board, the 2 Atheros AR8031 PHYs for eth0 and eth1
have interrupt lines connected to the shared IRQ2_B LS1021A pin.

Switching to interrupts offloads the PHY library from the task of
polling the MDIO status and AN registers (1, 4, 5) every second.

Unfortunately, the BCM5464R quad PHY connected to the switch does not
appear to have an interrupt line routed to the SoC.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/arm/boot/dts/ls1021a-tsn.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-tsn.dts b/arch/arm/boot/dts/ls1021a-tsn.dts
index 5b7689094b70..135d36461af4 100644
--- a/arch/arm/boot/dts/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/ls1021a-tsn.dts
@@ -203,11 +203,15 @@
 	/* AR8031 */
 	sgmii_phy1: ethernet-phy@1 {
 		reg = <0x1>;
+		/* SGMII1_PHY_INT_B: connected to IRQ2, active low */
+		interrupts-extended = <&extirq 2 IRQ_TYPE_EDGE_FALLING>;
 	};
 
 	/* AR8031 */
 	sgmii_phy2: ethernet-phy@2 {
 		reg = <0x2>;
+		/* SGMII2_PHY_INT_B: connected to IRQ2, active low */
+		interrupts-extended = <&extirq 2 IRQ_TYPE_EDGE_FALLING>;
 	};
 
 	/* BCM5464 quad PHY */
-- 
2.23.0

