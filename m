Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E63C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B35A20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfDDPSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:18:47 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:8500 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:18:46 -0400
X-IronPort-AV: E=Sophos;i="5.60,308,1549954800"; 
   d="scan'208";a="29661063"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Apr 2019 08:18:46 -0700
Received: from soft-dev3.microsemi.net (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Thu, 4 Apr 2019 08:18:45 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <ralf@linux-mips.org>, <paul.burton@mips.com>, <jhogan@kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] arch: mips: Fix initrd_start and initrd_end when read from DT
Date:   Thu, 4 Apr 2019 17:18:20 +0200
Message-ID: <1554391100-10060-1-git-send-email-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the bootloader passes arguments to linux kernel through device tree,
it passes the address of initrd_start and initrd_stop, which are in kseg0.
But when linux kernel reads these addresses from device tree, it converts
them to virtual addresses inside the function
__early_init_dt_declare_initrd.

At a later point then in the function init_initrd, it is checking for
initrd_start to be lower than PAGE_OFFSET, which for a 32 CPU it is not,
therefore it would disable the initrd by setting 0 to initrd_start and
initrd_stop.

The fix consists of checking if linux kernel received a device tree and not
having enable extended virtual address and in that case convert them back
to physical addresses that point in kseg0 as expected.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/mips/kernel/setup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8d1dc6c..b232784 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -264,6 +264,17 @@ static unsigned long __init init_initrd(void)
 		pr_err("initrd start must be page aligned\n");
 		goto disable;
 	}
+
+	/*
+	 * In case the initrd_start and initrd_end are read from DT,
+	 * then they are converted to virtual address, therefore convert
+	 * them back to physical address.
+	 */
+	if (!IS_ENABLED(CONFIG_EVA) && fw_arg0 == -2) {
+		initrd_start = __pa(initrd_start);
+		initrd_end = __pa(initrd_end);
+	}
+
 	if (initrd_start < PAGE_OFFSET) {
 		pr_err("initrd start < PAGE_OFFSET\n");
 		goto disable;
-- 
2.7.4

