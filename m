Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF82218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="taURnEyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfCONm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:42:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33401 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfCONmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:42:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id i8so9659859wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gz+IYaan7/2Eh+eJMLV0munYzmfacWjDFUXL21TiogA=;
        b=taURnEyhPquRk5Ay2RyfFOVZyjGDdGdYHAcKPleHcNp1Qgrkxts5McL4Mr6j/kVBHs
         y0wZl3OKieUbp8QMVYG5bPSQskd4Q1goOR1UjXsGcs43M83sCVRVeHGkHhjfoXU/qeC6
         nr6ZUHKbC8KWN98WzYppLz6y2hF+rnFLQ5NiufjeWwyOcbjDrleRfwplI/pcRphUnAet
         UgHs772kF5XQ/Xd/xAejCidgOuIjMQWTjZBr9zHerRXsJgHH3ZkslRd7qiPPJcmZ9DJd
         zQRUZkQI7qFuPy/LDBDKcZLxXOrd+l2vV1ixZxH/1vIJ9i1abVLukp74XkfAWunVB1ib
         cqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gz+IYaan7/2Eh+eJMLV0munYzmfacWjDFUXL21TiogA=;
        b=KjjB+KCF3mrHsvh6epbtnE3yqjRlPhVjSNgZcpKzPKj5yPvKhr+pFv70QiQgk/v3vr
         4lF1+O3vQW4i6ObcgfYLLuPIr3vGAK0Q3rsKwT35AZJrtPqyimhYmmIKlpuQlSHemJjS
         ucdqFPOCNRY53vO2JRxYYUI2Hs9iAtiH3O4PHe8eTKJKovdozISpPAB/FtuQdAGu0nLJ
         6YijR7alcqRv6zijNPFi6GJsN50r4nXs2U6ucMGkWGTph4sXYSq/mQqnwb/cRs7lrFJk
         kfR47eqTpLf3LYWlg8zVc5Zkp4iwX79KQWHCwdUOE/dx4VRCYyZNopaLEAcLLBcs7uLj
         NbbQ==
X-Gm-Message-State: APjAAAVy7yMNpTHrdc/X2bs3xgKLIMCZJ6hwUzLEDvNZ+hExWtCutSap
        nrr3EaJkhcqubiBsqGTNwNrUuA==
X-Google-Smtp-Source: APXvYqwq/ds+ohvPOdLU9ghTLwQJIFCSqgfQH0nYW6PffVPKKQKhj3Ora16ZfySP/rcuSQTvDIWoGQ==
X-Received: by 2002:adf:81a1:: with SMTP id 30mr2708660wra.285.1552657372397;
        Fri, 15 Mar 2019 06:42:52 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x17sm4616143wrd.95.2019.03.15.06.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 06:42:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: meson: g12a: add secure monitor
Date:   Fri, 15 Mar 2019 14:42:43 +0100
Message-Id: <20190315134244.14141-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315134244.14141-1-jbrunet@baylibre.com>
References: <20190315134244.14141-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interface to the secure monitor on g12a

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 31ddf9444b3e..92ee8c895ba6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -72,6 +72,10 @@
 		};
 	};
 
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.20.1

