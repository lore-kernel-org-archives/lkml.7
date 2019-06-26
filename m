Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B158DC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C02521738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520812;
	bh=1Bdi0/AIjYlIMigrOFZsl0rMjuXzCsm30opJkibrcrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l0FNZ4ESLdVAjtQJXRZi+kNVrh6IfxfPJf5sKKYwZWWObfAGFEDItdOTpt5pDRidm
	 qokgaqv6r3B53znqdOp8z5AKAGhM5ubxpGHLJFrFjYwi6f80wy0p/RZoO9WZTOSnnt
	 X+jGVqAt9DGpaM8fabK4IU7POj6YeC4PtAuvMoaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfFZDqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbfFZDqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:46:48 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-90.mobile.att.net [107.77.172.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCF8205ED;
        Wed, 26 Jun 2019 03:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520808;
        bh=1Bdi0/AIjYlIMigrOFZsl0rMjuXzCsm30opJkibrcrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBBL8aFpMJXnhBM38r4ik4S5SjjdYCAuDYKB1/Gg38iPG34SsB0ajFotruc/Zi0Jj
         kkNv12wfQTcQX23H+do9Z02EZ6NnvyJNAXkNkglz6EYHBDsoQEjp7JtlTiXJ1pZNr5
         04l9/5IIo3otHJWLRC+Bdh6mwUb+g8LM+iWVHAy4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 4/6] usb: gadget: fusb300_udc: Fix memory leak of fusb300->ep[i]
Date:   Tue, 25 Jun 2019 23:46:35 -0400
Message-Id: <20190626034637.24515-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034637.24515-1-sashal@kernel.org>
References: <20190626034637.24515-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <92siuyang@gmail.com>

[ Upstream commit 62fd0e0a24abeebe2c19fce49dd5716d9b62042d ]

There is no deallocation of fusb300->ep[i] elements, allocated at
fusb300_probe.

The patch adds deallocation of fusb300->ep array elements.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/fusb300_udc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/udc/fusb300_udc.c
index 948845c90e47..351012c498c5 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -1345,12 +1345,15 @@ static const struct usb_gadget_ops fusb300_gadget_ops = {
 static int fusb300_remove(struct platform_device *pdev)
 {
 	struct fusb300 *fusb300 = platform_get_drvdata(pdev);
+	int i;
 
 	usb_del_gadget_udc(&fusb300->gadget);
 	iounmap(fusb300->reg);
 	free_irq(platform_get_irq(pdev, 0), fusb300);
 
 	fusb300_free_request(&fusb300->ep[0]->ep, fusb300->ep0_req);
+	for (i = 0; i < FUSB300_MAX_NUM_EP; i++)
+		kfree(fusb300->ep[i]);
 	kfree(fusb300);
 
 	return 0;
@@ -1494,6 +1497,8 @@ static int fusb300_probe(struct platform_device *pdev)
 		if (fusb300->ep0_req)
 			fusb300_free_request(&fusb300->ep[0]->ep,
 				fusb300->ep0_req);
+		for (i = 0; i < FUSB300_MAX_NUM_EP; i++)
+			kfree(fusb300->ep[i]);
 		kfree(fusb300);
 	}
 	if (reg)
-- 
2.20.1

