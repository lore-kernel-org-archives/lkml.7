Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D01BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695332084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BbDjFob9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbfCAP3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:29:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34150 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCAP3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:29:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id a15so14498015qkc.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 07:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rUiNJkmLB2B4+cU0nflHVTHv5G+KzvxHN2t9SThrW7Q=;
        b=BbDjFob96QrQvvJlPKFBM/1FPM0JZEMTW1zK4JpvLdWZnIFDLR3eH7GMbwBzcgfzC4
         Vn0zrH+iVY236UpYXOeR/MrvCRjMZtBAHtulqc3sWEP4qjMdyzeFNpgia4MMMOLUkBZo
         shiPW84FrenIKk4dznFxk+uYug6Jk/PdMyIuKW1Gio4ggs1FJHW71MzYSSaijIF9G0bD
         jSA1jyDzBKEH7CYJm6BiJ8nJGFODS3GkwlQrUiqIX4crekEjiex4x/ME7AYxSI7aKmng
         abcGlY+1W01MmkQamogJ3djbc8IKBh52fSqbZ+k6QyP8uKAKa2TtCh6fafmRkF6tOU7u
         shkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rUiNJkmLB2B4+cU0nflHVTHv5G+KzvxHN2t9SThrW7Q=;
        b=liLd2N9bAYuxUAX0MOVUzvq5bVK/YLOOZnfUWCsv2nW2FBhIZldzfOzSbC36qATF5Q
         sFngMUAru9N06+XRvKJMSVMEDODy0RyxYMJKLYtsWlSUdk5ZeIRjcS50Qi5TPcJWB4Vk
         1fhYmfAFxj7Q84DOVgryQzXhHYbxmIK5KANUjPjKdirbi88AHm6bQyzWRHDnJ+BIsRy3
         rrA+k+heKPFpnqwQdL3JeBR5xtUQgzY4acFfNPT13ObTr/jIXsJlcZyFuABv2iL9ooiw
         aCksDuaUSQr6fxteSw/2oPojlL8P01sZHXXmdAShIju0AZsj7Q6QNkygAbBRIgG64Swt
         hcZw==
X-Gm-Message-State: APjAAAWKFvkWSj1woKBD7fMXPR73LGyoomHHw2kofdvhRB2lcj1FCJ0Y
        QLzHOXO20QFdQ6C8A8jH9Dq97A==
X-Google-Smtp-Source: APXvYqxzxBRaB/61PVqlriwGJZVamZIphRGkxyPdsbTCQylKSwY3bFIjvnI78nY2nUKfXs2mvFeC3A==
X-Received: by 2002:a37:dc04:: with SMTP id v4mr4184122qki.197.1551454184234;
        Fri, 01 Mar 2019 07:29:44 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t129sm11462756qkd.16.2019.03.01.07.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 07:29:43 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     toshi.kani@hpe.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] x86/mm: fix "old_pte" set but not used
Date:   Fri,  1 Mar 2019 10:29:24 -0500
Message-Id: <20190301152924.94762-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3a19109efbfa ("x86/mm: Fix try_preserve_large_page() to
handle large PAT bit") fixed try_preserve_large_page() by using the
corresponding pud/pmd prot/pfn interfaces, but left a variable unused
because it no longer used pte_pfn().

Later, the commit 8679de0959e6 ("x86/mm/cpa: Split, rename and clean up
try_preserve_large_page()") renamed try_preserve_large_page() to
__should_split_large_page(), but the unused variable remains.

arch/x86/mm/pageattr.c: In function '__should_split_large_page':
arch/x86/mm/pageattr.c:741:17: warning: variable 'old_pte' set but not
used [-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: improve the commit message.

 arch/x86/mm/pageattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 14e6119838a6..4c570612e24e 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -738,7 +738,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 {
 	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
-	pte_t new_pte, old_pte, *tmp;
+	pte_t new_pte, *tmp;
 	enum pg_level level;
 
 	/*
@@ -781,7 +781,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	 * Convert protection attributes to 4k-format, as cpa->mask* are set
 	 * up accordingly.
 	 */
-	old_pte = *kpte;
+
 	/* Clear PSE (aka _PAGE_PAT) and move PAT bit to correct position */
 	req_prot = pgprot_large_2_4k(old_prot);
 
-- 
2.17.2 (Apple Git-113)

