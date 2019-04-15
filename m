Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D81C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D9D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355331;
	bh=Key9FMWI+ffgSogPQuAWE/2CND/D/u2S4sMLXY8Jph4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i7XR6Oxuxa3XnNMXIXyzEMEgUWZXYlbmBfgmeXSjR5vVKMVvsX5FmRKw7oN3cWGSg
	 oAfUhAtghrUqstm+EHZXNf+UEsUjJ7I4BDKS0NULxqfGKVmd1IJR0/KidkHyddkFo7
	 WZTJ/pM7mt6Z9Z/819yzZoz/ttx6OBowvfaa3kmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfDOTIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730553AbfDOTIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4888218A1;
        Mon, 15 Apr 2019 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355327;
        bh=Key9FMWI+ffgSogPQuAWE/2CND/D/u2S4sMLXY8Jph4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2R0hqOLqPbZKQRgwmJwtaP8zjyL0Vrb/gX64EJM1N/nbEhWI3gnpdUlV2VzumRDlf
         oPCIyg9XqtaxsGZmeEqLxTEtKdZSyQ0iG0HyhTwjScEh1vC4f4ktEKYrOOPfCGNqWv
         dp9DGgnFUt5l7sVS6f0ijSrM4vHRkNrd+l6M2mE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>, Stable@vger.kernel.org
Subject: [PATCH 4.19 078/101] ARM: dts: am335x-evm: Correct the regulators for the audio codec
Date:   Mon, 15 Apr 2019 20:59:16 +0200
Message-Id: <20190415183744.563759844@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

commit 4f96dc0a3e79ec257a2b082dab3ee694ff88c317 upstream.

Correctly map the regulators used by tlv320aic3106.
Both 1.8V and 3.3V for the codec is derived from VBAT via fixed regulators.

Cc: <Stable@vger.kernel.org> # v4.14+
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/am335x-evm.dts |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -57,6 +57,24 @@
 		enable-active-high;
 	};
 
+	/* TPS79501 */
+	v1_8d_reg: fixedregulator-v1_8d {
+		compatible = "regulator-fixed";
+		regulator-name = "v1_8d";
+		vin-supply = <&vbat>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	/* TPS79501 */
+	v3_3d_reg: fixedregulator-v3_3d {
+		compatible = "regulator-fixed";
+		regulator-name = "v3_3d";
+		vin-supply = <&vbat>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	matrix_keypad: matrix_keypad0 {
 		compatible = "gpio-matrix-keypad";
 		debounce-delay-ms = <5>;
@@ -499,10 +517,10 @@
 		status = "okay";
 
 		/* Regulators */
-		AVDD-supply = <&vaux2_reg>;
-		IOVDD-supply = <&vaux2_reg>;
-		DRVDD-supply = <&vaux2_reg>;
-		DVDD-supply = <&vbat>;
+		AVDD-supply = <&v3_3d_reg>;
+		IOVDD-supply = <&v3_3d_reg>;
+		DRVDD-supply = <&v3_3d_reg>;
+		DVDD-supply = <&v1_8d_reg>;
 	};
 };
 


