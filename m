Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E73AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE6420B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568996505;
	bh=v/zuTY1CTu5pjJWBeLdx5nTGCDOWK5lV4Zyj61Aiqc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZD2iU7djgs4lE2MQ3t5jql4LKJjo4yURaiGWVqp1Aa3aHL9FrRA2ns8lTSeZqQ3yA
	 s2UvEjoDnT6tKn1zagz+pFGD6j6Ep7N6KSylzUOqM6jEBDNfz9/wXfkbK5i2P2lQVc
	 pS56nLiMggioKWFZG/ZihJhGaYy/Mh8lz60mOziQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405466AbfITQVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405393AbfITQVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:40 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0C921835;
        Fri, 20 Sep 2019 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568996499;
        bh=v/zuTY1CTu5pjJWBeLdx5nTGCDOWK5lV4Zyj61Aiqc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Byi0omnX5o2Qp0B6SzzhVdu6PlbwMX3v0dgJ1MqC72BVGsehtYXYjZXHdYcRGg/JK
         99OOpaD+dGT4BIlJSZHTJ+52+mZAyntx2bl0nbD/hLKuZgTywL5kGZNSJR4dB94iPP
         FQzjfxQyaMZ2TXKtmRnpQT185uFjy62anyBL4uzM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: watchdog: Add missing clocks requirement in Samsung SoC watchdog
Date:   Fri, 20 Sep 2019 18:21:23 +0200
Message-Id: <20190920162124.7036-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920162124.7036-1-krzk@kernel.org>
References: <20190920162124.7036-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SoC watchdog driver always required providing a clock
(either through platform data or from DT).  However when bindings were
added in commit 9487a9cc7140 ("watchdog: s3c2410: Add support for device
tree based probe"), they missed the requirement of clock.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Indent example with four spaces (more readable),
2. Add also missing required entries for clocks.
---
 .../devicetree/bindings/watchdog/samsung-wdt.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 5a3a3cec8e20..2fa40d8864b2 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -26,6 +26,13 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: watchdog
+
   interrupts:
     maxItems: 1
 
@@ -37,6 +44,8 @@ properties:
 
 required:
   - compatible
+  - clocks
+  - clock-names
   - interrupts
   - reg
 
-- 
2.17.1

