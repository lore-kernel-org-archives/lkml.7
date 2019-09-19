Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8990C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91C121A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930786;
	bh=r0m26UKHtA2rH1mqxbDjBWhP355JLVzzf6ub9mODwyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qnpMzvfIqpi65Bmo6IWImrY3mlxKqZRyTqvCJEhn1NHGK4Rflh1QCdMa4zT4vaLbz
	 GmTEjDC2qrnAYRGdkf0zOotIESHV5o1Ek2YH3Ki/V40EiF96h9V3+Pc4kZTOphXJz+
	 6pK28d4DrCd69BWQ9GxkC5TiacCtk599Nkt/hq1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405205AbfISWG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405174AbfISWGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:06:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61BA421A4C;
        Thu, 19 Sep 2019 22:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930778;
        bh=r0m26UKHtA2rH1mqxbDjBWhP355JLVzzf6ub9mODwyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wPkPF3nxZI/m2TCs1Y8tBVyhQiTpOVAThD1+NZ/pPsTCGU0+kp85olMyNL8PZt227
         FaIHyyTGiV0xBzxYrQ22C/X7K6EwYzk4knIvDxgxiIrjdPAKQq7VXEmzsUmolm3l1z
         0ACWz2+ls0TuXBLfQ55e+3UdWT1LLKsYT8jRQMpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5.2 003/124] phy: renesas: rcar-gen3-usb2: Disable clearing VBUS in over-current
Date:   Fri, 20 Sep 2019 00:01:31 +0200
Message-Id: <20190919214819.317756759@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit e6839c31a608e79f2057fab987dd814f5d3477e6 upstream.

The hardware manual should be revised, but the initial value of
VBCTRL.OCCLREN is set to 1 actually. If the bit is set, the hardware
clears VBCTRL.VBOUT and ADPCTRL.DRVVBUS registers automatically
when the hardware detects over-current signal from a USB power switch.
However, since the hardware doesn't have any registers which
indicates over-current, the driver cannot handle it at all. So, if
"is_otg_channel" hardware detects over-current, since ADPCTRL.DRVVBUS
register is cleared automatically, the channel cannot be used after
that.

To resolve this behavior, this patch sets the VBCTRL.OCCLREN to 0
to keep ADPCTRL.DRVVBUS even if the "is_otg_channel" hardware
detects over-current. (We assume a USB power switch itself protects
over-current and turns the VBUS off.)

This patch is inspired by a BSP patch from Kazuya Mizuguchi.

Fixes: 1114e2d31731 ("phy: rcar-gen3-usb2: change the mode to OTG on the combined channel")
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -61,6 +61,7 @@
 					 USB2_OBINT_IDDIGCHG)
 
 /* VBCTRL */
+#define USB2_VBCTRL_OCCLREN		BIT(16)
 #define USB2_VBCTRL_DRVVBUSSEL		BIT(8)
 
 /* LINECTRL1 */
@@ -374,6 +375,7 @@ static void rcar_gen3_init_otg(struct rc
 	writel(val, usb2_base + USB2_LINECTRL1);
 
 	val = readl(usb2_base + USB2_VBCTRL);
+	val &= ~USB2_VBCTRL_OCCLREN;
 	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
 	val = readl(usb2_base + USB2_ADPCTRL);
 	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);


