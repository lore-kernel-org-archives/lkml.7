Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97750C41514
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F85206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389538AbfIEMyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:54:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389222AbfIEMyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:54:47 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3F3DD6C0AF5D3E88FA96;
        Thu,  5 Sep 2019 20:54:43 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 20:54:35 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <mareklindner@neomailbox.ch>,
        <mchehab@kernel.org>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <sakari.ailus@linux.intel.com>,
        <a@unstable.cc>, <sw@simonwunderlich.de>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <zhongjiang@huawei.com>
Subject: [PATCH 1/3] batman-adv: Use FIELD_SIZEOF directly
Date:   Thu, 5 Sep 2019 20:51:34 +0800
Message-ID: <1567687896-19996-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1567687896-19996-1-git-send-email-zhongjiang@huawei.com>
References: <1567687896-19996-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more clear to use FIELD_SIZEOF instead of its implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/batman-adv/distributed-arp-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index b0af3a1..c79fdf8 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -91,8 +91,8 @@ struct batadv_dhcp_packet {
 	__u8 options[0];
 };
 
-#define BATADV_DHCP_YIADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->yiaddr)
-#define BATADV_DHCP_CHADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->chaddr)
+#define BATADV_DHCP_YIADDR_LEN FIELD_SIZEOF(struct batadv_dhcp_packet, yiaddr)
+#define BATADV_DHCP_CHADDR_LEN FIELD_SIZEOF(struct batadv_dhcp_packet, chaddr)
 
 static void batadv_dat_purge(struct work_struct *work);
 
-- 
1.7.12.4

