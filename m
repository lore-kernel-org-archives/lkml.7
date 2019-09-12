Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B95C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A30214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfILDpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 23:45:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729752AbfILDpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 23:45:05 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1167E92762D2E5FEB2E6;
        Thu, 12 Sep 2019 11:45:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 12 Sep 2019 11:44:52 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <vyasevich@gmail.com>, <nhorman@tuxdriver.com>,
        <marcelo.leitner@gmail.com>, <davem@davemloft.net>
CC:     <linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH v2 net 2/3] sctp: remove redundant assignment when call sctp_get_port_local
Date:   Thu, 12 Sep 2019 12:02:18 +0800
Message-ID: <20190912040219.67517-3-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912040219.67517-1-maowenan@huawei.com>
References: <7a450679-40ca-8a84-4cba-7a16f22ea3c0@huawei.com>
 <20190912040219.67517-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more parentheses in if clause when call sctp_get_port_local
in sctp_do_bind, and redundant assignment to 'ret'. This patch is to
do cleanup.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
---
 net/sctp/socket.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 5e1934c48709..2f810078c91d 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -399,9 +399,8 @@ static int sctp_do_bind(struct sock *sk, union sctp_addr *addr, int len)
 	 * detection.
 	 */
 	addr->v4.sin_port = htons(snum);
-	if ((ret = sctp_get_port_local(sk, addr))) {
+	if (sctp_get_port_local(sk, addr))
 		return -EADDRINUSE;
-	}
 
 	/* Refresh ephemeral port.  */
 	if (!bp->port)
-- 
2.20.1

