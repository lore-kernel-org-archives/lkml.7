Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D738C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1814233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbfHVJde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:33:34 -0400
Received: from shell.v3.sk ([90.176.6.54]:35758 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733216AbfHVJdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:33:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8C53ED7562;
        Thu, 22 Aug 2019 11:33:27 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cszP_4J_skTE; Thu, 22 Aug 2019 11:33:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0FB58D7574;
        Thu, 22 Aug 2019 11:27:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UvxyHw--d7gz; Thu, 22 Aug 2019 11:26:48 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 865E3D7559;
        Thu, 22 Aug 2019 11:26:47 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 04/20] dt-bindings: mrvl,intc: Add a MMP3 interrupt controller
Date:   Thu, 22 Aug 2019 11:26:27 +0200
Message-Id: <20190822092643.593488-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822092643.593488-1-lkundrak@v3.sk>
References: <20190822092643.593488-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to MMP2 one, but has an extra range for the other core. The
muxes stay the same.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Reformat the compatible property documentation to higlight the valid
  combinations
- Drop an unneeded mmp3-intc example

 .../bindings/interrupt-controller/mrvl,intc.txt    | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mrvl,=
intc.txt b/Documentation/devicetree/bindings/interrupt-controller/mrvl,in=
tc.txt
index 608fee15a4cfc..a0ed02725a9d7 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.tx=
t
+++ b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.tx=
t
@@ -1,13 +1,17 @@
 * Marvell MMP Interrupt controller
=20
 Required properties:
-- compatible : Should be "mrvl,mmp-intc", "mrvl,mmp2-intc" or
-  "mrvl,mmp2-mux-intc"
+- compatible : Should be
+               "mrvl,mmp-intc" on Marvel MMP,
+               "mrvl,mmp2-intc" along with "mrvl,mmp2-mux-intc" on MMP2 =
or
+               "marvell,mmp3-intc" with "mrvl,mmp2-mux-intc" on MMP3
 - reg : Address and length of the register set of the interrupt controll=
er.
   If the interrupt controller is intc, address and length means the rang=
e
-  of the whole interrupt controller. If the interrupt controller is mux-=
intc,
-  address and length means one register. Since address of mux-intc is in=
 the
-  range of intc. mux-intc is secondary interrupt controller.
+  of the whole interrupt controller. The "marvell,mmp3-intc" controller
+  also has a secondary range for the second CPU core.  If the interrupt
+  controller is mux-intc, address and length means one register. Since
+  address of mux-intc is in the range of intc. mux-intc is secondary
+  interrupt controller.
 - reg-names : Name of the register set of the interrupt controller. It's
   only required in mux-intc interrupt controller.
 - interrupts : Should be the port interrupt shared by mux interrupts. It=
's
--=20
2.21.0

