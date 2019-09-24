Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F51C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC75121BE5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344008;
	bh=RlYKxXdLi0iG8jA3nBMsToaPxsGq9Tnp4BjvMwYQlnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JC8JkrOIj0Bs+mqXIiapimIM32G9GFJOHEWITiMiP4g1J8bKIw4gH6eFs7XXL7MOU
	 rqA9W2mHag4a1b2xRQxaDn6u4H5aE+13j3cAxsnyhEVp6wXeWhzqe1KmPLp1VlAC4G
	 0MY33Lki9w/QWB0CDKB/1GsoZ8+Cnt92MsGylwlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410910AbfIXQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441616AbfIXQwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:52:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2992054F;
        Tue, 24 Sep 2019 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343960;
        bh=RlYKxXdLi0iG8jA3nBMsToaPxsGq9Tnp4BjvMwYQlnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MfTXGbo1fkdaX07vPXioWkt3ltJ9za0eaWLNjDq+489XXtYwkEglX5icy0DhATLGw
         01ZYd8CAPJO5FbXryw/vNoS9xqU0Y8jHutrg8QO4sZiDLXX/tIl8soWm6M7jmiVGlu
         62+iDJxXDqLLOfX495b/G3/jd662rGD/ZKP7yNHs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     hexin <hexin.op@gmail.com>, hexin <hexin15@baidu.com>,
        Liu Qi <liuqi16@baidu.com>, Zhang Yu <zhangyu31@baidu.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 11/14] vfio_pci: Restore original state on release
Date:   Tue, 24 Sep 2019 12:52:09 -0400
Message-Id: <20190924165214.28857-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924165214.28857-1-sashal@kernel.org>
References: <20190924165214.28857-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hexin <hexin.op@gmail.com>

[ Upstream commit 92c8026854c25093946e0d7fe536fd9eac440f06 ]

vfio_pci_enable() saves the device's initial configuration information
with the intent that it is restored in vfio_pci_disable().  However,
the commit referenced in Fixes: below replaced the call to
__pci_reset_function_locked(), which is not wrapped in a state save
and restore, with pci_try_reset_function(), which overwrites the
restored device state with the current state before applying it to the
device.  Reinstate use of __pci_reset_function_locked() to return to
the desired behavior.

Fixes: 890ed578df82 ("vfio-pci: Use pci "try" reset interface")
Signed-off-by: hexin <hexin15@baidu.com>
Signed-off-by: Liu Qi <liuqi16@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 47b229fa5e8ec..4b62eb3b59233 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -221,11 +221,20 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
 
 	/*
-	 * Try to reset the device.  The success of this is dependent on
-	 * being able to lock the device, which is not always possible.
+	 * Try to get the locks ourselves to prevent a deadlock. The
+	 * success of this is dependent on being able to lock the device,
+	 * which is not always possible.
+	 * We can not use the "try" reset interface here, which will
+	 * overwrite the previously restored configuration information.
 	 */
-	if (vdev->reset_works && !pci_try_reset_function(pdev))
-		vdev->needs_reset = false;
+	if (vdev->reset_works && pci_cfg_access_trylock(pdev)) {
+		if (device_trylock(&pdev->dev)) {
+			if (!__pci_reset_function_locked(pdev))
+				vdev->needs_reset = false;
+			device_unlock(&pdev->dev);
+		}
+		pci_cfg_access_unlock(pdev);
+	}
 
 	pci_restore_state(pdev);
 out:
-- 
2.20.1

