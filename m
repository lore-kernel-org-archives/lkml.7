Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78301C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 04:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F3420684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 04:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfCFEIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 23:08:05 -0500
Received: from regular1.263xmail.com ([211.150.99.136]:37924 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfCFEIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 23:08:05 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2019 23:08:03 EST
Received: from jiaolitao?raisecom.com (unknown [192.168.167.129])
        by regular1.263xmail.com (Postfix) with ESMTP id 9B7064E3;
        Wed,  6 Mar 2019 12:01:54 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (194.195.37.106.static.bjtelecom.net [106.37.195.194])
        by smtp.263.net (postfix) whith ESMTP id P1234T140524484818688S1551844910225279_;
        Wed, 06 Mar 2019 12:01:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <343bba039cdaeb20f05b0d6b3a86b10e>
X-RL-SENDER: jiaolitao@raisecom.com
X-SENDER: 006714@raisecom.com
X-LOGIN-NAME: jiaolitao@raisecom.com
X-FST-TO: davem@davemloft.net
X-SENDER-IP: 106.37.195.194
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
From:   Litao Jiao <jiaolitao@raisecom.com>
To:     davem@davemloft.net
Cc:     petrm@mellanox.com, idosch@mellanox.com, roopa@cumulusnetworks.com,
        sd@queasysnail.net, sbrivio@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiaolitao@raisecom.com
Subject: [PATCH] vxlan: do not need BH again in vxlan_cleanup()
Date:   Wed,  6 Mar 2019 12:01:48 +0800
Message-Id: <1551844908-8152-1-git-send-email-jiaolitao@raisecom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vxlan_cleanup() is a timer callback, it is already
and only running in BH context.

Signed-off-by: Litao Jiao <jiaolitao@raisecom.com>
---
 drivers/net/vxlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 2aae11f..98dde11 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2616,7 +2616,7 @@ static void vxlan_cleanup(struct timer_list *t)
 	for (h = 0; h < FDB_HASH_SIZE; ++h) {
 		struct hlist_node *p, *n;
 
-		spin_lock_bh(&vxlan->hash_lock);
+		spin_lock(&vxlan->hash_lock);
 		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
 			struct vxlan_fdb *f
 				= container_of(p, struct vxlan_fdb, hlist);
@@ -2638,7 +2638,7 @@ static void vxlan_cleanup(struct timer_list *t)
 			} else if (time_before(timeout, next_timer))
 				next_timer = timeout;
 		}
-		spin_unlock_bh(&vxlan->hash_lock);
+		spin_unlock(&vxlan->hash_lock);
 	}
 
 	mod_timer(&vxlan->age_timer, next_timer);
-- 
1.9.1



