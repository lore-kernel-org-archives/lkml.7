Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313CCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E056A20879
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="et6i47aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfCXEeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:34:18 -0400
Received: from csm1.csm-office.com.au ([165.228.118.109]:38338 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCXEeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:34:16 -0400
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id x2O4XY4l008019
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sun, 24 Mar 2019 15:33:55 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1553402036; bh=fYEKkpdWnZioXg7DaxhUYrSOwNnjiJwK5psYgwYJekQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=et6i47aw3oth8ZcR0AUS3m2GA8x7wKjN485i4EOGynGmBMNLZvNc/aPdboXB+Jdda
         0e+CPBAXOuyWcQZUYyKSDwcjAl6wF3LRToDTz9idTJePSStIt0GK9TJ2Ol+6kt1jux
         Iji2w13AngR0IM2b2vY3CZJl+ufkn0scSSqwyAh3qUVe+gXCM9Q0oquSgX/+AGDHX0
         iCD41fh8jv4y3VrMt8j1kf6JyB2u4LP9O4a+4XQiv/OuyDDFQfpaX82b0X5EwE0rkS
         xG4DzWanB6oxXPpbj115n7hOwjs5aYzfONEqP80puogVO5EQjtmbgKrRKvIfRfQqII
         c3VXRJkWTSXeg==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tom Burkart <tom@aussec.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Lukas Senger <lukas@fridolin.com>
Subject: [PATCH v18 2/3] dt-bindings: pps: pps-gpio PPS ECHO implementation
Date:   Sun, 24 Mar 2019 15:33:04 +1100
Message-Id: <20190324043305.6627-3-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190324043305.6627-2-tom@aussec.com>
References: <20190321154633.b9d1a356a100a4a14fa219f7@linux-foundation.org>
 <20190324043305.6627-1-tom@aussec.com>
 <20190324043305.6627-2-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the device tree binding changes required for the
PPS ECHO functionality for pps-gpio, that sysfs claims is available
already.

It adds two DT properties for configuring the PPS ECHO functionality.

This patch is provided separated from the rest of the patch per
Documentation/devicetree/bindings/submitting-patches.txt.

This patch was originally written by Lukas Senger as part of a masters
thesis project and modified for inclusion into the linux kernel by Tom
Burkart.

Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lukas Senger <lukas@fridolin.com>
Signed-off-by: Tom Burkart <tom@aussec.com>
---
 Documentation/devicetree/bindings/pps/pps-gpio.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
index 3683874832ae..9012a2a02e14 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -7,6 +7,10 @@ Required properties:
 - compatible: should be "pps-gpio"
 - gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
 
+Additional required properties for the PPS ECHO functionality:
+- echo-gpios: one PPS ECHO GPIO in the format described by ../gpio/gpio.txt
+- echo-active-ms: duration in ms of the active portion of the echo pulse
+
 Optional properties:
 - assert-falling-edge: when present, assert is indicated by a falling edge
                        (instead of by a rising edge)
@@ -19,5 +23,8 @@ Example:
 		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		assert-falling-edge;
 
+		echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		echo-active-ms = <100>;
+
 		compatible = "pps-gpio";
 	};
-- 
2.12.3

