Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60A3C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0166218AE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946725;
	bh=9yGX76b0evYWY6ZUDcFqemIAjWAR8z6jIRmJXYOc9c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Sjgr8J2sQl8I7zZ7JIrm0jtvN/7n9LU6QQNsZoLxmXDYffiFUF8cS6nUHRvZwJK3
	 STw0Mlq6HZvC3CBU3B0jg+Y6fbX3lts4P6VVOe0IsJzChUREgX+GxFOBQIDel6HIqW
	 upJI8/Mi2ZknmuU0Q0ktycVnUPfwUc3eDEXB0q6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfIHMpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbfIHMpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:45:22 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83019218AE;
        Sun,  8 Sep 2019 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946722;
        bh=9yGX76b0evYWY6ZUDcFqemIAjWAR8z6jIRmJXYOc9c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPSavz8ft1Qdqu3Kh3sdKRFJnKkMHUOdZJoM1PgarQxi/pnpWg+YralI6QMDGUHAK
         Mp+fpN927kPrjXbrFPYJRd2h3dgVcNgFz+pQmxNdj+ahjQ0T72Kg5TmmuCVQt8WOqE
         fJJSDtt6lUtIXpDIIE+epoNIaRLBXKNjxETN1Y7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 16/40] net: kalmia: fix memory leaks
Date:   Sun,  8 Sep 2019 13:41:49 +0100
Message-Id: <20190908121121.965144721@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121114.260662089@linuxfoundation.org>
References: <20190908121114.260662089@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index ce0b0b4e3a57c..c677ec2bae183 100644
--- a/drivers/net/usb/kalmia.c
+++ b/drivers/net/usb/kalmia.c
@@ -117,16 +117,16 @@ kalmia_init_and_get_ethernet_addr(struct usbnet *dev, u8 *ethernet_addr)
 	status = kalmia_send_init_packet(dev, usb_buf, sizeof(init_msg_1)
 		/ sizeof(init_msg_1[0]), usb_buf, 24);
 	if (status != 0)
-		return status;
+		goto out;
 
 	memcpy(usb_buf, init_msg_2, 12);
 	status = kalmia_send_init_packet(dev, usb_buf, sizeof(init_msg_2)
 		/ sizeof(init_msg_2[0]), usb_buf, 28);
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



