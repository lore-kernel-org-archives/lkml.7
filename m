Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3974CC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 09:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF402067D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 09:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="jA+nkWg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKXJfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 04:35:44 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47947 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfKXJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 04:35:44 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E4BE38066C;
        Sun, 24 Nov 2019 22:35:41 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1574588141;
        bh=DjOBw6Xpojk9+dBNOgHOjFHBLzPNhypo3ES2j4tw81Q=;
        h=From:To:Cc:Subject:Date;
        b=jA+nkWg/GArYd7kK10OBv5GD3RwwDGiA5EYA01K5XIr3CCe78xBgH8k2AT29EIJ+y
         bdmYTvYKvEKp6FM0hDXe42FDkEVPFUr9Fn3aFZard4a39hP/37M7VCMzNdXuGFoJom
         cV+Rqbm8pz9o+7JFy0v2LTnDbpM1urJxONekC/6Tg/a4D9mSfXkc9GFjLo7zlGAz+w
         ggaiz9J0GpWsvlShre1P/NKb+yxl1MKWChWYsKlnH/QBP7FWaK6obJf6Mk/qA0amBj
         lOKeX/yA0JsdzODVt/H09eI4O6+MN7PqD4fI16bwludTxQmhzJUYaQZ7MHLkKXWkv4
         zq9cItepE9avQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dda4ee80000>; Sun, 24 Nov 2019 22:35:41 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 753B313ED45;
        Sun, 24 Nov 2019 22:35:34 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E964F280063; Sun, 24 Nov 2019 22:35:35 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] ARM: mvebu: Enable MBUS error propagation
Date:   Sun, 24 Nov 2019 22:35:29 +1300
Message-Id: <20191124093529.32399-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U-boot disables MBUS error propagation for Armada-385. The effect of
this on the kernel is that any access to a mapped but inaccessible
address causes the system to hang.

By enabling MBUS error propagation the kernel can raise a Bus Error and
panic to restart the system.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    We've encountered an issue where rogue accesses to PCI-e space cause =
an
    Armada-385 system to lockup. We've found that enabling MBUS error
    propagation lets us get a bus error which at least gives us a panic t=
o
    help identify what was accessed.
   =20
    U-boot clears the IO Err Prop Enable Bit[1] but so far no-one seems t=
o
    know why.
   =20
    I wasn't sure where to put this code. There is similar code for kirwo=
od
    in the equivalent dt_init function. On Armada-XP the register is part=
 of
    the Core Coherency Fabric block (for A385 it's documented as part of =
the
    CCF block).
   =20
    --
    [1] - https://gitlab.denx.de/u-boot/u-boot/blob/master/arch/arm/mach-=
mvebu/cpu.c#L489

 arch/arm/boot/dts/armada-38x.dtsi |  5 +++++
 arch/arm/mach-mvebu/board-v7.c    | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada=
-38x.dtsi
index 3f4bb44d85f0..3214c67433eb 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -386,6 +386,11 @@
 				      <0x20250 0x8>;
 			};
=20
+			ioerrc: io-err-control@20200 {
+				compatible =3D "marvell,io-err-control";
+				reg =3D <0x20200 0x4>;
+			};
+
 			mpic: interrupt-controller@20a00 {
 				compatible =3D "marvell,mpic";
 				reg =3D <0x20a00 0x2d0>, <0x21070 0x58>;
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v=
7.c
index d2df5ef9382b..fb7718386ef9 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -138,10 +138,36 @@ static void __init i2c_quirk(void)
 	}
 }
=20
+#define MBUS_ERR_PROP_EN BIT(8)
+
+/*
+ * U-boot disables MBUS error propagation. Re-enable it so we
+ * can handle them as Bus Errors.
+ */
+static void __init enable_mbus_error_propagation(void)
+{
+	struct device_node *np =3D
+		of_find_compatible_node(NULL, NULL, "marvell,io-err-control");
+
+	if (np) {
+		void __iomem *reg;
+
+		reg =3D of_iomap(np, 0);
+		if (reg) {
+			u32 val;
+
+			val =3D readl_relaxed(reg);
+			writel_relaxed(val | MBUS_ERR_PROP_EN, reg);
+		}
+		of_node_put(np);
+	}
+}
+
 static void __init mvebu_dt_init(void)
 {
 	if (of_machine_is_compatible("marvell,armadaxp"))
 		i2c_quirk();
+	enable_mbus_error_propagation();
 }
=20
 static void __init armada_370_xp_dt_fixup(void)
@@ -191,6 +217,7 @@ DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/3=
85 (Device Tree)")
 	.l2c_aux_val	=3D 0,
 	.l2c_aux_mask	=3D ~0,
 	.init_irq       =3D mvebu_init_irq,
+	.init_machine	=3D mvebu_dt_init,
 	.restart	=3D mvebu_restart,
 	.dt_compat	=3D armada_38x_dt_compat,
 MACHINE_END
--=20
2.24.0

