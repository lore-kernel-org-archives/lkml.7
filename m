Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96875C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B76218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404017AbfHHKkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:40:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:47422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403836AbfHHKjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27BB1B05E;
        Thu,  8 Aug 2019 10:39:06 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v8 14/28] xen/pvh: annotate data appropriatelly
Date:   Thu,  8 Aug 2019 12:38:40 +0200
Message-Id: <20190808103854.6192-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new SYM_DATA_START_LOCAL, and SYM_DATA_END* macros to have:
  0000     8 OBJECT  LOCAL  DEFAULT    6 gdt
  0008    32 OBJECT  LOCAL  DEFAULT    6 gdt_start
  0028     0 OBJECT  LOCAL  DEFAULT    6 gdt_end
  0028   256 OBJECT  LOCAL  DEFAULT    6 early_stack
  0128     0 OBJECT  LOCAL  DEFAULT    6 early_stack

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/platform/pvh/head.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 1f8825bbaffb..4e63480bb223 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -150,11 +150,12 @@ END(pvh_start_xen)
 
 	.section ".init.data","aw"
 	.balign 8
-gdt:
+SYM_DATA_START_LOCAL(gdt)
 	.word gdt_end - gdt_start
 	.long _pa(gdt_start)
 	.word 0
-gdt_start:
+SYM_DATA_END(gdt)
+SYM_DATA_START_LOCAL(gdt_start)
 	.quad 0x0000000000000000            /* NULL descriptor */
 #ifdef CONFIG_X86_64
 	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* PVH_CS_SEL */
@@ -163,15 +164,14 @@ gdt_start:
 #endif
 	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* PVH_DS_SEL */
 	.quad GDT_ENTRY(0x4090, 0, 0x18)    /* PVH_CANARY_SEL */
-gdt_end:
+SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
-canary:
-	.fill 48, 1, 0
+SYM_DATA_LOCAL(canary, .fill 48, 1, 0)
 
-early_stack:
+SYM_DATA_START_LOCAL(early_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
-early_stack_end:
+SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
 
 	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
 	             _ASM_PTR (pvh_start_xen - __START_KERNEL_map))
-- 
2.22.0

