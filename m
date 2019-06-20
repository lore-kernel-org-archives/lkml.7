Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBFEC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033CB2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="TvNlbhsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfFTLY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:24:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38621 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfFTLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:24:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so4205119edo.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjM0cV/bj1P72dFe0nedZsKK4znRV88KKfVEX7k49WY=;
        b=TvNlbhsxVxOOqpPMrv/TSKNadKbnq/OOB32FLW8FOsWPBI+zHlAs3XT0wYYg4pjcod
         ghodAtJ9UyrWY+galSIg2HhrrzFJFoa+Nf/SOkwnaFgYEbjZWT7lqrZhkOa0Y7LTYbAj
         PM1KPPcHsP2gJmjrijblAneAds+cNGf3Pk7K0HkbYTx+HjM61HuR+/Yd5qfL+XKjQ9Bd
         KJeUb2yQ3CmE261znSts/ye4KC5y8/e37XoNqAk7CMnupNB+2s1pIQ7RlpkB1bGR5f8U
         WwmLCZYfuXvK+XbxzAV67OetxoiibSXHH3KLcaccHM6XeUK5nKmplvo1Ua0vg2+LtsGU
         4zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjM0cV/bj1P72dFe0nedZsKK4znRV88KKfVEX7k49WY=;
        b=mj1IlB/Iyk0adhYMemb3XPOeMlvfzqr4KXkuLG/HAMPO9iyGwOf/fKT/xPrLmD/TSu
         GK10JOBFImcfkopJXMcbt3RtRmJ5K7KXvsFy10j9bLAd9Z63Xp/wjlgQKm9QJCgDXVbg
         UUUZZ49AAutrlM5qiQ+L/iJAUpBwLJGQg633heJMqoqa62L4rUp3inTf3BAQhgkozVvZ
         HEak3X/jOii1xlYFa4W92fEBIdRYJFyoH2WJjcJLlf5RAWNNdCxP8ezbT5o7fvr+DM9h
         5qD1G8a5RXhpsF6GGBzFYMqkjuVfdW30GtwQdBVq4q7hLaDOTS5QL5VKBbSgXylhuXzT
         GvSA==
X-Gm-Message-State: APjAAAXYOKSD78+bwK5WiI8TpSza3TqFXOK5RW06D6U8Pkq9ubbtef6D
        FBzBpcV3/NR6IAPShWv45xNpXw==
X-Google-Smtp-Source: APXvYqxjOnXArZRjN7nJvFwzbquqB+n5nJGhIi+Izhsa0OZPDtvs3ljpYNfxEDpaVMv3ztyfFodH6Q==
X-Received: by 2002:a50:a544:: with SMTP id z4mr1460519edb.71.1561029864584;
        Thu, 20 Jun 2019 04:24:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o93sm6508189edd.46.2019.06.20.04.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 04:24:23 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 333F31040F8; Thu, 20 Jun 2019 14:24:25 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH] x86/boot/64: Fix missed fixup_pointer() for next_early_pgt access
Date:   Thu, 20 Jun 2019 14:24:22 +0300
Message-Id: <20190620112422.29264-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__startup_64() uses fixup_pointer() to access global variables in a
position-independent fashion. Access to next_early_pgt was wrapped into
the helper, but one of the instance in 5-level paging branch was missed.

GCC generates a R_X86_64_PC32 PC-relative relocation for the access
which doesn't trigger the issue, but Clang emmits a R_X86_64_32S which
leads to an invalid memory and system reboot.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 187e91fe5e91 ("x86/boot/64/clang: Use fixup_pointer() to access 'next_early_pgt'")
Cc: Alexander Potapenko <glider@google.com>
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 16b1cbd3a61e..4d98ba8063d1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -184,7 +184,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(early_dynamic_pgts[next_early_pgt++], physaddr);
+		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
-- 
2.21.0

