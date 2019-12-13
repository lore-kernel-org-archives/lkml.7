Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF403C341AC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC4824734
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLMMJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:09:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45928 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfLMMJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:09:56 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B435D8AB0A8FF068C476;
        Fri, 13 Dec 2019 20:09:54 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 20:09:46 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <stefanr@s5r6.in-berlin.de>
CC:     <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <linux1394-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] firewire: net: remove set but not used variable 'guid'
Date:   Fri, 13 Dec 2019 20:09:19 +0800
Message-ID: <20191213120919.8080-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/firewire/net.c: In function ‘fwnet_finish_incoming_packet’:
drivers/firewire/net.c:493:9: warning: variable ‘guid’ set but not
used [-Wunused-but-set-variable]

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/firewire/net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 715e491dfbc3..28785642a5c5 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -490,7 +490,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 {
 	struct fwnet_device *dev;
 	int status;
-	__be64 guid;
 
 	switch (ether_type) {
 	case ETH_P_ARP:
@@ -512,7 +511,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 	 * Parse the encapsulation header. This actually does the job of
 	 * converting to an ethernet-like pseudo frame header.
 	 */
-	guid = cpu_to_be64(dev->card->guid);
 	if (dev_hard_header(skb, net, ether_type,
 			   is_broadcast ? net->broadcast : net->dev_addr,
 			   NULL, skb->len) >= 0) {
-- 
2.17.2

