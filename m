Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4BCC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEE123403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102492;
	bh=qml2xfq2Vm0bbYh1zjkEGVJTy8eTz1McNIzEeQePNaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mr/lxKKuvSqjC11O0dRq7RUJz6HPGGW0ao20XDtXD/dt6yKEydRwAEaeimnPC2Ppc
	 vSacd96eBCOqtiXwdUSMaUUy5J77hNi6ELFGhk/x0RzEiLgwt5y6Js2J5Zj2K0Ke0r
	 ajcyUX6ryKoJQsrR29oyfF04yKkltyKMoIryHNn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfH2SOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbfH2SOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:14:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C8523403;
        Thu, 29 Aug 2019 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102482;
        bh=qml2xfq2Vm0bbYh1zjkEGVJTy8eTz1McNIzEeQePNaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5xapk0u44rpB/F/JfNaWJpWSwhgQNoqzC0J/M6CgCgsuHecgI73GLvMGWkLiL06K
         u4VQNvVeyMvS/wALYinN9jKVT5xNo847hFh4Cq5ACDm3HHaRAiLQix46wtoz3bV9Av
         eBPxfeRd6u+Al0CurVacwf8zEVil5Aw76pDNgB5c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 42/76] net: kalmia: fix memory leaks
Date:   Thu, 29 Aug 2019 14:12:37 -0400
Message-Id: <20190829181311.7562-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit f1472cb09f11ddb41d4be84f0650835cb65a9073 ]

In kalmia_init_and_get_ethernet_addr(), 'usb_buf' is allocated through
kmalloc(). In the following execution, if the 'status' returned by
kalmia_send_init_packet() is not 0, 'usb_buf' is not deallocated, leading
to memory leaks. To fix this issue, add the 'out' label to free 'usb_buf'.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/kalmia.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/kalmia.c b/drivers/net/usb/kalmia.c
index d62b6706a5376..fc5895f85cee2 100644
--- a/drivers/net/usb/kalmia.c
+++ b/drivers/net/usb/kalmia.c
@@ -113,16 +113,16 @@ kalmia_init_and_get_ethernet_addr(struct usbnet *dev, u8 *ethernet_addr)
 	status = kalmia_send_init_packet(dev, usb_buf, ARRAY_SIZE(init_msg_1),
 					 usb_buf, 24);
 	if (status != 0)
-		return status;
+		goto out;
 
 	memcpy(usb_buf, init_msg_2, 12);
 	status = kalmia_send_init_packet(dev, usb_buf, ARRAY_SIZE(init_msg_2),
 					 usb_buf, 28);
 	if (status != 0)
-		return status;
+		goto out;
 
 	memcpy(ethernet_addr, usb_buf + 10, ETH_ALEN);
-
+out:
 	kfree(usb_buf);
 	return status;
 }
-- 
2.20.1

