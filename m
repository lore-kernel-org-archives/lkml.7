Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7462CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4220A20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtONVZGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfDPQWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:22:33 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:52786 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbfDPQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:22:31 -0400
Received: by mail-qk1-f202.google.com with SMTP id x23so18304787qka.19
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NPvt7sSc1zkwaIBM5xgspuUUhdwpA/3SPScemFlYhns=;
        b=jtONVZGF4KZMsUVDVYcda4XXt6HI9EaWwWmnwfamxSnbgCRlY3WucXsN6EMdatspZE
         J4t1Sxd8Ptj70SNoEHyH0Fdlrqz8WaEq9BiYiWKNBAeWjKA8TlvLu5zM/W8Iu/rT33aI
         KmBSunX9M15SdKdBLiE3yvK+rb6qwbErHwYzW2P3ItZ+2+m63acWoeg0yAuWBkoiuif1
         k/wmW10+1zdQCArjIh6ED0W1HthShY/wE0ksFsthJnOtVCQIL6KP0FMgKRVNCOXIvCde
         ebK96VjpH+6YhaTa0aXdXjvMWW8c7tkFaReVcQK98b5Zq2/iuCAMTrJGd3Ae0pLFs61A
         RuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NPvt7sSc1zkwaIBM5xgspuUUhdwpA/3SPScemFlYhns=;
        b=tVeQ03qWOeMsVjmzauMsSXgUd35ROQQylVVBuoIiWwsS5jIsrfO5nI7wX+QaIa9JwM
         71pflhw/3rxFC+k/gnRbRwZHNrgYHQr14OE3Wt4snD49X7rH81pAPkfsRh40t6LdMOOo
         z16TWZllupVccyHQfVUi7IS/hpzSrWLLMwvsMCR7eFguLoxntDVqGlfNOQYYLsAWvz71
         iZkmxlVfCSzGZq4x1Ap8IoyQd8Oud7dy4lwQYM9AalqS/xS1FWXo4e5WnLDUhzUfpHYl
         QGjI+/R4iNMG42SGA7g/Vr33bDSWE1o+miuETphaHElYvisfKS24hpSJkl6OgZWv7VKB
         SDvA==
X-Gm-Message-State: APjAAAVeyWIogs0IZ7RanZwP13QpHgmgsQkTS3RmkMpRSJ7FZ7Rp5qMT
        /koxizFT/cKnKLY1SD9ogP9v0ak08IKA
X-Google-Smtp-Source: APXvYqz+p5jCEMyb5mCcnWCNrEdWPEIyNNVj/k1CwiFs3mip0KTJ/sOAQw4McYUj84e4RcEeyqtqXORwSDJz
X-Received: by 2002:ac8:8d4:: with SMTP id y20mr66951267qth.13.1555431750915;
 Tue, 16 Apr 2019 09:22:30 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:21:51 -0700
In-Reply-To: <20190416162150.150154-1-venture@google.com>
Message-Id: <20190416162150.150154-4-venture@google.com>
Mime-Version: 1.0
References: <20190416162150.150154-1-venture@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 3/3] ARM: dts: aspeed: zaius: fixed I2C bus numbers for pcie slots
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au
Cc:     Robert Lippert <rlippert@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Lippert <rlippert@google.com>

The change to include ibm-power9-cfam.dtsi resulted in a renumbering
of all of the I2C bus numbers behind the on-board muxes.  This breaks
some tools which have hardcoded the bus numbers.

Add device tree aliases for the I2C buses routed through the PCIe slots
so that they return to their former numbers before the cfam change.

Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 51265af622574..c12f89e042efc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -7,6 +7,14 @@
 	model = "Zaius BMC";
 	compatible = "ingrasys,zaius-bmc", "aspeed,ast2500";
 
+	aliases {
+		i2c15 = &i2cpcie0;
+		i2c16 = &i2cpcie1;
+		i2c17 = &i2cpcie2;
+		i2c19 = &i2cpcie3;
+		i2c20 = &i2cpcie4;
+	};
+
 	chosen {
 		stdout-path = &uart5;
 		bootargs = "console=ttyS4,115200 earlyprintk";
@@ -223,6 +231,27 @@
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		i2cpcie0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2cpcie1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2cpcie2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2ctpm: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 
 	/* MUX1 PCA9546A @71h
@@ -253,6 +282,17 @@
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		i2cpcie3: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2cpcie4: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
 	};
 
 	/* MUX1 PCA9546A @71h
-- 
2.21.0.392.gf8f6787159e-goog

