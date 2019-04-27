Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D65C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A039F206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfD0PPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60906 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727138AbfD0PPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:15 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-00014I-Io; Sat, 27 Apr 2019 16:15:12 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004a0-8L; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Matti Kurkela" <Matti.Kurkela@iki.fi>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.137141088@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 142/202] Input: elantech - enable 3rd button support
 on Fujitsu CELSIUS H780
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

commit e8b22d0a329f0fb5c7ef95406872d268f01ee3b1 upstream.

Like Fujitsu CELSIUS H760, the H780 also has a three-button Elantech
touchpad, but the driver needs to be told so to enable the middle touchpad
button.

The elantech_dmi_force_crc_enabled quirk was not necessary with the H780.

Also document the fw_version and caps values detected for both H760 and
H780 models.

Signed-off-by: Matti Kurkela <Matti.Kurkela@iki.fi>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/mouse/elantech.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1036,6 +1036,8 @@ static int elantech_get_resolution_v4(st
  * Asus UX31               0x361f00        20, 15, 0e      clickpad
  * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
  * Avatar AVIU-145A2       0x361f00        ?               clickpad
+ * Fujitsu CELSIUS H760    0x570f02        40, 14, 0c      3 hw buttons (**)
+ * Fujitsu CELSIUS H780    0x5d0f02        41, 16, 0d      3 hw buttons (**)
  * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
  * Fujitsu LIFEBOOK E546   0x470f00        50, 12, 09      2 hw buttons
  * Fujitsu LIFEBOOK E547   0x470f00        50, 12, 09      2 hw buttons
@@ -1083,6 +1085,13 @@ static const struct dmi_system_id elante
 			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H760"),
 		},
 	},
+	{
+		/* Fujitsu H780 also has a middle button */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H780"),
+		},
+	},
 #endif
 	{ }
 };

