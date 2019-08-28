Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A49C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D84214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH1R1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:27:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:45082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfH1R1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:27:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 286F8AFF2;
        Wed, 28 Aug 2019 17:27:44 +0000 (UTC)
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
Subject: [PATCH v2] powerpc/fadump: when fadump is supported register the fadump sysfs files.
Date:   Wed, 28 Aug 2019 19:27:42 +0200
Message-Id: <20190828172742.18378-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <e7fad352-48f3-f01d-1b19-a589a3b95c07@linux.ibm.com>
References: <e7fad352-48f3-f01d-1b19-a589a3b95c07@linux.ibm.com>
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
v2: move the sysfs initialization earlier to avoid condition nesting
---
 arch/powerpc/kernel/fadump.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4eab97292cc2..13741380b2f7 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1671,16 +1671,20 @@ static void fadump_init_files(void)
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
 
+	if (!fw_dump.fadump_supported)
+		return 0;
+
+	fadump_init_files();
 	fadump_show_config();
+
+	if (!fw_dump.fadump_enabled)
+		return 1;
+
 	/*
 	 * If dump data is available then see if it is valid and prepare for
 	 * saving it to the disk.
@@ -1696,7 +1700,6 @@ int __init setup_fadump(void)
 	/* Initialize the kernel dump memory structure for FAD registration. */
 	else if (fw_dump.reserve_dump_area_size)
 		init_fadump_mem_struct(&fdm, fw_dump.reserve_dump_area_start);
-	fadump_init_files();
 
 	return 1;
 }
-- 
2.22.0

