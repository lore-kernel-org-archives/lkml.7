Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DFEC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F06F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Tokifnbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfDLIbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:31:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33431 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfDLIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:31:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so3755766wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPCsPseQBMIVb8GXk16egJLLB0THHe+Jag2FwI16saY=;
        b=TokifnblVN/AL2lzCyPRHQtwKEIcmZ61PGo1mGX/g1gY2mLrOFNjSrn+97PJAjmYVc
         wtDq4baeeX76+Pga/vON4FrS7Ta8irmkPwoVu6sl5LRqacxLx8o9ZWVshho4QapreWge
         BsfAZboFA4TKVBxrg7ufKsUV18ROpfbZm/POO9P3tb89i2nN5ieOHLqhG3ZJBEWzxg6v
         l67WLaEIKangD1YhknKxSxlSC9x6sXrxLoiFv9gZFigQpAvSbxO1Qn/Uiim1zJCsZKcI
         9CSmxhgr2HLeTMLw8AAlVwhIWj3gtojLpkgwhgSP8xE25qqBSkx1ScbA8X1ta8k7auFY
         ZHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPCsPseQBMIVb8GXk16egJLLB0THHe+Jag2FwI16saY=;
        b=Qb3Tg77/vuCuSo0pspF47QK/MzTqQ6HD6ENe+VzrM1oROR8tRAPdzkWnm8ILll3dBQ
         WhoJ0QNhC1OOuAcHcEdYj0Br2dCPf+EWNnQoYtpwJ/FUVTUSwERnOHVzRz8R2t5PLA3x
         dl/L8fGsgrudJnwH0Y/EusktlyHAbb4UMKIeZCvz15oZhaknh2nGcsajUt4leH2mA4I3
         I9RwBwHUhT2yFouDWEvk3aha+nXwDfY2bNwUGhSYHg6YyJUnRfSwUxOOQfA+2rFsfsIA
         mbpoN1bLQ1SLuGoBDIWqHB79tJs2iaZnBWW0FuvvTASTTlsf/eX4hfn6Ge0+3pQXboSM
         uRDg==
X-Gm-Message-State: APjAAAW3fUCxcR1uayLaw74rFxYMxkvVCIRLwpQhY8flh0PoQVWjsT3o
        ItgJUP/lSXc1WT/Wt0WkauH5oA==
X-Google-Smtp-Source: APXvYqwk+GMGNMXDefYCGmfvStfKE3+MTsKFrKBj7tmmZ6wsghwSENP/smaIkJroQtDFTcUgf9+apQ==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr9647469wmf.107.1555057872283;
        Fri, 12 Apr 2019 01:31:12 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w11sm116054702wre.15.2019.04.12.01.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 01:31:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, devicetree@vger.kernel.org
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/3] media: dt-bindings: media: meson-ao-cec: Add G12A AO-CEC-B Compatible
Date:   Fri, 12 Apr 2019 10:30:58 +0200
Message-Id: <20190412083100.4070-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412083100.4070-1-narmstrong@baylibre.com>
References: <20190412083100.4070-1-narmstrong@baylibre.com>
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

