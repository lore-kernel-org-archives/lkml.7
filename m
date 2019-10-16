Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B6FFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5187A218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AXthPd/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392187AbfJPKFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:05:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34278 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfJPKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:05:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GA53DD083529;
        Wed, 16 Oct 2019 05:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571220303;
        bh=3fN5NK1stC3TVcBSIjgs4/Tpem+V0pvjRE5Z5G0ywEU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AXthPd/9+uvhWeGURO9li10+icI0WqRfXdQeS/Iune+mvVnkXasH9EanxahaECuF5
         /1+F3tHwPkIbU4hd9DcLyvNliaFg9AKGgZYp4m+n08L0dQZ9yWStg314vqcppT8ORw
         cc3AqQH28aw4phLSyeepJadhgUmRoqj7JLfhdVvo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GA532J122400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 05:05:03 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 05:04:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 05:05:02 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GA4sKD001596;
        Wed, 16 Oct 2019 05:04:59 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/2] usb: cdns3: gadget: Fix full-speed mode
Date:   Wed, 16 Oct 2019 13:04:52 +0300
Message-ID: <20191016100452.32613-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016100452.32613-1-rogerq@ti.com>
References: <20191016100452.32613-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to disable USB3 PHY for full-speed mode else
gadget mode is broken.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Reviewed-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 228cdc4ab886..157536753b8c 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2571,6 +2571,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
 	switch (max_speed) {
 	case USB_SPEED_FULL:
 		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
+		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
 		break;
 	case USB_SPEED_HIGH:
 		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

