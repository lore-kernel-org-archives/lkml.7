Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871DFC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6542086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6DmxOlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbfGHTZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:25:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41537 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391687AbfGHTZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:25:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so5093060pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5eHwBNuWYWKF1GupD4lDii6DsKsGEYAJZvTYM/KCqI=;
        b=g6DmxOlfjJavtQhzMxF93mSr+YoVsWfSuyZx1EJ62H9u6NIRhiIUo6rQbpJL0oyftP
         RVtP7lAuSo7E6rRmRJg94S5J3R/vu5pv1kgMpCqkXNEGCV0WHZvkY9PoO/kTHAWzCcxH
         vhRvNRkEsOzAHw0MhR0Y9OsFyaOruo1jmuQ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5eHwBNuWYWKF1GupD4lDii6DsKsGEYAJZvTYM/KCqI=;
        b=Psg7TdWVn1YrepWrcCjMO8S7kKxqruuZaXHdpLtLRouWjy3Y2uZeuxtIBAYM/fvdS7
         htBBaBcM9cIXS3KtLPLKmmnsKfWOUmuGqaPkbSN/WutqJTK5ONlNujmLyH6jQnBXTwp9
         tYA8Q2BDkOnAUt/qaz6EzfFfvTN2AnprRHhZC84aK19ab1yidBA7UPt1Ex/SqpI87YO1
         FX7X0K45x+re0fFe5WfGFT5R7hBLmWMnvi2sG9kP6XN+VqdVxNxkCFnpQ5E+V7Mg9eV5
         8Z7MlLnzRezDLUy1tAR4FphE9xgQWim/sJ/zTMq46GhcgxhkPYkOgDdFFxEnDeF6CFiu
         1EcA==
X-Gm-Message-State: APjAAAWCqTs+G16C/xrNAOlJwtNpqwd5vqgMhc9/Nxp+lmKB1GmxlgKz
        IcAGAZ0Lc6eKE/6f84t44wHyaw==
X-Google-Smtp-Source: APXvYqzfy0HVoxjXdQF/nkAhmrMgk9z+IbtHFWroP7aqxCr0POXhMb28WjmetIMRN/0+fXLRkz9HFw==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr26692509plz.191.1562613914916;
        Mon, 08 Jul 2019 12:25:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x65sm23185986pfd.139.2019.07.08.12.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:25:14 -0700 (PDT)
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
Subject: [PATCH v3 3/7] dt-bindings: net: realtek: Add property to enable SSC
Date:   Mon,  8 Jul 2019 12:24:55 -0700
Message-Id: <20190708192459.187984-4-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708192459.187984-1-mka@chromium.org>
References: <20190708192459.187984-1-mka@chromium.org>
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
Changes in v3:
- changed wording for supported PHY models

Changes in v2:
- patch added to the series (kind of, it already existed, but now
  the binding is created by another patch)
---
 Documentation/devicetree/bindings/net/realtek.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek.txt b/Documentation/devicetree/bindings/net/realtek.txt
index db0333f23fec..af2824664f08 100644
--- a/Documentation/devicetree/bindings/net/realtek.txt
+++ b/Documentation/devicetree/bindings/net/realtek.txt
@@ -15,6 +15,10 @@ Optional properties:
 
   Only supported for "realtek,rtl8211e".
 
+- realtek,enable-ssc : Enable Spread Spectrum Clocking (SSC) on this port.
+
+  Only supported for "realtek,rtl8211e".
+
 
 Example:
 
@@ -27,5 +31,6 @@ mdio0 {
 		compatible = "realtek,rtl8211e";
 		reg = <1>;
 		realtek,eee-led-mode-disable;
+		realtek,enable-ssc;
 	};
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

