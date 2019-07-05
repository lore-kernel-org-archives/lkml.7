Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED82FC468A7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EA4216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfGES4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 14:56:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfGES4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 14:56:16 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MFL8J-1hlPCN00kL-00FjKe; Fri, 05 Jul 2019 20:56:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@kernel.org
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [STABLE backport 4.9] arm64, vdso: Define vdso_{start,end} as array
Date:   Fri,  5 Jul 2019 20:55:50 +0200
Message-Id: <20190705185558.3655220-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9JINqZTxsunxdoxm0iUUSQeQ4/ecEkdB/hce9tuBRM0t29UkQyB
 lwdaoYveWTZgF/lUUJRSrqK5WYjQEc/k/B3bNFv2gb4NGga/CJxMU+NjQfEXT5gqJQt5kuo
 ZIons8w8mls3aB9ApHEnSFneR8RVUzIEHFM6caPOzmfKpEPQ4qNwFkjikgCKvQzq8szf9bK
 I3Y3ygKkOawd/NWlaivqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qLH4Ljn1ftU=:7RYumwgeDzndatUw45Gd63
 ankahKZDnMs8XbshANZqkIXJWYw+tKq4O4ySHlOhOuVekatL3/OZ/PWpMIvepxQ4jYTTseMAL
 D2Lwf7INkibOSaGg1/Eoo8ClWXQZ12MdSGun7BrflypAZjXnuqosuMtplMwTkdld2cC5YvLBW
 tYlqcXqfkzMqdcOUpgY40AxRWxkOJj0UZmHF8S2NJqLZp9ako89YdArPE/qAdr0SdM/Xg8mDs
 mMzCZm5VXJbwjskhasHVFRiwYeV3GjBST+hyfwOQ7Frd9Ailqn8DVpZ8dOEIb+VfifAt4Hlz0
 uMLvUpts4xuJFepYSagTZ67NegJrBfAKgVMqeXQGMnzUkK4JqzgpHK/VXRDxeeiiQa+g5Pg7C
 l1MWXr7PQA8AHZc1nTuYg39Ko3PbZJCNKLQZhSy6sTrPLggOQMH9Hdeg3annYY9dbfdgD+Yye
 l7aLSJRiCfUZA53vI51/eLHzCgsVXqAODgvOY+pe2nfVGqElXrv+JTu67RB9Rh3AwhQfBWbrO
 hKbKPCPGB0jPqkFh9DVefMw+lIx75MwDOF5zJJRflQRB+c1+v7Y0R+wj/bKLkVh2hvmgHcyBA
 q1I63aheIZu2AoC+NUmOJtYCq7eTp9TvPDcHzuuP5T9LbqdHsZVUEE9KUj6ibgdS+xOb48tai
 PtDKRxILS9xvJAIvdeesvCglw1pGNbAYZApVwMXppFEHlyzfXN4hnMHpwK2z9Gputf6thSCEK
 ZTG6x/wWfQPWxr+ozBXhNhAklu9pxcSE9y/Gsw==
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
Backported to 4.4, which predates the rework from
2077be6783b5 ("arm64: Use __pa_symbol for kernel symbols") and
5a9e3e156ec1 ("arm64: apply __ro_after_init to some objects")
---
 arch/arm64/kernel/vdso.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 97bc68f4c689..908bc5ab94c1 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -36,7 +36,7 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-extern char vdso_start, vdso_end;
+extern char vdso_start[], vdso_end[];
 static unsigned long vdso_pages;
 static struct page **vdso_pagelist;
 
@@ -115,14 +115,14 @@ static int __init vdso_init(void)
 {
 	int i;
 
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
@@ -135,7 +135,7 @@ static int __init vdso_init(void)
 
 	/* Grab the vDSO code pages. */
 	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = virt_to_page(&vdso_start + i * PAGE_SIZE);
+		vdso_pagelist[i + 1] = virt_to_page(vdso_start + i * PAGE_SIZE);
 
 	/* Populate the special mapping structures */
 	vdso_spec[0] = (struct vm_special_mapping) {
-- 
2.20.0

