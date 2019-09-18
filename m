Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490CCC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2064F21848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfIRClg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:41:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfIRClg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 22:41:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6B3BBFCF73A93D0EF5E1;
        Wed, 18 Sep 2019 10:41:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Wed, 18 Sep 2019 10:41:27 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jakub.kicinski@netronome.com>, <davem@davemloft.net>
CC:     <anna.schumaker@netapp.com>, <trond.myklebust@hammerspace.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhongjiang@huawei.com>
Subject: [RESENT PATCH net-next] ixgbe: Use memzero_explicit directly in crypto cases
Date:   Wed, 18 Sep 2019 10:38:21 +0800
Message-ID: <1568774301-8918-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, Use kzfree() to replace memset() + kfree() is feasible and
resonable.  But It's better to use memzero_explicit() to replace memset()
in crypto cases.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 113f608..7e4f32f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -960,9 +960,11 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 	return 0;
 
 err_aead:
-	kzfree(xs->aead);
+	memzero_explicit(xs->aead, sizeof(*xs->aead));
+	kfree(xs->aead);
 err_xs:
-	kzfree(xs);
+	memzero_explicit(xs, sizeof(*xs));
+	kfree(xs);
 err_out:
 	msgbuf[1] = err;
 	return err;
@@ -1047,7 +1049,8 @@ int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 	ixgbe_ipsec_del_sa(xs);
 
 	/* remove the xs that was made-up in the add request */
-	kzfree(xs);
+	memzero_explicit(xs, sizeof(*xs));
+	kfree(xs);
 
 	return 0;
 }
-- 
1.7.12.4

