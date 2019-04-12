Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E153C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15AB20652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="mNaYYAhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDLFCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 01:02:38 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40508 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfDLFCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 01:02:36 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 84092891A9;
        Fri, 12 Apr 2019 17:02:31 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1555045351;
        bh=QRINkbBDwCGpQne78Rboej0Vlek3WXEGOBoch9bHle8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mNaYYAhNyU0wJZcu0eE/VSARHJKL0qpygbs5JGzbwMRsDz5A6gkw+T4p1Z0gjrGzx
         RX+oU/cFsT7yG6GAWtXpKbZZp0pK7WYA/P7f1XyyXKmSkyZvPJCcCd6/yyZWwmWJy0
         7ESyb/HIhkpKh92hA9ZckGAhPq+J+S0DMN99CxrH/Q5yPHudw0e3ADVKh9HuxPOkGJ
         Iu9LQzDHntxml1o0ljeNAYFSOWIGxUT7JTg0Poq/eQl0wmUO5O7NoZpsErbeQrHV86
         Y7Cj4stvACiveVtk6Dlr/ttuxiJjxjdN5oC8Euz7KxflgYV0/2eJ2TbMUt2et7dGCf
         fafFJTi1P1ANg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cb01be20001>; Fri, 12 Apr 2019 17:02:31 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 980F313EEED;
        Fri, 12 Apr 2019 17:02:26 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 5DC551E1D9C; Fri, 12 Apr 2019 17:02:26 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/3] dt-bindings: spi: Add spi-mux-gpio
Date:   Fri, 12 Apr 2019 17:02:11 +1200
Message-Id: <20190412050213.17698-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for spi-mux-gpio which is a slightly more
complicated hardware implementation of using gpios to steer SPI chip
selects.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/spi/spi-mux-gpio.txt  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux-gpio.tx=
t

diff --git a/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt b/Doc=
umentation/devicetree/bindings/spi/spi-mux-gpio.txt
new file mode 100644
index 000000000000..a32f25321d37
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
@@ -0,0 +1,45 @@
+SPI bus gpio multiplexer
+
+The SPI bus gpio multiplexer can be used to implement more complicated a=
ccess
+logic than can be supported with the cs-gpios property of a SPI bus.
+
+In the example below we have a SoC with a single SPI CS that is gated by=
 the
+state of a gpio to select the desired SPI device.
+
+     +----------+  CS    +-----+ CS0  +----+
+     |          |--------|     |------|    |
+     |          |        | \ / |      +----+
+     |   SoC    |        |  +  |
+     |          |  GPIO  | / \ | CS1  +----+
+     |          |--------|     |------|    |
+     +----------+        +-----+      +----+
+
+Required properties:
+- compatible	- must be "spi-mux-gpio"
+- gpios		- gpios used to implement the multiplexing logic
+- spi-parent-bus - parent spi bus to use
+
+Optional properties:
+- spi-parent-cs - chip select on parent bus to use. Defaults to 0 if not
+                  specified.
+
+Example for a multiplexer with a single gpio:
+
+	spi-mux {
+		compatible =3D "spi-mux-gpio";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		gpios =3D <&gpio0 1 0>;
+		spi-parent-bus =3D <&spi0>;
+		spi-parent-cs =3D <0>;
+
+		spi-dev@0 {
+			compatible =3D "...";
+			reg =3D <0>;
+		}
+
+		spi-dev@1 {
+			compatible =3D "...";
+			reg =3D <1>;
+		}
+	};
--=20
2.21.0

