Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9122FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5811F20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AmipB06h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfLWGrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:47:43 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38474 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfLWGrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:47:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBN6leCk025408;
        Mon, 23 Dec 2019 00:47:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577083660;
        bh=EO+Ty98cVaBVVbs6cA70LmSk3Hb7Knjcq6kIN2H+6tk=;
        h=From:To:CC:Subject:Date;
        b=AmipB06h4UfWSh6bnEVJd8Sku4m1/SYoRqEd+RWpC/pkKXouvG9CQUmaKXtabahrV
         ccO8zEe4/GqpKC0f6oTxuVJ+a82/d0poqVxDMMOeTzXPRwXZCvfyH72a1oUwC72nzM
         3oHWr0zAsTTr3DPTvG5quzfNSzO6WYdZa1Pz4P4E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBN6leXD050926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 00:47:40 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 00:47:38 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 00:47:38 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBN6laOu104198;
        Mon, 23 Dec 2019 00:47:36 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <nsekhar@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: gadget: legacy: set max_speed to super-speed
Date:   Mon, 23 Dec 2019 08:47:35 +0200
Message-ID: <20191223064735.24662-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These interfaces do support super-speed so let's not
limit maximum speed to high-speed.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---

Hi Felipe,

Please queue this for -rc. Thanks.

cheers,
-roger

 drivers/usb/gadget/legacy/cdc2.c  | 2 +-
 drivers/usb/gadget/legacy/g_ffs.c | 2 +-
 drivers/usb/gadget/legacy/multi.c | 2 +-
 drivers/usb/gadget/legacy/ncm.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/legacy/cdc2.c b/drivers/usb/gadget/legacy/cdc2.c
index da1c37933ca1..8d7a556ece30 100644
--- a/drivers/usb/gadget/legacy/cdc2.c
+++ b/drivers/usb/gadget/legacy/cdc2.c
@@ -225,7 +225,7 @@ static struct usb_composite_driver cdc_driver = {
 	.name		= "g_cdc",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
-	.max_speed	= USB_SPEED_HIGH,
+	.max_speed	= USB_SPEED_SUPER,
 	.bind		= cdc_bind,
 	.unbind		= cdc_unbind,
 };
diff --git a/drivers/usb/gadget/legacy/g_ffs.c b/drivers/usb/gadget/legacy/g_ffs.c
index b640ed3fcf70..ae6d8f7092b8 100644
--- a/drivers/usb/gadget/legacy/g_ffs.c
+++ b/drivers/usb/gadget/legacy/g_ffs.c
@@ -149,7 +149,7 @@ static struct usb_composite_driver gfs_driver = {
 	.name		= DRIVER_NAME,
 	.dev		= &gfs_dev_desc,
 	.strings	= gfs_dev_strings,
-	.max_speed	= USB_SPEED_HIGH,
+	.max_speed	= USB_SPEED_SUPER,
 	.bind		= gfs_bind,
 	.unbind		= gfs_unbind,
 };
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
diff --git a/drivers/usb/gadget/legacy/ncm.c b/drivers/usb/gadget/legacy/ncm.c
index 8465f081e921..c61e71ba7045 100644
--- a/drivers/usb/gadget/legacy/ncm.c
+++ b/drivers/usb/gadget/legacy/ncm.c
@@ -197,7 +197,7 @@ static struct usb_composite_driver ncm_driver = {
 	.name		= "g_ncm",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
-	.max_speed	= USB_SPEED_HIGH,
+	.max_speed	= USB_SPEED_SUPER,
 	.bind		= gncm_bind,
 	.unbind		= gncm_unbind,
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

