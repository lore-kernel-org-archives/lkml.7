Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E462C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D427B206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Hwaji7y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfC1ECm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 00:02:42 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45072 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfC1ECj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 00:02:39 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1D08B891AB;
        Thu, 28 Mar 2019 17:02:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1553745758;
        bh=fRZTQLS3udad2cgQBUGRWrcv/kmxBMd4xpradg1ohsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Hwaji7y/9NpGG85DxyavyHZ5g2jm2UBTFk/72mYKUjYKya2EWwRr89ko1f6PpbYJZ
         GQC9l0pEq9viFZRSO5JsZ5VeXQeazGefDy9xQ8WknHdoQYPLRB3RBhJVQ687EKmvis
         e1FEtR6OrVOcT/CEXRERcet1aKvU77j+LlpIUq/vuxTC7RUhCINYRxzfRzHGdqmeQ0
         LKprxtcPc9H+FNVh6djVpnwHxTq+Dx0soNnZjFWMlKMc17HHXcy0UCbidttR4hhvzS
         LrtmfqlAb8+45F5Zlnl3Tcsq1W0214/7yOMpDl6P8mj45akJCfomCsr1Muq2CTwH4T
         G986kQPebIILw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c9c47510002>; Thu, 28 Mar 2019 17:02:30 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id D2C0613EF40;
        Thu, 28 Mar 2019 17:02:24 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id AF38F1E1124; Thu, 28 Mar 2019 17:02:24 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, marek.vasut@gmail.com, richard@nod.at,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] dt-binding: mtd: physmap: Add example using addr-gpios property
Date:   Thu, 28 Mar 2019 17:02:16 +1300
Message-Id: <20190328040217.1895-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328040217.1895-1-chris.packham@alliedtelesis.co.nz>
References: <20190328040217.1895-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an example showing how to use the addr-gpios property to deal with a
system with limited IO space.

Cc: devicetree@vger.kernel.org
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/mtd/mtd-physmap.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Docu=
mentation/devicetree/bindings/mtd/mtd-physmap.txt
index 7df0dcaccb7d..c69f4f065d23 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
@@ -96,3 +96,19 @@ An example using SRAM:
 		bank-width =3D <2>;
 	};
=20
+An example using gpio-addrs
+
+	flash@20000000 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "cfi-flash", "jedec-flash";
+		reg =3D <0x20000000 0x02000000>;
+		ranges =3D <0 0x00000000 0x02000000
+		          1 0x02000000 0x02000000>;
+		bank-width =3D <2>;
+		addr-gpios =3D <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		partition@0 {
+			label =3D "test-part1";
+			reg =3D <0 0x04000000>;
+		};
+	};
--=20
2.21.0

