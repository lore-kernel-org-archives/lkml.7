Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56784FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB9F20869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WAOLY0Cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438630AbfJQH6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:58:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50140 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732594AbfJQH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:58:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9H7w560017305;
        Thu, 17 Oct 2019 02:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571299085;
        bh=PB8P3M92Qr+BuxLmFcudWc9V7nMyMBfC6vJnswIve6k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WAOLY0CqXUZDnoyC1csA83T49deZ5hd4eG12f+WZF94jFvUSVUOBs4xgUbk9l5sSq
         T16gihJO88TT9GDyOaVobwU1KyT/4akLLQoFdyDm7JZRyM3dWa41xT/2M2DHsbVxAG
         2+eM4Up+0t77bVga4ROmziYW9qTye9JxGpvjaY0c=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9H7w5Ke015520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Oct 2019 02:58:05 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 17
 Oct 2019 02:57:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 17 Oct 2019 02:58:05 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9H7w2Gd102521;
        Thu, 17 Oct 2019 02:58:03 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: cdns3: Error out if USB_DR_MODE_UNKNOWN in cdns3_core_init_role()
Date:   Thu, 17 Oct 2019 10:58:01 +0300
Message-ID: <20191017075801.8734-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016131808.GB56859@kroah.com>
References: <20191016131808.GB56859@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB_DR_MODE_UNKNOWN should be treated as error as it is done in
cdns3_drd_update_mode().

Fixes: 02ffc26df96b ("usb: cdns3: fix cdns3_core_init_role()")
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/cdns3/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 1109dc5a4c39..c2123ef8d8a3 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -166,7 +166,6 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 		goto err;
 
 	switch (cdns->dr_mode) {
-	case USB_DR_MODE_UNKNOWN:
 	case USB_DR_MODE_OTG:
 		ret = cdns3_hw_role_switch(cdns);
 		if (ret)
@@ -182,6 +181,9 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 		if (ret)
 			goto err;
 		break;
+	default:
+		ret = -EINVAL;
+		goto err;
 	}
 
 	return ret;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

