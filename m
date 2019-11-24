Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4802C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9736020815
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 11:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="eS4K+WL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKXLkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 06:40:52 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.120]:8163 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfKXLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 06:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574595649;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=11dnnmhb1p7k4nx66KvKMNZIk0qpx8gkJedgWR7HCNM=;
        b=eS4K+WL/SFTR6d/xYkF5lhb8d/GMjFdszHfPtLZCrbM7/jqw3KfHWX5x/dUMGg9wWq
        ay07uRUabJr1pEOVprAzDGDG+7FMCilrQIpRBpBmskfRdpwHgrkOiKuJyAJfGXHH2A1m
        L0ydbAtCP3k47W2hzoLvVWNBkYxDvajBcFeZDT23un3A7ZKtSvgxCpQrAlvl4ZFUhNMi
        H0i/jwE1xEBPFEfPSnlMQeJ0XgAkn6feCFsuVzFOFR0Kbo+abk3xNYNjUsnps2L2yHyb
        twYWr9NNvERujdfa4APMa0jLMmNR2e2XOQgZDa5v2XmWjl4c/pcEihYHXhgpLSabKF8J
        C00A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH4HEaKeuIV"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id L09db3vAOBeXwEa
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 24 Nov 2019 12:40:33 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-mips@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Paul Boddie <paul@boddie.org.uk>
Subject: [PATCH v3 8/8] MIPS: DTS: jz4780: add sgx gpu node
Date:   Sun, 24 Nov 2019 12:40:28 +0100
Message-Id: <c73e2cee4f818654f264b0b7b5458bfaa0ac6a7a.1574595627.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574595627.git.hns@goldelico.com>
References: <cover.1574595627.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and add interrupt and clocks.

Tested to build for CI20 board and load a (non-working) driver.

Suggested-by: Paul Boddie <paul@boddie.org.uk>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index c54bd7cfec55..21ea5f4a405b 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -46,6 +46,17 @@
 		#clock-cells = <1>;
 	};
 
+	gpu: gpu@13040000 {
+		compatible = "ingenic,jz4780-sgx540-120", "img,sgx540-120", "img,sgx540", "img,sgx5";
+		reg = <0x13040000 0x4000>;
+
+		clocks = <&cgu JZ4780_CLK_GPU>;
+		clock-names = "gpu";
+
+		interrupt-parent = <&intc>;
+		interrupts = <63>;
+	};
+
 	tcu: timer@10002000 {
 		compatible = "ingenic,jz4780-tcu",
 			     "ingenic,jz4770-tcu",
-- 
2.23.0

