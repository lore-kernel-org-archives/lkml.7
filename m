Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214DC3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C3C2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HYBnUyoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfHOUxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:53:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39368 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732720AbfHOUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:53:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so3818037qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSpVZiPBrGYAUGx+Ea3a4Y0npIYaRGCqHD40eUQBGCU=;
        b=HYBnUyoVPsBJvVkswIQnogJxrcbVs8FykxsadpD+OBBcZSLXZY31yp6SetRVZSo3gw
         pXzFGNahpp430zsf6TO5hgqAge4ytAHZkg3cz+qsLurhE/NR2LeM/v5U35AorKka9gOm
         F0/agF8rX0XtBCdT4/DrAcB6EFxp+zi7TzRss7TkheyzTzqRpE6DOQzim91W1HXcSLOE
         wbTK2OuQvyTNEOSMn5Q8UkH9VBs/SMEVMpdybq9m9vQdnq1OEvPmmwCNhZn9WugTWoTF
         SFcCB60AjKm8JKJrM2UOHkhWHNhcfq764HCA8eZz6beZKGzsZJxEXd1W7upwpenkYYWx
         fjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSpVZiPBrGYAUGx+Ea3a4Y0npIYaRGCqHD40eUQBGCU=;
        b=dzi3VsSsY1fIIpL/s4kcG8NJzjjHm2De/nS83zyiw6Anl99Y3oNdRH5uLituUuBtHL
         PYEWK3XJ+3yHLWr0F8GfTM9M+OEDqMCPgAM18DmkW5rQTqeiHXdy07DC1hrBcjmYfwnX
         tnQxh4IuqI2R3idGSGWOl5ULRYDRBRvZKlv/Fsf3cYLHF79QpBNN9PNmOZvVU9coyuyY
         lejZszbUdCMkeBpeRw70fp1OnbRSvQ6S0u5aSxVUIz52iTNwzAQY8CvQd9EOx/0Zc2w+
         l5gYz16ko/W+4X4s9YOpNK1pSIQPTutciXnheFx7qQh21yjVQkIcjpVdB496ZZGbjxj8
         /SbA==
X-Gm-Message-State: APjAAAW/qvSVlhsTEiyXhudsiAOrU42igj+by1YsUnYFQpqvJXbp+jJw
        3vROdzPgZdbqnIEltO2IWS9hWw==
X-Google-Smtp-Source: APXvYqzbXNyNwRv677yBKxMuVBmtR2yPqIKJwxHbRYZPkBY8ioVL+BuHkgNtj5ndJuuFzEJngE7PkQ==
X-Received: by 2002:a0c:b0ef:: with SMTP id p44mr4599552qvc.27.1565902413583;
        Thu, 15 Aug 2019 13:53:33 -0700 (PDT)
Received: from ovpn-122-72.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x3sm1991828qkl.71.2019.08.15.13.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 13:53:33 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux@roeck-us.net, kirill.shutemov@linux.intel.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] parisc: fix compilation errrors
Date:   Thu, 15 Aug 2019 16:53:05 -0400
Message-Id: <20190815205305.1382-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 0cfaee2af3a0 ("include/asm-generic/5level-fixup.h: fix
variable 'p4d' set but not used") converted a few functions from macros
to static inline, which causes parisc to complain,

In file included from ./include/asm-generic/4level-fixup.h:38:0,
                 from ./arch/parisc/include/asm/pgtable.h:5,
                 from ./arch/parisc/include/asm/io.h:6,
                 from ./include/linux/io.h:13,
                 from sound/core/memory.c:9:
./include/asm-generic/5level-fixup.h:14:18: error: unknown type name
'pgd_t'; did you mean 'pid_t'?
 #define p4d_t    pgd_t
                  ^
./include/asm-generic/5level-fixup.h:24:28: note: in expansion of macro
'p4d_t'
 static inline int p4d_none(p4d_t p4d)
                            ^~~~~

It is because "4level-fixup.h" is included before "asm/page.h" where
"pgd_t" is defined.

Fixes: 0cfaee2af3a0 ("include/asm-generic/5level-fixup.h: fix variable 'p4d' set but not used")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/parisc/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index a39b079e73f2..6d58c1739b42 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -2,6 +2,7 @@
 #ifndef _PARISC_PGTABLE_H
 #define _PARISC_PGTABLE_H
 
+#include <asm/page.h>
 #include <asm-generic/4level-fixup.h>
 
 #include <asm/fixmap.h>
@@ -98,8 +99,6 @@ static inline void purge_tlb_entries(struct mm_struct *mm, unsigned long addr)
 
 #endif /* !__ASSEMBLY__ */
 
-#include <asm/page.h>
-
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
-- 
2.20.1 (Apple Git-117)

