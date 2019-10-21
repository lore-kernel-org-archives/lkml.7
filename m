Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB6CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344FA2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NDuJdtzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfJUO3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:29:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45819 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfJUO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:29:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so9278215wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxYYIsnCFuLUec3Mt7t5xj1H4ecLSFsGNR/kmuhF8Xw=;
        b=NDuJdtzqxA3OkM8uec3rQa8bOcNzLPulM0OXh/XyrH9Ymu5xNJsy3h1598MEwd6anI
         X/6r/euqtrCGbxi/pCDiLwiQB3wkDOwB1Ce/YSVAWgeySHI49KKoGcYIMQP4tMm179YS
         //N7JGeQhY9hYx8Ho3z+l5B66Hl6rzeuNV5xwkBfB5bv3B+Y3FOhaARhGQPpvwv8C7In
         7v0ZN1SfWLG6cyXOcItJ8sMrPMRxopF7WIM1/g+axau+0ZUUfCgN11UR3Re/geaFNUhJ
         tcDcueyK/Fsy6chlR4r+uAEJutQEmNL8K1Ubm0OIgcmakwZdzABtcnHW6OUMWmnZ5ze7
         dRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxYYIsnCFuLUec3Mt7t5xj1H4ecLSFsGNR/kmuhF8Xw=;
        b=RhybAvO1u4zV+KTY+stWy2SbrxZFAREjn+9+UulkXOsG8xJ3PRBAo+s0DRazYlBpv8
         Hx+B4jHTF2elX2PdKKLSlR/myFeZJvjQLKQvM7XftdjKWrEGiy3QJddokevSwZERq0Yx
         bQXmkDkLZDuOzvG6zA3xjk9OkFmqxpA+YB2lJ28qghDjdZLb0quYFAhb2jHyv7IoOBzA
         9OoZ+eY/t9peLyf+ADDCdwhWAMLyfxLSLCs/fnn/nJp1gT79HlIs//OfI3l6BSOHrwvd
         sDfjfWfkKzZatXM4NcXVizLTBS0EpB0R/1/mnLjiysibuT3+0HQ//YDvNsFddcjug335
         F5Pg==
X-Gm-Message-State: APjAAAVplStWjOsBNw1wJDtkTFDQBjZKO0HqOgrX1ACvhzig1i852YSY
        wvLJsxyV+zrlWTywU5JmFcXenAqe/pgSTw==
X-Google-Smtp-Source: APXvYqzoY3Id/cVnMuCKMTHqE3o3klKK3GFRil4uFFZJ/1VmKO1UXMdfsxgAkMy3bby5/p/Or7OubA==
X-Received: by 2002:adf:c143:: with SMTP id w3mr20338530wre.77.1571668147049;
        Mon, 21 Oct 2019 07:29:07 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d11sm17304463wrf.80.2019.10.21.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:29:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/5] arm64: dts: meson-g12a: fix gpu irq order
Date:   Mon, 21 Oct 2019 16:29:00 +0200
Message-Id: <20191021142904.12401-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191021142904.12401-1-narmstrong@baylibre.com>
References: <20191021142904.12401-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-g12b-s922x-khadas-vim3.dt.yaml: gpu@ffe40000: interrupt-names:0: 'job' was expected
meson-g12b-s922x-khadas-vim3.dt.yaml: gpu@ffe40000: interrupt-names:2: 'gpu' was expected

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3f39e020f74e..f9c52ada7fda 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2388,10 +2388,10 @@
 			compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
 			reg = <0x0 0xffe40000 0x0 0x40000>;
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "gpu", "mmu", "job";
+				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
 			clocks = <&clkc CLKID_MALI>;
 			resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
 
-- 
2.22.0

