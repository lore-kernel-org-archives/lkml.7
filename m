Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25823C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3D32073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfDPHwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:52:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39273 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDPHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:52:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3G7q8TP3338752
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 00:52:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3G7q8Q93338749;
        Tue, 16 Apr 2019 00:52:08 -0700
Date:   Tue, 16 Apr 2019 00:52:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jian-Hong Pan <tipbot@zytor.com>
Message-ID: <tip-5767575c1211e8958e5dd80d6542998b519c8478@git.kernel.org>
Cc:     bp@alien8.de, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org, jian-hong@endlessm.com,
        ard.biesheuvel@linaro.org, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, drake@endlessm.com
Reply-To: drake@endlessm.com, jian-hong@endlessm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          matt@codeblueprint.co.uk, torvalds@linux-foundation.org,
          bp@alien8.de, tglx@linutronix.de, ard.biesheuvel@linaro.org,
          peterz@infradead.org
In-Reply-To: <20190412080152.3718-1-jian-hong@endlessm.com>
References: <20190412080152.3718-1-jian-hong@endlessm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/reboot: Use EFI reboot for Acer TravelMate
 X514-51T
Git-Commit-ID: 5767575c1211e8958e5dd80d6542998b519c8478
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5767575c1211e8958e5dd80d6542998b519c8478
Gitweb:     https://git.kernel.org/tip/5767575c1211e8958e5dd80d6542998b519c8478
Author:     Jian-Hong Pan <jian-hong@endlessm.com>
AuthorDate: Fri, 12 Apr 2019 16:01:53 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 09:49:16 +0200

x86/reboot: Use EFI reboot for Acer TravelMate X514-51T

Upon reboot, the Acer TravelMate X514-51T laptop appears to complete the
shutdown process, but then it hangs in BIOS POST with a black screen.

The problem is intermittent - at some points it has appeared related to
Secure Boot settings or different kernel builds, but ultimately we have
not been able to identify the exact conditions that trigger the issue to
come and go.

Besides, the EFI mode cannot be disabled in the BIOS of this model.

However, after extensive testing, we observe that using the EFI reboot
method reliably avoids the issue in all cases.

So add a boot time quirk to use EFI reboot on such systems.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=203119
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: linux@endlessm.com
Link: http://lkml.kernel.org/r/20190412080152.3718-1-jian-hong@endlessm.com
[ Small clarification edits to the code and changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/reboot.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 725624b6c0c0..8fd3cedd9acc 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -81,6 +81,19 @@ static int __init set_bios_reboot(const struct dmi_system_id *d)
 	return 0;
 }
 
+/*
+ * Some machines don't handle the default ACPI reboot method and
+ * require the EFI reboot method:
+ */
+static int __init set_efi_reboot(const struct dmi_system_id *d)
+{
+	if (reboot_type != BOOT_EFI && !efi_runtime_disabled()) {
+		reboot_type = BOOT_EFI;
+		pr_info("%s series board detected. Selecting EFI-method for reboot.\n", d->ident);
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
