Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC86AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0574206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfDCFoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:44:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49210 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCFoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:44:05 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hBYgo-0004uA-Bo; Wed, 03 Apr 2019 05:43:58 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, hdegoede@redhat.com, rhowell@uwyo.edu,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate on BYT/CHT
Date:   Wed,  3 Apr 2019 13:43:52 +0800
Message-Id: <20190403054352.30120-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2c-designware-platdrv fails to work after the system restored from
hibernation:
[ 272.775692] i2c_designware 80860F41:00: Unknown Synopsys component type: 0xffffffff

Commit 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from
resume_noirq") makes acpi_lpss_{suspend_late,resume_early}() bail early
on BYT/CHT as resume_from_noirq is set. This means dw_i2c_plat_resume()
doesn't gets called by acpi_lpss_resume_early(), and this causes the
issue.

Introduce acpi_lpss_{poweroff_late,restore_early}() to make sure
driver's own poweroff_late and restore_early get called.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202139
Fixes: 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/acpi_lpss.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 1e2a10a06b9d..49aef186d73d 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -1058,6 +1058,11 @@ static int acpi_lpss_suspend_late(struct device *dev)
 	return acpi_lpss_do_suspend_late(dev);
 }
 
+static int acpi_lpss_poweroff_late(struct device *dev)
+{
+	return acpi_lpss_do_suspend_late(dev);
+}
+
 static int acpi_lpss_suspend_noirq(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
@@ -1089,6 +1094,11 @@ static int acpi_lpss_resume_early(struct device *dev)
 	return acpi_lpss_do_resume_early(dev);
 }
 
+static int acpi_lpss_restore_early(struct device *dev)
+{
+	return acpi_lpss_do_resume_early(dev);
+}
+
 static int acpi_lpss_resume_noirq(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
@@ -1141,10 +1151,10 @@ static struct dev_pm_domain acpi_lpss_pm_domain = {
 		.freeze_noirq = acpi_subsys_freeze_noirq,
 		.thaw_noirq = acpi_subsys_thaw_noirq,
 		.poweroff = acpi_subsys_suspend,
-		.poweroff_late = acpi_lpss_suspend_late,
+		.poweroff_late = acpi_lpss_poweroff_late,
 		.poweroff_noirq = acpi_subsys_suspend_noirq,
 		.restore_noirq = acpi_subsys_resume_noirq,
-		.restore_early = acpi_lpss_resume_early,
+		.restore_early = acpi_lpss_restore_early,
 #endif
 		.runtime_suspend = acpi_lpss_runtime_suspend,
 		.runtime_resume = acpi_lpss_runtime_resume,
-- 
2.17.1

