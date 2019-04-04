Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74113C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448412147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369100;
	bh=qrGZdm5h2p1U3m2QtfCyK+1E6kpx4gs5CFS6Rpgyadg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pVDBd58THawR5VA0aPqFHjl5b2KR3ihTgxJcAl/+REoCksAdVrUoH5iomAp9h959L
	 uVjNr04GyMGJeaD5ykcogyunssBlzuB5EfkwmldZWnvOW7K11YTiXEfmqZGo3+u/ay
	 /+Vat7q6iBxQQqur6jQDPO/cPwawBjgXYEbQqna0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbfDDJLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733186AbfDDJLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:11:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D29220693;
        Thu,  4 Apr 2019 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369094;
        bh=qrGZdm5h2p1U3m2QtfCyK+1E6kpx4gs5CFS6Rpgyadg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAaiL1mFsl++QmREUZzuFgo8u7fUQrkP1gNZzUeouD/tYSflilHqCZ7c4SmDwXxNP
         ow3FajoJ+CwELfI0TfFWrf5nTkf3P2dE6IhiHppD5koN1zLui8dFTpfQv8QTFqZzjb
         uG0kgmTbl//jTMxaJjWMazbrfVA7I3WUqN3BFjGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Bruce Allan <bruce.w.allan@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 082/246] ice: fix ice_remove_rule_internal vsi_list handling
Date:   Thu,  4 Apr 2019 10:46:22 +0200
Message-Id: <20190404084622.005270480@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f9264dd687f8d3f9104c9900f8f3e5e419f27c55 ]

When adding multiple VLANs to the same VSI, the ice_add_vlan code will
share the VSI list, so as not to create multiple unnecessary VSI lists.

Consider the following flow

  ice_add_vlan(hw, <VSI 0 VID 7, VSI 0 VID 8, VSI 0 VID 9>)

Where we add three VLAN filters for VIDs 7, 8, and 9, all for VSI 0.

The ice_add_vlan will create a single vsi_list and share it among all
the filters.

Later, if we try to remove a VLAN,

  ice_remove_vlan(hw, <VSI 0 VID 7>)

Then the removal code will update the vsi_list and remove VSI 0 from it.
But, since the vsi_list is shared, this breaks the list for the other
users who reference it. We actually even free the VSI list memory, and
may result in segmentation faults.

This is due to the way that VLAN rule share VSI lists with reference
counts, and is caused because we call ice_rem_update_vsi_list even when
the ref_cnt is greater than one.

To fix this, handle the case where ref_cnt is greater than one
separately. In this case, we need to remove the associated rule without
modifying the vsi_list, since it is currently being referenced by
another rule. Instead, we just need to decrement the VSI list ref_cnt.

The case for handling sharing of VSI lists with multiple VSIs is not
currently supported by this code. No such rules will be created today,
and this code will require changes if/when such code is added.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 2e5693107fa4..8d602247eb44 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1538,9 +1538,20 @@ ice_remove_rule_internal(struct ice_hw *hw, u8 recp_id,
 	} else if (!list_elem->vsi_list_info) {
 		status = ICE_ERR_DOES_NOT_EXIST;
 		goto exit;
+	} else if (list_elem->vsi_list_info->ref_cnt > 1) {
+		/* a ref_cnt > 1 indicates that the vsi_list is being
+		 * shared by multiple rules. Decrement the ref_cnt and
+		 * remove this rule, but do not modify the list, as it
+		 * is in-use by other rules.
+		 */
+		list_elem->vsi_list_info->ref_cnt--;
+		remove_rule = true;
 	} else {
-		if (list_elem->vsi_list_info->ref_cnt > 1)
-			list_elem->vsi_list_info->ref_cnt--;
+		/* a ref_cnt of 1 indicates the vsi_list is only used
+		 * by one rule. However, the original removal request is only
+		 * for a single VSI. Update the vsi_list first, and only
+		 * remove the rule if there are no further VSIs in this list.
+		 */
 		vsi_handle = f_entry->fltr_info.vsi_handle;
 		status = ice_rem_update_vsi_list(hw, vsi_handle, list_elem);
 		if (status)
-- 
2.19.1



