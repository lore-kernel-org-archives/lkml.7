Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB8EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93A9216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946747;
	bh=lSgo35euyZz7QBUuY01GXmYbUwFWdCcynZ9Jy3WfGxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wmMDj9yFkCD7BDXwpsGDh52j9/h1T95/1zWgP88jGfxJqOvovn6Ni8D9uA9C9C7Bb
	 dpf/YEBaNSr+NOG0LOuWL4GP0JHRLtIUd93lMlY+SZLbRv3m1ipaJcrI94fYcE92Bl
	 O1bVOv5QZ+rrFDDOa11PYP7k9LAfS8GdgGWxiJ5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfIHMpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbfIHMpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:45:43 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61CB5216C8;
        Sun,  8 Sep 2019 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946742;
        bh=lSgo35euyZz7QBUuY01GXmYbUwFWdCcynZ9Jy3WfGxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hH0PNbTPTPDxEM6bTwIM8pMaoVkRVb9V7yUloF4weaM7plKs8PbbpgFMAiH/sjaiq
         A09QuEpSQCAj/zgAo4IWtNnl+Y6+i7voHyJFNDOi2JhvkEA6egeFp/KnPoYZt4FZ1R
         QSGEJ3qAX5IHewfFR3BZINHbO4I98AGYMfZshbp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 23/40] IB/mlx4: Fix memory leaks
Date:   Sun,  8 Sep 2019 13:41:56 +0100
Message-Id: <20190908121124.574613231@linuxfoundation.org>
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

[ Upstream commit 5c1baaa82cea2c815a5180ded402a7cd455d1810 ]

In mlx4_ib_alloc_pv_bufs(), 'tun_qp->tx_ring' is allocated through
kcalloc(). However, it is not always deallocated in the following execution
if an error occurs, leading to memory leaks. To fix this issue, free
'tun_qp->tx_ring' whenever an error occurs.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Acked-by: Leon Romanovsky <leonro@mellanox.com>
Link: https://lore.kernel.org/r/1566159781-4642-1-git-send-email-wenwen@cs.uga.edu
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/mad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index d604b3d5aa3e4..c69158ccab822 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1680,8 +1680,6 @@ tx_err:
 				    tx_buf_size, DMA_TO_DEVICE);
 		kfree(tun_qp->tx_ring[i].buf.addr);
 	}
-	kfree(tun_qp->tx_ring);
-	tun_qp->tx_ring = NULL;
 	i = MLX4_NUM_TUNNEL_BUFS;
 err:
 	while (i > 0) {
@@ -1690,6 +1688,8 @@ err:
 				    rx_buf_size, DMA_FROM_DEVICE);
 		kfree(tun_qp->ring[i].addr);
 	}
+	kfree(tun_qp->tx_ring);
+	tun_qp->tx_ring = NULL;
 	kfree(tun_qp->ring);
 	tun_qp->ring = NULL;
 	return -ENOMEM;
-- 
2.20.1



