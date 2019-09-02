Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D3C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A303721897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAIvwr6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfIBFt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 01:49:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45138 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBFt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 01:49:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id x3so1015061plr.12;
        Sun, 01 Sep 2019 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikV6lemlNYdFpEeGQSYqb+rV/obqc+rmipJrPne+LAs=;
        b=MAIvwr6/8HrrYhQuIYpsBU0n0QRmouCFyUCeHgTs67GyIPGWan6FxktGY+LZYjzIvu
         PrwVa318B6qjN5QnsMN0pRREoNTd895ozDy4yXB0TRykCShhlG7ml/M97o3vFnkMHyfC
         qZigYBE9JwJvzsHoDP6hgvcxSlNKIRfUWz5Isd33sWtUVCNdePIxgSMqXjodFkzk5kdo
         94fDNtxSV88R7FTXr4MPwvAPyj2mxMylpSj34ORawW3vXxOMocG5FkKe2DQQSWvvJURU
         r2B5H7aRmLlE6TmP5yL7arlb9uTThbWFrJNIS7YDwbogQXUKL3Rj6Xj10xRta2FyZ2U0
         Ml2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikV6lemlNYdFpEeGQSYqb+rV/obqc+rmipJrPne+LAs=;
        b=o14V6ABGDFxWjrns9VYXeL8WH4R53Me2tS5w04TmtKgz87qAg2YCV2ZHhjrj/5CpUk
         lzzaqbUqLiO2+9f5mqp5BkiaXiJh4r0ltOvBB0aolYnN3Vh8cXiAqve7u4wJz0N7FAkK
         gvzQrppmla4d74vXO82RdUwA13SVMI9BZCBM4P7MJny29GbTTEXsJ4b8NUkOf1YQfemI
         1S7aUAN3aEYrgz+r54iqPamkB7P+57ecnYzmF4g7L/9nNyUs2d1BDePQcdbQADCL1gTU
         rAZnUxfqAo/o6EiQyRvkrZCsyXbQN9WAGRRbWss41WO4tCJJY9NiOkdBPFXX/Gylapsg
         Q0FA==
X-Gm-Message-State: APjAAAUceMkOsEPnvPJQBbwyge2JhZsU6gGHZQdtHlgkeD+JE01V94mH
        Op80ZLd8js9t7m7ZyZ+0QX0=
X-Google-Smtp-Source: APXvYqwmjDYBb+/h+lox38LRXgnKxFGbWgnCBcvK3a32iq8PnRmY1WQ3TIqaar+s+iJEVbDqoBGVeQ==
X-Received: by 2002:a17:902:7246:: with SMTP id c6mr339002pll.190.1567403396634;
        Sun, 01 Sep 2019 22:49:56 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id 136sm16533912pfz.123.2019.09.01.22.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 22:49:56 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv4-next 1/3] arm64: dts: meson: odroid-c2: p5v0 is the main 5V power input
Date:   Mon,  2 Sep 2019 05:49:33 +0000
Message-Id: <20190902054935.4899-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902054935.4899-1-linux.amoon@gmail.com>
References: <20190902054935.4899-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the schematic Monolithic Power Systems MP2161GJ-C499
supply a fixed output voltage of 5.0V. This supplies linked
to VDD_EE, HDMI_P5V0, USB_POWER, VCCK, VDDIO_AO1V8, VDDIO_AO3V3,
VDD3V3, DDR3_1V5 according to the schematics.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>

---
Rebased on linux-next.
Added Acked by Martin.
Fixed the commit message to add misssing VDDIO_AO3V3 and VDD3V3.
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 6039adda12ee..0cb5831d9daf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -50,6 +50,15 @@
 		};
 	};
 
+	p5v0: regulator-p5v0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 	tflash_vdd: regulator-tflash_vdd {
 		/*
 		 * signal name from schematics: TFLASH_VDD_EN
-- 
2.23.0

