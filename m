Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EA8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A76D20715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418706;
	bh=rrZSbi4G4miTJyPIz+Y84gcUjifvPimzBYe2sbVKh24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6j2Mds5xfjTPO3AsIMrubDkDGRsVJXWNMTwvZmg75Sqt17oiAoUVM1Frxda3BsOj
	 YO/wgQF3AYiYZORsJb8EaVBvBSbvaZPcQ32tEVR9QQzoBilhblndFSZe3G/KgNq8eG
	 /TGN0y7Ixjmsdg4Ww80lnr5ueemUlO/xhHEXmmy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKVKbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:31:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfKVKbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:31:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D1D20714;
        Fri, 22 Nov 2019 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418701;
        bh=rrZSbi4G4miTJyPIz+Y84gcUjifvPimzBYe2sbVKh24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etv7C/rwpWf1ZGlrt9I3fQw3xF8DKeIiqG5bq87+2gPZ5ojDe8UpKon0QKmsOfjAc
         EqTjglrIEJ5T8qkIc1CXQdmRfaqVVvyx5x+QSuucpfLOPXuyFNGvC99qrL4rgVHbvb
         iknAVsWrR3A/5Np0oH9U4N5WV2dIZ+3sDS4IGOws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Patryk=20Ma=C5=82ek?= <patryk.malek@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 022/159] i40e: Prevent deleting MAC address from VF when set by PF
Date:   Fri, 22 Nov 2019 11:26:53 +0100
Message-Id: <20191122100721.942284583@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patryk Małek <patryk.malek@intel.com>

[ Upstream commit 5907cf6c5bbe78be2ed18b875b316c6028b20634 ]

To prevent VF from deleting MAC address that was assigned by the
PF we need to check for that scenario when we try to delete a MAC
address from a VF.

Signed-off-by: Patryk Małek <patryk.malek@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index e116d9a99b8e9..cdb263875efb3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1677,6 +1677,16 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 			ret = I40E_ERR_INVALID_MAC_ADDR;
 			goto error_param;
 		}
+
+		if (vf->pf_set_mac &&
+		    ether_addr_equal(al->list[i].addr,
+				     vf->default_lan_addr.addr)) {
+			dev_err(&pf->pdev->dev,
+				"MAC addr %pM has been set by PF, cannot delete it for VF %d, reset VF to change MAC addr\n",
+				vf->default_lan_addr.addr, vf->vf_id);
+			ret = I40E_ERR_PARAM;
+			goto error_param;
+		}
 	}
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
-- 
2.20.1



