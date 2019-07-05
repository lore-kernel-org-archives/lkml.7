Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C7FC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BB720989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGESrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 14:47:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56029 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGESrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 14:47:47 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MVMqF-1i83313Aox-00SRHt; Fri, 05 Jul 2019 20:47:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@kernel.org
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [STABLE backport 4.9] arm64, vdso: Define vdso_{start,end} as array
Date:   Fri,  5 Jul 2019 20:47:20 +0200
Message-Id: <20190705184726.3221252-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J9Iu2hOBd57Q5rq9Xf8IC+BxgXaa2P4hpSWsU2FjYCLv76+DrHz
 8Om4XxSDxit042SEcgbBJojWhWuX3ms8kLLZ0IhZVAbWrjfxqn/8obfIUTFBf1tZGfwY9Tq
 7O71ICLIT6PSSmGFd3yFRqb/wvZHg9z8RoO6UK3B2dchqEXvDIwdj8MpDQWj0ZOA7iGOaiD
 WYtZrPmhiPbCFUe9IOhPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7nP5IUNxmBg=:GluX+cDzMCpvsK0wDxyVon
 hxx8ZemSFuhMU8FOCAU/vUcHFfErh+a2DLTfZEhFl09E4ech10S/X/pne8GbU4hJO4wtlZfxW
 B4xr453d2QYywoHHI6WtnmE7H2elddWjcM+dJPmoZyAyr3/GXEL2Ta7YcPmPzccTT60Ty/5c8
 cpXO64PMiM3/wbUVPR2rCUeJ3+lPAEPFl5H/CKaARIBV4YB1U+O4UMxhGE+F9WZJUfZnyunmo
 jRCWnqQzSdgQlU3kySHD3z4s9t2UK4BfHlMUhbqHzRAoII2EkfxJaeCXGdmkmsGyx78CQY/zg
 TIo5SuwFnGiz+3dIPONQZ1ACL8L3H6xXCRqopgNvt+ComAfC10aDVqsOR/0CmeowEOXNmjpzJ
 UujOFG9NFzJpbDvP/0xYmkDWe5PdcMJbbs7+gcla2IrT5yXdy8Hxk1tJl2GUe3sqZlSfgfAh/
 zBPzcttmBhtgOzvHPGwKUQJVNznDlhPC32eXWN9rrnLQsXe3PlcRIVsun8DpKpzeltTsXcSvE
 5PrBozokZucix/q5igEZRSmSVjqRt+63Nq/3BPJ7ZBb85bbl2NOF9lFxs8WCloOmtTDGeSbOc
 cgwjb3uPJwwdEHFg5+KMGCbnYpDchMfGCjoKbtvYsF2lQAxTUO2hefGi3iSnrPV4TAGmswqmb
 xD5Br6J0U0edvnGCYSx5cp0OF+UJ8EiVdQcw8rlsh7mb9J8TG0C2xmPLgFHKb/9XITIjRIhi3
 Qzf7LN/AO0fw4ug5SdTqBMco7djdJGL32gblgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Commit dbbb08f500d6146398b794fdc68a8e811366b451 upstream.

Adjust vdso_{start|end} to be char arrays to avoid compile-time analysis
that flags "too large" memcmp() calls with CONFIG_FORTIFY_SOURCE.

Cc: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Backported to 4.9, which is lacking the rework from
2077be6783b5 ("arm64: Use __pa_symbol for kernel symbols")
---
 arch/arm64/kernel/vdso.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index c9b9a5a322eb..c0f315ecfa7c 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -37,7 +37,7 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-extern char vdso_start, vdso_end;
+extern char vdso_start[], vdso_end[];
 static unsigned long vdso_pages __ro_after_init;
 
 /*
@@ -124,14 +124,14 @@ static int __init vdso_init(void)
 	int i;
 	struct page **vdso_pagelist;
 
-	if (memcmp(&vdso_start, "\177ELF", 4)) {
+	if (memcmp(vdso_start, "\177ELF", 4)) {
 		pr_err("vDSO is not a valid ELF object!\n");
 		return -EINVAL;
 	}
 
-	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
 	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, &vdso_start, 1L, vdso_data);
+		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
 
 	/* Allocate the vDSO pagelist, plus a page for the data. */
 	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
@@ -144,7 +144,7 @@ static int __init vdso_init(void)
 
 	/* Grab the vDSO code pages. */
 	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa(&vdso_start)) + i);
+		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa(vdso_start)) + i);
 
 	vdso_spec[0].pages = &vdso_pagelist[0];
 	vdso_spec[1].pages = &vdso_pagelist[1];
-- 
2.20.0

