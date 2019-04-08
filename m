Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF140C282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC0A213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qvEN2oRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDHJYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:24:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32867 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDHJYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:24:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so14774113wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPCsPseQBMIVb8GXk16egJLLB0THHe+Jag2FwI16saY=;
        b=qvEN2oRQgComG5lR//4SvQh1FjsGSWFitCflprTZKiZh+VDlvJXWKvMHXNVcdlupc6
         bDD0t7ZHFhSwB8AIaOsdJSHaesz2bxWsj59L/4BnbMoJ2vQdFD/XC0ShuboPLkRmYbew
         2MLexCvte3WZWoOLEUxHyruM64+t+7shcRjcLvBHeVesRWCshPVaL8e6dMTNuajbfbVB
         tCkPFStH4K2rV0tN172ntcgvMEaAxBmF05/PPO1Tj+61xofFP13PZF5+0Ej3WR9206/K
         8uNqxZVZpBFFRXELOUBVkCBSgb3vXNV6ykzQFBzjEGS4Dh/XSo77ymBqhKc2enPdG/36
         HkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPCsPseQBMIVb8GXk16egJLLB0THHe+Jag2FwI16saY=;
        b=JY4CfnFJvO9mRUU9COkef7ugH6o6l/2Z1j+PufYkG/3qFVL42l5HzcLgQYMF8kB/Br
         cD8sdEZY0ThrW6YP1cSTgr9hSqj5x+nv8pN1/7zLV7aOCA5XmXxENZp194nW0TlatHlE
         8g+kTteOnyHGRLbSLX9HLMYc/bEptiJdmcl0rxo3gSkRuld6n8JrJn4Fts/HVMO8rMX1
         WuY/zQE3fxu2cxrblZiCbXpnIZna8xDLpCW/NqGKRCOJ6OlQwM+x93jk2YyOMhWrHXqO
         a9nmpbvcYZfB2AUyyJWt+A4WQVSXj6ShpPexGtnZUCORPJTG/XVBH7inlG5a6HnkAcb+
         LmLw==
X-Gm-Message-State: APjAAAWkeVh1vkbrq2PAVkhhpAXR3oghDbojc/ruQ2aJkK47eKjP987x
        aAQviEFz63AgzpNVVNlBCarygA==
X-Google-Smtp-Source: APXvYqyh+RjyNILu+ZNXnY+tI1tgWVBIV0m+jMHwWvqy9ryRmkLHkBY4lLRACJ87KlQqIMsdTDGKOA==
X-Received: by 2002:a1c:480b:: with SMTP id v11mr16590842wma.25.1554715444219;
        Mon, 08 Apr 2019 02:24:04 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j3sm70528221wre.51.2019.04.08.02.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:24:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] media: dt-bindings: media: meson-ao-cec: Add G12A AO-CEC-B Compatible
Date:   Mon,  8 Apr 2019 11:23:56 +0200
Message-Id: <20190408092358.25894-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408092358.25894-1-narmstrong@baylibre.com>
References: <20190408092358.25894-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A embeds a second CEC controller named AO-CEC-B, and
the other one is AO-CEC-A described by the current bindings.

The register interface is very close but the internal architecture
is totally different.

The other difference is the clock source, the AO-CEC-B takes the
"oscin", the Always-On Oscillator clock, as input and embeds a
dual-divider clock divider to provide the precise 32768Hz base
clock for CEC communication.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/meson-ao-cec.txt      | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/meson-ao-cec.txt b/Documentation/devicetree/bindings/media/meson-ao-cec.txt
index 8671bdb08080..c67fc41d4aa2 100644
--- a/Documentation/devicetree/bindings/media/meson-ao-cec.txt
+++ b/Documentation/devicetree/bindings/media/meson-ao-cec.txt
@@ -4,16 +4,23 @@ The Amlogic Meson AO-CEC module is present is Amlogic SoCs and its purpose is
 to handle communication between HDMI connected devices over the CEC bus.
 
 Required properties:
-  - compatible : value should be following
+  - compatible : value should be following depending on the SoC :
+	For GXBB, GXL, GXM and G12A (AO_CEC_A module) :
 	"amlogic,meson-gx-ao-cec"
+	For G12A (AO_CEC_B module) :
+	"amlogic,meson-g12a-ao-cec"
 
   - reg : Physical base address of the IP registers and length of memory
 	  mapped region.
 
   - interrupts : AO-CEC interrupt number to the CPU.
   - clocks : from common clock binding: handle to AO-CEC clock.
-  - clock-names : from common clock binding: must contain "core",
-		  corresponding to entry in the clocks property.
+  - clock-names : from common clock binding, must contain :
+		For GXBB, GXL, GXM and G12A (AO_CEC_A module) :
+		- "core"
+		For G12A (AO_CEC_B module) :
+		- "oscin"
+		corresponding to entry in the clocks property.
   - hdmi-phandle: phandle to the HDMI controller
 
 Example:
-- 
2.21.0

