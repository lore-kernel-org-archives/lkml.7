Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC87C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBAE208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406587AbfHIL35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:29:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40587 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfHIL34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:29:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so5307048wmj.5;
        Fri, 09 Aug 2019 04:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QG5jO2mAi9YEi6xTWeKObSZGdS/DmG9prlRGSofT6eU=;
        b=JCW1cUzHMDDw3G981ylfwRhD5DtZF6ENS/EWbl7wwxghjEMu/QOwokJ1KLPjkKYo8a
         8//7ek8udO3GfkSLvLpP4yZThl7jBbX4DY9UhphqneqOEZWcPD5u3lmCK54Ci1jUuuVl
         nJo4bLC+gl4CIdDQJJ7j367bX2kpZWppi/CbD4oPagHMaDaB7A/e6o81RuSnYGA9y+Ag
         OdQv5Tm2rus3A1F1uguCq3KBtZ+sp5UJa8ReTcsThjeQ4kQIaqRSQlEBd+vFdchMno3A
         r3AsSVAxwtde+StRd1xcwjt5CgouuuWo1T4UzoEtpYyvX44/ZpTFpthrpqn7ILxVXpNt
         Kotg==
X-Gm-Message-State: APjAAAV++1gJfh/0HhTE67VVO/bMGRUmv8vmfrRFoenIZs0JCtLS1HYr
        OWmdrdCPc0M7NE5hJaQaZ3fYSEvq/TnuHg==
X-Google-Smtp-Source: APXvYqzVtdJ4e4jbXN5HklPgNSdUOT9M9Sm9lH5Z+9ooz8GGEKAWv6ry521yYgkxOkipPxuW42j14g==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr10205495wme.172.1565350194681;
        Fri, 09 Aug 2019 04:29:54 -0700 (PDT)
Received: from tfsielt31850.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id y1sm3684889wma.32.2019.08.09.04.29.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 04:29:54 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx7d: cl-som-imx7: add compatible for phy
Date:   Fri,  9 Aug 2019 12:29:46 +0100
Message-Id: <20190809112946.28659-1-git@andred.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While not strictly needed as "ethernet-phy-ieee802.3-c22"
is assumed by default if not given explicitly, having
the compatible string here makes it more clear what
this is and which driver handles this - an Ethernet
phy attached to mdio, handled by of_mdio.c

Signed-off-by: André Draszik <git@andred.net>
CC: Ilya Ledvich <ilya@compulab.co.il>
CC: Igor Grinberg <grinberg@compulab.co.il>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: NXP Linux Team <linux-imx@nxp.com>
CC: devicetree@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 62d5e9a4a781..7646284e13a7 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -54,10 +54,12 @@
 		#size-cells = <0>;
 
 		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 		};
 
 		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
 		};
 	};
-- 
2.20.1

