Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D4BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8A721019
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ORlCKUb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfCHNVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:21:44 -0500
Received: from forward102j.mail.yandex.net ([5.45.198.243]:38102 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbfCHNVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:21:44 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 08:21:41 EST
Received: from mxback11o.mail.yandex.net (mxback11o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::62])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id E7C47F20A16;
        Fri,  8 Mar 2019 16:14:58 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback11o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id OzD0CcTL3J-EwAuF58O;
        Fri, 08 Mar 2019 16:14:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1552050898;
        bh=r0jroba10AtHNL8QkSVj6KitIiEZyasMYlRIApO3mdE=;
        h=Subject:To:From:Message-Id:Cc:Date;
        b=ORlCKUb/sMlevvMWOn1Y79JiwOonpOf60G0vf7V3hyjs4M7b/ygBY2IHG3ZGGFNuc
         cTd/mCJYOivXBYdBRTeLswWObWHX6RD9qT9plEaqJBTOy6oCdPhNtmnSl4HPh3Y5Zs
         WgTn2ENlCeGPenkEL8Ohwp8G5TwrfcITui7kCcjE=
Authentication-Results: mxback11o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 7UnA1kZuEv-EpOCgePs;
        Fri, 08 Mar 2019 16:14:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     ibm-acpi@hmh.eng.br
Cc:     dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: Read EC information on newer models
Date:   Fri,  8 Mar 2019 21:14:26 +0800
Message-Id: <20190308131426.10254-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer ThinkPads have a totally different EC program information DMI
table. And thermal subdriver can't work without correct EC version.

Read from this entry if the old method failed to get EC information.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 62 ++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2e24ee42a3c6..17fd2065000b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9959,6 +9959,37 @@ static char __init tpacpi_parse_fw_id(const char * const s,
 	return '\0';
 }
 
+static void find_new_ec_fwstr(const struct dmi_header *dm, void *private)
+{
+	char *ec_fw_string = (char *) private;
+	const char *dmi_data = (const char *)dm;
+	/*
+	 * ThinkPad Embedded Controller Program Table on newer models
+	 *
+	 * Offset |  Name                | Width  | Description
+	 * ----------------------------------------------------
+	 *  0x00  | Type                 | BYTE   | 0x8C
+	 *  0x01  | Length               | BYTE   |
+	 *  0x02  | Handle               | WORD   | Varies
+	 *  0x04  | Signature            | BYTEx6 | ASCII for "LENOVO"
+	 *  0x0A  | OEM struct offset    | BYTE   | 0x0B
+	 *  0x0B  | OEM struct number    | BYTE   | 0x07, for this structure
+	 *  0x0C  | OEM struct revision  | BYTE   | 0x01, for this format
+	 *  0x0D  | ECP version ID       | STR ID |
+	 *  0x0E  | ECP release date     | STR ID |
+	 */
+
+	/* Return if data structure not match */
+	if (dm->type != 140 || dm->length < 0x0F ||
+	memcmp(dmi_data + 4, "LENOVO", 6) != 0 ||
+	dmi_data[0x0A] != 0x0B || dmi_data[0x0B] != 0x07 ||
+	dmi_data[0x0C] != 0x01)
+		return;
+
+	/* fwstr is the first 8byte string  */
+	strncpy(ec_fw_string, dmi_data + 0x0F, 8);
+}
+
 /* returns 0 - probe ok, or < 0 - probe error.
  * Probe ok doesn't mean thinkpad found.
  * On error, kfree() cleanup on tp->* is not performed, caller must do it */
@@ -9966,7 +9997,7 @@ static int __must_check __init get_thinkpad_model_data(
 						struct thinkpad_id_data *tp)
 {
 	const struct dmi_device *dev = NULL;
-	char ec_fw_string[18];
+	char ec_fw_string[18] = {0};
 	char const *s;
 	char t;
 
@@ -10006,20 +10037,25 @@ static int __must_check __init get_thinkpad_model_data(
 			   ec_fw_string) == 1) {
 			ec_fw_string[sizeof(ec_fw_string) - 1] = 0;
 			ec_fw_string[strcspn(ec_fw_string, " ]")] = 0;
+			break;
+		}
+	}
 
-			tp->ec_version_str = kstrdup(ec_fw_string, GFP_KERNEL);
-			if (!tp->ec_version_str)
-				return -ENOMEM;
+	/* Newer ThinkPads have different EC program info table */
+	if (!ec_fw_string[0])
+		dmi_walk(find_new_ec_fwstr, &ec_fw_string);
 
-			t = tpacpi_parse_fw_id(ec_fw_string,
-					       &tp->ec_model, &tp->ec_release);
-			if (t != 'H') {
-				pr_notice("ThinkPad firmware release %s doesn't match the known patterns\n",
-					  ec_fw_string);
-				pr_notice("please report this to %s\n",
-					  TPACPI_MAIL);
-			}
-			break;
+	if (ec_fw_string[0]) {
+		tp->ec_version_str = kstrdup(ec_fw_string, GFP_KERNEL);
+		if (!tp->ec_version_str)
+			return -ENOMEM;
+
+		t = tpacpi_parse_fw_id(ec_fw_string,
+			 &tp->ec_model, &tp->ec_release);
+		if (t != 'H') {
+			pr_notice("ThinkPad firmware release %s doesn't match the known patterns\n",
+				  ec_fw_string);
+			pr_notice("please report this to %s\n", TPACPI_MAIL);
 		}
 	}
 
-- 
2.20.1

