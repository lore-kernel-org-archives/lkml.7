Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A70C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6035C2465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfLTHCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:02:19 -0500
Received: from [167.172.186.51] ([167.172.186.51]:59384 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbfLTHCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:02:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 34B6DDFCA9;
        Fri, 20 Dec 2019 07:02:20 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id f5A35gHhxYqh; Fri, 20 Dec 2019 07:02:19 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CF188DFCAA;
        Fri, 20 Dec 2019 07:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BNAij8zkxaj4; Fri, 20 Dec 2019 07:02:19 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 819DADFCA9;
        Fri, 20 Dec 2019 07:02:19 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] USB: EHCI: ehci-mv: make the PHY optional
Date:   Fri, 20 Dec 2019 08:02:10 +0100
Message-Id: <20191220070210.239960-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may be using a NOP transceiver and those are treated specially by the
USB core and return -ENODEV with devm_phy_get().

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 21eb32baf9380..c8717f06cd8cb 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -127,7 +127,7 @@ static int mv_ehci_probe(struct platform_device *pdev=
)
 		ehci_mv->set_vbus =3D pdata->set_vbus;
 	}
=20
-	ehci_mv->phy =3D devm_phy_get(&pdev->dev, "usb");
+	ehci_mv->phy =3D devm_phy_optional_get(&pdev->dev, "usb");
 	if (IS_ERR(ehci_mv->phy)) {
 		retval =3D PTR_ERR(ehci_mv->phy);
 		if (retval !=3D -EPROBE_DEFER)
--=20
2.24.1

