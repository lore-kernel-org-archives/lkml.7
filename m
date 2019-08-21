Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C59C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEC922D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="06ddO7Cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfHUOVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38515 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbfHUOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:20:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so2330156wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGF5jUzlLHUnpyLwcU0i8JE40DhyIcPvkvE+Vwkjv+o=;
        b=06ddO7CxS5O0YGXLovcrz6ShwhrUNh32lhm+fF4sdfT11snt54gRQTEkde2KNoHgW2
         VN+pbM/Ob/Yz8tb0A1vrQBmhDK9TgBzPRMMtuSJa2Cljse+5o87tcbUpdAy+V6t3dCDy
         uv3XaX7I9jSEobPiLPbDXqS57w0ULNezpjHDYWCiPvmES6DZDzpFUnJj2KwIB1p6+UX/
         GLusvZ1HQxwffMQgnNfhnH7ONfRDlrKvJHVlzn6WA1Ph2DE7S8IV/XD9aGRXt7RYpu9b
         Kn2P9n5OX+/ZMEAgA8pC0lLb+dlIfJINmbCK58erbgGo0LcL2uSsn1Ae61PN3XhfvS07
         Z6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGF5jUzlLHUnpyLwcU0i8JE40DhyIcPvkvE+Vwkjv+o=;
        b=czp42KMo9g3TLeeYl6p+3d8ecuLNB5Zw55wgyO9HogL0NO13dmtBM6R5hSNTeFPbEs
         bKB7VsDbQ/mqvSCfktvnUUfvSQ2PVi1DSQBToqihmSFu0UF/azyPQZY1oDNNApzscgAV
         4eQINZ9OvDce95185ae3WumtuA4vorWmykD0zqcKNdQSzw8qdb5N/JzhyKSpB3Ns85Jh
         Jn0nZwz7+ahC+UVjkW1hTUbQjHv00+HvV5Q6fhZscUfVnmwlVkZBph730oj4pSvGuvUP
         gvApKC8NitpediaV9JQborD5CivREs/+X8E1DU+qW4Rf/Ssvb09nEzuVM/kQqH/wCZyh
         kJgQ==
X-Gm-Message-State: APjAAAUuqfp/ZqocI3XxJT2NiUdqn919qGi/TEkKFfU66ptSsDAjPrOs
        xEHJRAYX+KJkwUP1krIJSJgSSw==
X-Google-Smtp-Source: APXvYqxO0x8vMs0kU/VpvxdkH1TDg/46izp4XAK/663X31Vn4UFZsfKpt4KBDqQ1dNWeNPRLTcr4yw==
X-Received: by 2002:a7b:c241:: with SMTP id b1mr270320wmj.165.1566397257177;
        Wed, 21 Aug 2019 07:20:57 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:20:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 04/14] arm64: dts: meson-gx: fix spifc compatible
Date:   Wed, 21 Aug 2019 16:20:33 +0200
Message-Id: <20190821142043.14649-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxl-s805x-libretech-ac.dt.yaml: spi@8c80: compatible:0: 'amlogic,meson-gx-spifc' is not one of ['amlogic,meson6-spifc', 'amlogic,meson-gxbb-spifc']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 5b3dfd03c3d3..e2cdc9fce21c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -317,7 +317,7 @@
 			};
 
 			spifc: spi@8c80 {
-				compatible = "amlogic,meson-gx-spifc", "amlogic,meson-gxbb-spifc";
+				compatible = "amlogic,meson-gxbb-spifc";
 				reg = <0x0 0x08c80 0x0 0x80>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.22.0

