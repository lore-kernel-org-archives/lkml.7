Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B355EC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F35F25D44
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191854;
	bh=pIGIv1wMDp5xBsuqDHXtdtJ07HvAkgPfMtiuYo+B1rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w5rG8S09B7WwWkGw0mNZ47nD4wl8eZFu3sL0mmmxbuf7csU3zUmNHXUX+w0VJSd0U
	 sNb37HgrFo+pEm5No7nLEuwjOPWfJzQiaTTHnBO7+aKhSl4u5Bj90iV0T3pDYyr7zP
	 LNlBk8ezTJkvzlUvU0Ski73cXE0u8fbm5Qjl8em4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbfE3Eux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbfE3DLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:02 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32282244EE;
        Thu, 30 May 2019 03:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185861;
        bh=pIGIv1wMDp5xBsuqDHXtdtJ07HvAkgPfMtiuYo+B1rU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTV1KEh1LRExxmSVtod39mCrXXKon++JGXU5mGyjnyfSYGnp+H7libPR33igVOQbV
         QYMxOr2mNgbwQVWopY9sWOe7JDPQGT3rFSDntm9jbbUwCqfxf75VtQ2yHkxzsRMSmR
         Ql2BjMFolFN397OXopf/HHobtJ8PcOh0KmsAYjMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Nunley <nicholas.d.nunley@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 188/405] i40e: dont allow changes to HW VLAN stripping on active port VLANs
Date:   Wed, 29 May 2019 20:03:06 -0700
Message-Id: <20190530030550.544677171@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit bfb0ebed53857cfc57f11c63fa3689940d71c1c8 ]

Modifying the VLAN stripping options when a port VLAN is configured
will break traffic for the VSI, and conceptually doesn't make sense,
so don't allow this.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b1c265012c8ad..ac9fcb0976890 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2654,6 +2654,10 @@ void i40e_vlan_stripping_enable(struct i40e_vsi *vsi)
 	struct i40e_vsi_context ctxt;
 	i40e_status ret;
 
+	/* Don't modify stripping options if a port VLAN is active */
+	if (vsi->info.pvid)
+		return;
+
 	if ((vsi->info.valid_sections &
 	     cpu_to_le16(I40E_AQ_VSI_PROP_VLAN_VALID)) &&
 	    ((vsi->info.port_vlan_flags & I40E_AQ_VSI_PVLAN_MODE_MASK) == 0))
@@ -2684,6 +2688,10 @@ void i40e_vlan_stripping_disable(struct i40e_vsi *vsi)
 	struct i40e_vsi_context ctxt;
 	i40e_status ret;
 
+	/* Don't modify stripping options if a port VLAN is active */
+	if (vsi->info.pvid)
+		return;
+
 	if ((vsi->info.valid_sections &
 	     cpu_to_le16(I40E_AQ_VSI_PROP_VLAN_VALID)) &&
 	    ((vsi->info.port_vlan_flags & I40E_AQ_VSI_PVLAN_EMOD_MASK) ==
-- 
2.20.1



