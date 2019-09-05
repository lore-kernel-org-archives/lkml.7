Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE94C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFC92145D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390712AbfIEPoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390539AbfIEPno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 818032196F;
        Thu,  5 Sep 2019 15:43:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvD-0007bN-1z; Thu, 05 Sep 2019 11:43:43 -0400
Message-Id: <20190905154342.948420209@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [for-next][PATCH 19/25] recordmcount: Kernel style formatting
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Helsley <mhelsley@vmware.com>

Fix up the whitespace irregularity in the ELF switch
blocks.

Swapping the initial value of gpfx allows us to
simplify all but one of the one-line switch cases even
further.

Link: http://lkml.kernel.org/r/647f21f43723d3e831cedd3238c893db03eea6f0.1564596289.git.mhelsley@vmware.com

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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


