Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB281C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878652054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344105;
	bh=mhigEyX4N7wPbu9+w1npq2SXog76H2lNXrByJ6FAQyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bPAmDfLj3mF683PCPNggq3ovyAx0waViHKxytTwEod/Fht2PohG+8Tcph5AsKa+mO
	 CXuZZpvg4M0AXBX1M6jeC+n50ADOu1PHGBw8rVSlnLpOHHc9yuPwxkf1UD7XXrgbaf
	 9l6mc9csd7rZtyVuuoWX6kYFw0cOxeVDtfdQBD4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441523AbfIXQuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441472AbfIXQun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:50:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B620021D82;
        Tue, 24 Sep 2019 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343842;
        bh=mhigEyX4N7wPbu9+w1npq2SXog76H2lNXrByJ6FAQyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbYYd0M5Z8Va8P9oQwK4oNEFBqGz0QTPC/bahOUC61GZdqLuNg+zXA2h88XeaIJho
         hY1S7gi1mknR3la2Db5HfY2KOrR2ajhoxKxbrKOMPryz4p0w/zyCVbN23PNyjaFvLG
         cfnJa4sQmGiF69ioRYoFCscwGQleaHZG2X9vvMmY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 06/28] drm/radeon: Fix EEH during kexec
Date:   Tue, 24 Sep 2019 12:50:09 -0400
Message-Id: <20190924165031.28292-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924165031.28292-1-sashal@kernel.org>
References: <20190924165031.28292-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>

[ Upstream commit 6f7fe9a93e6c09bf988c5059403f5f88e17e21e6 ]

During kexec some adapters hit an EEH since they are not properly
shut down in the radeon_pci_shutdown() function. Adding
radeon_suspend_kms() fixes this issue.

Signed-off-by: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index f4becad0a78c0..54d97dd5780a1 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -368,11 +368,19 @@ radeon_pci_remove(struct pci_dev *pdev)
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
+	struct drm_device *ddev = pci_get_drvdata(pdev);
+
 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown
 	 */
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
+
+	/* Some adapters need to be suspended before a
+	* shutdown occurs in order to prevent an error
+	* during kexec.
+	*/
+	radeon_suspend_kms(ddev, true, true, false);
 }
 
 static int radeon_pmops_suspend(struct device *dev)
-- 
2.20.1

