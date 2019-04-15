Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4152EC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFA9218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355032;
	bh=ntpPcM1V/BIhkPV9FiA3vFDNNLlDpabPpDnNOY+lKqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SNAwJAPBHefbAvAtOV+n6jXlHePqvEEruNRLnx5XM8r8jSg3rS3cb0HhbBACdWO57
	 X49KTI7Zzou/oDsC6z9DtZoBIKWQl051NVNgh8ufazuq8kPXAR742B6hQGS+Bw1MIY
	 iiq0JtDtlZZ7KFARc8XUHV/RXMkknXYntcxcU3sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfDOTDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbfDOTDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DBD2087C;
        Mon, 15 Apr 2019 19:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355027;
        bh=ntpPcM1V/BIhkPV9FiA3vFDNNLlDpabPpDnNOY+lKqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yy9/uJUf44hSU86fMSdHp+f3cViZFSCnxPhsQnjl8vlCbNvDUAO4dqwfIx/DBz7iy
         cVgmMnzv7Zf++XtJVDe30Id26Efm4kaznWIdxdOOKEJOizLhdFE9UGjeV9yb5rMyKN
         DNWKYPfSwCncpopzHhKebUVGlpLanLui2GTT7Trc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>, Stable@vger.kernel.org
Subject: [PATCH 4.14 55/69] ARM: dts: am335x-evm: Correct the regulators for the audio codec
Date:   Mon, 15 Apr 2019 20:59:13 +0200
Message-Id: <20190415183734.874067906@linuxfoundation.org>
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
@@ -492,10 +510,10 @@
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
 


