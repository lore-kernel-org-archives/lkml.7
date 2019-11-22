Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCBD2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420488;
	bh=/5SV11ftb0X8yX48wLyDYS2i4vnc0xOfd1H3wpD0aY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z5OBMqERkgeB8zk77OnOzIG1weFz7aBHv4CXNX1frmKgJ/B2q1y2U9PVBCf8ZJOSN
	 oJ4ZeJDrVOWd2y1HgNb/lO6ecgKDRX0jnWWUezb1ef15lUgCACDL3xca1OxrrWAQck
	 C2Fy5pn0+r9ggvCDcimkO1XCRuFVHimS3Z/tPmk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfKVLB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731187AbfKVLBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:01:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D253F20706;
        Fri, 22 Nov 2019 11:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420484;
        bh=/5SV11ftb0X8yX48wLyDYS2i4vnc0xOfd1H3wpD0aY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16tgWQbDsX/4zF6+Qp8ADB36JoWUe7lngLp5PAnK4JMNKlSmPZ42nezvWgwldTQAY
         OeoS8W4fyp8Bl9zNdlGG1nLKclVKZAZTkSIRIkxY+nLw1zWz99SzT0Io8JtVJUo8/e
         fR0UZeA0yFLggjMpRh2HhcbWq9+OUFk9pM/PeGiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/220] ice: Fix forward to queue group logic
Date:   Fri, 22 Nov 2019 11:27:23 +0100
Message-Id: <20191122100917.963328217@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

[ Upstream commit be8ff000bf83e658e63ab64cf4d2755abc5add5b ]

When adding a rule, queue region size needs to be provided as log base 2
of the number of queues in region. Fix that.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 6b7ec2ae5ad67..4012adbab0112 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -468,6 +468,7 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 	void *daddr = NULL;
 	u32 act = 0;
 	__be16 *off;
+	u8 q_rgn;
 
 	if (opc == ice_aqc_opc_remove_sw_rules) {
 		s_rule->pdata.lkup_tx_rx.act = 0;
@@ -503,14 +504,19 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 		act |= (f_info->fwd_id.q_id << ICE_SINGLE_ACT_Q_INDEX_S) &
 			ICE_SINGLE_ACT_Q_INDEX_M;
 		break;
+	case ICE_DROP_PACKET:
+		act |= ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_DROP |
+			ICE_SINGLE_ACT_VALID_BIT;
+		break;
 	case ICE_FWD_TO_QGRP:
+		q_rgn = f_info->qgrp_size > 0 ?
+			(u8)ilog2(f_info->qgrp_size) : 0;
 		act |= ICE_SINGLE_ACT_TO_Q;
-		act |= (f_info->qgrp_size << ICE_SINGLE_ACT_Q_REGION_S) &
+		act |= (f_info->fwd_id.q_id << ICE_SINGLE_ACT_Q_INDEX_S) &
+			ICE_SINGLE_ACT_Q_INDEX_M;
+		act |= (q_rgn << ICE_SINGLE_ACT_Q_REGION_S) &
 			ICE_SINGLE_ACT_Q_REGION_M;
 		break;
-	case ICE_DROP_PACKET:
-		act |= ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_DROP;
-		break;
 	default:
 		return;
 	}
-- 
2.20.1



