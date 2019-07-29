Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A8BC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702E8217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429456;
	bh=F3xEu7dp5QQ6tel3JOLvaCiGrTfOh3hsxHZD8ZXf8Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2xfUzbyh7MhAq5KzdeHe4DE6MYUiT2wEowbxccoLEWvLblCwZhNWUejYfQkHzhzT
	 N1ZNYkfXKsmHsHfd/bXrf+N0TF0cAU3cmSWPeAvRwG4cA+jOsIH3CvXguBhEW5JME1
	 B6dakRYPgP0ohIzZQO4a8Ahr0qLqq3BI/bB22Bpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389762AbfG2ToP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389747AbfG2ToK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:44:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891222054F;
        Mon, 29 Jul 2019 19:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429449;
        bh=F3xEu7dp5QQ6tel3JOLvaCiGrTfOh3hsxHZD8ZXf8Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9FGuT9tuhPRwfonhp2p2+v7JUioZy8X8qeIVolhBldN5c3XE2AcHKGnrwspWJgxc
         M/0i4HMoqjJqG8GjEvuz9OUtFpeW+B4zqGgg8WuKy/LngjdEO3cWW1XRiUBl16qAQo
         qijtgMXIpPfa8Jb3v2RnwVDjhxXBm2cyX5SPVLWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.19 101/113] x86/sysfb_efi: Add quirks for some devices with swapped width and height
Date:   Mon, 29 Jul 2019 21:23:08 +0200
Message-Id: <20190729190719.625627564@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit d02f1aa39189e0619c3525d5cd03254e61bf606a upstream.

Some Lenovo 2-in-1s with a detachable keyboard have a portrait screen but
advertise a landscape resolution and pitch, resulting in a messed up
display if the kernel tries to show anything on the efifb (because of the
wrong pitch).

Fix this by adding a new DMI match table for devices which need to have
their width and height swapped.

At first it was tried to use the existing table for overriding some of the
efifb parameters, but some of the affected devices have variants with
different LCD resolutions which will not work with hardcoded override
values.

Reference: https://bugzilla.redhat.com/show_bug.cgi?id=1730783
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190721152418.11644-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/sysfb_efi.c |   46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

--- a/arch/x86/kernel/sysfb_efi.c
+++ b/arch/x86/kernel/sysfb_efi.c
@@ -231,9 +231,55 @@ static const struct dmi_system_id efifb_
 	{},
 };
 
+/*
+ * Some devices have a portrait LCD but advertise a landscape resolution (and
+ * pitch). We simply swap width and height for these devices so that we can
+ * correctly deal with some of them coming with multiple resolutions.
+ */
+static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
+	{
+		/*
+		 * Lenovo MIIX310-10ICR, only some batches have the troublesome
+		 * 800x1280 portrait screen. Luckily the portrait version has
+		 * its own BIOS version, so we match on that.
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "MIIX 310-10ICR"),
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1HCN44WW"),
+		},
+	},
+	{
+		/* Lenovo MIIX 320-10ICR with 800x1280 portrait screen */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
+					"Lenovo MIIX 320-10ICR"),
+		},
+	},
+	{
+		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
+					"Lenovo ideapad D330-10IGM"),
+		},
+	},
+	{},
+};
+
 __init void sysfb_apply_efi_quirks(void)
 {
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
 	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
 		dmi_check_system(efifb_dmi_system_table);
+
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
+	    dmi_check_system(efifb_dmi_swap_width_height)) {
+		u16 temp = screen_info.lfb_width;
+
+		screen_info.lfb_width = screen_info.lfb_height;
+		screen_info.lfb_height = temp;
+		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
+	}
 }


