Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6234C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4B21726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103083;
	bh=fCwsazgxFMvFOKX3wjRUjcwOHPTKDXtI9shIN5FUOGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cdvzGlityqB/r7tie5IJyWHX2b5ZSKX/QFF8dq4XCuLPWIDpGAdVvBBFaOVIsPma/
	 jkLd5fp0Ew6WSBijwpubVjGiqDO9byFPNVd2E9UwB1EQeWPWcXuO4a/JM6q78jM06z
	 pIcHkM4f6eSgyE/34QXfFyrKgP0twjmNuq6oN8tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfH2SYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbfH2SQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E032339E;
        Thu, 29 Aug 2019 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102582;
        bh=fCwsazgxFMvFOKX3wjRUjcwOHPTKDXtI9shIN5FUOGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrY9USNhpOcSwviFUMiWDVo6U4bHJTqQ2l5M0Q+RRyG1eRJQYdoRel1h7TA/6HEjo
         SNm4dVeK1gZ8WrcyGGQ7qAX0M1zFG8T1/+J0hsZ7nMp2puo4talFOfXucawEcBwkS/
         3QQewabkesHc74k0LSGPNHawgP8RghTcabavjqw0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 24/45] net: kalmia: fix memory leaks
Date:   Thu, 29 Aug 2019 14:15:24 -0400
Message-Id: <20190829181547.8280-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
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
index bd2ba36590288..0cc6993c279a2 100644
--- a/drivers/net/usb/kalmia.c
+++ b/drivers/net/usb/kalmia.c
@@ -117,16 +117,16 @@ kalmia_init_and_get_ethernet_addr(struct usbnet *dev, u8 *ethernet_addr)
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

