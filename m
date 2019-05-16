Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC33C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE51B2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="J8pjdZG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfEPKFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:05:04 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:50038 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbfEPKFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:05:04 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ECD37C1F31;
        Thu, 16 May 2019 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558001109; bh=ol9URR19tH7eq8Y4CYe1csjPcbIOlKJgB/PXWcwgEbc=;
        h=From:To:Cc:Subject:Date:From;
        b=J8pjdZG7AS4vvTkOWazb1nUexNU2WWJrw0Iq0r1R+iS7y3iclr1KBjM+fGC5hFmcI
         kq7FjYrQfdIx4cj0jAb/s9lqb+5JgHOhepbjWo1V27jNzC9TAgJEMGULP9SU4w9XtY
         bDN4DB/7KmLU5b5X+PQDDkgjs06p6To4iAAeI7BX7GBGVyiz1kOcmB+AvOcr2kwd8T
         v9C2JgyGdlGrijfa7bq6RKBdKmzOD3ywVx/6BW8BTx1coL56OugK+BTqbOy+1DT/8O
         YqrmuYxO79JlZWg0OPROPA8OubsXLTJTqfGMcD7VcDwU/KbqmcJU+tNYJ7AXIYwAFI
         CrlMZOeXUTrVQ==
Received: from ru20arcgnu1.internal.synopsys.com (unknown [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id D80F9A0067;
        Thu, 16 May 2019 10:04:59 +0000 (UTC)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] ARC: [plat-axs10x] Specify PHY node in .dtsi
Date:   Thu, 16 May 2019 13:04:53 +0300
Message-Id: <20190516100453.41530-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For completeness of the HW description add missing PHY entry in
AXS10x base-board .dtsi.

Cc: Trent Piepho <tpiepho@impinj.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/boot/dts/axs10x_mb.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 4ead6dc9af2f..98e9d63e868e 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -79,6 +79,7 @@
 			interrupts = < 4 >;
 			interrupt-names = "macirq";
 			phy-mode = "rgmii";
+			phy-handle = <&phy0>;
 			snps,pbl = < 32 >;
 			clocks = <&apbclk>;
 			clock-names = "stmmaceth";
@@ -86,6 +87,16 @@
 			resets = <&creg_rst 5>;
 			reset-names = "stmmaceth";
 			mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+				phy0: ethernet-phy@1 {
+					reg = <1>;
+				};
+			};
+
 		};
 
 		ehci@40000 {
-- 
2.16.2

