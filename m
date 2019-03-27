Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7DEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F317121734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709890;
	bh=/oYZVCgnCBklrRFTrSv6nhFinr/JaO+dksrUsFlPl2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tWOtC8pkT1DAWsxUFGsL8kE0rUTAgLSPPAC8MS49vpqrK4G340h/yr2Lxinhg0FKP
	 U5Jb0/bcXJyyAfnCV8UZ5IZHMEizoAS94g46Lmp8Z/KYQeQrjGR+tgvaap9B/GpOXP
	 G5WfxmMrijTZUGff3Z8QU5MeZGOtkHtJEgmlgDUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbfC0SEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387434AbfC0SEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CE1C2063F;
        Wed, 27 Mar 2019 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709883;
        bh=/oYZVCgnCBklrRFTrSv6nhFinr/JaO+dksrUsFlPl2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEPeH2HC8Uzfw45DZK9xQgYvIEJM8qdHTFIm8xqWhYH+8/RbVtsLVoqPu1anfvbHh
         xYPzfw/QEFgYpGD4256PJk9BuolwH+0W9KtvCqGH6jHV3y4a4kw1tANe734Zfj7rGc
         kiXvinOfx7kNmtWgwPlmbtt6RynDlBtkNaBp5XwM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 088/262] ice: fix ice_remove_rule_internal vsi_list handling
Date:   Wed, 27 Mar 2019 13:59:03 -0400
Message-Id: <20190327180158.10245-88-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

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

