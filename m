Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F63FECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D070821835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ioAtB1uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfJGMQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:16:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43416 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfJGMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:16:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97CGD2Z020799;
        Mon, 7 Oct 2019 07:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570450573;
        bh=JT6RnosxlMe8SvOy1VwR606ZNqg+8XpNbkC5dXgqkvo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ioAtB1uO2dWk6Kmff/0tXOG2aXczU4w1PLeI9HIbXuj1HxbO/xIMATdpAEIFQw9Bq
         nrDUXzmgzqfVQiR3YiMcHIP1tW+aV4SO/6vAclKU7GscwLIFc20s5/RLVKzax7pFtY
         CWU5Q3cIQjtVc4eBt8+WMH7+Qc/FeLmWm7U2xRRI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x97CGDi8070468
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Oct 2019 07:16:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 07:16:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 07:16:11 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97CG6fM070909;
        Mon, 7 Oct 2019 07:16:11 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <pawell@cadence.com>
CC:     <peter.chen@nxp.com>, <nsekhar@ti.com>, <kurahul@cadence.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] usb: cdns3: gadget: Fix full-speed mode
Date:   Mon, 7 Oct 2019 15:16:01 +0300
Message-ID: <20191007121601.25996-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007121601.25996-1-rogerq@ti.com>
References: <20191007121601.25996-1-rogerq@ti.com>
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

