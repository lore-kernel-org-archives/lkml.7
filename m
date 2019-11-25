Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E83C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E462082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="k/KMIjgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKYM0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:26:46 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:19637 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfKYM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574684803;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+VsrVMH/0AeKx+W15eVLwHD/fwlyWTB1SgPgdIap52w=;
        b=k/KMIjgYNCmwpZ0UJJKPWNZTXMLMFp1yjZe+OZRGaWFfU+BtB0broCUq/qDEVN1Yhv
        hrxEE3YaAuVBiCOglOoy1VIoW2Mg0aZDIRGET7r6aG7ylvNrZrO9k+YsJbC8aT+uwSme
        K6VaQmBJW+RCoIKPIFabmrDpmP2cb/yaRMA3v7M6dvIR6CCUcSo67dSvFEUI4fyW+pPR
        FSvJnFW76BKn71qm+rktdr9n+0EIj359MUk1M+hntA8H5fuEn5d2EWZQxNlbKDzhLvER
        QFuRPhrQLSKTTo+2TAgSUYS9t00agGb23mpEQ9+4Ek5AQH1ueadOFse+sHyxaf9mTmjQ
        Nwig==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1NmWArOmLo="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPCQh0FS
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 13:26:43 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 5/5] ARM: dts: ux500: nomadik-pinctrl: Add &gpio_in_nopull
Date:   Mon, 25 Nov 2019 13:22:56 +0100
Message-Id: <20191125122256.53482-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125122256.53482-1-stephan@gerhold.net>
References: <20191125122256.53482-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ste-nomadik-pinctrl.dtsi already defines in_nopull and gpio_in_pu/pd,
but there is no node to configure a pin as GPIO without pull up/down.
Add a new &gpio_in_nopull node for this.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
index 5673a1113aef..bfdb5d9a014f 100644
--- a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
@@ -25,6 +25,11 @@
 		ste,output = <OUTPUT_LOW>;
 	};
 
+	gpio_in_nopull: gpio_input_nopull {
+		ste,gpio = <GPIOMODE_ENABLED>;
+		ste,input = <INPUT_NOPULL>;
+	};
+
 	gpio_in_pu: gpio_input_pull_up {
 		ste,gpio = <GPIOMODE_ENABLED>;
 		ste,input = <INPUT_PULLUP>;
-- 
2.24.0

