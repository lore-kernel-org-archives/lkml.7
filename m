Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DE4206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCDUUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:20:33 -0500
Received: from shell.v3.sk ([90.176.6.54]:53442 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfCDUUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:20:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C852510296E;
        Mon,  4 Mar 2019 21:20:27 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ph1FmLhma25O; Mon,  4 Mar 2019 21:20:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 014B810297E;
        Mon,  4 Mar 2019 21:20:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zzeNJpIUaPIT; Mon,  4 Mar 2019 21:20:17 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B8A3D102981;
        Mon,  4 Mar 2019 21:20:16 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 3/5] dt-bindings: display: armada: Improve the LCDC documentation
Date:   Mon,  4 Mar 2019 21:20:04 +0100
Message-Id: <20190304202006.3863-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304202006.3863-1-lkundrak@v3.sk>
References: <20190304202006.3863-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port is a child, not a property. And should be accompanied by an
example. Plus a pair of cosmetic changes that don't seem to deserve a
separate commit.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Minor adjustments to the commit message wording.

 .../bindings/display/marvell,armada-lcdc.txt     | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/marvell,armada-lcd=
c.txt b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
index 46525ea3e646..2606a8efc956 100644
--- a/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
+++ b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
@@ -1,10 +1,11 @@
-Device Tree bindings for Armada DRM CRTC driver
+Marvell Armada LCD controller
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
 Required properties:
+
  - compatible: value should be "marvell,dove-lcd".
  - reg: base address and size of the LCD controller
  - interrupts: single interrupt number for the LCD controller
- - port: video output port with endpoints, as described by graph.txt
=20
 Optional properties:
=20
@@ -19,6 +20,11 @@ Note: all clocks are optional but at least one must be=
 specified.
 Further clocks may be added in the future according to requirements of
 different SoCs.
=20
+Required child nodes:
+
+- port: video output port with endpoints, as described by
+  Documentation/devicetree/bindings/graph.txt
+
 Example:
=20
 	lcd0: lcd-controller@820000 {
@@ -27,4 +33,10 @@ Example:
 		interrupts =3D <47>;
 		clocks =3D <&si5351 0>;
 		clock-names =3D "ext_ref_clk_1";
+
+		lcd0_port: port {
+			lcd0_rgb_out: endpoint {
+				remote-endpoint =3D <&encoder_rgb_in>;
+			};
+		};
 	};
--=20
2.20.1

