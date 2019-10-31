Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A8DCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566C520862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vZ6B5btc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfJaKmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:42:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59576 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfJaKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:42:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9VAgDDo034865;
        Thu, 31 Oct 2019 05:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572518533;
        bh=gO70mmf9IcQUlslo7qjHE3n0N/IXcdjUkVz4JHG/ARU=;
        h=From:To:CC:Subject:Date;
        b=vZ6B5btco0icM2RvPA2GvrDsNC8vYz61kUNrh3rjVn2Nwi8NuVZc08IKolknZXEzx
         0JLettfzXHF6HWxz0TNXqoB58glpP1hFQM+Wl+1kvNilTT+fGpJWhFR8m4vdq/GJlv
         etCE8rAAmsbdHd59bie/sObhoFU15Z4ObgWFQp7Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9VAgDuI085979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Oct 2019 05:42:13 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 31
 Oct 2019 05:41:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 31 Oct 2019 05:41:59 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9VAgA3U084883;
        Thu, 31 Oct 2019 05:42:11 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: gadget: legacy: multi: set max speed to super-speed
Date:   Thu, 31 Oct 2019 12:42:09 +0200
Message-ID: <20191031104209.25451-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

multi uses ACM, ECM/RNDIS and mass storage interfaces, all
of which support super-speed. Let's not limit g_multi
to high-speed.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/gadget/legacy/multi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/multi.c b/drivers/usb/gadget/legacy/multi.c
index 50515f9e1022..ec9749845660 100644
--- a/drivers/usb/gadget/legacy/multi.c
+++ b/drivers/usb/gadget/legacy/multi.c
@@ -482,7 +482,7 @@ static struct usb_composite_driver multi_driver = {
 	.name		= "g_multi",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
-	.max_speed	= USB_SPEED_HIGH,
+	.max_speed	= USB_SPEED_SUPER,
 	.bind		= multi_bind,
 	.unbind		= multi_unbind,
 	.needs_serial	= 1,
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

