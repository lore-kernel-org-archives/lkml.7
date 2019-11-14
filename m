Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ABFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10152070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WOUcLW3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKNLDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:03:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35548 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfKNLDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:03:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id r7so6217742ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 03:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jb+MOMLuIdaHgEwx11sXFvRMBqWhHSyGkvnIDPsupdw=;
        b=WOUcLW3G2Iayeuu5sPm24T439/72x+v6kvdOeZ3yyOFnInpWwaMAAiMlvEh+zz1v99
         KB41QGiNZmpNupPI2zSDjYAUMw+jOuNTtO6FDm4F9YE1ldnhegAL+Omp0xYCregSGy+S
         Zq9g75zHJ0vatkL7Y7LxTzPd5/s0ZaJslKRZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jb+MOMLuIdaHgEwx11sXFvRMBqWhHSyGkvnIDPsupdw=;
        b=ahIMCBGJHY3rSqsW5MdZpMGr+v5jqiGeOmmbKvPkLSw+LaRVh6pjGiVFuhBvCz7AjU
         Ma0tib67M7/20jJ6f1j2XWflYeP/GoUAPOF9HvrQL5WJ9JulRakfrrPILEuOMEB01LQc
         /o6D/upOo0pkTyZrxn4oKmDs1gYWxWuhA4/iX9cZns8EIE5PohTOEsdP/0hun0ht50Jv
         6XEHCRNHLn5FBqL8ZCmJcdfBGGUqhpHQydKurWirru/t+kvRYe1uLxz6vz0C8FlYFmQn
         wnlbShR9i2GjixBifwe2BLMyyisoi8z0lBgdjyXo4hLtZ/3Vzh3rSCAuuQd0/RCMJOoV
         N9DA==
X-Gm-Message-State: APjAAAVd9CDAUR0KlsKQYWQWnlWi8kH8i3kDvUxgtaVAiVOJOnqEoZQP
        OyibAyvY4RPMLVDBguQEmAi9cA==
X-Google-Smtp-Source: APXvYqyjNPi9tG3t/0IsBhpN6J0yN3A7dgHIGn4FZvEHTpjYDUeeXcxIhq+h6bgnCPrbA2iTYR8Fgw==
X-Received: by 2002:a2e:7307:: with SMTP id o7mr6253561ljc.10.1573729379406;
        Thu, 14 Nov 2019 03:02:59 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x5sm2498795lfg.71.2019.11.14.03.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 03:02:59 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Marc Zyngier <maz@kernel.org>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: ls1021a-tsn: Use interrupts for the SGMII PHYs
Date:   Thu, 14 Nov 2019 12:02:53 +0100
Message-Id: <20191114110254.32171-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191114110254.32171-1-linux@rasmusvillemoes.dk>
References: <20191114110254.32171-1-linux@rasmusvillemoes.dk>
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
index 5b7689094b70..9d8f0c2a8aba 100644
--- a/arch/arm/boot/dts/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/ls1021a-tsn.dts
@@ -203,11 +203,15 @@
 	/* AR8031 */
 	sgmii_phy1: ethernet-phy@1 {
 		reg = <0x1>;
+		/* SGMII1_PHY_INT_B: connected to IRQ2, active low */
+		interrupts-extended = <&extirq 2 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	/* AR8031 */
 	sgmii_phy2: ethernet-phy@2 {
 		reg = <0x2>;
+		/* SGMII2_PHY_INT_B: connected to IRQ2, active low */
+		interrupts-extended = <&extirq 2 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	/* BCM5464 quad PHY */
-- 
2.23.0

