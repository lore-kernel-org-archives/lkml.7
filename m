Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E6CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759F820673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bkZJOh+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFUWGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 18:06:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35946 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUWGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:06:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id f21so4004211pgi.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ryaqQTZCUF/hF6VaO5QT3dMTov2dUM5dS2MnCcID9K0=;
        b=bkZJOh+mMCVPn2xsEFJxgIc9ElvjsMXyto539DExGlvLKQCbEFYxF4Jd5vd9pOyLkR
         CjV5R5M89170qSsfAspvKmuBX6HMni74NRnyMt67MKlELohZ00koslBoKOQTAk8T3c7r
         Y9UBWw3sPchkhSZu2pX50693ihMbgRHvTpWtgjovbnAa0nIWZcVimE8RB9Q6XLJ42PnQ
         +xlBpQUuXhrTABFgdtVBBW3U4jqW4BIeWNRNdETOZ/QW1Fj9s9CLDjVNWIYSuVgxkXWK
         2j4QKgob0abP4Nspj5OVm0H74Oqa3n5eDNulAoiCVmSiZdLE1J7qooYddxZ6upU/MvtL
         +Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ryaqQTZCUF/hF6VaO5QT3dMTov2dUM5dS2MnCcID9K0=;
        b=KmJscEDo3uT9JSFrnraeZ9lYZtj6BKsmIVfzINFjhY0rIgAn2o11pFpjb7iQPJ3InM
         80dAWBMMg+ZjNoaguk+8NY5qyoV/gzyAJiq4ahMFg/VAm2DacvoukNM/5yxve2hlXeyv
         jRYK47JzF49SvZVS4JCxFA72YW+QGQ5DppboQDBZ/KsNBiheZGfK+X3ZutdFoxCx9fXr
         c+mMe0swIWPgmcTguyxKCbzBnJFfkOdtSxwOCDChpYb4ZPEnSGixeW55Gj1Vki16XVz1
         3rhS9tQkbyRzdo+SMfrVLE6NXQbGZtP4z6Qtnpqo1OtZYZYvAOIsko5P7liYRSSES4Z8
         EaCQ==
X-Gm-Message-State: APjAAAU4sQN6/t1iJenNzy2kAwh5ALGGKm1cBxuCEaIvK1X6XeVaEs0H
        C438qPz/5fu8FbgdMOAl9p2Pkg==
X-Google-Smtp-Source: APXvYqxHWwW/4SNCVZPUXPZki+bZvZo66exifsW1I8Pi10mlK+p5QI70JPDdcKnzJm3wapKHkDCOCA==
X-Received: by 2002:a63:4556:: with SMTP id u22mr14410988pgk.444.1561154814071;
        Fri, 21 Jun 2019 15:06:54 -0700 (PDT)
Received: from localhost ([38.98.37.134])
        by smtp.gmail.com with ESMTPSA id x7sm3439038pfm.82.2019.06.21.15.06.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:06:53 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:06:29 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
In-Reply-To: <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1906211504170.16518@viisi.sifive.com>
References: <1561114429-29612-1-git-send-email-yash.shah@sifive.com> <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Yash Shah wrote:

> DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Thanks, dropped the "reg-names" property from the patch, and queued the 
following updated version for v5.2-rc.


- Paul

From: Yash Shah <yash.shah@sifive.com>
Date: Fri, 21 Jun 2019 16:23:49 +0530
Subject: [PATCH] riscv: dts: Add DT node for SiFive FU540 Ethernet controller
 driver

DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Atish Patra <atish.patra@wdc.com>
[paul.walmsley@sifive.com: dropped the "reg-names" property, as it
 is not documented in the binding nor used in the driver]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi       | 16 ++++++++++++++++
 .../boot/dts/sifive/hifive-unleashed-a00.dts     |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 3c06ee4b2b29..83f40b00ab63 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -211,5 +211,21 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+		eth0: ethernet@10090000 {
+			compatible = "sifive,fu540-macb";
+			interrupt-parent = <&plic0>;
+			interrupts = <53>;
+			reg = <0x0 0x10090000 0x0 0x2000
+			       0x0 0x100a0000 0x0 0x1000>;
+			reg-names = "control";
+			status = "disabled";
+			local-mac-address = [00 00 00 00 00 00];
+			clock-names = "pclk", "hclk";
+			clocks = <&prci PRCI_CLK_GEMGXLPLL>,
+				 <&prci PRCI_CLK_GEMGXLPLL>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 	};
 };
diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 4da88707e28f..d783bf2c3507 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -63,3 +63,12 @@
 		disable-wp;
 	};
 };
+
+&eth0 {
+	status = "okay";
+	phy-mode = "gmii";
+	phy-handle = <&phy1>;
+	phy1: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
-- 
2.20.1

