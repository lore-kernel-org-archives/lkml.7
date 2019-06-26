Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE7AC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE932082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520669;
	bh=WAtDkC3Sn0v7Nf68myXvlN9U3b+YFysUdkAh2NVep5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EALw29yA5H2CiIKa9UGWGjsgL6u3uO+Qx5mcKaNL1VVk1YOiyCyyUDBN+Pxfff1UF
	 YEIjtbMB0OZqoCpXZD7X3I3ITO3DiAIl/t5ednzruAlOyRROHOMNDG7pFPy+kjVtEe
	 jF9J8NEzH7gougQDeJb4FZdJ+MzvNBwtS55iZ1A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfFZDo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfFZDoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:44:21 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-98.mobile.att.net [107.77.172.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76829205ED;
        Wed, 26 Jun 2019 03:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520660;
        bh=WAtDkC3Sn0v7Nf68myXvlN9U3b+YFysUdkAh2NVep5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vgB3C79xahg8fhYVxZ2HW4QpxmVkpT6nYiyoMqr7Q2TOOVB78W/WyBQv1F7yrAVTo
         Bxpj9M+tz8cCbNtrmdtff4NK56N0JbjoKv9X4JiLKqPSeN5dfUlqZ86nw5HbgSvqj9
         zX2XwVobdwbto+JYzBBCF4XopNmHuGWiXdbLxaFU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/34] usb: gadget: fusb300_udc: Fix memory leak of fusb300->ep[i]
Date:   Tue, 25 Jun 2019 23:43:18 -0400
Message-Id: <20190626034335.23767-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034335.23767-1-sashal@kernel.org>
References: <20190626034335.23767-1-sashal@kernel.org>
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
index 263804d154a7..00e3f66836a9 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -1342,12 +1342,15 @@ static const struct usb_gadget_ops fusb300_gadget_ops = {
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
@@ -1491,6 +1494,8 @@ static int fusb300_probe(struct platform_device *pdev)
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

