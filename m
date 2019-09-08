Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F05C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C99216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947453;
	bh=HcGSro/bVINMTqXcmyDPCbmvI42TSvHeyoJFat3J3Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DK0Oe5GYLsUPMghpRPrLcT7uA1JFJ/cAh8w6ZW0jAOUEihcNGo5+wh2ACVBMNWpys
	 qOfODJt/2zSFkvWfU4aUSt2phD+qfkatE8VIzPLxqyYX9ekirSvs+sCEIqHQH+vilo
	 kGZKqYqu06I5RMQizDxDhzfY65yTmyLOxQvzpZbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfIHMsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730906AbfIHMsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:48:14 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D069A218AC;
        Sun,  8 Sep 2019 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946894;
        bh=HcGSro/bVINMTqXcmyDPCbmvI42TSvHeyoJFat3J3Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkYQDLlcy7uSlqlRmldDKvVFlmbgpwK/6StmxD6CMGTe8QAq6E26EYlKjjbxiPtjb
         r999dA+zDtwxpvMTfyKdTG4Drxc2oGUqtZ+GqM56KxD9/re3DZzS9I0haL7vKmPA8W
         1yXdsVcmsRPKcHQRcQMv3unKgpOP1lf75C2LgG7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/57] net: kalmia: fix memory leaks
Date:   Sun,  8 Sep 2019 13:41:57 +0100
Message-Id: <20190908121140.283695606@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
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



