Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC082C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87682082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054528;
	bh=MVJXWWRUgvZ1zUCh0VY4byhSg34+07e77MeVGbVwFVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XbKWgIUJ4qc53NJtdaHnaQ6z0Ee1jzJOs2hRgvvsQalTly8iyTkqYCXfcCX91tGXy
	 n4J+6iSNLVPf+wS+Qw4aikse0KdQ91zcfcnJCMKbjzYgSzI9qAPnB6YrP8A0YXyDtH
	 kkue6yowm1scgw1IiRnorr2JoPCP8f0XkqGobmBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfFTSP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfFTSPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:15:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE902082C;
        Thu, 20 Jun 2019 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054524;
        bh=MVJXWWRUgvZ1zUCh0VY4byhSg34+07e77MeVGbVwFVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGUKNsrVhRorGaXn4mbncwnxLYVSX90oy/NiFnP0SuStkeM6X761RfLlxSRuTb2Kw
         wMfUeTw81Vv2XoTwgrbSeh74dzYLl0e3VBFPDyfgi6eYNe75swHNVPlJJw3Zg9kR5m
         fRhbpm41+Cp6otGlcNVLLRBEp/nkrgVvhwDx8GLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 59/98] ACPI/PCI: PM: Add missing wakeup.flags.valid checks
Date:   Thu, 20 Jun 2019 19:57:26 +0200
Message-Id: <20190620174352.041727866@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9a51c6b1f9e0239a9435db036b212498a2a3b75c ]

Both acpi_pci_need_resume() and acpi_dev_needs_resume() check if the
current ACPI wakeup configuration of the device matches what is
expected as far as system wakeup from sleep states is concerned, as
reflected by the device_may_wakeup() return value for the device.

However, they only should do that if wakeup.flags.valid is set for
the device's ACPI companion, because otherwise the wakeup.prepare_count
value for it is meaningless.

Add the missing wakeup.flags.valid checks to these functions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/device_pm.c | 4 ++--
 drivers/pci/pci-acpi.c   | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 824ae985ad93..ccb59768b1f3 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -949,8 +949,8 @@ static bool acpi_dev_needs_resume(struct device *dev, struct acpi_device *adev)
 	u32 sys_target = acpi_target_system_state();
 	int ret, state;
 
-	if (!pm_runtime_suspended(dev) || !adev ||
-	    device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
+	if (!pm_runtime_suspended(dev) || !adev || (adev->wakeup.flags.valid &&
+	    device_may_wakeup(dev) != !!adev->wakeup.prepare_count))
 		return true;
 
 	if (sys_target == ACPI_STATE_S0)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e1949f7efd9c..bf32fde328c2 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -666,7 +666,8 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
 	if (!adev || !acpi_device_power_manageable(adev))
 		return false;
 
-	if (device_may_wakeup(&dev->dev) != !!adev->wakeup.prepare_count)
+	if (adev->wakeup.flags.valid &&
+	    device_may_wakeup(&dev->dev) != !!adev->wakeup.prepare_count)
 		return true;
 
 	if (acpi_target_system_state() == ACPI_STATE_S0)
-- 
2.20.1



