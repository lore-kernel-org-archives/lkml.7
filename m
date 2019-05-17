Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8982AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00450206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LZNk7Xov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfEQGuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 02:50:09 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:52613 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfEQGuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 02:50:08 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x4H6nWQD001015;
        Fri, 17 May 2019 15:49:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x4H6nWQD001015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558075773;
        bh=N1B2j8YTLhqQwcpZvsbGQ/rqXqS3XcNo6ROsyEynx48=;
        h=From:To:Cc:Subject:Date:From;
        b=LZNk7XovCLIA/bkEo6VNizTpoEvpmo5lFBNWowQJHJefloaGu5KxW5l878vpMWSz2
         HVFz2xYL7AsO6cFu9z1DJLdERlIdT84bU2dJ7aqG6QLvU615/LfYDpShUXM63nfDrj
         9N50haB7RV10KMy9mvoDjx04sViO5TrdheoozQkNY1Ry2SIGG+AYmNC8w955sTM9FN
         ezqFIUz8La7izHgU6YUSToj/MzZQXN0sLpI8OFVPoKfjeg0j1KB8gIB1XNVkc5rEXk
         SGfJywUELWcNdagBjcZnujUo8zQ3z54PFXQ5ejnw9+hFtMkeZBFncKCYl32ePxlqDw
         Z9cbJjWHMQ0FA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Philipp Rudo <prudo@linux.ibm.com>
Subject: [PATCH] s390: add unreachable() to dump_fault_info() to fix -Wmaybe-uninitialized
Date:   Fri, 17 May 2019 15:49:22 +0900
Message-Id: <20190517064922.22743-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OPTIMIZE_INLINING is enabled for s390, I see this warning:

arch/s390/mm/fault.c:127:15: warning: 'asce' may be used uninitialized in this function [-Wmaybe-uninitialized]
  switch (asce & _ASCE_TYPE_MASK) {
arch/s390/mm/fault.c:177:16: note: 'asce' was declared here
  unsigned long asce;
                ^~~~

If get_fault_type() is not inlined, the compiler cannot deduce that
all the possible paths in the 'switch' statement are covered.

Of course, we could mark get_fault_type() as __always_inline to get
back the original behavior, but I do not think it sensible to force
inlining just for the purpose of suppressing the warning. Since this
is just a matter of warning, I want to keep as much room for compiler
optimization as possible.

I added unreachable() to teach the compiler that the 'default' label
is unreachable.

I got rid of the 'inline' marker. Even without the 'inline' hint,
the compiler inlines functions based on its inlining heuristic.

Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/mm/fault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index c220399ae196..91ce03fd0c84 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -85,7 +85,7 @@ static inline int notify_page_fault(struct pt_regs *regs)
  * Find out which address space caused the exception.
  * Access register mode is impossible, ignore space == 3.
  */
-static inline enum fault_type get_fault_type(struct pt_regs *regs)
+static enum fault_type get_fault_type(struct pt_regs *regs)
 {
 	unsigned long trans_exc_code;
 
@@ -211,6 +211,8 @@ static void dump_fault_info(struct pt_regs *regs)
 		asce = S390_lowcore.kernel_asce;
 		pr_cont("kernel ");
 		break;
+	default:
+		unreachable();
 	}
 	pr_cont("ASCE.\n");
 	dump_pagetable(asce, regs->int_parm_long & __FAIL_ADDR_MASK);
-- 
2.17.1

