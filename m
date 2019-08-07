Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A5EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201C621BE3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfHGND2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:03:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfHGND2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:03:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DB24AD17;
        Wed,  7 Aug 2019 13:03:27 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] x86/kconfig: remove X86_DIRECT_GBPAGES dependency on !DEBUG_PAGEALLOC
Date:   Wed,  7 Aug 2019 15:02:58 +0200
Message-Id: <20190807130258.22185-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These days CONFIG_DEBUG_PAGEALLOC just compiles in the code that has to be
enabled on boot time, or with an extra config option, and only then are the
large page based direct mappings disabled.

Therefore remove the config dependency, allowing 1GB direct mappings with
debug_pagealloc compiled in but not enabled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..58eae28c3dd6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1503,7 +1503,7 @@ config X86_5LEVEL
 
 config X86_DIRECT_GBPAGES
 	def_bool y
-	depends on X86_64 && !DEBUG_PAGEALLOC
+	depends on X86_64
 	---help---
 	  Certain kernel features effectively disable kernel
 	  linear 1 GB mappings (even if the CPU otherwise
-- 
2.22.0

