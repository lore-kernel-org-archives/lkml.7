Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2278C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C136F2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LwQ+7zDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404197AbfGHT0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:26:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38044 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfGHTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:25:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so8071825pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MaGzZisdYBBgFX/QuRcqVi/VI5GsRgwFYphjBCtTHs0=;
        b=LwQ+7zDaMDpO5piJbvIq8JbtbV72vHpBAwq3IFau8WlEoUnxJ+WP7+9VrBVGl+5uN4
         J+Ar+i53NQMiECyGyGjjJI35+J4wzNYAmWEhijO3gZurm/2WvoDHY0H8W1OIEOXs0/OI
         bI5bj6duTAH31k3iVODuW8sPlqBdnfdadfG5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MaGzZisdYBBgFX/QuRcqVi/VI5GsRgwFYphjBCtTHs0=;
        b=el6Zx2aBaZVMriiNG0I+PI9X6ALL45v3XhJX+yzqdzAKZURGLcy1tbysp9rb6wINsp
         jXHYxiDVWZRXCLx7TuJHZcxXBjPKvHsmWqHcMN1BEjcgHnIvA9rHAV+x9+1HAn/8sP76
         2Xl5dTajqBHD4EUY58cI5Ulkpk/vSOd5j2bvASLn0SzQyf+ZtZgpsIft/cdyYJrditK0
         +/KG0+rLOgxeIl14jAIzOdv1Crx17mYXkiEgzGIjVtLU9RaO9CW2kSiD3UlOtuLwj9w4
         0mKqIKUKRAXTB4kcxBzxrXtJOijnSCWvjOFWpe6jrlL+/MrfMXm39HEVN7F/iDcSiDvF
         AKNA==
X-Gm-Message-State: APjAAAWLAHODAgtlICDQ224bPm4vn70Gsif5N3+opvrs9GREAaBgyXKS
        8MK3/cexEYnA32ZEwAJ2Czkoww==
X-Google-Smtp-Source: APXvYqxcCcLYcn/x8D50rn/vmkXY7YFkvL0a3L/ogSHSleiZNJEF9oD7to8kU4B1bDy6uEs49/LGuA==
X-Received: by 2002:a63:f4e:: with SMTP id 14mr26032375pgp.58.1562613911655;
        Mon, 08 Jul 2019 12:25:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v184sm19032424pfb.82.2019.07.08.12.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:25:11 -0700 (PDT)
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
Subject: [PATCH v3 1/7] dt-bindings: net: Add bindings for Realtek PHYs
Date:   Mon,  8 Jul 2019 12:24:53 -0700
Message-Id: <20190708192459.187984-2-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708192459.187984-1-mka@chromium.org>
References: <20190708192459.187984-1-mka@chromium.org>
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
TODO: adapt PHY core to deal with optional compatible strings

Changes in v3:
- added entry for compatible string
- added compatible string to example
- mention that the new property is only available for RTL8211E

Changes in v2:
- document 'realtek,eee-led-mode-disable' instead of
  'realtek,enable-ssc' in the initial version
---
 .../devicetree/bindings/net/realtek.txt       | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek.txt

diff --git a/Documentation/devicetree/bindings/net/realtek.txt b/Documentation/devicetree/bindings/net/realtek.txt
new file mode 100644
index 000000000000..db0333f23fec
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek.txt
@@ -0,0 +1,31 @@
+Realtek PHY properties.
+
+This document describes properties of Realtek PHYs.
+
+Optional properties:
+- compatible: should be one of the following:
+  "realtek,rtl8201cp", "realtek,rtl8201f", "realtek,rtl8211",
+  "realtek,rtl8211b", "realtek,rtl8211c", "realtek,rtl8211dn",
+  "realtek,rtl8211e", "realtek,rtl8211f", "rtl8366rb"
+
+  the property is required if any of the properties are specified that
+  are only supported for certain Realtek PHYs.
+
+- realtek,eee-led-mode-disable: Disable EEE LED mode on this port.
+
+  Only supported for "realtek,rtl8211e".
+
+
+Example:
+
+mdio0 {
+	compatible = "snps,dwmac-mdio";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ethphy: ethernet-phy@1 {
+		compatible = "realtek,rtl8211e";
+		reg = <1>;
+		realtek,eee-led-mode-disable;
+	};
+};
-- 
2.22.0.410.gd8fdbe21b5-goog

