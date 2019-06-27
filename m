Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA455C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AAF2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUjwxsbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfF0RpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:45:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45901 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfF0Ro7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:44:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so1573884pfq.12;
        Thu, 27 Jun 2019 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tvqfJ6sX8D7AhhMMl5NxvQNNf+P9Cj0Mf8VtEYuVHhQ=;
        b=gUjwxsbOj9zF11K7N2R6GJLoQRzHvOnguFn3pNwGITkghwiyNN0zIRbAtDW2WkecSf
         4pi7X/GVsqF3s0T2puRY04GX1/ywOnu25k0cfbbLfhcS6jSLwTyon94ISWAuY3rabZwP
         QP+9hYCdAmXMHIhcq1xCOillujpLQTyyRVzqz35ujxm0lGjRuatCLSzGXKfmaRz4JA5U
         eVT5+yanaDw0RKeFUYNnviOG3j/opfkY0wHcGR1bKSOvNlUwRVwmPJdYc0cNhMlNSDOt
         Ia6sAvQZi3ysH1oDcxyXeubfV6vQc09Vky4+JWjicAz+QJh4LhsEZj4uo+eE+hfgzgnv
         azgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tvqfJ6sX8D7AhhMMl5NxvQNNf+P9Cj0Mf8VtEYuVHhQ=;
        b=UbhI284BNYUevnk6xAYs7CCEx1OEnFOSEnOiSgAx7flTY3S0pNMVjMKyr1UFwK+w+i
         7k4rLjgSw0bi3WMpKO55uImc+OSQYbK+G0VZKongmaASkxMJVnWDF3Gicp92aUnQQLjT
         xAJt/v7MTy7ntEk0/m5MymodWVkqYTMjim6K4ImvrufgvtU0fCP9SzQsdiZbA1SRZa86
         Tj4JuI5SFcgxDIf4Sb6o9OY9v7G2qtEMLOx2fBItGEOCM6LD1VAOhMsbob0HpTso6xRD
         ogv31gKsLsX0vkUWRBXposyy6JUS6PcNmU8pJXTEbJotuF9WFt+r6doWxGlBk2tJ+vU7
         J3AQ==
X-Gm-Message-State: APjAAAXmJzwxbfCJuWH/mGYHZAjAp06VmgNsdNUsMKs+vOGgVPPYQrha
        QFfgTB66N7hToNHoF3dzxGE=
X-Google-Smtp-Source: APXvYqxd3uhbhjziogjO38CMBomnNt4EgzdyAvQ6S0A9xaoofmauURFi7CpA5qEzERhB5NmWnU2E5w==
X-Received: by 2002:a63:fa4e:: with SMTP id g14mr4858876pgk.237.1561657498253;
        Thu, 27 Jun 2019 10:44:58 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id k4sm5202626pju.14.2019.06.27.10.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:44:57 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jes Sorensen <jes@trained-monkey.org>,
        "David S. Miller" <davem@davemloft.net>, linux-hippi@sunsite.dk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 80/87] net: hippi: remove memset after pci_alloc_consistent
Date:   Fri, 28 Jun 2019 01:44:51 +0800
Message-Id: <20190627174452.5677-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/net/hippi/rrunner.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index 7b9350dbebdd..2a6ec5394966 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1196,7 +1196,6 @@ static int rr_open(struct net_device *dev)
 		goto error;
 	}
 	rrpriv->rx_ctrl_dma = dma_addr;
-	memset(rrpriv->rx_ctrl, 0, 256*sizeof(struct ring_ctrl));
 
 	rrpriv->info = pci_alloc_consistent(pdev, sizeof(struct rr_info),
 					    &dma_addr);
@@ -1205,7 +1204,6 @@ static int rr_open(struct net_device *dev)
 		goto error;
 	}
 	rrpriv->info_dma = dma_addr;
-	memset(rrpriv->info, 0, sizeof(struct rr_info));
 	wmb();
 
 	spin_lock_irqsave(&rrpriv->lock, flags);
-- 
2.11.0

