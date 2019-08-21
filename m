Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA16C3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1422D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E29dEd83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfHUKMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:12:10 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33088 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfHUKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:12:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7LAC6hW037490;
        Wed, 21 Aug 2019 05:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566382326;
        bh=WNO04hK4EhcDleF0FXAgtkk2jCq84VoSQz9dZLs15O0=;
        h=From:To:CC:Subject:Date;
        b=E29dEd83zaZhDw5xBCNJzTwnO1xluZUhiiTMmv1bg4nVlJw48r4D5HBGR5igMseg2
         CZpfnngfNnissZYmVKrf9SuMs4jlWJ5ZsMzs+qCb1d0La7hWHTimnpZhGOSdbKNNE/
         wXZ+YCeZOPx/oTpKJ0S0cHfs8vOHAma+QUeN0bQI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7LAC6Lt003432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Aug 2019 05:12:06 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 21
 Aug 2019 05:12:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 21 Aug 2019 05:12:05 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7LAC3o8085916;
        Wed, 21 Aug 2019 05:12:04 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>, <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: gadget: udc: core: Fix error case while binding pending gadget drivers
Date:   Wed, 21 Aug 2019 13:12:01 +0300
Message-ID: <20190821101201.5377-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If binding a pending gadget driver fails we should not
remove it from the pending driver list, otherwise it
will cause a segmentation fault later when the gadget driver is
unloaded.

Test case:

- Make sure no UDC is available
- modprobe g_mass_storage file=wrongfile
- Load UDC driver so it becomes available
	lun0: unable to open backing file: wrongfile
- modprobe -r g_mass_storage

[   60.900431] Unable to handle kernel paging request at virtual address dead000000000108
[   60.908346] Mem abort info:
[   60.911145]   ESR = 0x96000044
[   60.914227]   Exception class = DABT (current EL), IL = 32 bits
[   60.920162]   SET = 0, FnV = 0
[   60.923217]   EA = 0, S1PTW = 0
[   60.926354] Data abort info:
[   60.929228]   ISV = 0, ISS = 0x00000044
[   60.933058]   CM = 0, WnR = 1
[   60.936011] [dead000000000108] address between user and kernel address ranges
[   60.943136] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[   60.948691] Modules linked in: g_mass_storage(-) usb_f_mass_storage libcomposite xhci_plat_hcd xhci_hcd usbcore ti_am335x_adc kfifo_buf omap_rng cdns3 rng_core udc_core crc32_ce xfrm_user crct10dif_ce snd_so6
[   60.993995] Process modprobe (pid: 834, stack limit = 0x00000000c2aebc69)
[   61.000765] CPU: 0 PID: 834 Comm: modprobe Not tainted 4.19.59-01963-g065f42a60499 #92
[   61.008658] Hardware name: Texas Instruments SoC (DT)
[   61.014472] pstate: 60000005 (nZCv daif -PAN -UAO)
[   61.019253] pc : usb_gadget_unregister_driver+0x7c/0x108 [udc_core]
[   61.025503] lr : usb_gadget_unregister_driver+0x30/0x108 [udc_core]
[   61.031750] sp : ffff00001338fda0
[   61.035049] x29: ffff00001338fda0 x28: ffff800846d40000
[   61.040346] x27: 0000000000000000 x26: 0000000000000000
[   61.045642] x25: 0000000056000000 x24: 0000000000000800
[   61.050938] x23: ffff000008d7b0d0 x22: ffff0000088b07c8
[   61.056234] x21: ffff000001100000 x20: ffff000002020260
[   61.061530] x19: ffff0000010ffd28 x18: 0000000000000000
[   61.066825] x17: 0000000000000000 x16: 0000000000000000
[   61.072121] x15: 0000000000000000 x14: 0000000000000000
[   61.077417] x13: ffff000000000000 x12: ffffffffffffffff
[   61.082712] x11: 0000000000000030 x10: 7f7f7f7f7f7f7f7f
[   61.088008] x9 : fefefefefefefeff x8 : 0000000000000000
[   61.093304] x7 : ffffffffffffffff x6 : 000000000000ffff
[   61.098599] x5 : 8080000000000000 x4 : 0000000000000000
[   61.103895] x3 : ffff000001100020 x2 : ffff800846d40000
[   61.109190] x1 : dead000000000100 x0 : dead000000000200
[   61.114486] Call trace:
[   61.116922]  usb_gadget_unregister_driver+0x7c/0x108 [udc_core]
[   61.122828]  usb_composite_unregister+0x10/0x18 [libcomposite]
[   61.128643]  msg_cleanup+0x18/0xfce0 [g_mass_storage]
[   61.133682]  __arm64_sys_delete_module+0x17c/0x1f0
[   61.138458]  el0_svc_common+0x90/0x158
[   61.142192]  el0_svc_handler+0x2c/0x80
[   61.145926]  el0_svc+0x8/0xc
[   61.148794] Code: eb03003f d10be033 54ffff21 a94d0281 (f9000420)
[   61.154869] ---[ end trace afb22e9b637bd9a7 ]---
Segmentation fault

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/gadget/udc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 7cf34beb50df..c272c8014772 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1142,7 +1142,7 @@ static int check_pending_gadget_drivers(struct usb_udc *udc)
 		if (!driver->udc_name || strcmp(driver->udc_name,
 						dev_name(&udc->dev)) == 0) {
 			ret = udc_bind_to_driver(udc, driver);
-			if (ret != -EPROBE_DEFER)
+			if (!ret)
 				list_del(&driver->pending);
 			break;
 		}
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

