Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558E6C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A32B206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="el/xIRmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbfHZNLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:11:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36274 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731526AbfHZNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:11:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7QDB31c068390;
        Mon, 26 Aug 2019 08:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566825063;
        bh=RFJRbu+lxvwQh27lC/rFrMFalHNlwSB8srZD2/w+1pQ=;
        h=From:To:CC:Subject:Date;
        b=el/xIRmMPOU9+sL7bDO5L85iz4ZwR6PFox0Js0EehNAkDd5VF6MF8tI5kZSAtGWGW
         ppPy1ximQvJn2F6QjIjQxLF2WmbFEC76YDZ0fDaeoaZHyhaUHLBciNomQ+SlSyaZgJ
         LwyXi9fxBb1gRliYeFTCCGJMqwrXOp5osgvuYZrg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7QDB2Vk075712
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Aug 2019 08:11:03 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 26
 Aug 2019 08:11:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 26 Aug 2019 08:11:01 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7QDAx7T084458;
        Mon, 26 Aug 2019 08:11:00 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <jianqiang.tang@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: dwc3: don't set gadget->is_otg flag
Date:   Mon, 26 Aug 2019 16:10:58 +0300
Message-ID: <20190826131058.17393-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts
commit 6a4290cc28be1 ("usb: dwc3: gadget: set the OTG flag in dwc3 gadget driver.")

We don't yet support any of the OTG mechanisms (HNP/SRP/ADP)
and are not setting gadget->otg_caps, so don't set gadget->is_otg
flag.

If we do then we end up publishing a OTG1.0 descriptor in
the gadget descriptor which causes device enumeration to fail
if we are connected to a host with CONFIG_USB_OTG enabled.

Host side log without this patch

[   96.720453] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[   96.901391] usb 1-1: Dual-Role OTG device on non-HNP port
[   96.907552] usb 1-1: set a_alt_hnp_support failed: -32
[   97.060447] usb 1-1: new high-speed USB device number 3 using xhci-hcd
[   97.241378] usb 1-1: Dual-Role OTG device on non-HNP port
[   97.247536] usb 1-1: set a_alt_hnp_support failed: -32
[   97.253606] usb usb1-port1: attempt power cycle
[   97.960449] usb 1-1: new high-speed USB device number 4 using xhci-hcd
[   98.141383] usb 1-1: Dual-Role OTG device on non-HNP port
[   98.147540] usb 1-1: set a_alt_hnp_support failed: -32
[   98.300453] usb 1-1: new high-speed USB device number 5 using xhci-hcd
[   98.481391] usb 1-1: Dual-Role OTG device on non-HNP port
[   98.487545] usb 1-1: set a_alt_hnp_support failed: -32
[   98.493532] usb usb1-port1: unable to enumerate USB device

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/gadget.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 173f5329d3d9..48213421e9e9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3318,7 +3318,6 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
 	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
-	dwc->gadget.is_otg		= dwc->dr_mode == USB_DR_MODE_OTG;
 	dwc->gadget.lpm_capable		= true;
 
 	/*
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

