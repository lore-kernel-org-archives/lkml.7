Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E3BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDE9205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483616;
	bh=lHb8nb/xLhqlCfKyPOxFc1Drdc9QqB8nk+WE0IyxIF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J2l4RilyK0WHPtUHg2iTQvM/RVSsR/v3xEfysy9TAwrk/eyky8d3vwcAscZMvhzwW
	 bAqpenJ4wJ8yr6EDx6s6pU0drdSmqzhEw7E63HiWzKXi/xoT3DnhZKdxn8hGsm0Cmz
	 qHgZRa7mYUHwaBPCdStg4LgVjV/U/iTac/HojOm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfLDSUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730958AbfLDSIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:08:48 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0342084B;
        Wed,  4 Dec 2019 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482928;
        bh=lHb8nb/xLhqlCfKyPOxFc1Drdc9QqB8nk+WE0IyxIF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLa4AtdcZufqcaESiiiM8lKkrxTRTOmmrTqNvoRsd6g3IxqydfBpmlRN265sDSeZX
         ytxmdQDrod8hgyfawMxAftbbnfyFRnHIojSFcqGs/W0hBniXS0gzdSQfNVGIbYHiQH
         8WuDttHwnA2GkuvVql7eHEUHGVLY+UxQXW9ryLRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 147/209] iommu/amd: Fix NULL dereference bug in match_hid_uid
Date:   Wed,  4 Dec 2019 18:55:59 +0100
Message-Id: <20191204175333.639579657@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 07b6cf58fd99b..d09c24825734e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -139,10 +139,14 @@ static struct lock_class_key reserved_rbtree_key;
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



