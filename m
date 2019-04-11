Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535DBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2E62070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfDKHOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:14:06 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:36436 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:14:05 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2019 03:14:02 EDT
Received: from jiaolitao?raisecom.com (unknown [192.168.167.131])
        by regular1.263xmail.com (Postfix) with ESMTP id 9E34A3BE;
        Thu, 11 Apr 2019 15:06:30 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED: 0
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [36.106.21.148])
        by smtp.263.net (postfix) whith ESMTP id P22649T139665665033984S1554966384531579_;
        Thu, 11 Apr 2019 15:06:30 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c3eb433156a4333e59d77d3acf8de74e>
X-RL-SENDER: jiaolitao@raisecom.com
X-SENDER: 006714@raisecom.com
X-LOGIN-NAME: jiaolitao@raisecom.com
X-FST-TO: davem@davemloft.net
X-SENDER-IP: 36.106.21.148
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Litao Jiao <jiaolitao@raisecom.com>
To:     davem@davemloft.net
Cc:     petrm@mellanox.com, idosch@mellanox.com, roopa@cumulusnetworks.com,
        sbrivio@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiaolitao@raisecom.com
Subject: [PATCH] vxlan: using hash_lock to protect one budegt in vxlan_flush
Date:   Thu, 11 Apr 2019 15:06:09 +0800
Message-Id: <1554966369-16259-1-git-send-email-jiaolitao@raisecom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hash_lock will hold long time in vxlan_flush when stopping the
vxlan device in which there has lots of vxlan fdb entries;it would
affect the bh process in local cpu; and other cpu would wait for
a long time in vxlan_snoop until the hash_lock is released;so
using hash_lock to protect one budegt in vxlan_flush could
reduce the continuous holding time of the lock.

Signed-off-by: Litao Jiao <jiaolitao@raisecom.com>
---
 drivers/net/vxlan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index d76dfed..306703e 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2816,9 +2816,10 @@ static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
 {
 	unsigned int h;
 
-	spin_lock_bh(&vxlan->hash_lock);
 	for (h = 0; h < FDB_HASH_SIZE; ++h) {
 		struct hlist_node *p, *n;
+
+		spin_lock_bh(&vxlan->hash_lock);
 		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
 			struct vxlan_fdb *f
 				= container_of(p, struct vxlan_fdb, hlist);
@@ -2828,8 +2829,8 @@ static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
 			if (!is_zero_ether_addr(f->eth_addr))
 				vxlan_fdb_destroy(vxlan, f, true, true);
 		}
+		spin_unlock_bh(&vxlan->hash_lock);
 	}
-	spin_unlock_bh(&vxlan->hash_lock);
 }
 
 /* Cleanup timer and forwarding table on shutdown */
-- 
1.9.1



