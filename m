Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E46C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E5E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U0Lfv6xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfFJQpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:45:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51090 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfFJQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:45:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so55995wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TRyxaZQqHMNp0VVnMd4WRE8MXewDkxrqm+3YLYJjv8=;
        b=U0Lfv6xXQYdjJ9AgDOt86SKfYMLsJQiyA5CZzXpWlUfZsOebroGH3J2iwGCoBlZogl
         JsITdGn/8hrBGCJ3m/gl2mtfQp6Q48lSxvMQHvMLw/bT7lfWKwtuOfK31psyKoFErMA+
         s7SWvkgEh8SjNUaOAzjjQPN2LtMweF5XGdbjkD/2oFbbVTBHVSGJySbObwimxsSDu4Uq
         lNHR3t1+RJLtvpJLvb2pUeDyOrLD4M5CSwRqmNEk8TzGUNHMNizbb48Qxb0zt7hUwar5
         aq1M3q8xmXjK+SzHcSlTm57EOdtjj0+qM/seZQr6JAd55HCdoWd2rSpjHlC9FhrsJGFS
         0xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TRyxaZQqHMNp0VVnMd4WRE8MXewDkxrqm+3YLYJjv8=;
        b=QTl/uO6XMXFl7jKCw3wF3jLUgL662gJiJwoaA4fw0Ah1M+DlPxPqYdwynrUbtyuJqP
         9lPEFybDBM/mRaYNjAbXVuc1NwbAQjT59c2tRD6RQxo+jegZYyutum7dTFe2kWKPKk3y
         sSNc5K4kUMypRXF0z1f82uGZRKr5EscCh1Rjzt3gHiGJgQv0YLr74rj0fFDhACjnlgKE
         m2CRyPI9MzfqEUrxzyXU6Pvgn9al3gbfdG2qOgXJj2FUa0WsxbGzJZh5bf9XpxD2Tdbw
         DxVNsiJjDAngUumTuT/lgrLHRnAs1SZ9vc6wp2DD8u0vuSKX83EVGNEm1B3R00Q446sA
         D45Q==
X-Gm-Message-State: APjAAAXikn6n9f/KASkmllCfz9a16b7V9LhpR3K+5Rc5p4leEjDMuTvy
        HdMngcOG9Fmp+/a3uYFhFQevN28z
X-Google-Smtp-Source: APXvYqxwFt6ucPkTrpCTORtB7RuLEUEPbP7g2R5tiuGO9jw9qHOMEFz8FvX1gbPD3Iij4Xz4lXedRw==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr13887680wmc.163.1560185141527;
        Mon, 10 Jun 2019 09:45:41 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA40000C4C39937FBD289.dip0.t-ipconnect.de. [2003:f1:33dd:a400:c4:c399:37fb:d289])
        by smtp.googlemail.com with ESMTPSA id g17sm11441158wrm.7.2019.06.10.09.45.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 09:45:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: meson: g12a: x96-max: add the Ethernet PHY interrupt line
Date:   Mon, 10 Jun 2019 18:45:31 +0200
Message-Id: <20190610164531.8303-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190610164531.8303-1-martin.blumenstingl@googlemail.com>
References: <20190610164531.8303-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X96 Max has the PHY reset and interrupt lines are identical to the
Odroid-N2:
- GPIOZ_14 is the interrupt on X96 Max
- GPIOZ_15 is the reset line on X96 Max

Add GPIOZ_14 as PHY interrupt line on the X96 Max so we don't have to
poll for the PHY status.

Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 24956edaf8e2..e3f3f37d3081 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -180,6 +180,10 @@
 		reset-assert-us = <10000>;
 		reset-deassert-us = <10000>;
 		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.22.0

