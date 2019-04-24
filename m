Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07414C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4F321903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125890;
	bh=Ek1SctxGzvZAFP9LQADDHcCTI36okv/Uqrd4o58BSoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uO75WsltZMEmAPAZcw3jd6Ka1Aq2lvM2IFUiKZ2RBY4rEwGfAm2bIY22QOPF2oomk
	 dr/gYdBUaQcut94bbRcjf1xs9m/M90/jciRMnQrVejghlwFxB/gYfzGPIAZ+UjMe0K
	 N1ORvNyrntVRfyFel7gJTtSJ8SnTOh+rZ2eiDG/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbfDXRL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733263AbfDXRL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:11:26 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E645D21903;
        Wed, 24 Apr 2019 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125885;
        bh=Ek1SctxGzvZAFP9LQADDHcCTI36okv/Uqrd4o58BSoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOoTPVrtMMY+rlBCgrV4tLuQOGqUa/XCaLVRLnjSG7Nly39g2A3RWduxlcr41f149
         UNhc0kHMnSmyLEMbtERLGiIl52ZeNEKuvAyNi9v7g0ZcIdpuPmbyIrWUwAgdfBX/IL
         Q7/O6BYUqPTz+ZFyPx074xCglcUBKhi5NWbiArME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 018/104] IB/mlx4: Increase the timeout for CM cache
Date:   Wed, 24 Apr 2019 19:08:35 +0200
Message-Id: <20190424170851.094209616@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2612d723aadcf8281f9bf8305657129bd9f3cd57 ]

Using CX-3 virtual functions, either from a bare-metal machine or
pass-through from a VM, MAD packets are proxied through the PF driver.

Since the VF drivers have separate name spaces for MAD Transaction Ids
(TIDs), the PF driver has to re-map the TIDs and keep the book keeping
in a cache.

Following the RDMA Connection Manager (CM) protocol, it is clear when
an entry has to evicted form the cache. But life is not perfect,
remote peers may die or be rebooted. Hence, it's a timeout to wipe out
a cache entry, when the PF driver assumes the remote peer has gone.

During workloads where a high number of QPs are destroyed concurrently,
excessive amount of CM DREQ retries has been observed

The problem can be demonstrated in a bare-metal environment, where two
nodes have instantiated 8 VFs each. This using dual ported HCAs, so we
have 16 vPorts per physical server.

64 processes are associated with each vPort and creates and destroys
one QP for each of the remote 64 processes. That is, 1024 QPs per
vPort, all in all 16K QPs. The QPs are created/destroyed using the
CM.

When tearing down these 16K QPs, excessive CM DREQ retries (and
duplicates) are observed. With some cat/paste/awk wizardry on the
infiniband_cm sysfs, we observe as sum of the 16 vPorts on one of the
nodes:

cm_rx_duplicates:
      dreq  2102
cm_rx_msgs:
      drep  1989
      dreq  6195
       rep  3968
       req  4224
       rtu  4224
cm_tx_msgs:
      drep  4093
      dreq 27568
       rep  4224
       req  3968
       rtu  3968
cm_tx_retries:
      dreq 23469

Note that the active/passive side is equally distributed between the
two nodes.

Enabling pr_debug in cm.c gives tons of:

[171778.814239] <mlx4_ib> mlx4_ib_multiplex_cm_handler: id{slave:
1,sl_cm_id: 0xd393089f} is NULL!

By increasing the CM_CLEANUP_CACHE_TIMEOUT from 5 to 30 seconds, the
tear-down phase of the application is reduced from approximately 90 to
50 seconds. Retries/duplicates are also significantly reduced:

cm_rx_duplicates:
      dreq  2460
[]
cm_tx_retries:
      dreq  3010
       req    47

Increasing the timeout further didn't help, as these duplicates and
retries stems from a too short CMA timeout, which was 20 (~4 seconds)
on the systems. By increasing the CMA timeout to 22 (~17 seconds), the
numbers fell down to about 10 for both of them.

Adjustment of the CMA timeout is not part of this commit.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Acked-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 56a593e0ae5d..2aedbd18ffbc 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -39,7 +39,7 @@
 
 #include "mlx4_ib.h"
 
-#define CM_CLEANUP_CACHE_TIMEOUT  (5 * HZ)
+#define CM_CLEANUP_CACHE_TIMEOUT  (30 * HZ)
 
 struct id_map_entry {
 	struct rb_node node;
-- 
2.19.1



