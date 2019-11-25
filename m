Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CE8C43141
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0D52084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="h+IZ/s2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfKYM0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:26:46 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:8129 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfKYM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574684803;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=qe7PGJv0jJ8/TYHTxQ8OIf3CAJK3fMrNQb5cSYH+wNM=;
        b=h+IZ/s2rVI2QI+q7UH8DP7D/nDcXtK6Lv23n79wqNW9QipfR0QKNINtIZZGfv+I7Zb
        GD6/vcoh8HFgp2dAdzaSNZW67W+KIuWZ9fnBe142mmDkeOUbnzZh1+wQ8BT+1vqb/vtW
        S4F7lcX1hHbfF8K17vtJfLmyw4jIgdrJt8Q6FSI9GmKXig/JtdnHqwBHfQgoIZdW88ru
        3nhCcUAdSukcqmS/cG7WNDUQ4MGewytKq1CkjvW7I56ZhROE1emIBpJrulSAADBcKhpT
        JMf5Lmn/tm7UQkhyBmq0oDl84rOEfcWaZB9il0NOy3LzqVR939b16xYEXZVAhxIaSPwQ
        HHkA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1NmWArOmLo="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPCQg0FP
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 13:26:42 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/5] ARM: dts: ux500: Add alternative SDI pin configs
Date:   Mon, 25 Nov 2019 13:22:54 +0100
Message-Id: <20191125122256.53482-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125122256.53482-1-stephan@gerhold.net>
References: <20191125122256.53482-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDI0/SDI1 can be used in configurations where some of the pins
(e.g. direction control) are not used. The pinctrl driver has
separate pin groups for them.

Add new pin configurations for:
  - mc0_a_2: like mc0_a_1, but without CMDDIR/DAT0DIR/DAT2DIR
  - mc1_a_2: like mc1_a_1, but without FBCLK

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi | 77 +++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
index b3ef91b98207..b6d0a60e9aed 100644
--- a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
@@ -257,6 +257,47 @@
 				ste,config = <&slpm_out_lo_wkup_pdis>;
 			};
 		};
+
+		mc0_a_2_default: mc0_a_2_default {
+			default_mux {
+				function = "mc0";
+				groups = "mc0_a_2";
+			};
+			default_cfg1 {
+				pins = "GPIO22_AA3"; /* FBCLK */
+				ste,config = <&in_nopull>;
+			};
+			default_cfg2 {
+				pins = "GPIO23_AA4"; /* CLK */
+				ste,config = <&out_lo>;
+			};
+			default_cfg3 {
+				pins =
+				"GPIO24_AB2", /* CMD */
+				"GPIO25_Y4", /* DAT0 */
+				"GPIO26_Y2", /* DAT1 */
+				"GPIO27_AA2", /* DAT2 */
+				"GPIO28_AA1"; /* DAT3 */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		mc0_a_2_sleep: mc0_a_2_sleep {
+			sleep_cfg1 {
+				pins =
+				"GPIO22_AA3", /* FBCLK */
+				"GPIO24_AB2", /* CMD */
+				"GPIO25_Y4", /* DAT0 */
+				"GPIO26_Y2", /* DAT1 */
+				"GPIO27_AA2", /* DAT2 */
+				"GPIO28_AA1"; /* DAT3 */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins = "GPIO23_AA4"; /* CLK */
+				ste,config = <&slpm_out_lo_wkup_pdis>;
+			};
+		};
 	};
 
 	sdi1 {
@@ -301,6 +342,42 @@
 				ste,config = <&slpm_in_wkup_pdis>;
 			};
 		};
+
+		mc1_a_2_default: mc1_a_2_default {
+			default_mux {
+				function = "mc1";
+				groups = "mc1_a_2";
+			};
+			default_cfg1 {
+				pins = "GPIO208_AH16"; /* CLK */
+				ste,config = <&out_lo>;
+			};
+			default_cfg2 {
+				pins =
+				"GPIO210_AJ15", /* CMD */
+				"GPIO211_AG14", /* DAT0 */
+				"GPIO212_AF13", /* DAT1 */
+				"GPIO213_AG13", /* DAT2 */
+				"GPIO214_AH15"; /* DAT3 */
+				ste,config = <&in_pu>;
+			};
+		};
+
+		mc1_a_2_sleep: mc1_a_2_sleep {
+			sleep_cfg1 {
+				pins = "GPIO208_AH16"; /* CLK */
+				ste,config = <&slpm_out_lo_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins =
+				"GPIO210_AJ15", /* CMD */
+				"GPIO211_AG14", /* DAT0 */
+				"GPIO212_AF13", /* DAT1 */
+				"GPIO213_AG13", /* DAT2 */
+				"GPIO214_AH15"; /* DAT3 */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+		};
 	};
 
 	sdi2 {
-- 
2.24.0

