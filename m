Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C3EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488B72077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PIk3ArTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDZOuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:50:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5995 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:50:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc31ab20000>; Fri, 26 Apr 2019 07:50:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 07:50:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Apr 2019 07:50:53 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:50:53 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:50:52 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Apr 2019 14:50:52 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc31acb0005>; Fri, 26 Apr 2019 07:50:52 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <linux-usb@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jim Lin <jilin@nvidia.com>
Subject: [PATCH 5/6] usb: dwc2: Adjusted for usb_hub_clear_tt_buffer
Date:   Fri, 26 Apr 2019 22:50:50 +0800
Message-ID: <1556290250-9567-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556290226; bh=v34xjFzSvqBXRMCnwm/8i+4X+lkRZq/wrmlwB+tTkjE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=PIk3ArTS7muqB65o1mklZdn3+sigbcbqGewkqGNt4r0c5Y0/oGVExvB286AzZWkAK
         Pezw85SU7kBxsScACbyPqeR5onlTZD4krMuE01oJ8uFPFjVmSmhbAkvDWtEYhqHf1G
         Zcmze7SeM0ZmejTxVLF5ZYMafQL0cs/i8iz4wupa4anRk/4qwfUcNPlg7ar6f5ReKh
         9b82oJjPl3o64UoZRRsJyolWq6WgbOXkus1Pr9BLxrD3qahKXQh5GePf0HravOKcoc
         dwhZihUTfjUUNu5SKOXgG8/zqtRPPulOfwzeBliITNJLcLFBwtqukPuoHPgvYA8jqA
         tplvNe8avmZ0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add argument for usb_hub_clear_tt_buffer to specify device number
that will have the TT state of its hub cleared.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/dwc2/hcd_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index 88b5dcf3aefc..a3bb6911a62a 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -125,7 +125,7 @@ static void dwc2_hc_handle_tt_clear(struct dwc2_hsotg *hsotg,
 
 	if (qtd->urb->status != -EPIPE && qtd->urb->status != -EREMOTEIO) {
 		chan->qh->tt_buffer_dirty = 1;
-		if (usb_hub_clear_tt_buffer(usb_urb))
+		if (usb_hub_clear_tt_buffer(usb_urb, usb_urb->dev->devnum))
 			/* Clear failed; let's hope things work anyway */
 			chan->qh->tt_buffer_dirty = 0;
 	}
-- 
2.1.4

