Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1448BECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BE4208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rNysBzRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbfILKbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:31:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53914 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbfILKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:31:52 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1599233A;
        Thu, 12 Sep 2019 12:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1568284309;
        bh=bzzBdJ8km6S2yNYY9lcTrycfpw5n5B4KvAGCiNkIb1c=;
        h=From:To:Cc:Subject:Date:From;
        b=rNysBzRenXSTQHx+DfN8weauJRdSh/Kzvi7vYFhlVyYJd99SVoET00cDsy0z5KLZp
         E7OspUj9iwwNnOHIjRNeT22+j9adnn52iTvpQdB0w5mtokz4EW7yX6dwlDc2FVv9Q+
         Eu7/COOpP0svx0NwYGRYN9jGQTsE/kwtrf4i+fpk=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@glider.be>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: renesas: r8a77970: Fix PWM3
Date:   Thu, 12 Sep 2019 11:31:43 +0100
Message-Id: <20190912103143.985-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pwm3 was incorrectly added with a compatible reference to the
renesas,pwm-r8a7790 (H2) due to a single characther ommision.

Fix the compatible string.

Fixes: de625477c632 ("arm64: dts: renesas: r8a779{7|8}0: add PWM support")
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 2c4ab70e2a39..74c2c0024e45 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -652,7 +652,7 @@
 		};
 
 		pwm3: pwm@e6e33000 {
-			compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+			compatible = "renesas,pwm-r8a77970", "renesas,pwm-rcar";
 			reg = <0 0xe6e33000 0 8>;
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
-- 
2.20.1

