Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C74321925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfCUWBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:01:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:53200 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfCUWA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="127513566"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1921730214C; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 03/17] x86: Don't inline __const_udelay
Date:   Thu, 21 Mar 2019 14:59:55 -0700
Message-Id: <20190321220009.29334-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

__const_udelay is marked inline, and LTO will happily inline it everywhere
Dropping the inline saves ~44k text in a LTO build.

13999560        1740864 1499136 17239560        1070e08 vmlinux-with-udelay-inline
13954764        1736768 1499136 17190668        1064f0c vmlinux-wo-udelay-inline

Even without LTO I believe marking it noinline documents it correctly.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index f5b7f1b3b6d7..b7375dc6898f 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -162,7 +162,7 @@ void __delay(unsigned long loops)
 }
 EXPORT_SYMBOL(__delay);
 
-void __const_udelay(unsigned long xloops)
+noinline void __const_udelay(unsigned long xloops)
 {
 	unsigned long lpj = this_cpu_read(cpu_info.loops_per_jiffy) ? : loops_per_jiffy;
 	int d0;
-- 
2.20.1

