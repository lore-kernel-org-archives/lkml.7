Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCE220803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412999;
	bh=qY0P0E0BvbecrqZR3RJQkrXgiBEdtUhhcKjdkgFs8uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UoA5pYwbhJTOR4fZhSafwVPJ8rCbwsypLVwVnpobpXIUK/LbVjGEPL0MJxec3xEae
	 hgD4vX2VHhAp/r+lG9FN7W4ijU9NCRehaYLPpZ9Hsju2RYq+OgJ5I91hPANoWUsf+O
	 /G4EEvPoH1VsUxxH1hgnoDmL35hfuF6HylJ5oJCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfLCWnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfLCWnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:43:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1458F207DD;
        Tue,  3 Dec 2019 22:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412994;
        bh=qY0P0E0BvbecrqZR3RJQkrXgiBEdtUhhcKjdkgFs8uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGdYd/ne/+435wbFd9CGgSyHLHlr1pJAJrOSry9OYQ7mAKXlIJNWuC0VwwfuYM/pE
         y9TD0pLp/xyhppS2IxVqATSMlcdYoxHK49ag++h5NA/6nHuV8tavJUlzh/sxq5DiCq
         UcZyEKWf3xw9jMNL+N5MFZosL+B2sl1RTP2Bze7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 096/135] i40e: Fix for ethtool -m issue on X722 NIC
Date:   Tue,  3 Dec 2019 23:35:36 +0100
Message-Id: <20191203213037.811098163@linuxfoundation.org>
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

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

[ Upstream commit 4c9da6f2b8a029052c75bd4a61ae229135831177 ]

This patch contains fix for a problem with command:
'ethtool -m <dev>'
which breaks functionality of:
'ethtool <dev>'
when called on X722 NIC

Disallowed update of link phy_types on X722 NIC
Currently correct value cannot be obtained from FW
Previously wrong value returned by FW was used and was
a root cause for incorrect output of 'ethtool <dev>' command

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 906cf68d3453a..4a53bfc017b13 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1861,7 +1861,8 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
 	     hw->aq.fw_min_ver < 40)) && hw_link_info->phy_type == 0xE)
 		hw_link_info->phy_type = I40E_PHY_TYPE_10GBASE_SFPP_CU;
 
-	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
+	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE &&
+	    hw->mac.type != I40E_MAC_X722) {
 		__le32 tmp;
 
 		memcpy(&tmp, resp->link_type, sizeof(tmp));
-- 
2.20.1



