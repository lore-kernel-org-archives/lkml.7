Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C713EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835A420651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356450;
	bh=wKkHwOQj5RIqSl4IAipOYpMxvC6ArGGnPtpw1Mc1DnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YZYYgo40+hK7P8pIFayIDoFUaXVpq+r/UbWT+wxPtVQHnrT5DZqSdl8XnwU2mhxYJ
	 C6nmBH54dm4MgxlQ4G/kiamDLhvEsLzFLQzMKKQhRKD2eVjiIWI2kYveTFIRIM9WHK
	 ZFc3SFIfm1vkztCfOd7zJ9zP7QDTMYFX8bJQc6j0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfDOTDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbfDOTDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D94218FE;
        Mon, 15 Apr 2019 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355024;
        bh=wKkHwOQj5RIqSl4IAipOYpMxvC6ArGGnPtpw1Mc1DnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoE/Pqpyd5PfPYeNGi/T5dDONmFqKHYtVqcKjACi7oIPdyuntFre0rL0Um5gj68RE
         L6eXrXISyqhdNiqi5Sr1AXM+JxfPRkH87ZcfWQPWtkQYPgtm2t0bnbi1JxhBUF2Y2y
         CWKuei5o4XCXNT31d326dvQJ2FZwfIWAZa1DKPvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>, Stable@vger.kernel.org
Subject: [PATCH 4.14 54/69] ARM: dts: am335x-evmsk: Correct the regulators for the audio codec
Date:   Mon, 15 Apr 2019 20:59:12 +0200
Message-Id: <20190415183734.641831835@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

commit 6691370646e844be98bb6558c024269791d20bd7 upstream.

Correctly map the regulators used by tlv320aic3106.
Both 1.8V and 3.3V for the codec is derived from VBAT via fixed regulators.

Cc: <Stable@vger.kernel.org> # v4.14+
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/am335x-evmsk.dts |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -73,6 +73,24 @@
 		enable-active-high;
 	};
 
+	/* TPS79518 */
+	v1_8d_reg: fixedregulator-v1_8d {
+		compatible = "regulator-fixed";
+		regulator-name = "v1_8d";
+		vin-supply = <&vbat>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	/* TPS78633 */
+	v3_3d_reg: fixedregulator-v3_3d {
+		compatible = "regulator-fixed";
+		regulator-name = "v3_3d";
+		vin-supply = <&vbat>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&user_leds_s0>;
@@ -493,10 +511,10 @@
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
 


