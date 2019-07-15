Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6ABC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951CD2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198526;
	bh=OpOsLOSWHTYl/Z1oKwxTfZB+zZtDvt09ioVEEvxshGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XPz1U2SFk3b5OB9MVjT13uJQiCKy/okAPUfhAxwrDao596Aoonv2h3hJLxwH4MuoQ
	 W+4gRQehTpndoTXjUqMV55kqeiS6e33wr9XtDqKP+LaktOCNPiLFdcQqAu1CBgmhh9
	 mzjWEaS6X8hJPpiAwJr1LKFK1V0vNCamWS+6XXHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfGONsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731546AbfGONsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:48:39 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F17F20896;
        Mon, 15 Jul 2019 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198518;
        bh=OpOsLOSWHTYl/Z1oKwxTfZB+zZtDvt09ioVEEvxshGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKhxUS7AmSWpgvs7/THPNqS4K76HpJ6pym86CI1YYzxorILIE3rf2Oh191ZIdHTCQ
         6LxIjKKpOVWvMME3JnakH4CVQzQF5clCosdcMpNRhGLc9oO3Z5L2KPbVRSKtmkr1/U
         74tIrAS7ItoJx3vEuCXFuqXbP7S4Wg7O1njylTU8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brett Creeley <brett.creeley@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 033/249] ice: Fix couple of issues in ice_vsi_release
Date:   Mon, 15 Jul 2019 09:43:18 -0400
Message-Id: <20190715134655.4076-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brett Creeley <brett.creeley@intel.com>

[ Upstream commit aa6ccf3f2d7042f94c4e91538956ce7051e7856e ]

Currently the driver is calling ice_napi_del() and then
unregister_netdev(). The call to unregister_netdev() will result in a
call to ice_stop() and then ice_vsi_close(). This is where we call
napi_disable() for all the MSI-X vectors. This flow is reversed so make
the changes to ensure napi_disable() happens prior to napi_del().

Before calling napi_del() and free_netdev() make sure
unregister_netdev() was called. This is done by making sure the
__ICE_DOWN bit is set in the vsi->state for the interested VSI.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 -
 drivers/net/ethernet/intel/ice/ice_lib.c  | 24 ++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 792e6e42030e..754c7080c3fc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -451,7 +451,6 @@ int ice_set_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
 int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
 void ice_fill_rss_lut(u8 *lut, u16 rss_table_size, u16 rss_size);
 void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
-void ice_napi_del(struct ice_vsi *vsi);
 #ifdef CONFIG_DCB
 int ice_pf_ena_all_vsi(struct ice_pf *pf, bool locked);
 void ice_pf_dis_all_vsi(struct ice_pf *pf, bool locked);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index fbf1eba0cc2a..f14fa51cc704 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2754,19 +2754,14 @@ int ice_vsi_release(struct ice_vsi *vsi)
 
 	if (vsi->type == ICE_VSI_VF)
 		vf = &pf->vf[vsi->vf_id];
-	/* do not unregister and free netdevs while driver is in the reset
-	 * recovery pending state. Since reset/rebuild happens through PF
-	 * service task workqueue, its not a good idea to unregister netdev
-	 * that is associated to the PF that is running the work queue items
-	 * currently. This is done to avoid check_flush_dependency() warning
-	 * on this wq
+	/* do not unregister while driver is in the reset recovery pending
+	 * state. Since reset/rebuild happens through PF service task workqueue,
+	 * it's not a good idea to unregister netdev that is associated to the
+	 * PF that is running the work queue items currently. This is done to
+	 * avoid check_flush_dependency() warning on this wq
 	 */
-	if (vsi->netdev && !ice_is_reset_in_progress(pf->state)) {
-		ice_napi_del(vsi);
+	if (vsi->netdev && !ice_is_reset_in_progress(pf->state))
 		unregister_netdev(vsi->netdev);
-		free_netdev(vsi->netdev);
-		vsi->netdev = NULL;
-	}
 
 	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 		ice_rss_clean(vsi);
@@ -2799,6 +2794,13 @@ int ice_vsi_release(struct ice_vsi *vsi)
 	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
 	ice_vsi_delete(vsi);
 	ice_vsi_free_q_vectors(vsi);
+
+	/* make sure unregister_netdev() was called by checking __ICE_DOWN */
+	if (vsi->netdev && test_bit(__ICE_DOWN, vsi->state)) {
+		free_netdev(vsi->netdev);
+		vsi->netdev = NULL;
+	}
+
 	ice_vsi_clear_rings(vsi);
 
 	ice_vsi_put_qs(vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7843abf4d44d..dbf3d39ad8b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1667,7 +1667,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
  * ice_napi_del - Remove NAPI handler for the VSI
  * @vsi: VSI for which NAPI handler is to be removed
  */
-void ice_napi_del(struct ice_vsi *vsi)
+static void ice_napi_del(struct ice_vsi *vsi)
 {
 	int v_idx;
 
-- 
2.20.1

