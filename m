Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2086DC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1522084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfDMKAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:00:03 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:38666 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfDMKAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:00:03 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Apr 2019 06:00:02 EDT
Received: from jiaolitao?raisecom.com (unknown [192.168.167.201])
        by lucky1.263xmail.com (Postfix) with ESMTP id 70B0F571AA;
        Sat, 13 Apr 2019 17:52:18 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED: 0
X-ABS-CHECKED: 0
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [36.106.21.149])
        by smtp.263.net (postfix) whith ESMTP id P18443T140378703386368S1555149129851949_;
        Sat, 13 Apr 2019 17:52:17 +0800 (CST)
X-UNIQUE-TAG: <072f6e018e707cc40dde5741654fad3e>
X-RL-SENDER: jiaolitao@raisecom.com
X-SENDER: 006714@raisecom.com
X-LOGIN-NAME: jiaolitao@raisecom.com
X-FST-TO: davem@davemloft.net
X-SENDER-IP: 36.106.21.149
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Litao Jiao <jiaolitao@raisecom.com>
To:     davem@davemloft.net
Cc:     petrm@mellanox.com, idosch@mellanox.com, roopa@cumulusnetworks.com,
        sbrivio@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiaolitao@raisecom.com
Subject: [PATCH] vxlan: do not add dynamic fdb entry when the dev has been downed
Date:   Sat, 13 Apr 2019 17:51:52 +0800
Message-Id: <1555149112-14115-1-git-send-email-jiaolitao@raisecom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the dev has been downed or goes downing, it should not
add dynamic fdb entry for the dev.

Signed-off-by: Litao Jiao <jiaolitao@raisecom.com>
---
 drivers/net/vxlan.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index d76dfed..3b45fe4 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1125,11 +1125,13 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
+	err = -EINVAL;
 	spin_lock_bh(&vxlan->hash_lock);
-	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
-			       port, src_vni, vni, ifindex,
-			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
-			       true, extack);
+	if (netif_running(dev) || (ndm->ndm_state & NUD_PERMANENT))
+		err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
+				       port, src_vni, vni, ifindex,
+				       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
+				       true, extack);
 	spin_unlock_bh(&vxlan->hash_lock);
 
 	return err;
-- 
1.9.1



