Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97325206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfD0Pam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:30:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60920 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727148AbfD0PPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-00014H-Iw; Sat, 27 Apr 2019 16:15:12 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004Zw-7U; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Matti Kurkela" <Matti.Kurkela@iki.fi>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.303619649@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 141/202] Input: elantech - force needed quirks on
 Fujitsu H760
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matti Kurkela <Matti.Kurkela@iki.fi>

commit f9a703a54d16ba2470391c4b12236ee56591d50c upstream.

Just like Fujitsu CELSIUS H730, the H760 also has an Elantech touchpad with
the same quirks. Without this patch, the touchpad is useless out-of-the-box
as the mouse pointer won't move.

This patch makes the driver aware of both the crc_enabled=1 requirement and
the middle button, making the touchpad fully functional out-of-the-box.

Signed-off-by: Matti Kurkela <Matti.Kurkela@iki.fi>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/mouse/elantech.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1076,6 +1076,13 @@ static const struct dmi_system_id elante
 			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
 		},
 	},
+	{
+		/* Fujitsu H760 also has a middle button */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H760"),
+		},
+	},
 #endif
 	{ }
 };
@@ -1420,6 +1427,13 @@ static const struct dmi_system_id elante
 		},
 	},
 	{
+		/* Fujitsu H760 does not work with crc_enabled == 0 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H760"),
+		},
+	},
+	{
 		/* Fujitsu LIFEBOOK E544  does not work with crc_enabled == 0 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),

