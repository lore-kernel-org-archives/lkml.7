Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9383FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B34E22D6D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566238854;
	bh=oJGr4uBf27t1EnvM3eWCwbVoz4PVt3i7Qe7GuzWbUyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RDs2SK/g3ooj+cNfcNupdysAthfdDYdXs/VDABFB1QkEDEijk7pzHE38jzlIiZAvi
	 XnKt8gqSFfP4tco6Mwdo35RARP1HrQtFgiSVMbgwTY3IbAXIi46I/Qz49yMGjFGJHC
	 c4WM3WncZGvmPiKiFj4O/oJ7LjPVtfnQhR8W5SdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfHSSUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbfHSSUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:20:50 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1912522CF4;
        Mon, 19 Aug 2019 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566238849;
        bh=oJGr4uBf27t1EnvM3eWCwbVoz4PVt3i7Qe7GuzWbUyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQlWvevldi7MNP01+5KonDd1b0mdfvEzRopdGvQuZ/31rhV2JvudYzwnoBAF+2fIV
         42RU7oJ1eznYRZZJlLxQivS0cMhPSqIzSVPddTQeDKGKbk3JI+w3SX/nJt1jtMIX6W
         9DeXBxEIlcCnypieSj81KMuN+ZRKCKBzMVxJWOGU=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/6] dt-bindings: watchdog: sun4i: Add the watchdog interrupts
Date:   Mon, 19 Aug 2019 20:20:36 +0200
Message-Id: <20190819182039.24892-3-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819182039.24892-1-mripard@kernel.org>
References: <20190819182039.24892-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The Allwinner watchdog has an interrupt, either shared or dedicated
depending on the SoC, that has been described in some DT, but not all of
them.

The binding is also completely missing that description. Let's add that
property to be consistent.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
index dc7553f57708..31c95c404619 100644
--- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
@@ -31,9 +31,13 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
+  - interrupts
 
 unevaluatedProperties: false
 
@@ -42,6 +46,7 @@ examples:
     wdt: watchdog@1c20c90 {
         compatible = "allwinner,sun4i-a10-wdt";
         reg = <0x01c20c90 0x10>;
+        interrupts = <24>;
         timeout-sec = <10>;
     };
 
-- 
2.21.0

