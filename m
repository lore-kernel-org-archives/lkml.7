Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD94FC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770142075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142226;
	bh=anNXDwU1QQ1P75e5uA1Vk4W6iUlx6TtteWrqSceTEdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKGsySAGVHh17OnyGxFAGnBG4RLAc2+3G14r2rF9sbBB+D3wz+ZSKqunALnhM1er8
	 GKT6kg2gG9JlJNU1MVYjkNU6XYbpV5NLuyJj7qnZ95GUCZShktJo7ooq0PHhRjOti/
	 sne3OmX+cOt7kqL6zU6pDhCkLsRQ7ofgv0qX1tCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfKSFnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbfKSFnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:43:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308B6208C3;
        Tue, 19 Nov 2019 05:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142220;
        bh=anNXDwU1QQ1P75e5uA1Vk4W6iUlx6TtteWrqSceTEdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tD+53Rt6u4zfSyF+vTiY5xrZT9UI1IgEHnWoKry9TDMu1xgyH9IvDj8Z3/kRbxiTP
         Ct1VtrSisJznlvhfd9uvqJfvJtHSU+wCGQ/Y73fLyerEA9cDHUHfvUBauK5PurZIRg
         P5oyj82YMSrrfARG2t1D0fLHmpcn2UgxUICg1rT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Golan Ben Ami <golan.ben.ami@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 396/422] iwlwifi: pcie: fit reclaim msg to MAX_MSG_LEN
Date:   Tue, 19 Nov 2019 06:19:53 +0100
Message-Id: <20191119051424.792804627@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

[ Upstream commit 81f0c66187e1ebb7b63529d82faf7ff1e0ef428a ]

Today, the length of a debug message in iwl_trans_pcie_reclaim
may pass the MAX_MSG_LEN, which is 110.
An example for this kind of message is:

'iwl_trans_pcie_reclaim: Read index for DMA queue txq id (2),
last_to_free 65535 is out of range [0-65536] 2 2.'

Cut the message a bit so it will fit the allowed MAX_MSG_LEN.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 42fdb7970cfdc..2fec394a988c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1103,7 +1103,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 
 	if (!iwl_queue_used(txq, last_to_free)) {
 		IWL_ERR(trans,
-			"%s: Read index for DMA queue txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
+			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
 			__func__, txq_id, last_to_free,
 			trans->cfg->base_params->max_tfd_queue_size,
 			txq->write_ptr, txq->read_ptr);
-- 
2.20.1



