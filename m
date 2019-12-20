Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A0CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C252465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLTHCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:02:24 -0500
Received: from [167.172.186.51] ([167.172.186.51]:59404 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbfLTHCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:02:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EFD5FDFCAB;
        Fri, 20 Dec 2019 07:02:24 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7QzHhIRQE_fc; Fri, 20 Dec 2019 07:02:24 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8F180DFCAC;
        Fri, 20 Dec 2019 07:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EAJEg_byXsaI; Fri, 20 Dec 2019 07:02:24 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 48964DFCAB;
        Fri, 20 Dec 2019 07:02:24 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] USB: EHCI: ehci-mv: add HSIC support
Date:   Fri, 20 Dec 2019 08:02:18 +0100
Message-Id: <20191220070218.240053-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some special dance is needed to initialize the HSIC port.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 66ec1fdf9fe7d..21eb32baf9380 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -11,6 +11,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/of.h>
 #include <linux/platform_data/mv_usb.h>
 #include <linux/io.h>
=20
@@ -67,6 +68,8 @@ static int mv_ehci_reset(struct usb_hcd *hcd)
 {
 	struct device *dev =3D hcd->self.controller;
 	struct ehci_hcd_mv *ehci_mv =3D hcd_to_ehci_hcd_mv(hcd);
+	struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
+	u32 status;
 	int retval;
=20
 	if (ehci_mv =3D=3D NULL) {
@@ -80,6 +83,14 @@ static int mv_ehci_reset(struct usb_hcd *hcd)
 	if (retval)
 		dev_err(dev, "ehci_setup failed %d\n", retval);
=20
+	if (of_usb_get_phy_mode(dev->of_node) =3D=3D USBPHY_INTERFACE_MODE_HSIC=
) {
+		status =3D ehci_readl(ehci, &ehci->regs->port_status[0]);
+		status |=3D PORT_TEST_FORCE;
+		ehci_writel(ehci, status, &ehci->regs->port_status[0]);
+		status &=3D ~PORT_TEST_FORCE;
+		ehci_writel(ehci, status, &ehci->regs->port_status[0]);
+	}
+
 	return retval;
 }
=20
--=20
2.24.1

