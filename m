Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9029C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B18D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344095;
	bh=jP8I5CNRk/iM76spTAw03o6FHfCpfdMcnRg9jkQSMXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lyqGhUMkvkLWFm+GAQXYRoZpi6IMdTqqmG4nqEWDanAG729kcSDswjprp68k8HLLK
	 Wh3mOW4UT5c7aFk+Df2V1KJSGYh/lYly5xNC59L3s5hIa4J2VjplKjnJ9Fe5pR7jAr
	 tsMBNFeIHVZqx6R6TxENzUrnMXyGbyHWVpFsXGdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410971AbfIXQyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404721AbfIXQvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:51:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DFAD21D71;
        Tue, 24 Sep 2019 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343898;
        bh=jP8I5CNRk/iM76spTAw03o6FHfCpfdMcnRg9jkQSMXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khH7hPJZ4CIEixaYWOg7u/2u0m5G8g1xfgjz6B7qiFfiwzlK32RZBbo3GgYZOjRNe
         k+uUWcNfyGOQNZfczfwG41qiN9vIWDHCYSasrz0lthUfd0i/LrfWMVGhzpHCczoAEG
         6uQfwabcld2e9B8pvh875/hgNGP1GatX999nMIss=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 03/19] drm/radeon: Fix EEH during kexec
Date:   Tue, 24 Sep 2019 12:51:14 -0400
Message-Id: <20190924165130.28625-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924165130.28625-1-sashal@kernel.org>
References: <20190924165130.28625-1-sashal@kernel.org>
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
index 30bd4a6a9d466..3ccf5b28b326e 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -366,11 +366,19 @@ radeon_pci_remove(struct pci_dev *pdev)
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

