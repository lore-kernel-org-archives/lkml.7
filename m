Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81824C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C522084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749551;
	bh=2Ej4JXBL+umRmchx+lpkGnP86ilUK0ZlJFwHz58qWn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A1iXr52xVh/7kbVT+slKRlss3vvNUAYxfxxvNmHsSLKlr5uVNTje2TRrp5WAcG0bG
	 5Q5ZXaoy2awKus0ePMGrDEXOrGDTZUIGEecTE/dlVHCrQua4BrKQDFHR/PtfwPiTh1
	 LqWiSGnt2Rm+zhZP4qXZIzFUAIiC641DV+s2X9ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfHNCXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbfHNCXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:23:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFAE420842;
        Wed, 14 Aug 2019 02:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749423;
        bh=2Ej4JXBL+umRmchx+lpkGnP86ilUK0ZlJFwHz58qWn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rO3N69vTD2cxsVhehfCzZXw8vppclvor+Ze/uWNa8Xq72B4xP2uodymQ9Inw4L14E
         ii2/2nCYJQvV8eOJkmRpLZ4YxVszrjL+x96UIgLWHKteTXl+SOcj3tS/wUuJdk19gS
         psVCrUisrVQhYGwEIiABZXOzCgV8Kr005aHoR/dM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/33] isdn: mISDN: hfcsusb: Fix possible null-pointer dereferences in start_isoc_chain()
Date:   Tue, 13 Aug 2019 22:23:02 -0400
Message-Id: <20190814022323.17111-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022323.17111-1-sashal@kernel.org>
References: <20190814022323.17111-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit a0d57a552b836206ad7705a1060e6e1ce5a38203 ]

In start_isoc_chain(), usb_alloc_urb() on line 1392 may fail
and return NULL. At this time, fifo->iso[i].urb is assigned to NULL.

Then, fifo->iso[i].urb is used at some places, such as:
LINE 1405:    fill_isoc_urb(fifo->iso[i].urb, ...)
                  urb->number_of_packets = num_packets;
                  urb->transfer_flags = URB_ISO_ASAP;
                  urb->actual_length = 0;
                  urb->interval = interval;
LINE 1416:    fifo->iso[i].urb->...
LINE 1419:    fifo->iso[i].urb->...

Thus, possible null-pointer dereferences may occur.

To fix these bugs, "continue" is added to avoid using fifo->iso[i].urb
when it is NULL.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index c60c7998af173..6f19530ba2a93 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1402,6 +1402,7 @@ start_isoc_chain(struct usb_fifo *fifo, int num_packets_per_urb,
 				printk(KERN_DEBUG
 				       "%s: %s: alloc urb for fifo %i failed",
 				       hw->name, __func__, fifo->fifonum);
+				continue;
 			}
 			fifo->iso[i].owner_fifo = (struct usb_fifo *) fifo;
 			fifo->iso[i].indx = i;
-- 
2.20.1

