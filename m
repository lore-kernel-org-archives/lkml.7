Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91BEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80D12075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DB5B43lV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfC0KdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:33:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41061 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732707AbfC0KdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:33:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so10201125wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gp5xnfcYqxDRaQuohb65UiVl+ealJY+xKv+LZ1d7Q3s=;
        b=DB5B43lVarscconbHiOQ++cbHEiMgH4cV91ofWi+0UHqxqHQcKEi81JzLPhTyVWoGh
         rti8A5Un7bw+jQBnMhxJnb02T/ol9to83PpCwlOTC2cXYm0fWZzJaGd8n/ZeRtmQAOYz
         /UADmMLz96Cjby6iBOTcm6fzbWxEVf5SNqBarptR5n1EtvA6czlhEI4ZsBsg6t9o16bB
         uHy4cm0cvcj4zQuuOJYLieZOpmOuwHOxw2Nb+xwMbYK5s0KVP4bfV4jh1574GPErICtz
         Gdit1eLiMh8e90AdeEulAM4wpARIYHKs3RxgwzWa0ATvY7v84pRNiqTPwTfZ8cxzCHNx
         1TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gp5xnfcYqxDRaQuohb65UiVl+ealJY+xKv+LZ1d7Q3s=;
        b=T5IwVJuxHWgIn127MBcyzVBAXx0J0w2SvEciookFdTXpSZQjxFBCFZ5tBGyQqQTZo+
         GMs3y9cz211g7qPwuPzGu5aTOCGa5GeHiyC6Oq5OwjDRDNQ1Oc+5+12dTppr1It/XoAB
         u6H+I/GQa5EzzdBcCDPoh3duuj7FTpalNHhqJg3l4G3u1L4BCA4A9c1Yl1g5uF//LQXI
         5loUMrBUXAD+xSMdJwIAheC3/LC3LXK46BSM4rgHrmuNUeAJZG64EcS11lRO21rAPc+r
         DhEWjWm9c2zQbaZY9rXt2Y7d/LaOy/UGLes8udtHHSyE9sH23kFYcZBX/+/prJT6d6vm
         Lcwg==
X-Gm-Message-State: APjAAAXf2edXhKaM9qgY37kECTglsTldEqw/IWVAy+ioY6WU694mW65D
        EYsMB4fmBtBQfH4tkJLqqM1vcOT0TunRGw==
X-Google-Smtp-Source: APXvYqxSvH5WMfEfbZh69CcLpeULI6GlPOCq+xSQWPOKDTw1qbv9iYMJB+EM6PkMbFweRkJWg9d8oA==
X-Received: by 2002:adf:c809:: with SMTP id d9mr9386275wrh.304.1553682791164;
        Wed, 27 Mar 2019 03:33:11 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a20sm27017513wmb.17.2019.03.27.03.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 03:33:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/6] dt-bindings: clk: meson: add g12b periph clock controller bindings
Date:   Wed, 27 Mar 2019 11:33:03 +0100
Message-Id: <20190327103308.25058-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327103308.25058-1-narmstrong@baylibre.com>
References: <20190327103308.25058-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the specific Amlogic G12B clock driver compatible.

G12B clock driver is very close, the main differences are :
- the clock tree is duplicated for the both clusters, and the
  SYS_PLL are swapped between the clusters
- G12A has additional clocks like for CSI an other components

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index 5c8b105be4d6..6eaa52092313 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -10,6 +10,7 @@ Required Properties:
 		"amlogic,gxl-clkc" for GXL and GXM SoC,
 		"amlogic,axg-clkc" for AXG SoC.
 		"amlogic,g12a-clkc" for G12A SoC.
+		"amlogic,g12b-clkc" for G12B SoC.
 - clocks : list of clock phandle, one for each entry clock-names.
 - clock-names : should contain the following:
   * "xtal": the platform xtal
-- 
2.21.0

