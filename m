Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50929C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC832073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077633;
	bh=HrJod3kPfmM5fFu3bzx6CgUyozxnjdXrrWPnBhsLpHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QoBnBbcmK5JiZ3LBy7ksycJVQfW68s/WwzZwQ8ozmhiEhtKG4S78KgMtm/UIqkzdT
	 RqWGLOPRf3+BezMlLaWaWCYhvpQZix5AtGj2ntEFSJqaS0fqxGMsEKmUT8y5qLAbVJ
	 m8vDFFkYNXP/kqC7Ja0jQADiLGYCYnGxESrXXknc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfLKPUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:20:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732341AbfLKPU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:20:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E4A224654;
        Wed, 11 Dec 2019 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077628;
        bh=HrJod3kPfmM5fFu3bzx6CgUyozxnjdXrrWPnBhsLpHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w3LPHzTW9AaMWJDSREr1g/ECy3p14Y6/XDLdg/DHM69NSDXfKtWVdTzo1rZtYs0CY
         MIbKZa/zfTgTvuefc2DuhLAoLbgN046+3R9CJNE4O7jLm0D3DmNBK0zN5Linc8G+Sj
         NhlHkrOT2ZX8BLa+eI3fK6HrAhF4gLX8ug/6z95U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xue Chaojing <xuechaojing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/243] net-next/hinic: fix a bug in rx data flow
Date:   Wed, 11 Dec 2019 16:03:54 +0100
Message-Id: <20191211150343.962432137@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>

[ Upstream commit b1a200484143a727ce293e0f200a543cc7584152 ]

In rx_alloc_pkts(), there is a loop call of tasklet, which causes
100% cpu utilization, even no packets are being received. This patch
fixes this bug.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
index 4c0f7eda1166c..06b24a92ed7d4 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -207,9 +207,9 @@ skb_out:
 		wmb();  /* write all the wqes before update PI */
 
 		hinic_rq_update(rxq->rq, prod_idx);
+		tasklet_schedule(&rxq->rx_task);
 	}
 
-	tasklet_schedule(&rxq->rx_task);
 	return i;
 }
 
-- 
2.20.1



