Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DE6C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7F0218AF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567867555;
	bh=xwF/NMtim/ONqBCJ2ccw0i+PrFhjbooHiKBxOMf6rhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KK/4uM8aShs0yeF/Ik4VZU5gyiZrAWU4+oVOznMCV1Ghrhlt+c3hDY73svY9ifKqA
	 rVN9abspgG/u4KGGCCi5qLrqpV+8lYLU/lddSX5Yp48E5zBnifF7P68VGHosoUZ7EN
	 WMCsvQtse7ukzaQmQXf4+6aUKTVZPydtEYAvvQE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406042AbfIGOpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 10:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfIGOpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 10:45:52 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E78CB2178F;
        Sat,  7 Sep 2019 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567867551;
        bh=xwF/NMtim/ONqBCJ2ccw0i+PrFhjbooHiKBxOMf6rhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ven4TqF0BAZitzuK9/vTK74xh9k7bqoMjFNIrxUTELtO/rgSZBVOvDi+lSSrr/Xo
         neSSnL4Dn+6v9MRFu6ISDGxs319/zf/P98nr/LdDesm/D903kkn3jUkYgSUJBg4Vnp
         oDyu9FuYVh9RZOejCBNQHepPtNMQhJuToVXRc36Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] dt-bindings: watchdog: Add missing clocks requirement in Samsung SoC watchdog
Date:   Sat,  7 Sep 2019 16:45:41 +0200
Message-Id: <20190907144541.16949-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190907144541.16949-1-krzk@kernel.org>
References: <20190907144541.16949-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SoC watchdog driver always required providing a clock
(either through platform data or from DT).  However when bindings were
added in commit 9487a9cc7140 ("watchdog: s3c2410: Add support for device
tree based probe"), they missed the requirement of clock.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/watchdog/samsung-wdt.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 39f1ca3bc4db..9edde497b040 100644
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
 
-- 
2.17.1

