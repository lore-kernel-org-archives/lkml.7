Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E460C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169E9218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SBPe3IE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGCThc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:37:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37303 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:37:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so1769089plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQZ58FD/CMop10T7Gp1bzD+eWeahigYqOQwY2UyguU8=;
        b=SBPe3IE51/7ccubMHDlsTs11O7jUmvYCXQFNbE9FVfb49LtIoeT+lamCuOhFuBs2Oh
         Hpm6bDBdEmGVl3OXVsxoe/nrh9Lg/2IZATTZFWB2+lWtQrFbjycVF/q+j2XPnd8cdTyq
         Hj0UzTsvFWGfGVOi9VpYwZh2sTZ1//TQrbatw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQZ58FD/CMop10T7Gp1bzD+eWeahigYqOQwY2UyguU8=;
        b=neF9/RA9lBFxwAW1NEIDSLlpvPN9IHJhp1E4RXDeUpJ7ev6Pb7JZbp7tjrt7lNpO1a
         TvzE8BtkvRdK0dX3ZOHNvcyqUhBAW+dAuZp2FlYov/BI8YUkF/s59o4KITYgfY5i3QuA
         ij5qvQuEBWCruoyHtNz3uetEQ2rwuwfyWtCgk+JGHgalTu3DEWNpfcmYTj2QSQZaTZ3I
         gCOTacFKdWbLkpwNaCCVw7wfw0hcu/MaFo+w37tKST7Tx1xw6hq87gXUiMeXBJtqzTlM
         xvmecoCCKNhrlolSlNhaur3Vim9VsgTz7oLsy2sARQadwj+25QfIFWIKla4nQgnsIzUa
         TMDg==
X-Gm-Message-State: APjAAAXZIwyquNnRaoBbFz4c76uXGMclIkPS80KQgRp4wZqjadNRogXx
        l2wZKZIZFEvWi1MeOSvCY2M7Sl/vMDQ=
X-Google-Smtp-Source: APXvYqwettcIVbccD5RzpnI6VqVTrml29NMabd0/WlB/vXOclHQ2+VMYlYdocXXEbA3GVQufuQckyw==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr44437556plb.103.1562182651183;
        Wed, 03 Jul 2019 12:37:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q5sm3145126pgj.49.2019.07.03.12.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 12:37:30 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/7] dt-bindings: net: Add bindings for Realtek PHYs
Date:   Wed,  3 Jul 2019 12:37:18 -0700
Message-Id: <20190703193724.246854-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 'realtek,eee-led-mode-disable' property to disable EEE
LED mode on Realtek PHYs that support it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- document 'realtek,eee-led-mode-disable' instead of
  'realtek,enable-ssc' in the initial version
---
 .../devicetree/bindings/net/realtek.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek.txt

diff --git a/Documentation/devicetree/bindings/net/realtek.txt b/Documentation/devicetree/bindings/net/realtek.txt
new file mode 100644
index 000000000000..63f7002fa704
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek.txt
@@ -0,0 +1,19 @@
+Realtek PHY properties.
+
+This document describes properties of Realtek PHYs.
+
+Optional properties:
+- realtek,eee-led-mode-disable: Disable EEE LED mode on this port.
+
+Example:
+
+mdio0 {
+	compatible = "snps,dwmac-mdio";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ethphy: ethernet-phy@1 {
+		reg = <1>;
+		realtek,eee-led-mode-disable;
+	};
+};
-- 
2.22.0.410.gd8fdbe21b5-goog

