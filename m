Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E519FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A282075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="S3aK+0cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfCKGhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:37:00 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:47758 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfCKGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:36:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id DD759987
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:36:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6thciTYUYDLX for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 01:36:57 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id AEDBE98E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:36:57 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id w200so4234753itc.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iF9v+FUhWtsHe+L2xZEZfAWfmtK880LpyFebA8HE0mo=;
        b=S3aK+0cvnGRuHJDSzoFS3EneP5I4UsLPTZ/BI2RDSrWMT0Ko8hp6C45Is55LYu4ic2
         i/evMg2FYkBdGdjlToczHYZvnhwY5Xmb69FCgtWqj6JXa5+QMrKQ1bogDKWXCp2d+Xgd
         Qm3BKXB8StWu+YNC9s1HuLRqdONigInMURuGyqyqaUQ8k7v02VERmuP9Tze8WWjKMjTW
         grPSmJ9i5G7liqc2Tva/Y/fi3ljhUT8N24LIVk8EcM67hwtG8najKGPEo9ZoYcMXXVgj
         o9/xhW/BIfh4RKNoys7EbLUcFfVmqjdrtlks+dJNuo4hI1bsTJsW+uFEQgIiIK+YXjvE
         L3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iF9v+FUhWtsHe+L2xZEZfAWfmtK880LpyFebA8HE0mo=;
        b=eI4XlmnDpk91j9TUh8ao6HDbOQOBUsjHRtf8sB4OxLa98G8F4S0EuLMZdc/7C0GhPR
         H/QtbyMrselPTxnjeHTbF1BRlXnp+wpbKMpPiyrh3ZlUdIxnSK6QcA1Ljcv8AET+QAHX
         Lf4pDsttpxrYp0Y7vKCjq4JEz1MUoKx5736wzQCppFBvAWb//u5nrrCEYH6q6g8S3dDs
         Sn7c9rAyz+VWVAlb1GMWiqYS6AcIFaCMUn2z1c4tyS8QQBwvkj5HhiYBSKOxocbXsVyq
         wHnM6XjOkuUmF/xjqB69EwOgaB5Zl/m0lKa0DU0CndprIjZoX1RuvJOAnPP2RPzsV4iv
         8BFw==
X-Gm-Message-State: APjAAAWHhDMh68HIiDTrcgn0+QiLU/TVj9EuUa0zKzZKTkU3zn27oS1n
        6COdlJqne6GzebXRUygsenSvVUEvRwSq3SgUB9NRPL2/paZXQSfubII4J6kg5kfgGtPRLKrz+KA
        4jL865977jNpw8l3FNeHTlGPliQvm
X-Received: by 2002:a6b:7701:: with SMTP id n1mr14706839iom.143.1552286217374;
        Sun, 10 Mar 2019 23:36:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAbgKAW7t3Z62xnxNuLwxv4dVLBl+ZaL9XFuNhAfVK9PsYo0NGYXesRfkzX3JQCA5jy845Qg==
X-Received: by 2002:a6b:7701:: with SMTP id n1mr14706828iom.143.1552286217154;
        Sun, 10 Mar 2019 23:36:57 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id t5sm1822812ioi.43.2019.03.10.23.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:36:56 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ocelot_board: fix a NULL pointer dereference
Date:   Mon, 11 Mar 2019 01:36:32 -0500
Message-Id: <20190311063632.21111-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case devm_kcalloc fails, the fix returns -ENOMEM to avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/mscc/ocelot_board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index e7f90101d2e0..af68abf1632a 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -256,6 +256,8 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 
 	ocelot->ports = devm_kcalloc(&pdev->dev, ocelot->num_phys_ports,
 				     sizeof(struct ocelot_port *), GFP_KERNEL);
+	if (!ocelot->ports)
+		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ocelot->multicast);
 	ocelot_init(ocelot);
-- 
2.17.1

