Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CB3CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BC521835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfKAOAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:00:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58254 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfKAOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:00:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iQXTN-00055Z-FX; Fri, 01 Nov 2019 14:00:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ice: fix potential infinite loop because loop counter being too small
Date:   Fri,  1 Nov 2019 14:00:17 +0000
Message-Id: <20191101140017.16646-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the for-loop counter i is a u8 however it is being checked
against a maximum value hw->num_tx_sched_layers which is a u16. Hence
there is a potential wrap-around of counter i back to zero if
hw->num_tx_sched_layers is greater than 255.  Fix this by making i
a u16.

Addresses-Coverity: ("Infinite loop")
Fixes: b36c598c999c ("ice: Updates to Tx scheduler code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index fc624b73d05d..2fde9653a608 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1036,7 +1036,7 @@ enum ice_status ice_sched_query_res_alloc(struct ice_hw *hw)
 	struct ice_aqc_query_txsched_res_resp *buf;
 	enum ice_status status = 0;
 	__le16 max_sibl;
-	u8 i;
+	u16 i;
 
 	if (hw->layer_info)
 		return status;
-- 
2.20.1

