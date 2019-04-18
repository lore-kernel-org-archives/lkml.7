Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267D4C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B5920835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d+kP4iGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbfDRIiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:38:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42687 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRIiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:38:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so825324plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bVH6oZEWqWRwSE0/zky4AIHwuUMb+EYBfI1m7D47hvA=;
        b=d+kP4iGnPPsJH195CFKmLzM/4aHciSX+va5RvQIVQVtXjqO++AB09jw33FL1P6C1d7
         QvPHwGkGLQC3l571Bij0IfETek07nkzlBPn8nUyn1TTJFIZ77H925APPNFEy77dY1muG
         WoONfCG3bkLhFBJZNRKpJd+Dj17jfcSCnu4gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bVH6oZEWqWRwSE0/zky4AIHwuUMb+EYBfI1m7D47hvA=;
        b=owrOnqir5Kwg7QVvET7IXIDtuP8CRRfv7m1FOseEIHha+GyMSDeLYpx9Hi/BNf+ERh
         em93X1nBHElClO6fznAjIsPiHbioLqPAJHmptbQOecWiwe4GfBqidMbg0xijWEUvGE91
         pRn5yblLhjQ0/0x2AtBiCPO5Avx6do6p4hfooRjTnZQiVnEk68EqlFASBRvctZ9exBEk
         EC/afWWQGmgf2/5bmhW00DHDgg6/QmoDW+3VK+YxM6hI8++yULFbbPPBOO9bjgkBjjWl
         fXyTX6QTNyj91NfmGEQqoFPer/xKUQk6eTNVfqH3T0a6xSPUf1Tv6Ea0cDgjCIUScOqP
         mP4g==
X-Gm-Message-State: APjAAAV6oHTUug7/EzZA7NKh+4lKlkWujy/a9kqG0Jwc4XwKxTYaB7E0
        B58zrDHhLy5M7v/FnPJsD3jJnA==
X-Google-Smtp-Source: APXvYqxrA8AME7NKdzH/AFx+LJOTNrvdS7kT+oO5o/hApSLzlsh7JT2vIk+7hbp0s1EQqTigyEzXHg==
X-Received: by 2002:a17:902:b58e:: with SMTP id a14mr64799527pls.44.1555576702113;
        Thu, 18 Apr 2019 01:38:22 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id o81sm2075917pfa.156.2019.04.18.01.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 01:38:21 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/2] arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
Date:   Thu, 18 Apr 2019 14:08:12 +0530
Message-Id: <20190418083813.11776-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some camera modules have the SoC feeding a master clock to the sensor
instead of having a standalone crystal. This clock signal is generated
from the clock control unit and output from the CSI MCLK function of
pin PE1.

Add a pinmux setting for it for camera sensors to reference.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 6f27eb082429..6f4e00ec9c68 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -597,6 +597,11 @@
 				function = "csi";
 			};
 
+			csi_mclk_pin: csi-mclk {
+				pins = "PE1";
+				function = "csi";
+			};
+
 			i2c0_pins: i2c0-pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
-- 
2.18.0.321.gffc6fa0e3

