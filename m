Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F733C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3256A2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bmuBwTTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfGVIW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:22:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34695 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfGVIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:22:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8MphL3738614
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:22:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8MphL3738614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563783771;
        bh=do8rKCgK34eZi9UvSjJY/LddM6qNTjKJd+DgwItJOvo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bmuBwTTSt1jO7He7hw6KJR7ljuEgEu0oOQfvRu1WKRjm8jtYSvCVQgjGhhkgbEwYx
         xv2QQcvCpS7bbEX4Vukfh2BkKlFEYsxbiBGv2hwJvZ+wvvq0RTXc5GWnCGcnsIEAKm
         12fSVNKgH/VpFIax1AzUv/8YBjBY7qQikYMOtj3FpTDz4nbm8W56n+0Q07ZTOePyTw
         r/0JawLYWX17qLnzAPgdd1/V2rkWo0YwzoYN87+i6unwIkqMqKoPohfCZSKbKn/2UD
         hcpC9JUtpJjKoG4onWBhZ1QqWlO3HhCmc96Z40tDzPOJttCG5KleyXl2tkIEQm7w3b
         9MhD5R6wwGucQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8Mo353738611;
        Mon, 22 Jul 2019 01:22:50 -0700
Date:   Mon, 22 Jul 2019 01:22:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-8e998fc24de47c55b47a887f6c95ab91acd4a720@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jroedel@suse.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, jroedel@suse.de,
          dave.hansen@linux.intel.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190719184652.11391-3-joro@8bytes.org>
References: <20190719184652.11391-3-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Sync also unmappings in vmalloc_sync_all()
Git-Commit-ID: 8e998fc24de47c55b47a887f6c95ab91acd4a720
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

Commit-ID:  8e998fc24de47c55b47a887f6c95ab91acd4a720
Gitweb:     https://git.kernel.org/tip/8e998fc24de47c55b47a887f6c95ab91acd4a720
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Fri, 19 Jul 2019 20:46:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:18:30 +0200

x86/mm: Sync also unmappings in vmalloc_sync_all()

With huge-page ioremap areas the unmappings also need to be synced between
all page-tables. Otherwise it can cause data corruption when a region is
unmapped and later re-used.

Make the vmalloc_sync_one() function ready to sync unmappings and make sure
vmalloc_sync_all() iterates over all page-tables even when an unmapped PMD
is found.

Fixes: 5d72b4fba40ef ('x86, mm: support huge I/O mapping capability I/F')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20190719184652.11391-3-joro@8bytes.org

---
 arch/x86/mm/fault.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e64173db4970..9ceacd1156db 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -177,11 +177,12 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 
 	pmd = pmd_offset(pud, address);
 	pmd_k = pmd_offset(pud_k, address);
-	if (!pmd_present(*pmd_k))
-		return NULL;
 
-	if (!pmd_present(*pmd))
+	if (pmd_present(*pmd) != pmd_present(*pmd_k))
 		set_pmd(pmd, *pmd_k);
+
+	if (!pmd_present(*pmd_k))
+		return NULL;
 	else
 		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
 
@@ -203,17 +204,13 @@ void vmalloc_sync_all(void)
 		spin_lock(&pgd_lock);
 		list_for_each_entry(page, &pgd_list, lru) {
 			spinlock_t *pgt_lock;
-			pmd_t *ret;
 
 			/* the pgt_lock only for Xen */
 			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
 
 			spin_lock(pgt_lock);
-			ret = vmalloc_sync_one(page_address(page), address);
+			vmalloc_sync_one(page_address(page), address);
 			spin_unlock(pgt_lock);
-
-			if (!ret)
-				break;
 		}
 		spin_unlock(&pgd_lock);
 	}
