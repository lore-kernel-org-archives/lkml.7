Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbfJOQDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:03:38 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53847 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJOQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:03:38 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKPIL-0007ca-6t; Tue, 15 Oct 2019 17:03:33 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKPIK-0003yf-TL; Tue, 15 Oct 2019 17:03:32 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 2/2] phy: phy-brcm-usb-init: fix use of integer as pointer
Date:   Tue, 15 Oct 2019 17:03:32 +0100
Message-Id: <20191015160332.15244-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015160332.15244-1-ben.dooks@codethink.co.uk>
References: <20191015160332.15244-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xhci_ec_base variable is a pointer, so don't compare
it with an integer.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Al Cooper <alcooperx@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com
---
 drivers/phy/broadcom/phy-brcm-usb-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index fa6dd117c40e..91b5b09589d6 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -707,7 +707,7 @@ static void brcmusb_usb3_otp_fix(struct brcm_usb_init_params *params)
 	void __iomem *xhci_ec_base = params->xhci_ec_regs;
 	u32 val;
 
-	if (params->family_id != 0x74371000 || xhci_ec_base == 0)
+	if (params->family_id != 0x74371000 || !xhci_ec_base)
 		return;
 	brcmusb_writel(0xa20c, USB_XHCI_EC_REG(xhci_ec_base, IRAADR));
 	val = brcmusb_readl(USB_XHCI_EC_REG(xhci_ec_base, IRADAT));
-- 
2.23.0

