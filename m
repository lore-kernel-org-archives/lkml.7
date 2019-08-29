Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71550C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCCF23404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfH2KLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:11:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:6438 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfH2KLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:11:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 03:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="210487424"
Received: from olenz-mobl1.ger.corp.intel.com (HELO artemis.ger.corp.intel.com) ([10.252.5.248])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2019 03:11:27 -0700
From:   Rob Bradford <robert.bradford@intel.com>
To:     x86@kernel.org
Cc:     Rob Bradford <robert.bradford@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@surriel.com>,
        Juergen Gross <jgross@suse.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/reboot: Avoid EFI reboot when not running on EFI
Date:   Thu, 29 Aug 2019 11:11:18 +0100
Message-Id: <20190829101119.7345-1-robert.bradford@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the check using efi_runtime_disabled() which only checks if EFI
runtime was disabled on the kernel command line with a call to
efi_enabled(EFI_RUNTIME_SERVICES) to check if EFI runtime services are
available.

In the situation where the kernel was booted without an EFI environment
then only efi_enabled(EFI_RUNTIME_SERVICES) correctly represents that no
EFI is available. Setting "noefi" or "efi=noruntime" on the commandline
continue to have the same effect as efi_enabled(EFI_RUNTIME_SERVICES)
will return false.

Signed-off-by: Rob Bradford <robert.bradford@intel.com>
---
 arch/x86/kernel/reboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 09d6bded3c1e..0b0a7fccdb00 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -500,7 +500,7 @@ static int __init reboot_init(void)
 	 */
 	rv = dmi_check_system(reboot_dmi_table);
 
-	if (!rv && efi_reboot_required() && !efi_runtime_disabled())
+	if (!rv && efi_reboot_required() && efi_enabled(EFI_RUNTIME_SERVICES))
 		reboot_type = BOOT_EFI;
 
 	return 0;
-- 
2.21.0

