Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD01C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ABE21F26
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aPmQCUAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfGVIWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:22:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfGVIWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:22:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8M7Qx3738567
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:22:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8M7Qx3738567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563783727;
        bh=nFpwrdz1VhHsf706FAhPrB/XMWMkiW2mKtHJjosrQXY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aPmQCUAh30tRZ++lBoVTQZ1sohn72DmxY/m1d30G6yZdY/MaVEuuIlk0tHNzcXI3D
         T0xCGS9zO80fIKRV2DJQUD00cy1PSKZ2JuhqaRUuyWTHFyFPjDFXJI4ahbTu8x9rI+
         yvuFIbRcOB07qpEhjtzicTP9mCx6yDlWLLS8NrZv9axUctqxb5ANcvs7932tVfAFbX
         UDYDH50Rqv+OUrIeW05G6+EPvvtsPeoaCslrNHHEtFoxvOOI/O4wrz/KwRfcRKSU+d
         T6Ojb0DmKR/FPMLiMz4tdTCCPmLhDA+IMccvWCRoHSr7wJZEXE9ToCZAkMXz9bK8wb
         UxBbeSgFo3/Og==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8M6aC3738564;
        Mon, 22 Jul 2019 01:22:06 -0700
Date:   Mon, 22 Jul 2019 01:22:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-51b75b5b563a2637f9d8dc5bd02a31b2ff9e5ea0@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        jroedel@suse.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          jroedel@suse.de, linux-kernel@vger.kernel.org,
          dave.hansen@linux.intel.com
In-Reply-To: <20190719184652.11391-2-joro@8bytes.org>
References: <20190719184652.11391-2-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Check for pfn instead of page in
 vmalloc_sync_one()
Git-Commit-ID: 51b75b5b563a2637f9d8dc5bd02a31b2ff9e5ea0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  51b75b5b563a2637f9d8dc5bd02a31b2ff9e5ea0
Gitweb:     https://git.kernel.org/tip/51b75b5b563a2637f9d8dc5bd02a31b2ff9e5ea0
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Fri, 19 Jul 2019 20:46:50 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:18:30 +0200

x86/mm: Check for pfn instead of page in vmalloc_sync_one()

Do not require a struct page for the mapped memory location because it
might not exist. This can happen when an ioremapped region is mapped with
2MB pages.

Fixes: 5d72b4fba40ef ('x86, mm: support huge I/O mapping capability I/F')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20190719184652.11391-2-joro@8bytes.org

---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6c46095cd0d9..e64173db4970 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -183,7 +183,7 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	if (!pmd_present(*pmd))
 		set_pmd(pmd, *pmd_k);
 	else
-		BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
+		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
 
 	return pmd_k;
 }
