Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0ADC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C26F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367945;
	bh=wvVp/bppQjloXfbyYic/6Cv0O5xuY0hajD5Q7bqmVEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OGhzHne+FuJVUmqrXBxQ0CenG2YUoiXq04PsQ8SW2ui5IG/9K3Hj3LRvSIgnyGbHB
	 clcI7RyqHmdNbl9ea8eEdofP77FB9JmQsjhGCXT1J2kOU3pZ5dQDD8MQCV8NaRZX3u
	 OQddKnjFw5xte+yIYdsZPc3Qz2fbi6n1Nm0aRXfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfDDIwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbfDDIwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE0D20855;
        Thu,  4 Apr 2019 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367937;
        bh=wvVp/bppQjloXfbyYic/6Cv0O5xuY0hajD5Q7bqmVEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IH/Vb0X91LIYLXWN5SQiHYkhXUujVuAVBJMXps8yG8KQl15UvIg5XMzhw+sFvLJLJ
         ol4x1nclZt1FImzf5/GXoHTxAMd6JjnIiZlW/skwaEZeAOX/WXmxAu2GIQRGV8u+6A
         3wbcPGqYLGy72SQmkX55syK/xujmy9MxALHXfTfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 53/91] ACPI / video: Refactor and fix dmi_is_desktop()
Date:   Thu,  4 Apr 2019 10:47:37 +0200
Message-Id: <20190404084538.540963612@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 667dc5c86fef..d79e38abd6d9 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2069,21 +2069,28 @@ static int __init intel_opregion_present(void)
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



