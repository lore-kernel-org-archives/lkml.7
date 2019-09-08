Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AFBC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B4B2067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947593;
	bh=Arer8dkUm8lSgpruEGvxWHMeV2nlWuAorFR9XbNy6OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xZEbxKlh2SHqCk5MwPyCoMtWxci12IdjzvhkezhDO5+9HgHkkYMdZUZLWdvh1qVF7
	 noXk95mEnMTOkubcD8tsHhBADDRTcRmvmyI7i65ZhGKUYsN7kfVJ93gnFUz7M8rduT
	 6YWZit+LHQGz7W6jIZy8Ns+SLa8upJwfwey5uC6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfIHMpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730024AbfIHMpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:45:12 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 232B221927;
        Sun,  8 Sep 2019 12:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946711;
        bh=Arer8dkUm8lSgpruEGvxWHMeV2nlWuAorFR9XbNy6OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIDvl5bfntqIGMbrLzYdT9DYvlCAGuOaZ1ZaAAInBGRoHx15ZoZkEWc2wqIa5pxzI
         rcERjSpsRO140jIVt205V2zjWC5Eu1Sy7DSlUN7VFUaLZsGCA/rSprhH9VxoCqBbhs
         30qzew/+obywwX8c/GPuG/6dbqU+yVZk6PnqpE9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/40] net: myri10ge: fix memory leaks
Date:   Sun,  8 Sep 2019 13:41:45 +0100
Message-Id: <20190908121120.447555029@linuxfoundation.org>
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

[ Upstream commit 20fb7c7a39b5c719e2e619673b5f5729ee7d2306 ]

In myri10ge_probe(), myri10ge_alloc_slices() is invoked to allocate slices
related structures. Later on, myri10ge_request_irq() is used to get an irq.
However, if this process fails, the allocated slices related structures are
not deallocated, leading to memory leaks. To fix this issue, revise the
target label of the goto statement to 'abort_with_slices'.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index b171ed2015fe4..a0a555052d8ca 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -3922,7 +3922,7 @@ static int myri10ge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * setup (if available). */
 	status = myri10ge_request_irq(mgp);
 	if (status != 0)
-		goto abort_with_firmware;
+		goto abort_with_slices;
 	myri10ge_free_irq(mgp);
 
 	/* Save configuration space to be restored if the
-- 
2.20.1



