Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B1C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D29A21479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RG1N9qyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGATwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:52:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45196 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfGATwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:52:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so7056680pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4Hod/x1MVNHO5bSEWzPdLsP26qI40u5ky94UaZs3Ok=;
        b=RG1N9qyoJc8Gm1mGDNB+WCBLXDNI+CswCxWxzW1nPlRqvvtqh6yqfRwMyDL1wIbxUW
         shUYjVAbOiNaLQqgic7RgUERn5Xd5mKsMxX+lsCCYm1/BDq5b1nJYhaZP37eyh0NxrCM
         SHkjoSPJM/HW4DBdT9aEbAFBc5TbMpKPJzkoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4Hod/x1MVNHO5bSEWzPdLsP26qI40u5ky94UaZs3Ok=;
        b=S0EdtPiLsHW3vr5o0hS+v4Ab3hbjWk97o6oLyWCHEm/8HKqbM4iqmFXYM2uFpcccc7
         MlBN5smcMIZvrWRpypuzTeU4vsJmUDhmEsLV39XImg4XvGNhpTfCGkNocHv3vAp9nex9
         Cq2h9nxETxWmydO2PSWM+hRyLAZ8sxHmuBaUDzcROAiV4I+gd9ykfXYkM6wq845pEtE7
         Oj48MNUiQno4/syx8O7ap76ZtFaB0L81WyP0ZQFQ1tRJmxc71sAFGdEG3FCatj4MPCnP
         urEobvDne0VpEGom8FWP8wvKtAxIE16mx1yYt1K5udlRDGWBVlr9MrVGJmik8Udqej7P
         pCqQ==
X-Gm-Message-State: APjAAAUseZZzCBstj3qQJILeo9WmtLZYhmjTams5rl/BPfS571quMDCZ
        eGf7FDzs/WKKFbXNa6th+7cDbw==
X-Google-Smtp-Source: APXvYqwQMv6Ji9rV5QoYqMLRG2WCQNLYyCsww96zbtRJtLi1AdVa1f2X6XL5FCL9ah8axoRlfhKodA==
X-Received: by 2002:a63:d0:: with SMTP id 199mr26577010pga.85.1562010750726;
        Mon, 01 Jul 2019 12:52:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v23sm11428812pff.185.2019.07.01.12.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 12:52:30 -0700 (PDT)
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
Subject: [PATCH 1/3] dt-bindings: net: Add bindings for Realtek PHYs
Date:   Mon,  1 Jul 2019 12:52:23 -0700
Message-Id: <20190701195225.120808-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 'realtek,enable-ssc' property to enable Spread Spectrum
Clocking (SSC) on Realtek PHYs that support it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../devicetree/bindings/net/realtek.txt       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek.txt

diff --git a/Documentation/devicetree/bindings/net/realtek.txt b/Documentation/devicetree/bindings/net/realtek.txt
new file mode 100644
index 000000000000..9fad97e7404f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek.txt
@@ -0,0 +1,21 @@
+Realtek PHY properties.
+
+This document describes properties of Realtek PHYs.
+
+Optional properties:
+- realtek,enable-ssc	Enable Spread Spectrum Clocking (SSC) on this port.
+			SSC is only available on some Realtek PHYs (e.g.
+			RTL8211E).
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
+		realtek,enable-ssc;
+	};
+};
-- 
2.22.0.410.gd8fdbe21b5-goog

