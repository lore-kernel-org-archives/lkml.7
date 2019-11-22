Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28294C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE942070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402504;
	bh=IPTb/noze68zxc4Ep0YinQYWP6168edJf7Te72FHfnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fq/K19eiPrndDl+dMwUNJUUPmL15bin2wGdVfk3F785N0rL9GULj56jF8jJ/3lkfq
	 RIWxc4VIOv5bpdpeMln8gQ3b23F5Wo6N6KoStrHXGqtJJOoR8ohnveqHmEVB02mUdr
	 r/RjcQObMYHvUCgd19dkbr/YjArXL74HiOf/qvb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKVGBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbfKVGBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:01:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4001E2071B;
        Fri, 22 Nov 2019 06:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402499;
        bh=IPTb/noze68zxc4Ep0YinQYWP6168edJf7Te72FHfnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SK9pg2XCO9+jmGGiCHckEx9QjCsMadglAByCrKJLN/QUSiCj6BCGQLuU4SY4xcQAy
         cL6dqQvB4GqDCZ7PJBrXA5e2uo6e1u5WkflP0Bv33ClujjknLuiVCc63WDPszFPHVU
         0cXwLH7uExfl1rnd8Wm1m92trkP5F/MCEwOUkNqg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 10/91] ACPI / LPSS: Ignore acpi_device_fix_up_power() return value
Date:   Fri, 22 Nov 2019 01:00:08 -0500
Message-Id: <20191122060129.4239-9-sashal@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1a2fa02f7489dc4d746f2a15fb77b3ce1affade8 ]

Ignore acpi_device_fix_up_power() return value. If we return an error
we end up with acpi_default_enumeration() still creating a platform-
device for the device and we end up with the device still being used
but without the special LPSS related handling which is not useful.

Specicifically ignoring the error fixes the touchscreen no longer
working after a suspend/resume on a Prowise PT301 tablet.

This tablet has a broken _PS0 method on the touchscreen's I2C controller,
causing acpi_device_fix_up_power() to fail, causing fallback to standard
platform-dev handling and specifically causing acpi_lpss_save/restore_ctx
to not run.

The I2C controllers _PS0 method does actually turn on the device, but then
does some more nonsense which fails when run during early boot trying to
use I2C opregion handling on another not-yet registered I2C controller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_lpss.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 8e38249311bdf..a9158858f54cd 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -448,12 +448,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	 * have _PS0 and _PS3 without _PSC (and no power resources), so
 	 * acpi_bus_init_power() will assume that the BIOS has put them into D0.
 	 */
-	ret = acpi_device_fix_up_power(adev);
-	if (ret) {
-		/* Skip the device, but continue the namespace scan. */
-		ret = 0;
-		goto err_out;
-	}
+	acpi_device_fix_up_power(adev);
 
 	adev->driver_data = pdata;
 	pdev = acpi_create_platform_device(adev, dev_desc->properties);
-- 
2.20.1

