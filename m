Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56834C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239D820659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402592;
	bh=b/jHQB1x+5NehrmLNVjMgte8dWT+yjMVkd02sMqx1aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x/OA6Pt1BVKoj96XeO+NW9NCk+YYBHaKPZ47Lo7FAd808/g3KKYncSzfrI600dNue
	 kD47/nw1jIISqnv7BsSv3CWULYOBwD/amHxB3qC3DAUUp1Ya3Yl4F5P5fQLPfiPldH
	 Q6FfsiYvpWyJ6oSop78KHfgPBBjt8xEhnsvFW36Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfKVGDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729853AbfKVGDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:03:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA96720717;
        Fri, 22 Nov 2019 06:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402585;
        bh=b/jHQB1x+5NehrmLNVjMgte8dWT+yjMVkd02sMqx1aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEwSR93yKSMCQXhMkaZujy8KPT1WUN2R/n+yLqcUyXbgEI8rRnPd940kuX1WURdOZ
         tHF4z0DLqRT5hR6ivQ9hpJYTeSk8KKE4wwGFcY5NuzpuX8w1eUUdDUGNq5Sr0xSF/A
         z1IADrnW+gIV7XJu3uD1JInkO5BSIzRov7kmvrTk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaron Ma <aaron.ma@canonical.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.9 86/91] iommu/amd: Fix NULL dereference bug in match_hid_uid
Date:   Fri, 22 Nov 2019 01:01:24 -0500
Message-Id: <20191122060129.4239-85-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Ma <aaron.ma@canonical.com>

[ Upstream commit bb6bccba390c7d743c1e4427de4ef284c8cc6869 ]

Add a non-NULL check to fix potential NULL pointer dereference
Cleanup code to call function once.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Fixes: 2bf9a0a12749b ('iommu/amd: Add iommu support for ACPI HID devices')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e81acb2b6ee7d..c898c70472bb2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -176,10 +176,14 @@ static struct lock_class_key reserved_rbtree_key;
 static inline int match_hid_uid(struct device *dev,
 				struct acpihid_map_entry *entry)
 {
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	const char *hid, *uid;
 
-	hid = acpi_device_hid(ACPI_COMPANION(dev));
-	uid = acpi_device_uid(ACPI_COMPANION(dev));
+	if (!adev)
+		return -ENODEV;
+
+	hid = acpi_device_hid(adev);
+	uid = acpi_device_uid(adev);
 
 	if (!hid || !(*hid))
 		return -ENODEV;
-- 
2.20.1

