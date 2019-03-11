Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8572320657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="EsrOIl9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfCKGBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:01:50 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36012 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfCKGBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:01:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 5A02098A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ei7JYHuqk6yH for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 01:01:48 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 2A4EF9B2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:01:48 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id j18so4141315itl.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jkql9+9SMsDs/hp1TQhYV55XKpqZRFsl5YXVcN0jSFo=;
        b=EsrOIl9TpZL5WhSf3ztYfolyC7GAenvRY2ObM/mqsgd/7zcWnN8x/FEO0yRqfIXlz2
         ASroOA3/6zPGXWU2yrnAqI/WYeH46vVa4XfFNe+lU/DvSMsXbfSxK6vByffA+uLwRcaG
         ezpa7td4Is82xwk9rDDXS07OLZPSCQj49wZhu0s0jcaCMh37CBmwb5CFin+bRfpseKI5
         9jCBhK85Pe28nhMW5Fg0+wJw980vqZeFtTkYAsIdbVlFdAtArdCSJWmpkjCIa6GNAmJT
         I682XSP5zDyXS1nZumtt7UMgiGKE215KjfhRXSyA7khRUyDLUe/klkO8Kdy2EGvKcWZE
         re/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jkql9+9SMsDs/hp1TQhYV55XKpqZRFsl5YXVcN0jSFo=;
        b=erBCuy7waBrLGaPQWXcsKxLH3LpTgfTuo6KObM8/bNO/PIWHPkgEAvs/igCOdKP38K
         Tg1VH68fEsx6bTSXQyVWd+Il7/TEAzpSU0apCzCTlerSloUFM3Ex2GP3UBDu6X8GosnW
         ALmkao8YXrNi7pssP7P5P3R2T412yZvnD689g3ISTV6hi6zT2Nw/wnaXKpQalXK/GLqA
         sARaW5H+nB25Rcaq1tK1hmLl3Oka/NAAMdUoAwJNCLyDRZLjQBv9gCINXPPd0Amp0oC6
         BHm/jE741mAuA5Dqk4m10fwj1b1Gw7w31PihKg8AaARFkcatE+zukVOH7zQ7t0lihuws
         NjTg==
X-Gm-Message-State: APjAAAVFda9EvlAW2kzRjR/DsqVEVf0ishwkFJ9uM8Xw/xcvBPoTU1l5
        nmPl7SciUFELH32kdjIIVOt30M660Eu03og7ff9+w/aZ2AssRhpWXTR+5sNQXZuTY/gpu1haDcd
        kY/Qr2cr/n6UTAVIY9BCUHR3Y3KEG
X-Received: by 2002:a24:1309:: with SMTP id 9mr3854926itz.163.1552284107687;
        Sun, 10 Mar 2019 23:01:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmo4nTFQunDwx6+tvFlyvQ3srrNNzgzssPLTSdLuckUJOHEAa9eh1LfzgDaFjkC0EmwIkxTQ==
X-Received: by 2002:a24:1309:: with SMTP id 9mr3854913itz.163.1552284107412;
        Sun, 10 Mar 2019 23:01:47 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id a7sm1739785iok.48.2019.03.10.23.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:01:46 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: lio_core: fix two NULL pointer dereferences
Date:   Mon, 11 Mar 2019 01:01:41 -0500
Message-Id: <20190311060142.15377-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case octeon_alloc_soft_command fails, the fix reports the
error and returns to avoid NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/cavium/liquidio/lio_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index e21bf3724611..1c50c10b5a16 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -1211,6 +1211,11 @@ int liquidio_change_mtu(struct net_device *netdev, int new_mtu)
 
 	sc = (struct octeon_soft_command *)
 		octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE, 16, 0);
+	if (!sc) {
+		netif_info(lio, rx_err, lio->netdev,
+			   "Failed to allocate soft command\n");
+		return -ENOMEM;
+	}
 
 	ncmd = (union octnet_cmd *)sc->virtdptr;
 
@@ -1684,6 +1689,11 @@ int liquidio_set_fec(struct lio *lio, int on_off)
 
 	sc = octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE,
 				       sizeof(struct oct_nic_seapi_resp), 0);
+	if (!sc) {
+		dev_err(&oct->pci_dev->dev,
+			"Failed to allocate soft command\n");
+		return -ENOMEM;
+	}
 
 	ncmd = sc->virtdptr;
 	resp = sc->virtrptr;
-- 
2.17.1

