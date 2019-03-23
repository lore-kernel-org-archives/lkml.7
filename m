Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8551FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C26521019
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="R/4Q+zEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfCWDwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:52:33 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:40870 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCWDwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:52:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 87BEAE32
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3mZwUHyg6tqg for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:52:31 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 5D0D4C6A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:52:31 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id k2so3414099ioj.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46dnDyAIZFFf/nS7hndZ0SEprIdcbLj0+piwG5AvCho=;
        b=R/4Q+zEMNVx5NIpghNB1IiSxPBCuQCHuWOm4ylDKZAT56L3+MNCte9fK2f9mJ99v5f
         LNzjMoaTxqHNbrW77fk84v7HsDoAyv4TcY1yGxY4dtSo5VuaGtesUV6KAgYFPZz6oHvA
         r6GM7G8JoCoFyaiOoT8dFTiARfRudFjGillgcHZaERVEu5ZvpPG1oXglHeHixdsSlUyN
         5wZmV/XcxzVvU5Fwqcfbwr3gei5KlxcU9z+c/XIu/p5DXZpVwHzSUw+2rHkcPuVRM9Y6
         19UjGWJPCuI2Ty2LADS16ytj1cyM1YMFPpXS/LQnEuibLyIRfekBRulf74VuGdsigGh1
         v9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=46dnDyAIZFFf/nS7hndZ0SEprIdcbLj0+piwG5AvCho=;
        b=JWD2WCxPLBwwv/TgL+UeH9dyqksWKOvr/0SpfB3k2MzGshFUrcAbhdT6Af4lTn5Prv
         hx4MQ2LkWVWiDmY/ITOjJ+NG088d5hoWDVjZ5Yffy7Ht2esbEwv+yVAdtW+aQWwQc0vg
         s/OYlXj9x0qkXdXOJ4WJbQ60maWQdy9dDIIW3TsMYXoAY6pmNNUK8tUZIcGXC4Nn6IDi
         xbO8gn3V4adUMr9Dwth7fGqEZJCgijyqu/Y80VjNMrBDQ+rFp00id5ekRmjovVanHnC7
         NI5LtwheC64unIkGiLOcdh2z4iJx6Vj19n+Qj8AHGIqWJyMSxKFsuplwSro4TNWWC1PZ
         /Glg==
X-Gm-Message-State: APjAAAW5gZ2vJ2oY3vsyCjOFyLlewh68OdxY5C79pMlKfKGICaY3Ksvg
        ciETOESHDNwZKgHPbjIFgPJn6kdVjvfu0fhbpTHEr8njQjsmrz3v9gmFyfsa/6t67pEyJ9GqMEM
        rV+vx9TlOT2cMwHel4PoT0uzA2SVv
X-Received: by 2002:a05:660c:151:: with SMTP id r17mr738023itk.177.1553313150733;
        Fri, 22 Mar 2019 20:52:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyxydQJi7Uq/WxAIT3XaD7i4dt3xyQ/bh/GpRZzTOI1ReceTvEEyAveS+fXoyhB4MeCBa+5uw==
X-Received: by 2002:a05:660c:151:: with SMTP id r17mr738013itk.177.1553313150480;
        Fri, 22 Mar 2019 20:52:30 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v23sm4271941ioq.6.2019.03.22.20.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:52:29 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Colin Ian King <colin.king@canonical.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: fjes: fix potential NULL pointer dereferences
Date:   Fri, 22 Mar 2019 22:52:21 -0500
Message-Id: <20190323035223.23714-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311.161910.28459399773636110.davem@davemloft.net>
References: <20190311.161910.28459399773636110.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_workqueue fails, the patch returns -ENOMEM to avoid
NULL pointer dereferences.

In addition, the patch fixes memory-leak issues.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>

---
V2: free resources properly
---
 drivers/net/fjes/fjes_main.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index d3eae1239045..471486eefb7b 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1252,8 +1252,16 @@ static int fjes_probe(struct platform_device *plat_dev)
 	adapter->open_guard = false;
 
 	adapter->txrx_wq = alloc_workqueue(DRV_NAME "/txrx", WQ_MEM_RECLAIM, 0);
+	if (!adapter->txrx_wq) {
+		err = -ENOMEM;
+		goto err_free_netdev;
+	}
 	adapter->control_wq = alloc_workqueue(DRV_NAME "/control",
 					      WQ_MEM_RECLAIM, 0);
+	if (!adapter->control_wq) {
+		err = -ENOMEM;
+		goto err_free_wq;
+	}
 
 	INIT_WORK(&adapter->tx_stall_task, fjes_tx_stall_task);
 	INIT_WORK(&adapter->raise_intr_rxdata_task,
@@ -1270,7 +1278,7 @@ static int fjes_probe(struct platform_device *plat_dev)
 	hw->hw_res.irq = platform_get_irq(plat_dev, 0);
 	err = fjes_hw_init(&adapter->hw);
 	if (err)
-		goto err_free_netdev;
+		goto err_free_wq;
 
 	/* setup MAC address (02:00:00:00:00:[epid])*/
 	netdev->dev_addr[0] = 2;
@@ -1292,6 +1300,11 @@ static int fjes_probe(struct platform_device *plat_dev)
 
 err_hw_exit:
 	fjes_hw_exit(&adapter->hw);
+err_free_wq:
+	if (adapter->txrx_wq)
+		destroy_workqueue(adapter->txrx_wq);
+	if (adapter->control_wq)
+		destroy_workqueue(adapter->control_wq);
 err_free_netdev:
 	free_netdev(netdev);
 err_out:
-- 
2.17.1

