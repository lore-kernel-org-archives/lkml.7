Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51488C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19251217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382798;
	bh=mhigEyX4N7wPbu9+w1npq2SXog76H2lNXrByJ6FAQyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKaPN/gMyQdL2jAN0NyOok2iJdw7BxkhEr8d/upJwxVNJUgIslMIMnKceYmCEylgm
	 82J/9+52qWpAc+UEXs7ARkEDdOh5bkVrOgpf2tzfK755n/gAFjKUzosblo47chbGO4
	 kQA++qQDyCHP4NH8Bu34WLRS+w5naiYcwArnQ4L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfJFR0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbfJFR0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:26:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8249A2077B;
        Sun,  6 Oct 2019 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382792;
        bh=mhigEyX4N7wPbu9+w1npq2SXog76H2lNXrByJ6FAQyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4ykw7wdquOrAXO6ZqbBN3nG43rtCBZvzKsHOIeoLZVRLwdw68Vp1EnnPbL9A45NH
         nzvf7/GnBuuEjZUes/c0s2pDPOSKqw5OBTtENvE6f5cRA3/meNvtjpkK2YyUjt4DIA
         n9LpHYzkjDazDsK+HGYsnBeHlvEhrEuRTKznICBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 08/68] drm/radeon: Fix EEH during kexec
Date:   Sun,  6 Oct 2019 19:20:44 +0200
Message-Id: <20191006171112.242315152@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



