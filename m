Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D3AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA352080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfKZOFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:05:05 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47442 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728198AbfKZOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:05:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tj9VXT6_1574777093;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Tj9VXT6_1574777093)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Nov 2019 22:04:58 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: fix use after free in typec_register_port()
Date:   Tue, 26 Nov 2019 22:04:52 +0800
Message-Id: <20191126140452.14048-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't use "port->sw" and/or "port->mux" after it has been freed.

Fixes: 23481121c81d ("usb: typec: class: Don't use port parent for getting mux handles")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/typec/class.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 7ece6ca..91d6227 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1612,14 +1612,16 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	port->sw = typec_switch_get(&port->dev);
 	if (IS_ERR(port->sw)) {
+		ret = PTR_ERR(port->sw);
 		put_device(&port->dev);
-		return ERR_CAST(port->sw);
+		return ERR_PTR(ret);
 	}
 
 	port->mux = typec_mux_get(&port->dev, NULL);
 	if (IS_ERR(port->mux)) {
+		ret = PTR_ERR(port->mux);
 		put_device(&port->dev);
-		return ERR_CAST(port->mux);
+		return ERR_PTR(ret);
 	}
 
 	ret = device_add(&port->dev);
-- 
1.8.3.1

