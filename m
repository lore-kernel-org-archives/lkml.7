Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INVALID_DATE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A04C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C783214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pacien.net header.i=@pacien.net header.b="pERwqMKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfIYJsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:48:23 -0400
Received: from drt.pacien.net ([5.2.64.213]:60442 "EHLO drt.pacien.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfIYJsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:48:22 -0400
Received: from lsn.pacien.net (mail.kea [10.0.3.108])
        by drt.pacien.net (OpenSMTPD) with ESMTP id dd0b71fb;
        Wed, 25 Sep 2019 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pacien.net;
         s=lsn.pacien.net; h=Date:Message-ID:Cc:In-Reply-To:Subject:From:
        Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-To:To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k5vM3iqTrJFHvMei5yw/jf63ySBSFhk36kIUWh5YeVw=; b=pERwqMKNUuPozpM/4UHdX/s4uj
        qrvjxZnWPq1G0JyOl+92dL9ONg9Hn4xbwNfHHSiZAZTSepY0tbfJEHA//Awd2piv1to55Jmr1wunq
        uJamQYi3hF45Zq5fgRls19Ka3VwG2s2oaM/XdXCCq/fmetvmMmwAlr6ugjM+AKxT90/lr6YxntCtF
        ZEHNRafB71gZG1b7zJO0vMOPFKi4peEQX4pMvtv/TGgJA/dKl5oOQP4vMO7U1q2EL/CXveVvlrQh3
        eOnILMmx3f527FGR5X/AYOvBWNiP3leE7J+TZVx3uQypvq8j2A8kuTwMuPcbTddJoCZP5QYXHXe/o
        BOb2SClg==;
Received: from warfstation.kea ([10.1.1.1] helo=localhost)
        by lsn.pacien.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.2)
        (envelope-from <pacien.trangirard@pacien.net>)
        id 1iD3uE-0008Lc-8n; Wed, 25 Sep 2019 09:48:18 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From:   Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
Date:   Thu, 12 Sep 2019 00:07:45 +0200
Subject: [PATCH v2] platform/x86: dell-laptop: fix broken kbd backlight on Inspiron 10xx
In-Reply-To: <20190925082149.yjhmmb64i4h6sddi@pali>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <156940489220.8635.14349142383780268583@WARFSTATION>
Date:   Wed, 25 Sep 2019 11:48:12 +0200
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a quirk disabling keyboard backlight support for the
Dell Inspiron 1012 and 1018.

Those models wrongly report supporting keyboard backlight control
features (through SMBIOS tokens) even though they're not equipped with
a backlit keyboard. This led to broken controls being exposed
through sysfs by this driver which froze the system when used.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D107651
Signed-off-by: Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
---
 drivers/platform/x86/dell-laptop.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell=
-laptop.c
index d27be2836bc2..ffe5abbdadda 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -33,6 +33,7 @@
=20
 struct quirk_entry {
 	bool touchpad_led;
+	bool kbd_broken_backlight;
 	bool kbd_led_levels_off_1;
 	bool kbd_missing_ac_tag;
=20
@@ -73,6 +74,10 @@ static struct quirk_entry quirk_dell_latitude_e6410 =3D {
 	.kbd_led_levels_off_1 =3D true,
 };
=20
+static struct quirk_entry quirk_dell_inspiron_1012 =3D {
+	.kbd_broken_backlight =3D true,
+};
+
 static struct platform_driver platform_driver =3D {
 	.driver =3D {
 		.name =3D "dell-laptop",
@@ -310,6 +315,24 @@ static const struct dmi_system_id dell_quirks[] __init=
const =3D {
 		},
 		.driver_data =3D &quirk_dell_latitude_e6410,
 	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "Dell Inspiron 1012",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1012"),
+		},
+		.driver_data =3D &quirk_dell_inspiron_1012,
+	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "Dell Inspiron 1018",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1018"),
+		},
+		.driver_data =3D &quirk_dell_inspiron_1012,
+	},
 	{ }
 };
=20
@@ -2040,6 +2063,9 @@ static int __init kbd_led_init(struct device *dev)
 {
 	int ret;
=20
+	if (quirks && quirks->kbd_broken_backlight)
+		return -ENODEV;
+
 	kbd_init();
 	if (!kbd_led_present)
 		return -ENODEV;
--=20
2.19.2
