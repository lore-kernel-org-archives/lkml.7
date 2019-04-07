Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E072CC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF22B20863
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDGViq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:38:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfDGViq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:38:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F52A4627A;
        Sun,  7 Apr 2019 21:38:46 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-121-19.rdu2.redhat.com [10.10.121.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7750E610A0;
        Sun,  7 Apr 2019 21:38:41 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: i8042 - disable KBD port on Late-2016 Razer Blade Stealth
Date:   Sun,  7 Apr 2019 17:37:34 -0400
Message-Id: <20190407213735.10658-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 07 Apr 2019 21:38:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The late 2016 model of the Razer Blade Stealth has a built-in USB
keyboard, but for some reason the BIOS exposes an i8042 controller with
a connected KBD port. While this fake AT Keyboard device doesn't appear
to report any events, attempting to change the state of the caps lock
LED on it from on to off causes the entire system to hang.

So, introduce a quirk table for disabling keyboard probing by default,
i8042_dmi_nokbd_table, and add this specific model of Razer laptop to
that table.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 136f6e7bf797..888f5f6feebf 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -884,6 +884,22 @@ static const struct dmi_system_id __initconst i8042_dmi_kbdreset_table[] = {
 	{ }
 };
 
+static const struct dmi_system_id i8042_dmi_nokbd_table[] __initconst = {
+	{
+		/*
+		 * Razer Blade Stealth (Late 2016 model) - Keyboard is on USB
+		 * but the system exposes a fake AT keyboard that crashes the
+		 * system if the caps lock LED is changed
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Blade Stealth"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "2.04"),
+		},
+	},
+	{ }
+};
+
 #endif /* CONFIG_X86 */
 
 #ifdef CONFIG_PNP
@@ -1040,6 +1056,9 @@ static int __init i8042_pnp_init(void)
 #ifdef CONFIG_X86
 	if (dmi_check_system(i8042_dmi_nopnp_table))
 		i8042_nopnp = true;
+
+	if (dmi_check_system(i8042_dmi_nokbd_table))
+		i8042_nokbd = true;
 #endif
 
 	if (i8042_nopnp) {
-- 
2.20.1

