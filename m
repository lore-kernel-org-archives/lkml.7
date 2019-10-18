Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DA7CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5537D222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="sx1ydCMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634569AbfJRSrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:47:02 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.175]:28982 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502809AbfJRSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1571424409;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=xz95XaDLnnSMdaKFjAvNeNi9Kf9q1CPGUe86Ptqg0XY=;
        b=sx1ydCMlUhHff+LUz7Ah73qaA7PTdbk/ecbB5IQZzebyvcaHVuAnHqd1r+wh5HoOZd
        AEPPutSqGzR+ZfbGdPB8E4teQXCB1zM4L3rYLiXFZo8jrMUfXpJ9hzNqPfGDUjkOVt6t
        56AcdPUq+MwP9ynhi4dYh9F6uPYXzVAGpdwjE6F0WzXu8zR7DZVGSftpTuhpDUj/4CNw
        fKx0KnSXPmppUxkY3/Q8Drs83h3W+OBxlO1vMHa6ZieOV9PuAEeJFpEzHJT6DBbTPy6P
        ERdK34d1Nk8wnvi/Xo2KfjHhY4YDYHLywgQ7HBUBCwXoGdhMXk8bfsLIRSqRlKzcl1uo
        zoEQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH6F3CFF60="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.28.1 DYNA|AUTH)
        with ESMTPSA id R0b2a8v9IIkYDLI
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 18 Oct 2019 20:46:34 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 7/7] ARM: DTS: omap5: add sgx gpu child node
Date:   Fri, 18 Oct 2019 20:46:30 +0200
Message-Id: <790e680db41f12c5962a5ed4ffe468615afe9716.1571424390.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1571424390.git.hns@goldelico.com>
References: <cover.1571424390.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and add timer and interrupt.

Teste on Pyra-Handheld.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 1fb7937638f0..041a05b1cc4d 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -274,10 +274,14 @@
 			#size-cells = <1>;
 			ranges = <0 0x56000000 0x2000000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			sgx: sgx@0 {
+				compatible = "img,sgx544-116", "img,sgx544", "ti,omap-omap5-sgx544-116";
+				reg = <0x0 0x10000>;
+				reg-names = "sgx";
+				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+				timer = <&timer11>;
+				img,cores = <2>;
+			};
 		};
 
 		dss: dss@58000000 {
-- 
2.19.1

