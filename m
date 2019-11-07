Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9FDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBA02085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfKGQsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:48:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:38182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfKGQsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:48:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBAA5AE2D;
        Thu,  7 Nov 2019 16:48:02 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] powerpc/fadump: when fadump is supported register the fadump sysfs files.
Date:   Thu,  7 Nov 2019 17:47:57 +0100
Message-Id: <20191107164757.15140-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023175651.24833-1-msuchanek@suse.de>
References: <20191023175651.24833-1-msuchanek@suse.de>
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

There is duplicate message about lack of support by firmware in
fadump_reserve_mem and setup_fadump. Remove the duplicate message in
setup_fadump.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: move the sysfs initialization earlier to avoid condition nesting
v3: remove duplicate message
---
 arch/powerpc/kernel/fadump.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ed59855430b9..ff0114aeba9b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1466,16 +1466,15 @@ static void fadump_init_files(void)
  */
 int __init setup_fadump(void)
 {
-	if (!fw_dump.fadump_enabled)
-		return 0;
-
-	if (!fw_dump.fadump_supported) {
-		printk(KERN_ERR "Firmware-assisted dump is not supported on"
-			" this hardware\n");
+	if (!fw_dump.fadump_supported)
 		return 0;
-	}
 
+	fadump_init_files();
 	fadump_show_config();
+
+	if (!fw_dump.fadump_enabled)
+		return 1;
+
 	/*
 	 * If dump data is available then see if it is valid and prepare for
 	 * saving it to the disk.
@@ -1492,8 +1491,6 @@ int __init setup_fadump(void)
 	else if (fw_dump.reserve_dump_area_size)
 		fw_dump.ops->fadump_init_mem_struct(&fw_dump);
 
-	fadump_init_files();
-
 	return 1;
 }
 subsys_initcall(setup_fadump);
-- 
2.23.0

