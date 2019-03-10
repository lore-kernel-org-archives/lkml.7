Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C14C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A64A206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fEPJm+X4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCJH5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:57:44 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:53226 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfCJH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:57:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 17A23BB8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 07:57:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IORPG7gCRqcZ for <linux-kernel@vger.kernel.org>;
        Sun, 10 Mar 2019 01:57:41 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id DE16FBC0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 01:57:41 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id w19so1691431ioa.15
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 23:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MzOTGNaM6xKyCz979o1NCUtyTJWBfNLq000kVLZMQPI=;
        b=fEPJm+X4LANPfNMBb7r4sXN14RyQnFbjVDgwIUXMudFiqPioevD4vvfLvsjAWfWIe7
         H8di3L/mFU2gt18AFKpTOi69CkLn4P6gfwloJo1w3fCHa7H0mckgvpFcH7X0HxCCeEJJ
         GL0Aje+cXbCZxDasYEGhWKumzTt0XtF8cG6Y+gUYAEGoJPtwBPUaAHlg3bKgCsXor4ru
         UIOmVqbhbxROzg9tH0vdQ8B1MFHgMbQGSDOCHHhI6IV97yAXlPpq8hf5gsgnJbPU3qVs
         xBxyB7aRQu0z2ZCLNh5fpucyWaOLJRZc7Qe4dC/JaWnWRqXcfid1xjbR9nceBf7Nl7V4
         a9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MzOTGNaM6xKyCz979o1NCUtyTJWBfNLq000kVLZMQPI=;
        b=PrruHmYJhk4O0iT3+aGvg+Nkro3rKqSoa2DZAma4B/PSGLPOThXCTmsMU4IBI7HKEM
         hwLbWmvdtzoWx+8qGip8OURAlT/KRLksqvixzPlo01sWwno2QrAqVvx7CtGFdQPiF5VB
         OiL1+/I6GGUV4Hdvy1zyFaMDPkFQfMwszX/aR8RCIrdISaMBpblj4VuZjFMKLbjd1pPG
         Jp0mBS1hTKqDjeuw6lpYeth3vYncmLbvEEA1iYlKI7a9XqJiKn9OgDZbwBuNTeD5/faF
         sJFm3ENuRao9TmKsQwIGAZG6QG6jAx3USD52zs8jCXdyv60wXCF+JH0nmRrEq5d/u67N
         EgQQ==
X-Gm-Message-State: APjAAAXvKsJa3+M7T5TpTOVIxkO0fTMQqiQzKopOwiTcmyXlq9Ko4gJo
        nDE20EAfvtBcwK8kUCiTS73aTEvobLuX9xfKcS5G268fhS/pe6loJ4CQlex1XOt6HLTKMpI2ri5
        3dNtMsZFZBS/+NxudyPhWW82HKTiV
X-Received: by 2002:a02:1e13:: with SMTP id m19mr14061642jad.94.1552204661450;
        Sat, 09 Mar 2019 23:57:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzz7ERUcOzQ/s5R4J83FTgwYZ9sFaGRad8qxA/ZC/7L2dl/Z23Tk4ypi7KswRJjpEqjqiWnIA==
X-Received: by 2002:a02:1e13:: with SMTP id m19mr14061633jad.94.1552204661064;
        Sat, 09 Mar 2019 23:57:41 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v14sm959667iol.61.2019.03.09.23.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 23:57:40 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Wei Liu <wei.liu2@citrix.com>, Joe Perches <joe@perches.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: spi: fix a potential NULL pointer dereference
Date:   Sun, 10 Mar 2019 01:57:33 -0600
Message-Id: <20190310075735.3392-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_workqueue fails to allocate the work queue and
returns NULL, the fix releases the resources and returns
-ENOMEM.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/can/spi/mcp251x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index e90817608645..2737b9a20dfe 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -962,6 +962,14 @@ static int mcp251x_open(struct net_device *net)
 
 	priv->wq = alloc_workqueue("mcp251x_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
 				   0);
+	if (unlikely(!priv->wq)) {
+		dev_err(&spi->dev, "failed to allocate work queue\n");
+		mcp251x_power_enable(priv->transceiver, 0);
+		close_candev(net);
+		ret = -ENOMEM;
+		goto open_unlock;
+	}
+
 	INIT_WORK(&priv->tx_work, mcp251x_tx_work_handler);
 	INIT_WORK(&priv->restart_work, mcp251x_restart_work_handler);
 
-- 
2.17.1

