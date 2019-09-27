Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B832C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0909C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pacien.net header.i=@pacien.net header.b="W/6VBmEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfI0VTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:19:13 -0400
Received: from drt.pacien.net ([5.2.64.213]:36668 "EHLO drt.pacien.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfI0VTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:19:12 -0400
Received: from lsn.pacien.net (mail.kea [10.0.3.108])
        by drt.pacien.net (OpenSMTPD) with ESMTP id be8358c7;
        Fri, 27 Sep 2019 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pacien.net;
         s=lsn.pacien.net; h=Date:Message-ID:Subject:To:From:Cc:References:
        In-Reply-To:Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=e5S26ZKLBZQ6C5oRLkB+Hi9vtUZLDXXi8MTbU//OIck=; b=W/6VBmEIIaiv4xiR2ErwCybmlu
        Zv/RUYuAjcB+KKZYz6Jf6qhUDj0nE7mq8rc7tGWSZc6Hxmi+cIeT9pBp/s8jJFJu3rYkk9s7DWsWl
        XaSeyhG30CeS688vnb8KydKNy2DuIu0FGn2Uafpgf2Lvz+dnQJ2jMW5axOngeH0zcNM8mblxCyCZS
        BJhUWCIIwHeYne1WDKPvH9K9cAhhVD8rgnBvyZTwd1jto8Rr0YK5s2EEZWapZC7Dq2AAXhaWW+6tz
        HxY0lmCgh3x3tnbGopF6a6zhJ8OwXpnxMEVbTu8ck8r/NLOXiqsDdXZf7MkaLSFRog6odiWvCU5ef
        VvWeVUog==;
Received: from warfstation.kea ([10.1.1.1] helo=localhost)
        by lsn.pacien.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.2)
        (envelope-from <pacien.trangirard@pacien.net>)
        id 1iDxdt-0006W5-JI; Fri, 27 Sep 2019 21:19:09 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190926081146.f4f26kun7ekwqsgj@pali>
References: <20190925082149.yjhmmb64i4h6sddi@pali> <156940489220.8635.14349142383780268583@WARFSTATION> <CAHp75VfkL3QGXYjeEEqr75SWCKo1SDEqS9q3YEQWYM4iXbUzcg@mail.gmail.com> <20190926081146.f4f26kun7ekwqsgj@pali>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
To:     Pali Rohar <pali.rohar@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] platform/x86: dell-laptop: disable kbd backlight on Inspiron 10xx
Message-ID: <156961914387.417.14261217089484891942@WARFSTATION>
Date:   Fri, 27 Sep 2019 23:19:03 +0200
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
index d27be2836bc2..74e988f839e8 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -33,6 +33,7 @@
=20
 struct quirk_entry {
 	bool touchpad_led;
+	bool kbd_led_not_present;
 	bool kbd_led_levels_off_1;
 	bool kbd_missing_ac_tag;
=20
@@ -73,6 +74,10 @@ static struct quirk_entry quirk_dell_latitude_e6410 =3D {
 	.kbd_led_levels_off_1 =3D true,
 };
=20
+static struct quirk_entry quirk_dell_inspiron_1012 =3D {
+	.kbd_led_not_present =3D true,
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
@@ -1493,6 +1516,9 @@ static void kbd_init(void)
 {
 	int ret;
=20
+	if (quirks && quirks->kbd_led_not_present)
+		return;
+
 	ret =3D kbd_init_info();
 	kbd_init_tokens();
=20
--=20
2.19.2
