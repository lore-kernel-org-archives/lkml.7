Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5578BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366A320644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfHTSMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 14:12:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:53754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727358AbfHTSMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:12:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54DEFAEF5;
        Tue, 20 Aug 2019 18:12:14 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH rebased] powerpc/fadump: when fadump is supported register the fadump sysfs files.
Date:   Tue, 20 Aug 2019 20:12:11 +0200
Message-Id: <20190820181211.14694-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it is not possible to distinguish the case when fadump is
supported by firmware and disabled in kernel and completely unsupported
using the kernel sysfs interface. User can investigate the devicetree
but it is more reasonable to provide sysfs files in case we get some
fadumpv2 in the future.

With this patch sysfs files are available whenever fadump is supported
by firmware.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
Rebase on top of http://patchwork.ozlabs.org/patch/1150160/
[v5,31/31] powernv/fadump: support holes in kernel boot memory area
---
 arch/powerpc/kernel/fadump.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4b1bb3c55cf9..7ad424729e9c 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1319,13 +1319,9 @@ static void fadump_init_files(void)
  */
 int __init setup_fadump(void)
 {
-	if (!fw_dump.fadump_enabled)
-		return 0;
-
-	if (!fw_dump.fadump_supported) {
+	if (!fw_dump.fadump_supported && fw_dump.fadump_enabled) {
 		printk(KERN_ERR "Firmware-assisted dump is not supported on"
 			" this hardware\n");
-		return 0;
 	}
 
 	fadump_show_config();
@@ -1333,19 +1329,26 @@ int __init setup_fadump(void)
 	 * If dump data is available then see if it is valid and prepare for
 	 * saving it to the disk.
 	 */
-	if (fw_dump.dump_active) {
+	if (fw_dump.fadump_enabled) {
+		if (fw_dump.dump_active) {
+			/*
+			 * if dump process fails then invalidate the
+			 * registration and release memory before proceeding
+			 * for re-registration.
+			 */
+			if (fw_dump.ops->fadump_process(&fw_dump) < 0)
+				fadump_invalidate_release_mem();
+		}
 		/*
-		 * if dump process fails then invalidate the registration
-		 * and release memory before proceeding for re-registration.
+		 * Initialize the kernel dump memory structure for FAD
+		 * registration.
 		 */
-		if (fw_dump.ops->fadump_process(&fw_dump) < 0)
-			fadump_invalidate_release_mem();
-	}
-	/* Initialize the kernel dump memory structure for FAD registration. */
-	else if (fw_dump.reserve_dump_area_size)
-		fw_dump.ops->fadump_init_mem_struct(&fw_dump);
+		else if (fw_dump.reserve_dump_area_size)
+			fw_dump.ops->fadump_init_mem_struct(&fw_dump);
 
-	fadump_init_files();
+	}
+	if (fw_dump.fadump_supported)
+		fadump_init_files();
 
 	return 1;
 }
-- 
2.22.0

