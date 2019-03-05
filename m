Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25379C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A282087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="lGADcDwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfCEUTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:19:37 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55858 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbfCEUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:19:35 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B5565891A9;
        Wed,  6 Mar 2019 09:19:32 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551817172;
        bh=JDIzi7JyFss5+0sxv120uPEvr4G7fdX0unzBAlMeHSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lGADcDwHJq1b9UGfZ1wUtcqIFziyxivOoFje/R4clupF4N4M4DPlzn2Z2B1KxjtPF
         Lnj0F+ouer79csxuF/pM1mbKmX2F6UNPSXrROHKSHf3dHtnJy8xazhdAvuArLkDY6D
         n7iZ7NdYBPiZjQcN7KDzsdmYsg9x0zBTGXxV5xzXzMSOcuJfsI6xig0VAIKVdAJZ6S
         PBmh4qF0kd74k/o+MCpq2b9NFDIMdIEmMXxhfI4i4LDbAV3YjNuznO1xILmHqW5FGs
         vwkA/JdPzStEHXR/9WKoCfyyxlJH4yOlUysnFlGYgDDx6ozI7H2lgxBBnz01/+bMI5
         MHCbO7ejUZsHA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c7ed9d40001>; Wed, 06 Mar 2019 09:19:32 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id B6B4B13EF3B;
        Wed,  6 Mar 2019 09:19:32 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 803AC1E1D96; Wed,  6 Mar 2019 09:19:32 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/3] ARM: dts: armada-38x: add interrupts for watchdog
Date:   Wed,  6 Mar 2019 09:19:22 +1300
Message-Id: <20190305201924.14853-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190305201924.14853-1-chris.packham@alliedtelesis.co.nz>
References: <20190305201924.14853-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first interrupt is for the regular watchdog timeout. Normally the
RSTOUT line will trigger a reset before this interrupt fires but on
systems with a non-standard reset it may still trigger.

The second interrupt is for a timer1 which is used as a pre-timeout for
the watchdog.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- new, split out from "watchdog: orion_wdt: use timer1 as a pretimeout"

 arch/arm/boot/dts/armada-38x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada=
-38x.dtsi
index 929459c42760..fc550c640ca8 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -376,6 +376,8 @@
 				reg =3D <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;
 				clocks =3D <&coreclk 2>, <&refclk>;
 				clock-names =3D "nbclk", "fixed";
+				interrupts-extended =3D <&gic GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>;
 			};
=20
 			cpurst: cpurst@20800 {
--=20
2.21.0

