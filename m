Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD85C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043522084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfLDM4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:56:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:37462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfLDM4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:56:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DCDE2B35E;
        Wed,  4 Dec 2019 12:56:44 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Florian Fanelli <f.fainelli@gmail.com>
Cc:     mbrugger@suse.com, phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: bcm2711: fix soc's node dma-ranges
Date:   Wed,  4 Dec 2019 13:56:33 +0100
Message-Id: <20191204125633.27696-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raspberry Pi's firmware has a feature to select how much memory to
reserve for its GPU called 'gpu_mem'. The possible values go from 16MB
to 944MB, with a default of 64MB. This memory resides in the topmost
part of the lower 1GB memory area and grows bigger expanding towards the
begging of memory.

It turns out that with low 'gpu_mem' values (16MB and 32MB) the size of
the memory available to the system in the lower 1GB area can outgrow the
interconnect's dma-range as its size was selected based on the maximum
system memory available given the default gpu_mem configuration. This
makes that memory slice unavailable for DMA. And may cause nasty kernel
warnings if CMA happens to include it.

Change soc's dma-ranges to really reflect it's HW limitation, which is
being able to only DMA to the lower 1GB area.

Fixes: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

NOTE: I'd appreciate if someone from the RPi foundation commented on
this as it's something that I'll propose to be backported to their tree.

 arch/arm/boot/dts/bcm2711.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 5b61cd915f2b..d6a0e350b7b4 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -43,7 +43,7 @@ soc {
 			 <0x7c000000  0x0 0xfc000000  0x02000000>,
 			 <0x40000000  0x0 0xff800000  0x00800000>;
 		/* Emulate a contiguous 30-bit address range for DMA */
-		dma-ranges = <0xc0000000  0x0 0x00000000  0x3c000000>;
+		dma-ranges = <0xc0000000  0x0 0x00000000  0x40000000>;
 
 		/*
 		 * This node is the provider for the enable-method for
-- 
2.24.0

