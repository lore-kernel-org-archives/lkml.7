Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1072147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LXAin0Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfCLHcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:32:50 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:47072 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfCLHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:32:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 914D684D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:32:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gRe5WP4-rfya for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 02:32:48 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 5E7407B8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:32:48 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id i24so1141490iol.21
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WQP8GztQ+lsJ0g2nITx8iCV6S9LfwdKk+S7ZJ/ceSj8=;
        b=LXAin0Bcwme3Kl+QMcsLoGyExujOPVOKrtL59g+k+7Ovhjje5LCpfjwpuHhbPNqtrs
         akRNoJUTu5QkYnD+2ABqL23pfagixo3eV1tMK46WCf7ed/ao6lx1WlLMm5DK5+VrR1RY
         /9ZH85W6GLyXiK8P0xnExBdoeUAz2Tj0lNzDmWv2CsCgdHGcQsvjp0G56THbcJiCDkOe
         CYOZmrXNWWvBXMDwiIwm/OYresBtaBOzu54dT2wTId3vC+BLJuXYYuA81hMiDU5W96w1
         ean+UCAN7CF0XyrwqEJpmGtVdCN27rrp7X0hyv/U3z5rressMNTMCJiPvifzWu9Vo/T6
         B+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WQP8GztQ+lsJ0g2nITx8iCV6S9LfwdKk+S7ZJ/ceSj8=;
        b=ARfEKRhhBgm4KrQmVR7aMuRG2u/IkXc7wpwiYvZi3RAQ7gqLAtong/JKf4Ky8B8Txd
         P/XtsY+qPDCSXoERamPCh0Hc5oWXCot+3s4rDRuCWn4xHfmpyLsE9XAUe1dlkL7hw/Md
         OIavR5QmIsgaJgTtHZAFOyVSEY5ng+udMxSbQVVd9rBlEDQOnLXlQhipZMIyM7A0SpRp
         YmRReu59xo3qmZu4gDfnwU/6e4A/QlMTu49AdUIa3KKW41iUmrBa/zJEurlwLLx5wwCE
         7TO/TVZwZ2D19g+zCltlIExzNxfrkFKXqTkanpqZJJ4mGKrl0PNF9zDSmGhz0wI7WRLl
         EjXA==
X-Gm-Message-State: APjAAAVtWNGUDfJ0dyVLL17ag1gctPfMWa7wmVGhF31VoGGVAvLPC5/m
        5nLUqQ/WupYBbPReGca078PPWB+aAHQzIbV0RJs7b3jRI8Y/o3WWvJdHILYE4fgv4PGzDVKETMF
        eD07TbE3X337/dbQAjc6QbcEBItC6
X-Received: by 2002:a02:3806:: with SMTP id b6mr20075511jaa.60.1552375967914;
        Tue, 12 Mar 2019 00:32:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqiyIM5PGhtk/zvEzfP/SY0s3p5KfUYhRaggAuLXI4qErUf54VQKwPuXyPrAyC9Al1LySj7g==
X-Received: by 2002:a02:3806:: with SMTP id b6mr20075498jaa.60.1552375967677;
        Tue, 12 Mar 2019 00:32:47 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 187sm963994itl.27.2019.03.12.00.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:32:47 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: fix a potential NULL pointer dereference
Date:   Tue, 12 Mar 2019 02:32:41 -0500
Message-Id: <20190312073241.27495-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of_device_get_match_data fails, the fix return -ENOMEM
to avoid the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 3256e5cbad27..344ead5949b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -485,6 +485,8 @@ static int dwc_eth_dwmac_remove(struct platform_device *pdev)
 	int err;
 
 	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -EINVAL;
 
 	err = stmmac_dvr_remove(&pdev->dev);
 	if (err < 0)
-- 
2.17.1

