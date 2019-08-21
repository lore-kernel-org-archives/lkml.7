Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF6EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7015C2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfHUINg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:13:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:38127 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfHUINg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:13:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 01:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="183465880"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2019 01:13:32 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        rppt@linux.ibm.com, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH] x86/apic: Update virtual irq base for DT/OF based system as well
Date:   Wed, 21 Aug 2019 16:13:30 +0800
Message-Id: <20190821081330.1187-1-rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ioapic_dynirq_base' contains the virtual IRQ base number. Presently, it is
updated to the end of hardware IRQ numbers but this is done only when IOAPIC
configuration type is IOAPIC_DOMAIN_LEGACY or IOAPIC_DOMAIN_STRICT. There is
a third type IOAPIC_DOMAIN_DYNAMIC which applies when IOAPIC configuration
comes from devicetree.
Please see dtb_add_ioapic() in arch/x86/kernel/devicetree.c

In case of IOAPIC_DOMAIN_DYNAMIC (DT/OF based system), 'ioapic_dynirq_base'
remains to zero initialized value. This means that for OF based systems,
virtual IRQ base will get set to zero. Zero value for a virtual IRQ is a
invalid value.
Please see https://yarchive.net/comp/linux/zero.html for more details.

Update 'ioapic_dynirq_base' for IOAPIC_DOMAIN_DYNAMIC case as well just like
it is presently updated for IOAPIC_DOMAIN_LEGACY & IOAPIC_DOMAIN_STRICT i.e.
set the virtual IRQ base to the end of hardware IRQ numbers when IOAPIC
configuration comes from devicetree.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 arch/x86/kernel/apic/io_apic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c7bb6c69f21c..fe50cd91122b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2336,7 +2336,8 @@ static int mp_irqdomain_create(int ioapic)
 	ip->irqdomain->parent = parent;
 
 	if (cfg->type == IOAPIC_DOMAIN_LEGACY ||
-	    cfg->type == IOAPIC_DOMAIN_STRICT)
+	    cfg->type == IOAPIC_DOMAIN_STRICT ||
+	    cfg->type == IOAPIC_DOMAIN_DYNAMIC)
 		ioapic_dynirq_base = max(ioapic_dynirq_base,
 					 gsi_cfg->gsi_end + 1);
 
-- 
2.11.0

