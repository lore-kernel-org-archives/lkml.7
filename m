Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E3DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABC0218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fb7/biK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392201AbfJPKFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:05:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40708 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfJPKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:05:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GA50e8076555;
        Wed, 16 Oct 2019 05:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571220300;
        bh=X9OoVAqkmWigRFAcfWsbH/rWq/4QTLvI1rJbdzVDNHU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Fb7/biK5lCA0Y4A/v4Mzjl8g6rlJ/oCFT96AJT9GohkKpcWgd4GRzAgm5t9htLC9p
         fG0nnf+QUVk6tqAnsbW5LrKYc48XMnbJhz9WTHERNHYa26nyx65UyvLsp21P6GY+j0
         EIIkIC953c2o74sqWGX2BBpTmmNu2QC2iPCb+Zqs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GA50aM047863
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 05:05:00 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 05:04:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 05:04:52 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GA4sKC001596;
        Wed, 16 Oct 2019 05:04:57 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/2] usb: cdns3: fix cdns3_core_init_role()
Date:   Wed, 16 Oct 2019 13:04:51 +0300
Message-ID: <20191016100452.32613-2-rogerq@ti.com>
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

At startup we should trigger the HW state machine
only if it is OTG mode. Otherwise we should just
start the respective role.

Initialize idle role by default. If we don't do this then
cdns3_idle_role_stop() is not called when switching to
host/device role and so lane switch mechanism
doesn't work. This results to super-speed device not working
in one orientation if it was plugged before driver probe.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: Pawel Laszczak <pawell@cadence.com>
Tested-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 06f1e105be4e..c2123ef8d8a3 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -160,10 +160,30 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	if (ret)
 		goto err;
 
-	if (cdns->dr_mode != USB_DR_MODE_OTG) {
+	/* Initialize idle role to start with */
+	ret = cdns3_role_start(cdns, USB_ROLE_NONE);
+	if (ret)
+		goto err;
+
+	switch (cdns->dr_mode) {
+	case USB_DR_MODE_OTG:
 		ret = cdns3_hw_role_switch(cdns);
 		if (ret)
 			goto err;
+		break;
+	case USB_DR_MODE_PERIPHERAL:
+		ret = cdns3_role_start(cdns, USB_ROLE_DEVICE);
+		if (ret)
+			goto err;
+		break;
+	case USB_DR_MODE_HOST:
+		ret = cdns3_role_start(cdns, USB_ROLE_HOST);
+		if (ret)
+			goto err;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
 	}
 
 	return ret;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

