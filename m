Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBF3C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558472082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765931;
	bh=n2ZPc5mWVXvVlYy8in4aeJCAQhA1LUx8eA4rG19ZCVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AOnbLMbvIitu+KQRUbD5ASAqD2cnnyoeeGftVrCFPba/pJmY+Eft8mG5nE4IqV+Ex
	 xhJZvOUraqT48LV/8M98TRCMFIiu8WSJRZgGKncIZaprCyHvI+RULqPKayPW0BY5wR
	 nFlkDImlQTX5v2qzGIwEXFivxXsrPF++IcrGFC/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfI2OAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729845AbfI2OAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:00:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D8B02082F;
        Sun, 29 Sep 2019 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765600;
        bh=n2ZPc5mWVXvVlYy8in4aeJCAQhA1LUx8eA4rG19ZCVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYP/TEzdcIl4o1ry+BwDUk3CryEhgvMBoihPkQonZeulzcHEPLtmgoOdXA9hIMo7K
         Px4OAeWhvuyDh+iCl6Tv0Caa1wtNaCTvCNq5I12pmM9gJXOFFWLcrA7inXb3t7eOhJ
         7eV5NHwVibsz2O8+qhaT4qFv3BLGBPeearMFRpPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Kacper=20Piwi=C5=84ski?= <cosiekvfj@o2.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 57/63] ACPI: video: Add new hw_changes_brightness quirk, set it on PB Easynote MZ35
Date:   Sun, 29 Sep 2019 15:54:30 +0200
Message-Id: <20190929135040.889718199@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 4f7f96453b462b3de0fa18d18fe983960bb5ee7f ]

Some machines change the brightness themselves when a brightness hotkey
gets pressed, despite us telling them not to. This causes the brightness to
go two steps up / down when the hotkey is pressed. This is esp. a problem
on older machines with only a few brightness levels.

This commit adds a new hw_changes_brightness quirk which makes
acpi_video_device_notify() only call backlight_force_update(...,
BACKLIGHT_UPDATE_HOTKEY) and not do anything else, notifying userspace
that the brightness was changed and leaving it at that fixing the dual
step problem.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204077
Reported-by: Kacper Piwiński <cosiekvfj@o2.pl>
Tested-by: Kacper Piwiński <cosiekvfj@o2.pl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_video.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index d73afb562ad95..1a23e7aa74df7 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -73,6 +73,12 @@ module_param(report_key_events, int, 0644);
 MODULE_PARM_DESC(report_key_events,
 	"0: none, 1: output changes, 2: brightness changes, 3: all");
 
+static int hw_changes_brightness = -1;
+module_param(hw_changes_brightness, int, 0644);
+MODULE_PARM_DESC(hw_changes_brightness,
+	"Set this to 1 on buggy hw which changes the brightness itself when "
+	"a hotkey is pressed: -1: auto, 0: normal 1: hw-changes-brightness");
+
 /*
  * Whether the struct acpi_video_device_attrib::device_id_scheme bit should be
  * assumed even if not actually set.
@@ -418,6 +424,14 @@ static int video_set_report_key_events(const struct dmi_system_id *id)
 	return 0;
 }
 
+static int video_hw_changes_brightness(
+	const struct dmi_system_id *d)
+{
+	if (hw_changes_brightness == -1)
+		hw_changes_brightness = 1;
+	return 0;
+}
+
 static const struct dmi_system_id video_dmi_table[] = {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
@@ -542,6 +556,21 @@ static const struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V131"),
 		},
 	},
+	/*
+	 * Some machines change the brightness themselves when a brightness
+	 * hotkey gets pressed, despite us telling them not to. In this case
+	 * acpi_video_device_notify() should only call backlight_force_update(
+	 * BACKLIGHT_UPDATE_HOTKEY) and not do anything else.
+	 */
+	{
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=204077 */
+	 .callback = video_hw_changes_brightness,
+	 .ident = "Packard Bell EasyNote MZ35",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Packard Bell"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "EasyNote MZ35"),
+		},
+	},
 	{}
 };
 
@@ -1625,6 +1654,14 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 	bus = video_device->video;
 	input = bus->input;
 
+	if (hw_changes_brightness > 0) {
+		if (video_device->backlight)
+			backlight_force_update(video_device->backlight,
+					       BACKLIGHT_UPDATE_HOTKEY);
+		acpi_notifier_call_chain(device, event, 0);
+		return;
+	}
+
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
 		brightness_switch_event(video_device, event);
-- 
2.20.1



