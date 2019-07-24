Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1875C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7542A21734
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000643;
	bh=bRicMM1vr8NVGXlwayavMoeOg8/keyWSP4QV+K4M610=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eaSsSV1OvRupNkkJv9HP5pJiekOc7LDAN9G4l1b1pC6vzIPgf9cFgVQflluM4CSNY
	 POicrXJJFgpOh1BgPpaJASkMDHHYdH8wBY2GY2u3FI8bLWHys55PClmbd6NZHaXCZe
	 azMpErD2Kp5/D+rUhzNBSNO/6Y1HG0G/3jnUQdsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390996AbfGXUhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387884AbfGXTXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:23:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B4D22AEC;
        Wed, 24 Jul 2019 19:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996233;
        bh=bRicMM1vr8NVGXlwayavMoeOg8/keyWSP4QV+K4M610=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9OLhjW8x5/LoJNi4E5chWvqFodVqZSkyMS4yEDX0tNXQkhM97/0Y/i6EqCdduTXS
         r13t4dXlnpaR9w1f04LkGcio1+RXDoV2XxJMa01FhCypMZq/lxRvg2omR/CFYmi/+A
         zqq/C3v59MdPbkSzkemRrJq+tBgZISj+4nidOyfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brett Creeley <brett.creeley@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 026/413] ice: Gracefully handle reset failure in ice_alloc_vfs()
Date:   Wed, 24 Jul 2019 21:15:17 +0200
Message-Id: <20190724191737.336085579@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



