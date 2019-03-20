Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1AFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3B021871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfCTIVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:21:24 -0400
Received: from shell.v3.sk ([90.176.6.54]:52090 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbfCTIVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:21:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 808281032FB;
        Wed, 20 Mar 2019 09:21:16 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P4PyZnp4MVGR; Wed, 20 Mar 2019 09:21:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2DA9D1031D4;
        Wed, 20 Mar 2019 09:21:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s4fyvSnx2IAA; Wed, 20 Mar 2019 09:21:02 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7499B1032FF;
        Wed, 20 Mar 2019 09:21:01 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 5/5] dt-bindings: display: armada: Document bus-width property
Date:   Wed, 20 Mar 2019 09:20:57 +0100
Message-Id: <20190320082057.856943-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320082057.856943-1-lkundrak@v3.sk>
References: <20190320082057.856943-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to choose a different pixel format for the
endpoint. Modelled after what other LCD controllers use, including
marvell,pxa2xx-lcdc and atmel,hlcdc-display-controller and perhaps more.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v2:
- Collected the Reviewed-by tag

 .../devicetree/bindings/display/marvell,armada-lcdc.txt     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/marvell,armada-lcd=
c.txt b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
index 0ea4cbe5a32e..d1dadaaeee73 100644
--- a/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
+++ b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
@@ -25,6 +25,11 @@ Required child nodes:
=20
 - port: video output port with endpoints, as described by
   Documentation/devicetree/bindings/graph.txt
+  The endpoints can optionally specify the following property:
+
+  - bus-width: recognized values are <12>, <16>, <18> and <24>, that
+    select "rgb444", "rgb565", "rgb666" or "rgb888" pixel format
+    respectively. Defaults to <24> if unspecified.
=20
 Example:
=20
@@ -37,6 +42,7 @@ Example:
=20
 		lcd0_port: port {
 			lcd0_rgb_out: endpoint {
+				bus-width =3D <24>;
 				remote-endpoint =3D <&encoder_rgb_in>;
 			};
 		};
--=20
2.20.1

