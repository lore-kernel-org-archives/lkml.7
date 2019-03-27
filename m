Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F89C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AD82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712605;
	bh=obaYy4YuILPpmU1jJhv6AtZkirhMgeoSyuWypcPsZL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DSjg2M7/pwC+sfxv11qeoUQK4jGcxk2j6rM8bUBicWRDQHXvydswufqppvckShecs
	 sbJ3cjV3zayYsxOe1aXIUKODoAa5Jy92vm7YREZm8QY47R9CP75uU3cy4O1hyplxok
	 Drwo28nzDfNb/WgKZo2YI6th4d2xTRZIqey7nYHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390949AbfC0SuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389921AbfC0SS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:18:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 319EF2147C;
        Wed, 27 Mar 2019 18:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710707;
        bh=obaYy4YuILPpmU1jJhv6AtZkirhMgeoSyuWypcPsZL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zfkkdbqfmh5ELrpVyJE5kNGH+S74tH6M1XZC69oiHytn8V/5mg1kWGjJRiVKsRrx2
         JA8dpedbM6VNyzgwJnduHxuqTvSMV2maTq0YlYUOu4PhRujfE+FHzwUjIAB/FwDzAX
         K76FI7RMOVgd26H69nIkyzOsAaY3HJMshJErvo1I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 067/123] ACPI / video: Refactor and fix dmi_is_desktop()
Date:   Wed, 27 Mar 2019 14:15:31 -0400
Message-Id: <20190327181628.15899-67-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit cecf3e3e0803462335e25d083345682518097334 ]

This commit refactors the chassis-type detection introduced by
commit 53fa1f6e8a59 ("ACPI / video: Only default only_lcd to true on
Win8-ready _desktops_") (where desktop means anything without a builtin
screen).

The DMI chassis_type is an unsigned integer, so rather then doing a
whole bunch of string-compares on it, convert it to an int and feed
the result to a switch case.

Note the switch case uses hex values, this is done because the spec
uses hex values too. This changes the check for "Main Server Chassis"
from checking for 11 decimal to 11 hexadecimal, this is a bug fix,
the original check for 11 decimal was wrong.

Fixes: 53fa1f6e8a59 ("ACPI / video: Only default only_lcd to true ...")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
[ rjw: Drop redundant return statements ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_video.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index dbdd460a9958..9f56c066227c 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2123,21 +2123,28 @@ static int __init intel_opregion_present(void)
 	return opregion;
 }
 
+/* Check if the chassis-type indicates there is no builtin LCD panel */
 static bool dmi_is_desktop(void)
 {
 	const char *chassis_type;
+	unsigned long type;
 
 	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
 	if (!chassis_type)
 		return false;
 
-	if (!strcmp(chassis_type, "3") || /*  3: Desktop */
-	    !strcmp(chassis_type, "4") || /*  4: Low Profile Desktop */
-	    !strcmp(chassis_type, "5") || /*  5: Pizza Box */
-	    !strcmp(chassis_type, "6") || /*  6: Mini Tower */
-	    !strcmp(chassis_type, "7") || /*  7: Tower */
-	    !strcmp(chassis_type, "11"))  /* 11: Main Server Chassis */
+	if (kstrtoul(chassis_type, 10, &type) != 0)
+		return false;
+
+	switch (type) {
+	case 0x03: /* Desktop */
+	case 0x04: /* Low Profile Desktop */
+	case 0x05: /* Pizza Box */
+	case 0x06: /* Mini Tower */
+	case 0x07: /* Tower */
+	case 0x11: /* Main Server Chassis */
 		return true;
+	}
 
 	return false;
 }
-- 
2.19.1

