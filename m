Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D60CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3695B218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfC3As0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:48:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:21332 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbfC3Arw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:47:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 17:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="scan'208";a="136048036"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2019 17:47:51 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DD53F301C78; Fri, 29 Mar 2019 17:47:50 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 2/9] x86/cpu/amd: Ifdef 32bit only assembler for 32bit
Date:   Fri, 29 Mar 2019 17:47:36 -0700
Message-Id: <20190330004743.29541-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330004743.29541-1-andi@firstfloor.org>
References: <20190330004743.29541-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The "vide" inline assembler is only needed on 32bit kernels for old
32bit only CPUs.  Ifdef it to not include it into 64bit kernels.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/cpu/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1bcb489e07e7..fb6a64bd765f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -82,12 +82,14 @@ static inline int wrmsrl_amd_safe(unsigned msr, unsigned long long val)
  *	performance at the same time..
  */
 
+#ifdef CONFIG_X86_32
 extern __visible void vide(void);
 __asm__(".text\n"
 	".globl vide\n"
 	".type vide, @function\n"
 	".align 4\n"
 	"vide: ret\n");
+#endif
 
 static void init_amd_k5(struct cpuinfo_x86 *c)
 {
-- 
2.20.1

