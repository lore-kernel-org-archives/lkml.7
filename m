Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF14CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7F520C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367545;
	bh=PLagiQe7k14T8vKSg65U3wFzS/VDCFNuNLdpQTW7bwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wga34Lt7k3ERLwulxDti8MKV2Owgn/lSXQ8HKdBUBGHxGk+I9ABrSzv5ybfhg8Iai
	 1+WTDeUZJWes+BWJvjuBQ/pZ4fv8QdDnJ1m4f5rFVk78YDFbd2bSEnF3O0oBslhG+5
	 vrpT5k2dBLp248FtS1re3wtGSzWwP8cbTy+LjUUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbfB1PZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:25:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388105AbfB1PLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74077218AE;
        Thu, 28 Feb 2019 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366713;
        bh=PLagiQe7k14T8vKSg65U3wFzS/VDCFNuNLdpQTW7bwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqEJPw6exBa2P1PqZEiYrAe9A4GpopaJeVQjL3jWMc1x+VN+W29gBt1DdjhER250R
         2IdL7wmdtWcktMwbgH0TvFchsLMrz/4p5aXxIhSunujuIpfxRkigYrrg4GNIt9ohAJ
         gCKRCDTmwwKaXxSEg2v1XwajHB2znXwDH55nWDqg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 25/64] drm/radeon: check if device is root before getting pci speed caps
Date:   Thu, 28 Feb 2019 10:10:26 -0500
Message-Id: <20190228151105.11277-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit afeff4c16edaa6275b903f82b0561406259aa3a3 ]

Check if the device is root rather before attempting to see what
speeds the pcie port supports.  Fixes a crash with pci passthrough
in a VM.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=109366
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 5 +++--
 drivers/gpu/drm/radeon/si_dpm.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index d587779a80b4d..a97294ac96d59 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5676,7 +5676,7 @@ int ci_dpm_init(struct radeon_device *rdev)
 	u16 data_offset, size;
 	u8 frev, crev;
 	struct ci_power_info *pi;
-	enum pci_bus_speed speed_cap;
+	enum pci_bus_speed speed_cap = PCI_SPEED_UNKNOWN;
 	struct pci_dev *root = rdev->pdev->bus->self;
 	int ret;
 
@@ -5685,7 +5685,8 @@ int ci_dpm_init(struct radeon_device *rdev)
 		return -ENOMEM;
 	rdev->pm.dpm.priv = pi;
 
-	speed_cap = pcie_get_speed_cap(root);
+	if (!pci_is_root_bus(rdev->pdev->bus))
+		speed_cap = pcie_get_speed_cap(root);
 	if (speed_cap == PCI_SPEED_UNKNOWN) {
 		pi->sys_pcie_mask = 0;
 	} else {
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 8fb60b3af0158..0a785ef0ab660 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -6899,7 +6899,7 @@ int si_dpm_init(struct radeon_device *rdev)
 	struct ni_power_info *ni_pi;
 	struct si_power_info *si_pi;
 	struct atom_clock_dividers dividers;
-	enum pci_bus_speed speed_cap;
+	enum pci_bus_speed speed_cap = PCI_SPEED_UNKNOWN;
 	struct pci_dev *root = rdev->pdev->bus->self;
 	int ret;
 
@@ -6911,7 +6911,8 @@ int si_dpm_init(struct radeon_device *rdev)
 	eg_pi = &ni_pi->eg;
 	pi = &eg_pi->rv7xx;
 
-	speed_cap = pcie_get_speed_cap(root);
+	if (!pci_is_root_bus(rdev->pdev->bus))
+		speed_cap = pcie_get_speed_cap(root);
 	if (speed_cap == PCI_SPEED_UNKNOWN) {
 		si_pi->sys_pcie_mask = 0;
 	} else {
-- 
2.19.1

