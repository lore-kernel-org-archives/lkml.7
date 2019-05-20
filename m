Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1FF2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355493;
	bh=ljhw1NtefORkXSEcsCILjXYghqr+KIzORm1z49WSosU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kh5bFHaLy+LwvU9PJeJIFESXUAfcl2u+T3ORNGBWjLcwjB2et9kq/23kpChccxAkE
	 LWDqrGju8To7uX0Hlh1Piyy+OnRJ0PYuc51f5xhIjCdbZPwk/QFgLZ83tcCe2SA7kq
	 ZGiKztIYej26JARjJ2u1LYImTeidAf9b4b0Omntc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbfETMbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390331AbfETMb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:31:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305C020645;
        Mon, 20 May 2019 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355487;
        bh=ljhw1NtefORkXSEcsCILjXYghqr+KIzORm1z49WSosU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5a+P1EvFnWbi5sTKJj4TKGf1Cz13Gm8x9zPHI56imDaM/x5qgNE9++5fpDv/wJlC
         0DnzbQ2L8Jgjv/6Jwy9f2Qr7w5Je2Xrmf01Hk7a3sol57/eTaz+4Vx4Pyr8M9C627E
         T7mMZDIwN+ydzWbscN3YXmnu65FVCocgt8BS9oDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.1 014/128] power: supply: axp288_fuel_gauge: Add ACEPC T8 and T11 mini PCs to the blacklist
Date:   Mon, 20 May 2019 14:13:21 +0200
Message-Id: <20190520115250.424049155@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 9274c78305e12c5f461bec15f49c38e0f32ca705 upstream.

The ACEPC T8 and T11 Cherry Trail Z8350 mini PCs use an AXP288 and as PCs,
rather then portables, they does not have a battery. Still for some
reason the AXP288 not only thinks there is a battery, it actually
thinks it is discharging while the PC is running, slowly going to
0% full, causing userspace to shutdown the system due to the battery
being critically low after a while.

This commit adds the ACEPC T8 and T11 to the axp288 fuel-gauge driver
blacklist, so that we stop reporting bogus battery readings on this device.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1690852
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/axp288_fuel_gauge.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -686,6 +686,26 @@ intr_failed:
  */
 static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 	{
+		/* ACEPC T8 Cherry Trail Z8350 mini PC */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "T8"),
+			/* also match on somewhat unique bios-version */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
+		},
+	},
+	{
+		/* ACEPC T11 Cherry Trail Z8350 mini PC */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "T11"),
+			/* also match on somewhat unique bios-version */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
+		},
+	},
+	{
 		/* Intel Cherry Trail Compute Stick, Windows version */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),


