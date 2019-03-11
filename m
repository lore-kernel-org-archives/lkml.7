Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ADEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DDB20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TZ6cXqJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfCKHKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:10:32 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:49614 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKHKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:10:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id CCA929B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iF4aV9t-Kqim for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 02:10:29 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 9EF0A9B2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:10:29 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id q184so4307632itd.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G7Fo7k82Ea3DfQt+/zMJOXlPOfcqxFsbS1ReXGKz9vU=;
        b=TZ6cXqJbPhLdjo8pzT1QkeF9P0O0U596fbz+1HwgwOWhHlVMsL+QNMoM/MOnfreW1j
         RadRCNMxXSSwgT58QrcUOlIK29/R20+Ztw4oHasRsNu/uC7m2RM0F5qLxoBJM2uMaqdH
         ynHASqHlPFPFls5oXKiG2S5d+3iSMpNm7/MKmG1cLi5pl0tBHAB3Ce2V+oS3FHA4nSa7
         L10psHJiRMAUMMkMhLicMsdgC9vifv+/q4Z9q6YHRtn+NAQXGQHo/TF/yxzGmGsM4TJZ
         452gd/c4YA1qohW3dAN8vgL8yYufcsFKbO1RpvkudatOsNWRVahSYnD8HiQhkX/KaQ10
         RN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G7Fo7k82Ea3DfQt+/zMJOXlPOfcqxFsbS1ReXGKz9vU=;
        b=C275RcUzTNAvdtK7Y6yUa/eadQdj8hjEATm1/WJ7nfqUIMrVxwjmVD4iQd6VezyzB5
         76Oj5Ysw89HNK0zQnJTYdsEGo0EFy+AmGMmsjo6fh2BSA5scarx57JMGNwJMFaOg+ANy
         HRg5Fm+Su06P7RfDx2RF94Pr2c+BUmSood5dKIoG58S1xvD1te1jaHBOwUxA05qs3f8h
         2ZPkow5EISXTPeQTXgYTx3E93YEYz9f1ZT0At5jeJckUyHtkodQednggcQBpbTFXSC/f
         SE+F/WCgqpqyVwFB4gBr/PyJfNNXoUQgFenEhs15t7CNyuqh/VkTuzxfBrDUnUicC137
         i9nA==
X-Gm-Message-State: APjAAAUCtA2ci/v2zf+YAKynyaHFllFFcjGMKk35bgnhHkvRjwElNl6b
        vebeA0+2papPbcpoX1RcbxPzeyLbdY+MS61KXpWNo/IqXBgQfonp8bKeEzEHv95EdtEp8V9ET4r
        kmYBTdp5APGqSyi37mOwMkF8FTyYR
X-Received: by 2002:a24:7c0b:: with SMTP id a11mr14929253itd.161.1552288229246;
        Mon, 11 Mar 2019 00:10:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybi2rbyc2mnGigMR3e+StNBnyPRfi+Fmx9p6mHZ4a3Qt2TJrU+9gh3MXN7saj2pRnefqralg==
X-Received: by 2002:a24:7c0b:: with SMTP id a11mr14929241itd.161.1552288228976;
        Mon, 11 Mar 2019 00:10:28 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id c25sm1996198ioa.75.2019.03.11.00.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 00:10:28 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Colin Ian King <colin.king@canonical.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: fjes: fix potential NULL pointer dereferences
Date:   Mon, 11 Mar 2019 02:10:21 -0500
Message-Id: <20190311071022.27610-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_workqueue fails, the fix returns -ENOMEM to avoid
ULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/fjes/fjes_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index d3eae1239045..18c2c9e24c24 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1252,8 +1252,17 @@ static int fjes_probe(struct platform_device *plat_dev)
 	adapter->open_guard = false;
 
 	adapter->txrx_wq = alloc_workqueue(DRV_NAME "/txrx", WQ_MEM_RECLAIM, 0);
+	if (!adapter->txrx_wq) {
+		err = -ENOMEM;
+		goto err_free_netdev;
+	}
+
 	adapter->control_wq = alloc_workqueue(DRV_NAME "/control",
 					      WQ_MEM_RECLAIM, 0);
+	if (!adapter->control_wq) {
+		err = -ENOMEM;
+		goto err_free_netdev;
+	}
 
 	INIT_WORK(&adapter->tx_stall_task, fjes_tx_stall_task);
 	INIT_WORK(&adapter->raise_intr_rxdata_task,
-- 
2.17.1

