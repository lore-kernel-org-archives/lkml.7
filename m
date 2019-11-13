Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C9EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20E5222D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573609962;
	bh=zqKtBzIawqTh/gatYN8sjqqV0PNsU8huQ0cDbHWqccg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oeqiemFDUdZlPZ2huS7pnDe7rPM9SaybZDtdIQif6TSM8XWV40bm18r+eYx9Q0arU
	 FWwsXpI5YTqKlEbFlb2PcPUp8qabak8qFkMNHdWDRw+aj5pA/0O0oEHUu/S2iG1nY6
	 rxkIWzTuv1wD6lAfbKuAHjKD7+YXO/47xR2dQ5OA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfKMBwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:52:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbfKMBwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:52:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40E62245D;
        Wed, 13 Nov 2019 01:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609950;
        bh=zqKtBzIawqTh/gatYN8sjqqV0PNsU8huQ0cDbHWqccg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlaKi2lDmjvObhXSPwpOl3tx5VofL1XUX4VXFhYsPZKdsKhy9aUwNLNzMv/78Xwwx
         7UcVvHyakvVrAEzMGJmSQXi0GAKHiS1beXOhXJ2BO0kQsug6UDa5XHhd7tmq1nN2im
         a92dRyGAnlCBLSVoqgiVgDbgkntarfJ6l+uViqCU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 087/209] ARM: dts: da850-lego-ev3: slow down A/DC as much as possible
Date:   Tue, 12 Nov 2019 20:48:23 -0500
Message-Id: <20191113015025.9685-87-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

[ Upstream commit aea4762fb46e048c059ff49565ee33da07c8aeb3 ]

Due to the electrical design of the A/DC circuits on LEGO MINDSTORMS EV3,
if we are reading analog values as fast as possible (i.e. using DMA to
service the SPI) the A/DC chip will read incorrect values - as much as
0.1V off when the SPI is running at 10MHz. (This has to do with the
capacitor charge time when channels are muxed in the A/DC.)

This patch slows down the SPI as much as possible (if CPU is at 456MHz,
SPI runs at 1/2 of that, so 228MHz and has a max prescalar of 256, so
we could get ~891kHz, but we're just rounding it to 1MHz). We also use
the max allowable value for WDELAY to slow things down even more.

These changes reduce the error of the analog values to about 5mV, which
is tolerable.

Commits a3762b13a596 ("spi: spi-davinci: Add support for SPI_CS_WORD")
and e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
CPU usage") introduce changes that allow DMA transfers to be used, so
this slow down is needed now.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index c4729d0e6c196..66fcadf0ba910 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -352,7 +352,8 @@
 		compatible = "ti,ads7957";
 		reg = <3>;
 		#io-channel-cells = <1>;
-		spi-max-frequency = <10000000>;
+		spi-max-frequency = <1000000>;
+		ti,spi-wdelay = <63>;
 		vref-supply = <&adc_ref>;
 	};
 };
-- 
2.20.1

