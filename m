Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BF821734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414063;
	bh=mv1M9FJxvZBHJbs/qqnjc2kl51JfClxx9tmGgCrhjEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MilvcTT738K+Lp7UVnR0cv7Q8NImVig+PM0azb7PpwLRCjLAENIMkP5K5NpJ/m1fF
	 KcbYe5LZQJqb0m53nc0Bj6YhJ0Ux7V41nMk/HK0JMEyNL/tLCApP0zQ/r8c/3R30EO
	 T4JggDIFrLnGULspe/7IkCSnP4L2z0L7A8ACNH58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfCLSHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfCLRMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:20 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25E6217D9;
        Tue, 12 Mar 2019 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410738;
        bh=mv1M9FJxvZBHJbs/qqnjc2kl51JfClxx9tmGgCrhjEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtggwwBuuE2V/21yARAN/EeytBFhjS89G2dGpb/XR/hWP37+LJV7aLpd1i0OlYJsc
         ZLM1Zo/sHcoWIBgkN/4NJMww8USq4v55LoIpgC/A/tBFljjU/zVymRSxBMEyJxk6hw
         9FpoTMDNf15RcFmNcngnf9YI1Ru/V6n/HiVgFZWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 042/171] qed: Fix LACP pdu drops for VFs
Date:   Tue, 12 Mar 2019 10:07:02 -0700
Message-Id: <20190312170351.723521857@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ff9296966e5e00b0d0d00477b2365a178f0f06a3 ]

VF is always configured to drop control frames
(with reserved mac addresses) but to work LACP
on the VFs, it would require LACP control frames
to be forwarded or transmitted successfully.

This patch fixes this in such a way that trusted VFs
(marked through ndo_set_vf_trust) would be allowed to
pass the control frames such as LACP pdus.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c    |  5 +++++
 drivers/net/ethernet/qlogic/qed/qed_l2.h    |  3 +++
 drivers/net/ethernet/qlogic/qed/qed_sriov.c | 10 ++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index b8baa6fcef8e..e68ca83ae915 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -748,6 +748,11 @@ int qed_sp_vport_update(struct qed_hwfn *p_hwfn,
 		return rc;
 	}
 
+	if (p_params->update_ctl_frame_check) {
+		p_cmn->ctl_frame_mac_check_en = p_params->mac_chk_en;
+		p_cmn->ctl_frame_ethtype_check_en = p_params->ethtype_chk_en;
+	}
+
 	/* Update mcast bins for VFs, PF doesn't use this functionality */
 	qed_sp_update_mcast_bin(p_hwfn, p_ramrod, p_params);
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.h b/drivers/net/ethernet/qlogic/qed/qed_l2.h
index 8d80f1095d17..7127d5aaac42 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.h
@@ -219,6 +219,9 @@ struct qed_sp_vport_update_params {
 	struct qed_rss_params		*rss_params;
 	struct qed_filter_accept_flags	accept_flags;
 	struct qed_sge_tpa_params	*sge_tpa_params;
+	u8				update_ctl_frame_check;
+	u8				mac_chk_en;
+	u8				ethtype_chk_en;
 };
 
 int qed_sp_vport_update(struct qed_hwfn *p_hwfn,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index ca6290fa0f30..71a7af134dd8 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -1969,7 +1969,9 @@ static void qed_iov_vf_mbx_start_vport(struct qed_hwfn *p_hwfn,
 	params.vport_id = vf->vport_id;
 	params.max_buffers_per_cqe = start->max_buffers_per_cqe;
 	params.mtu = vf->mtu;
-	params.check_mac = true;
+
+	/* Non trusted VFs should enable control frame filtering */
+	params.check_mac = !vf->p_vf_info.is_trusted_configured;
 
 	rc = qed_sp_eth_vport_start(p_hwfn, &params);
 	if (rc) {
@@ -5130,6 +5132,9 @@ static void qed_iov_handle_trust_change(struct qed_hwfn *hwfn)
 		params.opaque_fid = vf->opaque_fid;
 		params.vport_id = vf->vport_id;
 
+		params.update_ctl_frame_check = 1;
+		params.mac_chk_en = !vf_info->is_trusted_configured;
+
 		if (vf_info->rx_accept_mode & mask) {
 			flags->update_rx_mode_config = 1;
 			flags->rx_accept_filter = vf_info->rx_accept_mode;
@@ -5147,7 +5152,8 @@ static void qed_iov_handle_trust_change(struct qed_hwfn *hwfn)
 		}
 
 		if (flags->update_rx_mode_config ||
-		    flags->update_tx_mode_config)
+		    flags->update_tx_mode_config ||
+		    params.update_ctl_frame_check)
 			qed_sp_vport_update(hwfn, &params,
 					    QED_SPQ_MODE_EBLOCK, NULL);
 	}
-- 
2.19.1



