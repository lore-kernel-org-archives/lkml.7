Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAE5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809D12133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802859;
	bh=Qxmb6vn3g3QEs2Y31wCulIpv1Hya/mij5H+crVxaM88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OEH1lWt1bOK657MnAgZvc/1z4WPTXDd2ssmDO9t8si1evykD/628D8zy5Z/paRx1N
	 BRkZiD8v7D5pboYVQWn3hxwMPJO/oD9X85WLRsr5HaUIBm5Iu+RBencp3wKgnVTeeF
	 P3WHevhW4K0t9TXyYKh1a5mhHJdM/OMGPtWD8qdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfHNROS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfHNROO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:14:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CCF62084D;
        Wed, 14 Aug 2019 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802853;
        bh=Qxmb6vn3g3QEs2Y31wCulIpv1Hya/mij5H+crVxaM88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHC3Wa+T57ba0CnRsEa+eahM0T0ONgixcwBgYy5DJZQc0CmI5Mx47k3Ed9itIOh6e
         w38N+N0nhJgd4irFPqgR+vFCyM7Lvg/C3d5XJqqmRdsBLT77ogGxJTd/sqbgPZPCLE
         qAAe7tln71Cfyp1EV8mUtcmJ8Cq3UTcSGWPOB6js=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+d6a5a1a3657b596ef132@syzkaller.appspotmail.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 52/69] can: peak_usb: pcan_usb_pro: Fix info-leaks to USB devices
Date:   Wed, 14 Aug 2019 19:01:50 +0200
Message-Id: <20190814165749.015597775@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>

commit ead16e53c2f0ed946d82d4037c630e2f60f4ab69 upstream.

Uninitialized Kernel memory can leak to USB devices.

Fix by using kzalloc() instead of kmalloc() on the affected buffers.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+d6a5a1a3657b596ef132@syzkaller.appspotmail.com
Fixes: f14e22435a27 ("net: can: peak_usb: Do not do dma on the stack")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -500,7 +500,7 @@ static int pcan_usb_pro_drv_loaded(struc
 	u8 *buffer;
 	int err;
 
-	buffer = kmalloc(PCAN_USBPRO_FCT_DRVLD_REQ_LEN, GFP_KERNEL);
+	buffer = kzalloc(PCAN_USBPRO_FCT_DRVLD_REQ_LEN, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 


