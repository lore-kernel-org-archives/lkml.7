Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DD9ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EEF2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391893AbfJPJJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:09:25 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:24354 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388342AbfJPJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:09:25 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 16 Oct 2019 02:09:21 -0700
Received: from akaher-virtual-machine.eng.vmware.com (unknown [10.197.103.239])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 66AE5B2609;
        Wed, 16 Oct 2019 05:09:23 -0400 (EDT)
From:   Ajay Kaher <akaher@vmware.com>
To:     <gregkh@linuxfoundation.org>
CC:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <jmorris@namei.org>,
        <yoshfuji@linux-ipv6.org>, <kaber@trash.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <amakhalov@vmware.com>,
        <srinidhir@vmware.com>, <bvikas@vmware.com>, <anishs@vmware.com>,
        <vsirnapalli@vmware.com>, <srostedt@vmware.com>,
        <akaher@vmware.com>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.9.y] Revert "net: sit: fix memory leak in sit_init_net()"
Date:   Wed, 16 Oct 2019 14:33:54 +0530
Message-ID: <1571216634-44834-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 375d6d454a95ebacb9c6eb0b715da05a4458ffef which is
commit 07f12b26e21ab359261bf75cfcb424fdc7daeb6d upstream.

Unnecessarily calling free_netdev() from sit_init_net().
ipip6_dev_free() of 4.9.y called free_netdev(), so no need
to call again after ipip6_dev_free().

Cc: Mao Wenan <maowenan@huawei.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 net/ipv6/sit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 47ca2a2..16eba7b 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1856,7 +1856,6 @@ static int __net_init sit_init_net(struct net *net)
 
 err_reg_dev:
 	ipip6_dev_free(sitn->fb_tunnel_dev);
-	free_netdev(sitn->fb_tunnel_dev);
 err_alloc_dev:
 	return err;
 }
-- 
2.7.4

