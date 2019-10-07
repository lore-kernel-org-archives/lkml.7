Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CA2C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9700621721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f1SvghfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJGMQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:16:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42698 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfJGMQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:16:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97CGBhW002292;
        Mon, 7 Oct 2019 07:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570450571;
        bh=luxPLzNAkImkqjzDPkTQhoXBhGNskTrAYJY6hFR5nmA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f1SvghfH1q1BAwutukAL/iITgkUw3QQ4S4tzdNoF96b7MsWWjn7wrv2RSg8FgKdN6
         y4CVGVcMm0UGvjlQ6uvGFZAK96GPB3x/rwQd4CcwnO0/mmTtpGjQwY2xhHeJNnYSBI
         o4VU/wrYrxGxPk5i+16RE2GHx9BsGtZF7Az8LrzQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x97CGBGw070332
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Oct 2019 07:16:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 07:16:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 07:16:09 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97CG6fL070909;
        Mon, 7 Oct 2019 07:16:09 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <pawell@cadence.com>
CC:     <peter.chen@nxp.com>, <nsekhar@ti.com>, <kurahul@cadence.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] usb: cdns3: fix cdns3_core_init_role()
Date:   Mon, 7 Oct 2019 15:16:00 +0300
Message-ID: <20191007121601.25996-2-rogerq@ti.com>
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
---
 drivers/usb/cdns3/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 06f1e105be4e..1109dc5a4c39 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -160,10 +160,28 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	if (ret)
 		goto err;
 
-	if (cdns->dr_mode != USB_DR_MODE_OTG) {
+	/* Initialize idle role to start with */
+	ret = cdns3_role_start(cdns, USB_ROLE_NONE);
+	if (ret)
+		goto err;
+
+	switch (cdns->dr_mode) {
+	case USB_DR_MODE_UNKNOWN:
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
 	}
 
 	return ret;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

