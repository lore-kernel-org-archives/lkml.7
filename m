Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E03C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2E82054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344228;
	bh=P+lHs+riG0EDUfKFNMgXrIoSQvmWTKxTqzK5otPhaIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aKDoW31TNIaw6UTr2HdFWHZHWGfn3wyEveiHYTuQlPBJDg9FH0DNEnFzLHb+4d7iz
	 zBNgCdl9ILR1f82kl/xr+tAzFeAjLuiahC4jH+ti5G63Dd7+k9JKEexNwqGf5UddCp
	 svv5pgRqrMWYBYJWw0IqjUzASzKZQL5V+k3XCJLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407133AbfIXQ5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410205AbfIXQtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:49:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C1A21906;
        Tue, 24 Sep 2019 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343743;
        bh=P+lHs+riG0EDUfKFNMgXrIoSQvmWTKxTqzK5otPhaIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxpSuxWZdBZEFziMcxkxvejcCkNIyvBTYavYstz60hcoggzB3o9xJr7dKkVVIZbIp
         9SqmRx92Hl7WwhJIyj/64JO628ZqEevlMmUguL/D4rapRYn6lJ5HG5IxGFaqMsCtFY
         FaBmRQ47V6tqmgnqkQl7NZobO1KpO2BLVc+axEfo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 09/50] drm/radeon: Fix EEH during kexec
Date:   Tue, 24 Sep 2019 12:48:06 -0400
Message-Id: <20190924164847.27780-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164847.27780-1-sashal@kernel.org>
References: <20190924164847.27780-1-sashal@kernel.org>
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
index 2a7977a23b31c..25b5407c74b5a 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -364,11 +364,19 @@ radeon_pci_remove(struct pci_dev *pdev)
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

