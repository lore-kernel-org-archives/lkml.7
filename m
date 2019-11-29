Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF7EC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30232086A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="EaG70I7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfK2VJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:09:53 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:36051 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2VJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:09:53 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D75B723059;
        Fri, 29 Nov 2019 22:09:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575061791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vBGH4Is8jTUA/hpecRwlSpOFBZJJLpBTculd0msTkEU=;
        b=EaG70I7RiyaiHNh/CcggLrwsnJYaFUU7+ulXZv6r7uax/uYOh4rlcOeqMH/3n3wvENoJIZ
        gN0VCKL7LHsbbJ8/s8YolS1WJTPmr/1amTZIigQC6/FpyBMa2hlTszvhPrVMarKnhtzWJb
        tC92UluXLeJUc8T3/mXoYXM5wBXYhyw=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: put SAIs into async mode
Date:   Fri, 29 Nov 2019 22:09:37 +0100
Message-Id: <20191129210937.26808-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: D75B723059
X-Spamd-Result: default: False [6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.607];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1028A SoC has only unidirectional SAIs. Therefore, it doesn't make
sense to have the RX and TX part synchronous. Even worse, the RX part
wont work out of the box because by default it is configured as
synchronous to the TX part. And as said before, the pinmux of the SoC
can only be configured to route either the RX or the TX signals to the
SAI but never both at the same time. Thus configure the asynchronous
mode by default.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 379913756e90..9be33426e5ce 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -637,6 +637,7 @@
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 4>,
 			       <&edma0 1 3>;
+			fsl,sai-asynchronous;
 			status = "disabled";
 		};
 
@@ -651,6 +652,7 @@
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 6>,
 			       <&edma0 1 5>;
+			fsl,sai-asynchronous;
 			status = "disabled";
 		};
 
@@ -665,6 +667,7 @@
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 8>,
 			       <&edma0 1 7>;
+			fsl,sai-asynchronous;
 			status = "disabled";
 		};
 
@@ -679,6 +682,7 @@
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 10>,
 			       <&edma0 1 9>;
+			fsl,sai-asynchronous;
 			status = "disabled";
 		};
 
@@ -693,6 +697,7 @@
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 12>,
 			       <&edma0 1 11>;
+			fsl,sai-asynchronous;
 			status = "disabled";
 		};
 
@@ -707,6 +712,7 @@
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 14>,
 			       <&edma0 1 13>;
+			fsl,sai-asynchronous;
 			status = "disabled";
 		};
 
-- 
2.20.1

