Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0FFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9195220835
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="JB36U0KS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfIZX2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:28:38 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46917 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfIZX23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 19:28:29 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C27EA891A9;
        Fri, 27 Sep 2019 11:28:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1569540506;
        bh=rAUvLPAfWgWX2H5eqfh6QWkokkEOuv0sRFKi68bW+K8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JB36U0KSnpnlx8YF1jJPhEhP5AhZnmpoIwR40mzFa78b871sZeSFwlmSCNCuql6LC
         w1A2JyKaE6YRCHux7qC4IB8h/oVFu300iBiXhLPke1KMzHW2PtnomqzGlsvDcKpcrw
         R7y8hed96I1Kv0qEKM73z2AHAaA85Rb5vcIz5/7++CO53G3R7592ZMr+mH9AFNAaIT
         58Ug022CDVphFs2fKo6RZSSQf43phwM3FQa242V1y6nQaTTUd7h4dZwhZ0pMXwlD+1
         3BuRXmXwm7IpY4ZUz3KCZKhwQ8Rp79OlWfF9aHgT6ueOAO4ZkzJSWH6RTyTiBG8IF6
         4cpsE+DAAvW7Q==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d8d49980002>; Fri, 27 Sep 2019 11:28:26 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 4D56B13EF59;
        Fri, 27 Sep 2019 11:28:28 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9641428003E; Fri, 27 Sep 2019 11:28:24 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/3] ARM: dts: mvebu: add sdram controller node to Armada-38x
Date:   Fri, 27 Sep 2019 11:28:19 +1200
Message-Id: <20190926232820.27676-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190926232820.27676-1-chris.packham@alliedtelesis.co.nz>
References: <20190926232820.27676-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Armada-38x uses an SDRAM controller that is compatible with the
Armada-XP. The key difference is the width of the bus (XP is 64/32, 38x
is 32/16). The SDRAM controller registers are the same between the two
SoCs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada=
-38x.dtsi
index 3f4bb44d85f0..e038abc0c6b4 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -103,6 +103,11 @@
 			#size-cells =3D <1>;
 			ranges =3D <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
=20
+			sdramc: sdramc@1400 {
+				compatible =3D "marvell,armada-xp-sdram-controller";
+				reg =3D <0x1400 0x500>;
+			};
+
 			L2: cache-controller@8000 {
 				compatible =3D "arm,pl310-cache";
 				reg =3D <0x8000 0x1000>;
--=20
2.23.0

