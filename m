Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DDCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1F420874
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565700477;
	bh=fK5hDNjRuNS77RPfIT+JYLABnTrKkRRYlSzM051qvLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NxMMRZlp791KW4dXQNSkNSdxsNDDNNSTtaFZsIEeMe3mgNNNEwCu8eSvnwZNj6/If
	 f9+FPdLAYYsyLBGP4n+OBF630XKXryNCeCWiK53K/sm/zoUlQ8PiDIkJv4nFw4lzA5
	 wl5mC7Mhpn9b7PNNV258FHiYoyqnKc6c66wJzTi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfHMMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHMMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:47:54 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A922085A;
        Tue, 13 Aug 2019 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565700473;
        bh=fK5hDNjRuNS77RPfIT+JYLABnTrKkRRYlSzM051qvLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtLC0+FjMtX2PpANrFFwlrg4UdEHF35C/aYylTdp4pgcxiabgIKoggv6/ddaYKRvJ
         76EwtZduy6hKmfgMtvjH5UcQVZ9KhKtxJtFOlBIZ81CTArvajcEsYpVn0TbqefLFbO
         qWNppVCDVmLxWVrD8LrMtgrkrekxWNuK8DZ5GQ64=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 3/5] dt-bindings: watchdog: sun4i: Add the watchdog interrupts
Date:   Tue, 13 Aug 2019 14:47:42 +0200
Message-Id: <20190813124744.32614-3-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813124744.32614-1-mripard@kernel.org>
References: <20190813124744.32614-1-mripard@kernel.org>
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

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
index 93df27ec1664..4ace89f129b4 100644
--- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
@@ -28,6 +28,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   timeout-sec:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -36,6 +39,7 @@ properties:
 required:
   - compatible
   - reg
+  - interrupts
 
 additionalProperties: false
 
@@ -44,6 +48,7 @@ examples:
     wdt: watchdog@1c20c90 {
         compatible = "allwinner,sun4i-a10-wdt";
         reg = <0x01c20c90 0x10>;
+        interrupts = <24>;
         timeout-sec = <10>;
     };
 
-- 
2.21.0

