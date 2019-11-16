Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5A4C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A121479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921133;
	bh=HUmds+9b5PGZVPdZ+yxdGP7APAcPSnss65fij7jLvqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdLGnQ86qwTx659nBbcXmpNJHokFelf/P/HfXU1qcPqape6HllpHHNaClgSoXR32a
	 vwrpv/QReQ41MYG1W4k62+Js5TxvUFBLpGBnvGohzu8B8mUEItzjXtDKVNGLs+kREx
	 +fHcbk8rjE2mwUWNmqis19FPwajYWd6ctCJbH0fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfKPPqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbfKPPqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:46:05 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB4220857;
        Sat, 16 Nov 2019 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919164;
        bh=HUmds+9b5PGZVPdZ+yxdGP7APAcPSnss65fij7jLvqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYpt+74JiTYRynxon1wbtIkFhcyv3BLIvkjfSXasGF2O+5uXQgqRMumtE256O/Yv/
         tF2FdVzI4jgiEQjpo2GgW7P5fOFEf19MDddRgIRpYME6qvIrA7Nv2+d7scDNAZ42PW
         gDYMLBfypECepKOBEsxFSx0Gst5aViR8c7ACw67g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jon Mason <jdmason@kudzu.us>,
        "Gerd W . Haeussler" <gerd.haeussler@cesys-it.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-ntb@googlegroups.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 172/237] ntb_netdev: fix sleep time mismatch
Date:   Sat, 16 Nov 2019 10:40:07 -0500
Message-Id: <20191116154113.7417-172-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Mason <jdmason@kudzu.us>

[ Upstream commit a861594b1b7ffd630f335b351c4e9f938feadb8e ]

The tx_time should be in usecs (according to the comment above the
variable), but the setting of the timer during the rearming is done in
msecs.  Change it to match the expected units.

Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
Suggested-by: Gerd W. Haeussler <gerd.haeussler@cesys-it.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ntb_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index b12023bc2cab5..df8d49ad48c38 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -236,7 +236,7 @@ static void ntb_netdev_tx_timer(struct timer_list *t)
 	struct net_device *ndev = dev->ndev;
 
 	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
-		mod_timer(&dev->tx_timer, jiffies + msecs_to_jiffies(tx_time));
+		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 	} else {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
-- 
2.20.1

