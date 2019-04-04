Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B97C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217742075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369218;
	bh=ZkzlwT1k3wumyTyD2ebr+3dl94WGUbBC70k03IVrQvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TCG8Sbts6nENNnzyMw1sm55NU1sIa74eAarHUTXJgjZ4yV++6xjlD3h63AQCFie9c
	 d3MTnj3zuCpVsk0XDy89VwJ587kEKRTh11AyHfarPwVGH83tXB1rhujPcUlQR9ktMs
	 2D9hNBs96qxPd/FadTqjgzlCqrEzG6esqKigo97s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfDDJNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733080AbfDDJNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E670820693;
        Thu,  4 Apr 2019 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369210;
        bh=ZkzlwT1k3wumyTyD2ebr+3dl94WGUbBC70k03IVrQvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKi+sh4wijZ9gVSAGnuFnOoTdfcw8cKb84LLAnxtcMjNVt5w5vV3G0AILxD9mKZVP
         nf80PAETc2vVhlWzi/OnJs5ETxIUotm1QRwP9H/QjhzBlheUc2n6kuSplyk5V49MWQ
         4h7WTZ7o/HEAGdkdl1Dr+s6CCE2PZPLeHr2dcxJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 138/246] ACPI / video: Refactor and fix dmi_is_desktop()
Date:   Thu,  4 Apr 2019 10:47:18 +0200
Message-Id: <20190404084623.998137725@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index f0b52266b3ac..1ab1460c4a4e 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2124,21 +2124,28 @@ static int __init intel_opregion_present(void)
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



