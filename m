Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F71FC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB021473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GsOUHEkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDHMSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:18:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39542 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfDHMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:18:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so14447537wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPCsPseQBMIVb8GXk16egJLLB0THHe+Jag2FwI16saY=;
        b=GsOUHEkgKUmpMV0FVrA2lW8sTwQgov5Qlw2IShucdpSrVtORe+Tdp0qCY8kNMrXiqM
         UcxRR4+ljsvh7ubYmA9yTpm3oC7+Et9xO/Bd3kJV9VvbwiMsb1/DCerUbV0BAkAFLxHk
         QTCzgv4vD4249gqUeadn4jCsWT+iA4fb3qiKAboSKqvseCSBHXpKsWwxHfmf2QF9eOOq
         yaD94ct997yZpqHhsfG0enQuiY+i8cesScDZyYhDFlLlk3ZgRouRp7i8t44H14l5nEWv
         NJPYsHeEexnOz4TrfnHVsvjxfWGuYqLDV9x9x0nyWrjADrgFqMCPh3+Yb+OqeSM8xcNQ
         D2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPCsPseQBMIVb8GXk16egJLLB0THHe+Jag2FwI16saY=;
        b=ExqVuaOolAGEjRDkPiwmmOzaSvRlsgXCVDU5lzcgSmlKCXCM3jyyCJmf5vOgin7Q9G
         wNeIX+O6Wue9l27IgU3nunbEcGE3S6sAPie7Y5+iECO24r6eetVlYHmcjHxkETnPcf0l
         IaP/O+HZw6hQOGT2bV/sFbMKzVJkx+QXdMxkUJYfs9l9RiZ4sERdFwnDhYYFGCnWL4lD
         VHBcbtc0qvw5JgPD2p0Z0Qo/JQXyIRi9Qtno9TMOIATLVQklsAIeIgXiBNiID9sguxTp
         fcAIr+M/DOi/rdwYaQmEYla5rC8Qokvdcnab4hDCUo0JQwcW77rRn/+1Qfv4VSCkOISs
         gOWA==
X-Gm-Message-State: APjAAAWya1fEv5DXsuW18nfxINxfW0CdpEZEY+qRMU+z/cNE0DoR+YYk
        XB6DOC+3dD14j7fJgtyInqcbPw==
X-Google-Smtp-Source: APXvYqzlps4FBMCEKeNxdqwjhf8OR5kgIWSeFcLdE5eWPVGGik79f/RubJkbQKGxK2pm7A3cSfw01w==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr17951855wme.111.1554725888769;
        Mon, 08 Apr 2019 05:18:08 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e1sm52865103wrw.66.2019.04.08.05.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 05:18:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] media: dt-bindings: media: meson-ao-cec: Add G12A AO-CEC-B Compatible
Date:   Mon,  8 Apr 2019 14:18:03 +0200
Message-Id: <20190408121805.2870-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408121805.2870-1-narmstrong@baylibre.com>
References: <20190408121805.2870-1-narmstrong@baylibre.com>
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

