Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72121C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432DB207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412996;
	bh=KxTiF+clM6zkDw/1Ly8e3THCRXNCPT+1U5GKrKVfEJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mLlB0jahycLnyX+GUWt05kb40W3fywac7FKaV36ULx9gUFsyrkw2psm4wKmyRya6O
	 ZlvdY43Gg7f/N6h2sSFdub1A/DTgnQ7pTMJsxk2+NAZSg0IFTgdvOT+WWstSDfh5Y4
	 OA54IXPPIAqp+1qnRI7d9glvN2SBauZT9BgF0uBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfLCWnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:43:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfLCWnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:43:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D721206EC;
        Tue,  3 Dec 2019 22:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412991;
        bh=KxTiF+clM6zkDw/1Ly8e3THCRXNCPT+1U5GKrKVfEJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mi5zTbMJj/f8usKAPWEkc2mR0J9LBvRIFAZ1pZHgQg45IZYuqzU4XvOeeM1IGlXOs
         iRQapinnUmn+4hZAstKh7BLTVAfbPIgAcSKU0AF9hnQgnL/PaDCh+83FMQnkl6pwyC
         dz3f6IAoZfmOsmxouy7wHZjrD+jCC5TphVJJkNdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Nunley <nicholas.d.nunley@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 095/135] iavf: initialize ITRN registers with correct values
Date:   Tue,  3 Dec 2019 23:35:35 +0100
Message-Id: <20191203213037.584629529@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

[ Upstream commit 4eda4e0096842764d725bcfd77471a419832b074 ]

Since commit 92418fb14750 ("i40e/i40evf: Use usec value instead of reg
value for ITR defines") the driver tracks the interrupt throttling
intervals in single usec units, although the actual ITRN registers are
programmed in 2 usec units. Most register programming flows in the driver
correctly handle the conversion, although it is currently not applied when
the registers are initialized to their default values. Most of the time
this doesn't present a problem since the default values are usually
immediately overwritten through the standard adaptive throttling mechanism,
or updated manually by the user, but if adaptive throttling is disabled and
the interval values are left alone then the incorrect value will persist.

Since the intended default interval of 50 usecs (vs. 100 usecs as
programmed) performs better for most traffic workloads, this can lead to
performance regressions.

This patch adds the correct conversion when writing the initial values to
the ITRN registers.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 9d2b50964a08f..fa857b60ba2b6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -336,7 +336,7 @@ iavf_map_vector_to_rxq(struct iavf_adapter *adapter, int v_idx, int r_idx)
 	q_vector->rx.target_itr = ITR_TO_REG(rx_ring->itr_setting);
 	q_vector->ring_mask |= BIT(r_idx);
 	wr32(hw, IAVF_VFINT_ITRN1(IAVF_RX_ITR, q_vector->reg_idx),
-	     q_vector->rx.current_itr);
+	     q_vector->rx.current_itr >> 1);
 	q_vector->rx.current_itr = q_vector->rx.target_itr;
 }
 
@@ -362,7 +362,7 @@ iavf_map_vector_to_txq(struct iavf_adapter *adapter, int v_idx, int t_idx)
 	q_vector->tx.target_itr = ITR_TO_REG(tx_ring->itr_setting);
 	q_vector->num_ringpairs++;
 	wr32(hw, IAVF_VFINT_ITRN1(IAVF_TX_ITR, q_vector->reg_idx),
-	     q_vector->tx.target_itr);
+	     q_vector->tx.target_itr >> 1);
 	q_vector->tx.current_itr = q_vector->tx.target_itr;
 }
 
-- 
2.20.1



