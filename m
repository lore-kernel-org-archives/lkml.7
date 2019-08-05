Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D7C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB65206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfHELxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:53:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728468AbfHELxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:53:15 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 73B2986D541AE633558B;
        Mon,  5 Aug 2019 19:53:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 19:53:05 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <davem@davemloft.net>, <socketcan@hartkopp.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <maowenan@huawei.com>
Subject: [PATCH net-next v3] net: can: Fix compiling warnings for two functions
Date:   Mon, 5 Aug 2019 19:57:44 +0800
Message-ID: <20190805115744.112440-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <6fd68e9b-a8ae-4e5e-9b23-c099b5ca9aa4@web.de>
References: <6fd68e9b-a8ae-4e5e-9b23-c099b5ca9aa4@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two warnings in net/can, fix them by setting bcm_sock_no_ioctlcmd
and raw_sock_no_ioctlcmd as static.

net/can/bcm.c:1683:5: warning: symbol 'bcm_sock_no_ioctlcmd' was not declared. Should it be static?
net/can/raw.c:840:5: warning: symbol 'raw_sock_no_ioctlcmd' was not declared. Should it be static?

Fixes: 473d924d7d46 ("can: fix ioctl function removal")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 v1->v2: change patch description typo error, 'warings' to 'warnings'.
 v2->v3: change subject of patch.
 net/can/bcm.c | 2 +-
 net/can/raw.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index bf1d0bbecec8..b8a32b4ac368 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1680,7 +1680,7 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	return size;
 }
 
-int bcm_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
+static int bcm_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
 			 unsigned long arg)
 {
 	/* no ioctls for socket layer -> hand it down to NIC layer */
diff --git a/net/can/raw.c b/net/can/raw.c
index da386f1fa815..a01848ff9b12 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -837,7 +837,7 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	return size;
 }
 
-int raw_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
+static int raw_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
 			 unsigned long arg)
 {
 	/* no ioctls for socket layer -> hand it down to NIC layer */
-- 
2.20.1

