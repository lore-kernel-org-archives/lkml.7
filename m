Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7672C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFE1206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfGaSYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:24:51 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:7789 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729775AbfGaSYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:24:48 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 31 Jul 2019 11:24:35 -0700
Received: from rlwimi.localdomain (unknown [10.166.66.112])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 1C21CB288B;
        Wed, 31 Jul 2019 14:24:39 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v4 6/8] recordmcount: Kernel style formatting
Date:   Wed, 31 Jul 2019 11:24:14 -0700
Message-ID: <647f21f43723d3e831cedd3238c893db03eea6f0.1564596289.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564596289.git.mhelsley@vmware.com>
References: <cover.1564596289.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the whitespace irregularity in the ELF switch
blocks.

Swapping the initial value of gpfx allows us to
simplify all but one of the one-line switch cases even
further.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 scripts/recordmcount.c | 47 ++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 67f9c45b824f..273ca8b42b20 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -489,15 +489,15 @@ static int do_file(char const *const fname)
 		push_bl_mcount_thumb = push_bl_mcount_thumb_be;
 		break;
 	}  /* end switch */
-	if (memcmp(ELFMAG, ehdr->e_ident, SELFMAG) != 0
-	||  w2(ehdr->e_type) != ET_REL
-	||  ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
+	if (memcmp(ELFMAG, ehdr->e_ident, SELFMAG) != 0 ||
+	    w2(ehdr->e_type) != ET_REL ||
+	    ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
 		fprintf(stderr, "unrecognized ET_REL file %s\n", fname);
 		cleanup();
 		goto out;
 	}
 
-	gpfx = 0;
+	gpfx = '_';
 	switch (w2(ehdr->e_machine)) {
 	default:
 		fprintf(stderr, "unrecognized e_machine %u %s\n",
@@ -510,32 +510,35 @@ static int do_file(char const *const fname)
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_32;
 		mcount_adjust_32 = -1;
+		gpfx = 0;
+		break;
+	case EM_ARM:
+		reltype = R_ARM_ABS32;
+		altmcount = "__gnu_mcount_nc";
+		make_nop = make_nop_arm;
+		rel_type_nop = R_ARM_NONE;
+		gpfx = 0;
 		break;
-	case EM_ARM:	 reltype = R_ARM_ABS32;
-			 altmcount = "__gnu_mcount_nc";
-			 make_nop = make_nop_arm;
-			 rel_type_nop = R_ARM_NONE;
-			 break;
 	case EM_AARCH64:
-			reltype = R_AARCH64_ABS64;
-			make_nop = make_nop_arm64;
-			rel_type_nop = R_AARCH64_NONE;
-			ideal_nop = ideal_nop4_arm64;
-			gpfx = '_';
-			break;
-	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
-	case EM_MIPS:	 /* reltype: e_class    */ gpfx = '_'; break;
-	case EM_PPC:	 reltype = R_PPC_ADDR32;   gpfx = '_'; break;
-	case EM_PPC64:	 reltype = R_PPC64_ADDR64; gpfx = '_'; break;
-	case EM_S390:    /* reltype: e_class    */ gpfx = '_'; break;
-	case EM_SH:	 reltype = R_SH_DIR32;                 break;
-	case EM_SPARCV9: reltype = R_SPARC_64;     gpfx = '_'; break;
+		reltype = R_AARCH64_ABS64;
+		make_nop = make_nop_arm64;
+		rel_type_nop = R_AARCH64_NONE;
+		ideal_nop = ideal_nop4_arm64;
+		break;
+	case EM_IA_64:	reltype = R_IA64_IMM64; break;
+	case EM_MIPS:	/* reltype: e_class    */ break;
+	case EM_PPC:	reltype = R_PPC_ADDR32; break;
+	case EM_PPC64:	reltype = R_PPC64_ADDR64; break;
+	case EM_S390:	/* reltype: e_class    */ break;
+	case EM_SH:	reltype = R_SH_DIR32; gpfx = 0; break;
+	case EM_SPARCV9: reltype = R_SPARC_64; break;
 	case EM_X86_64:
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_64;
 		reltype = R_X86_64_64;
 		rel_type_nop = R_X86_64_NONE;
 		mcount_adjust_64 = -1;
+		gpfx = 0;
 		break;
 	}  /* end switch */
 
-- 
2.20.1

