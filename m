Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62E0C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD37121726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfFZNjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:39:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:43541 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZNjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:39:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 06:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="167043312"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2019 06:39:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 143A0162; Wed, 26 Jun 2019 16:39:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] io-mapping: Use PHYS_PFN() macro in io_mapping_map_atomic_wc()
Date:   Wed, 26 Jun 2019 16:39:39 +0300
Message-Id: <20190626133939.1998-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PHYS_PFN() macro in io_mapping_map_atomic_wc() instead of
open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/io-mapping.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 6e125e9b4187..837058bc1c9f 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -28,6 +28,7 @@ struct io_mapping {
 
 #ifdef CONFIG_HAVE_ATOMIC_IOMAP
 
+#include <linux/pfn.h>
 #include <asm/iomap.h>
 /*
  * For small address space machines, mapping large objects
@@ -64,12 +65,10 @@ io_mapping_map_atomic_wc(struct io_mapping *mapping,
 			 unsigned long offset)
 {
 	resource_size_t phys_addr;
-	unsigned long pfn;
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	pfn = (unsigned long) (phys_addr >> PAGE_SHIFT);
-	return iomap_atomic_prot_pfn(pfn, mapping->prot);
+	return iomap_atomic_prot_pfn(PHYS_PFN(phys_addr), mapping->prot);
 }
 
 static inline void
-- 
2.20.1

