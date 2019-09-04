Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644BBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAB322CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfIDCmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 22:42:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbfIDCmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:42:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EDCC07904D833413A145;
        Wed,  4 Sep 2019 10:42:14 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 10:42:06 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     <zhongjiang@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] net: Use kzfree() directly
Date:   Wed, 4 Sep 2019 10:39:09 +0800
Message-ID: <1567564752-6430-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of Coccinelle. We find some place to replace.

@@
expression M, S;
@@

- memset(M, 0, S);
- kfree(M);
+ kzfree(M); 

zhong jiang (3):
  ixgbe: Use kzfree() rather than its implementation.
  sunrpc: Use kzfree rather than its implementation.
  net: mpoa: Use kzfree rather than its implementation.

 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 9 +++------
 net/atm/mpoa_caches.c                          | 6 ++----
 net/sunrpc/auth_gss/gss_krb5_keys.c            | 9 +++------
 3 files changed, 8 insertions(+), 16 deletions(-)

-- 
1.7.12.4

