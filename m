Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F77C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0104C204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497898;
	bh=Uwa8wS0dmARYNw/g0YO2nMdEBPNRIqFT6GX1YFH3etI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kxa6e0PqjSoQq5ptSHHQhrihQw5D4F2G3/Hlh4R1Po9OoGLBmSKql8azP+WwYQS8m
	 StvP4/ZI0VSEPSBF7SS5ZCQpgNp/r0bLB/Fb/am17wvaKCRUidofS9ISVexk2E/119
	 uWFcEcg9JFS86L+fAzmC1Xo1RnWFV3s6aCgrEnc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfKKSo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbfKKSox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:44:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15E0204FD;
        Mon, 11 Nov 2019 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497892;
        bh=Uwa8wS0dmARYNw/g0YO2nMdEBPNRIqFT6GX1YFH3etI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7uIhPXdtel4naEE8llrpm8DCeoBuCgy6JGwN6z1lNZ/071dK/KRXMmp8xs2EM650
         LcKSG9x07No2Elkyy4YKbsqKWzaFhV23uknEtDeMxL1TfdoyCLup5anq1ybEqC7V8e
         dOd1UG82r8JHu45Md81AJ8aCHA/XFks7xTQpu2EY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/125] usb: fsl: Check memory resource before releasing it
Date:   Mon, 11 Nov 2019 19:28:48 +0100
Message-Id: <20191111181451.931107178@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

[ Upstream commit bc1e3a2dd0c9954fd956ac43ca2876bbea018c01 ]

Check memory resource existence before releasing it to avoid NULL
pointer dereference

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Reviewed-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index be59309e848c3..d44b26d5b2a2c 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2552,7 +2552,7 @@ static int fsl_udc_remove(struct platform_device *pdev)
 	dma_pool_destroy(udc_controller->td_pool);
 	free_irq(udc_controller->irq, udc_controller);
 	iounmap(dr_regs);
-	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
+	if (res && (pdata->operating_mode == FSL_USB2_DR_DEVICE))
 		release_mem_region(res->start, resource_size(res));
 
 	/* free udc --wait for the release() finished */
-- 
2.20.1



