Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF14C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC250206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573612014;
	bh=aINBe0j896dO0o/clmYn1WdFrDDx1W1Boi3TVHdmbmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qBkvlnhB09TfqD9IlEIl9oLwPNlmpyfibjIp4bMLYV5T1DgTIrXpg4uKDmm9s8wf/
	 IKbCKwh/JRGy7RiL9dovB3tEVvWexYGwEw2frypbtIPYs/22/Z2wvpqE64J506uAVS
	 oI8q8oUIUWZ8/fZgKQDQOPeMwytsJWRvTWb3W4y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfKMC0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfKMBvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6494D222CE;
        Wed, 13 Nov 2019 01:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609871;
        bh=aINBe0j896dO0o/clmYn1WdFrDDx1W1Boi3TVHdmbmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05L/aJJ8a9GE7G+LgNsBGgOZSf7fYAmBBCPGsa8wOQhd+Vq7XovQ9u7PazDd71yJi
         vIa0R74eXhbmmeRZh9QHeCHoYTQyXwq72BIgsQTME4OReuVui3p5pHnhvktXY1t5EA
         X9G6BwwW7iupSoGHfiPiYgKv6TTRocRBeUNApxUI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 034/209] usb: gadget: udc: fotg210-udc: Fix a sleep-in-atomic-context bug in fotg210_get_status()
Date:   Tue, 12 Nov 2019 20:47:30 -0500
Message-Id: <20191113015025.9685-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 2337a77c1cc86bc4e504ecf3799f947659c86026 ]

The driver may sleep in an interrupt handler.
The function call path (from bottom to top) in Linux-4.17 is:

[FUNC] fotg210_ep_queue(GFP_KERNEL)
drivers/usb/gadget/udc/fotg210-udc.c, 744:
	fotg210_ep_queue in fotg210_get_status
drivers/usb/gadget/udc/fotg210-udc.c, 768:
	fotg210_get_status in fotg210_setup_packet
drivers/usb/gadget/udc/fotg210-udc.c, 949:
	fotg210_setup_packet in fotg210_irq (interrupt handler)

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
If possible, spin_unlock() and spin_lock() around fotg210_ep_queue()
can be also removed.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index 587c5037ff079..bc6abaea907d8 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -741,7 +741,7 @@ static void fotg210_get_status(struct fotg210_udc *fotg210,
 	fotg210->ep0_req->length = 2;
 
 	spin_unlock(&fotg210->lock);
-	fotg210_ep_queue(fotg210->gadget.ep0, fotg210->ep0_req, GFP_KERNEL);
+	fotg210_ep_queue(fotg210->gadget.ep0, fotg210->ep0_req, GFP_ATOMIC);
 	spin_lock(&fotg210->lock);
 }
 
-- 
2.20.1

