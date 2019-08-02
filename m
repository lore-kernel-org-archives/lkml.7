Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D136AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBEF2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739604;
	bh=aoktpKRMOnaV0/TY0aeXe55S3un/k258dCIgSTDe6XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MdsCzYtC9eoGus2YVwSMGpenGDgBvUkHva4wT7+3wCRgP2xuFrl7J7Y843S9SmPtr
	 xOmMbCuKPsV/3CH33kj865LjPcPtZXYwyvMsmrd+lH7ttl1vA2omwSDQ890BvIu3bh
	 IwKXACXBb+5fT0T5DZAmsnrq/GE01y/gtVjV7VLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406263AbfHBJxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406190AbfHBJxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:53:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C763A2064A;
        Fri,  2 Aug 2019 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739598;
        bh=aoktpKRMOnaV0/TY0aeXe55S3un/k258dCIgSTDe6XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lElO6gmpB/fUxHNI7YH3Fz7Chfp/e0icfs3rvsrgjZurN/RHKGgicw0try4RQyhzq
         mCpWkTsKXNfmQEKv1A9HwSYfNorzJasQ2xpc5FDrDEebRxzMZsCiqALjrILyZre/WK
         zAXL6rKWTEf/OjPnJXSF+5EGqb7vqU7VdYX7VXQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, allen yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 213/223] arm64: dts: marvell: Fix A37xx UART0 register size
Date:   Fri,  2 Aug 2019 11:37:18 +0200
Message-Id: <20190802092250.604846678@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: allen yan <yanwei@marvell.com>

commit c737abc193d16e62e23e2fb585b8b7398ab380d8 upstream.

Armada-37xx UART0 registers are 0x200 bytes wide. Right next to them are
the UART1 registers that should not be declared in this node.

Update the example in DT bindings document accordingly.

Signed-off-by: allen yan <yanwei@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/serial/mvebu-uart.txt |    2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
@@ -8,6 +8,6 @@ Required properties:
 Example:
 	serial@12000 {
 		compatible = "marvell,armada-3700-uart";
-		reg = <0x12000 0x400>;
+		reg = <0x12000 0x200>;
 		interrupts = <43>;
 	};
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -96,7 +96,7 @@
 
 			uart0: serial@12000 {
 				compatible = "marvell,armada-3700-uart";
-				reg = <0x12000 0x400>;
+				reg = <0x12000 0x200>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};


