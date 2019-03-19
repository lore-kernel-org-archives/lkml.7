Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9955DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7485720850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfCSPMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:12:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfCSPMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:12:39 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47F83D272B1EC928FD45;
        Tue, 19 Mar 2019 23:12:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 23:12:23 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <sagi@lightbitslabs.com>,
        <xiyou.wangcong@gmail.com>, <kgraul@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] datagram: Make __skb_datagram_iter static
Date:   Tue, 19 Mar 2019 22:59:46 +0800
Message-ID: <20190319145946.20504-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

net/core/datagram.c:411:5: warning:
 symbol '__skb_datagram_iter' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/core/datagram.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index b2651bb..ed8accb 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -408,10 +408,10 @@ int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags)
 }
 EXPORT_SYMBOL(skb_kill_datagram);
 
-int __skb_datagram_iter(const struct sk_buff *skb, int offset,
-			struct iov_iter *to, int len, bool fault_short,
-			size_t (*cb)(const void *, size_t, void *, struct iov_iter *),
-			void *data)
+static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
+			       struct iov_iter *to, int len, bool fault_short,
+			       size_t (*cb)(const void *, size_t, void *,
+					    struct iov_iter *), void *data)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset, start_off = offset, n;
-- 
2.7.4


