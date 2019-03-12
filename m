Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DD6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413708;
	bh=Y6AD5yQUcHxaAcnbJPtTbKl7/p7YCiYvp8vnaTv4/JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e1oH4qJlSUfWkQuznAuf3p9Rq3v7z7H0rSVNiiogXLAssCqBJ2Hi/kovaApkW1Cse
	 Pq0OV1F+2RmqOZ0JLjGQZmhZqpbuYtocB6nCfPPno5UubCc8padpxlm04rucXyiiS/
	 3ogvhOx66noc1jCKyj3gukk6E/bBgzPv9o3JxgYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfCLSBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfCLRNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:10 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8DFF2173C;
        Tue, 12 Mar 2019 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410789;
        bh=Y6AD5yQUcHxaAcnbJPtTbKl7/p7YCiYvp8vnaTv4/JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bECDWiwPbI55IqmF+VdUxyqdE6m3AC6lHjPX0XJjxxAP4hrpy1eVXs87rpVoVzWi0
         WXOJjCm+gzoxzF/QcFANq5WtOLPIdk2MjLTEi92Xuxbno/SyTQGBHp0ffkFk03Mhdn
         CFqTxiTlB0JRW4EKqYnvew/0VRaV5hhadN1WLsvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 102/171] drm/radeon: check if device is root before getting pci speed caps
Date:   Tue, 12 Mar 2019 10:08:02 -0700
Message-Id: <20190312170356.883488003@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d587779a80b4..a97294ac96d5 100644
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
index 8fb60b3af015..0a785ef0ab66 100644
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



