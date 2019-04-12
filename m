Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57C6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E292186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="y/EpSJ0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDLICU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:02:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33053 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfDLICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:02:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so4743621plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pFtD6XTcrj9w2SnuHqodWDjdloefY+ALagCjvVxogs=;
        b=y/EpSJ0C1eHt/lvss8ZPJr7850TfkJ5XeXJKMTlnxIVhNOyQInppg9d9H+x22KCvUg
         W1t0RD+j46OZ9Oh6hFJ2Mo6ZvQgFAL9bufLooT8qROiIZkcsBcZn7noKE8CIBCGQbjw7
         x45loZaGQtSgJpv8fqZKkWLI4M1Ps4Rd6PaOV9Om5p4RfaQu0zimZ9D7zoxOqMzySNnB
         6dJaDrCeP901Bh5GYqxxR2l4ZJcoCwUx1RQFwSnw/QA8TrYUnpdRgWqknmPsLTZPd36k
         u9TqZbaTq2vE8ktgrN2p45qDyT8/cmcqkXcy61JPnLYvCb3oTWQFuoWwLRIhvUfCDxT/
         R75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pFtD6XTcrj9w2SnuHqodWDjdloefY+ALagCjvVxogs=;
        b=RcPRW9zVaoGOgRZlrpyWVVZkO7p112rvTi9Z0GpNtu01C1ln8dXF8JW5gsSTQyZIl5
         hX/oIUNoWc4qXcymftjVlFdNzlahgbSTSYcHDKIQVR/2NcgXhuKvj9/RAuLeDR9INomU
         SqeiReY4SJ18Xn3KfA6Urryh0DrLsaenokjbe7Ti/USMVTPGultHVGGWMBDFrmwMMAyJ
         vvOQcDmhhskEJ7UyMxb/CvoZbHM1W1gQLyttuHu+dLFPMuDfc1SAzy2N66LD4LMAMnPn
         redMdXL6zkG0o2Xfha1stpFYHyd/pEIp5QtgX2N2rqT3YpqJb8GH5k3PCHnazVKS0qTz
         Bgtg==
X-Gm-Message-State: APjAAAWWaT+EWmoptMQNW10ISPpAESKPHPBPMLZeM7hk2WYGpdrfye8l
        MF8uE6AxzSB1MvQnbxJUeIS4pHT5d4k=
X-Google-Smtp-Source: APXvYqyZ8btl473eNeekUjE/S4UDO344hauxAtTngUTvm4nsnDJPStwhz3QT9Wcd8xs1L14m/Yyj8g==
X-Received: by 2002:a17:902:266:: with SMTP id 93mr17516167plc.201.1555056139064;
        Fri, 12 Apr 2019 01:02:19 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id j14sm44337556pfa.57.2019.04.12.01.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 01:02:18 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH v2] x86/reboot: Use efi reboot for Acer TravelMate X514-51T
Date:   Fri, 12 Apr 2019 16:01:53 +0800
Message-Id: <20190412080152.3718-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon reboot, the Acer TravelMate X514-51T laptop appears to complete the
shutdown process, but then it hangs in BIOS POST with a black screen.

The problem is intermittent - at some points it has appeared related to
Secure Boot settings or different kernel builds, but ultimately we have
not been able to identify the exact conditions that trigger the issue to
come and go.

Besides, the EFI mode cannot be disabled in the BIOS of this model.

However, after extensive testing, we observe that using the EFI reboot
method reliably avoids the issue in all cases.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=203119
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
v2:
- Add the EFI runtime state checking in set_efi_reboot function for the
  quirk.
- Refine the printing information by writing "EFI" in the string
  directly.

 arch/x86/kernel/reboot.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 725624b6c0c0..07111b8c41dd 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -81,6 +81,19 @@ static int __init set_bios_reboot(const struct dmi_system_id *d)
 	return 0;
 }
 
+/*
+ * Some machines require the "reboot=e" commandline options
+ */
+static int __init set_efi_reboot(const struct dmi_system_id *d)
+{
+	if (reboot_type != BOOT_EFI && !efi_runtime_disabled()) {
+		reboot_type = BOOT_EFI;
+		pr_info("%s series board detected. Selecting EFI-method for reboots.\n",
+			d->ident);
+	}
+	return 0;
+}
+
 void __noreturn machine_real_restart(unsigned int type)
 {
 	local_irq_disable();
@@ -166,6 +179,14 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "AOA110"),
 		},
 	},
+	{	/* Handle reboot issue on Acer TravelMate X514-51T */
+		.callback = set_efi_reboot,
+		.ident = "Acer TravelMate X514-51T",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate X514-51T"),
+		},
+	},
 
 	/* Apple */
 	{	/* Handle problems with rebooting on Apple MacBook5 */
-- 
2.20.1

