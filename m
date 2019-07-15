Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24136C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3F52054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563203669;
	bh=XttTZV1WxecbDv1QVSpMVqZbbtGOSwbQn5fveaxmjyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IaxH9PffN+Z84tN0I6ucidVE9zkLP4Z48y0UwwzQ/JOX3cAQXcRMxRJ2WCknVfrt4
	 +rhaaCWTozushFaVRs6N+mflKc/X0xLU6T4ESWPJquSJmG942VDU2/SNgo9UzMYbdz
	 djevoWf7I80Id6wfMZLp7T8N1pNWsGurtBZ4y29g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfGONs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731301AbfGONsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:48:21 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABEB620896;
        Mon, 15 Jul 2019 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198500;
        bh=XttTZV1WxecbDv1QVSpMVqZbbtGOSwbQn5fveaxmjyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jat5AYmKuan2njS31cnVN3rrD/WPGODc89X4PV8F1GKJsGL0lbVPH0wUSbl8MhEE9
         ljbM0yqBYxpcbK/8HjmzEC8Mm/A5l5RqCepBE9fmrfkh0vRxAHErxF1Hongc0MWjZ6
         cHv0A+Kp7MeKJ93hC4+tKZSUltVlUEc6pXTYwLXY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brett Creeley <brett.creeley@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 027/249] ice: Gracefully handle reset failure in ice_alloc_vfs()
Date:   Mon, 15 Jul 2019 09:43:12 -0400
Message-Id: <20190715134655.4076-27-sashal@kernel.org>
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

[ Upstream commit 72f9c2039859e6303550f202d6cc6b8d8af0178c ]

Currently if ice_reset_all_vfs() fails in ice_alloc_vfs() we fail to
free some resources, reset variables, and return an error value.
Fix this by adding another unroll case to free the pf->vf array, set
the pf->num_alloc_vfs to 0, and return an error code.

Without this, if ice_reset_all_vfs() fails in ice_alloc_vfs() we will
not be able to do SRIOV without hard rebooting the system because
rmmod'ing the driver does not work.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index a805cbdd69be..81ea77978355 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1134,7 +1134,7 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16 num_alloc_vfs)
 			   GFP_KERNEL);
 	if (!vfs) {
 		ret = -ENOMEM;
-		goto err_unroll_sriov;
+		goto err_pci_disable_sriov;
 	}
 	pf->vf = vfs;
 
@@ -1154,12 +1154,19 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16 num_alloc_vfs)
 	pf->num_alloc_vfs = num_alloc_vfs;
 
 	/* VF resources get allocated during reset */
-	if (!ice_reset_all_vfs(pf, true))
+	if (!ice_reset_all_vfs(pf, true)) {
+		ret = -EIO;
 		goto err_unroll_sriov;
+	}
 
 	goto err_unroll_intr;
 
 err_unroll_sriov:
+	pf->vf = NULL;
+	devm_kfree(&pf->pdev->dev, vfs);
+	vfs = NULL;
+	pf->num_alloc_vfs = 0;
+err_pci_disable_sriov:
 	pci_disable_sriov(pf->pdev);
 err_unroll_intr:
 	/* rearm interrupts here */
-- 
2.20.1

