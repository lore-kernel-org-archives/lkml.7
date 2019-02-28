Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39444C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17CF206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366553;
	bh=PLagiQe7k14T8vKSg65U3wFzS/VDCFNuNLdpQTW7bwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BMmyvLFbiQjkSwr7ORRIoUmlA4m7AOGIud052LNDKTG4iREuFqLKlmO9IxojbG0bi
	 kLdZTxrsahAu2o54hjBrGPOP4cVpYEpJ18IpQ01T6U411zTdOj6/fpDNiKwFgWYRzN
	 y+E773/5jHLZIt7fMxWZU6QPwpOUQk2+Oi/LY9gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbfB1PJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732629AbfB1PJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B44218B0;
        Thu, 28 Feb 2019 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366545;
        bh=PLagiQe7k14T8vKSg65U3wFzS/VDCFNuNLdpQTW7bwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFQZqfT2L0EwhR43M5sTAlBE5fyNNj8fekEmJysEQBHyqqzWlaERw2gzwxzWK50bO
         oHaH5IoBpx7jTdxnC0XszoDlpI8S2FocAptv8NR6BGfFjGqjQYvy8ecxWnKamSMIT2
         dcp0IMPM441WBnmMDqEviGWrsrX0/No57602pIuI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 33/81] drm/radeon: check if device is root before getting pci speed caps
Date:   Thu, 28 Feb 2019 10:07:25 -0500
Message-Id: <20190228150813.10256-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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

