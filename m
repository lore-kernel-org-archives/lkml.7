Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECAAC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A6D20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919513;
	bh=IAEDZlt8A6hzSw6P9V2pngCWWFZv96wHAGTdZ7IvUfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gz+hGCQW53dD3hQepiDZ8Jokdn3zlsWcOYuso1RFMzXn+idiwRYjHRUL2hyJ63kNK
	 Wb7pM11xl0i40kHXT2ePq4uR7tjMULPj7gq7lfde6vy78q/RVkAk+R3PKpaCGGe+yG
	 6ZJNIUdnFemnIMc3cdNkzZTQC4is+YaZ8q/AupqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfEOLZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731937AbfEOLZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:25:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98E220881;
        Wed, 15 May 2019 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919509;
        bh=IAEDZlt8A6hzSw6P9V2pngCWWFZv96wHAGTdZ7IvUfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bEBUITnFhn2Dvvk3a2Oux1LG9ntkCAulzqyRWumlndkJG48D6756hzmNp/g9NgDZJ
         rlqzHT4zqK7BE+xvkq7oSJtT2iiXiEGOVXnomQFLKMatAICjw+b9XV5QKtcMh9oCwP
         qOgd8e0eua2XybBKT2VyIQkDg4r08XancXUHJjmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 103/113] tuntap: synchronize through tfiles array instead of tun->numqueues
Date:   Wed, 15 May 2019 12:56:34 +0200
Message-Id: <20190515090701.460414501@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 9871a9e47a2646fe30ae7fd2e67668a8d30912f6 ]

When a queue(tfile) is detached through __tun_detach(), we move the
last enabled tfile to the position where detached one sit but don't
NULL out last position. We expect to synchronize the datapath through
tun->numqueues. Unfortunately, this won't work since we're lacking
sufficient mechanism to order or synchronize the access to
tun->numqueues.

To fix this, NULL out the last position during detaching and check
RCU protected tfile against NULL instead of checking tun->numqueues in
datapath.

Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: weiyongjun (A) <weiyongjun1@huawei.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: c8d68e6be1c3b ("tuntap: multiqueue support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -708,6 +708,8 @@ static void __tun_detach(struct tun_file
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
 		ntfile->queue_index = index;
+		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
+				   NULL);
 
 		--tun->numqueues;
 		if (clean) {
@@ -1090,7 +1092,7 @@ static netdev_tx_t tun_net_xmit(struct s
 	tfile = rcu_dereference(tun->tfiles[txq]);
 
 	/* Drop packet if interface is not attached */
-	if (txq >= tun->numqueues)
+	if (!tfile)
 		goto drop;
 
 	if (!rcu_dereference(tun->steering_prog))
@@ -1281,6 +1283,7 @@ static int tun_xdp_xmit(struct net_devic
 
 	rcu_read_lock();
 
+resample:
 	numqueues = READ_ONCE(tun->numqueues);
 	if (!numqueues) {
 		rcu_read_unlock();
@@ -1289,6 +1292,8 @@ static int tun_xdp_xmit(struct net_devic
 
 	tfile = rcu_dereference(tun->tfiles[smp_processor_id() %
 					    numqueues]);
+	if (unlikely(!tfile))
+		goto resample;
 
 	spin_lock(&tfile->tx_ring.producer_lock);
 	for (i = 0; i < n; i++) {


