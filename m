Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB81C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D40279DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YcLh+vQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfFCNAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:00:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFCNAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:00:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53CxlDD601575
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 05:59:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53CxlDD601575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559566788;
        bh=sR4mY6kMBnO2Amto5Pvlrw0vCfovaVTLDM/RnUHkBu4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YcLh+vQPYmGYcB8uGb/DBuxS9zfI7s4dddISAYOkEg410+7PdiKcekX73qUq1Mn92
         9C/TPrRSMN0VAwW+8J9NsBULEjiSaOMMtjHFUATzc/M1lYT6FxROB7vDw1P+B3Q92u
         /i3FeBXF1k+FGiSS7sfIqx47uA5btmrNKO0mO1vkjYPrXWcnd8bJnbSrdBDiltb373
         8XZ35b1ctXxMNUxKxFm193SL0PhqNhYLBLqqoninCJpVGFj7CRKaK09IWJxNQS2kXH
         br2v7R4p0uXNpmTZ28pTgH84kJogkiEIUJ7i1QAn2LOuLgdOQ69w87mKVI7y9ceX78
         9NesV4RItoUPQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53Cxkjo601572;
        Mon, 3 Jun 2019 05:59:46 -0700
Date:   Mon, 3 Jun 2019 05:59:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rick Edgecombe <tipbot@zytor.com>
Message-ID: <tip-31e67340cc65edfd9dac5ef26f81de8414ce5906@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, mroos@linux.ee,
        dave.hansen@intel.com, luto@kernel.org, bp@alien8.de,
        rick.p.edgecombe@intel.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, hpa@zytor.com, davem@davemloft.net,
        peterz@infradead.org, namit@vmware.com, tglx@linutronix.de
Reply-To: mroos@linux.ee, linux-kernel@vger.kernel.org, mingo@kernel.org,
          luto@kernel.org, dave.hansen@intel.com,
          torvalds@linux-foundation.org, rick.p.edgecombe@intel.com,
          akpm@linux-foundation.org, bp@alien8.de, tglx@linutronix.de,
          namit@vmware.com, peterz@infradead.org, hpa@zytor.com,
          davem@davemloft.net
In-Reply-To: <20190527211058.2729-3-rick.p.edgecombe@intel.com>
References: <20190527211058.2729-3-rick.p.edgecombe@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] mm/vmalloc: Avoid rare case of flushing TLB with
 weird arguments
Git-Commit-ID: 31e67340cc65edfd9dac5ef26f81de8414ce5906
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

Commit-ID:  31e67340cc65edfd9dac5ef26f81de8414ce5906
Gitweb:     https://git.kernel.org/tip/31e67340cc65edfd9dac5ef26f81de8414ce5906
Author:     Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate: Mon, 27 May 2019 14:10:58 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:47:25 +0200

mm/vmalloc: Avoid rare case of flushing TLB with weird arguments

In a rare case, flush_tlb_kernel_range() could be called with a start
higher than the end.

In vm_remove_mappings(), in case page_address() returns 0 for all pages
(for example they were all in highmem), _vm_unmap_aliases() will be
called with start = ULONG_MAX, end = 0 and flush = 1.

If at the same time, the vmalloc purge operation is triggered by something
else while the current operation is between remove_vm_area() and
_vm_unmap_aliases(), then the vm mapping just removed will be already
purged. In this case the call of vm_unmap_aliases() may not find any other
mappings to flush and so end up flushing start = ULONG_MAX, end = 0. So
only set flush = true if we find something in the direct mapping that we
need to flush, and this way this can't happen.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Meelis Roos <mroos@linux.ee>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 868b104d7379 ("mm/vmalloc: Add flag for freeing of special permsissions")
Link: https://lkml.kernel.org/r/20190527211058.2729-3-rick.p.edgecombe@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 mm/vmalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93b2dca2aadb..4c9e150e5ad3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2125,6 +2125,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 {
 	unsigned long start = ULONG_MAX, end = 0;
 	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
+	int flush_dmap = 0;
 	int i;
 
 	/*
@@ -2163,6 +2164,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 		if (addr) {
 			start = min(addr, start);
 			end = max(addr + PAGE_SIZE, end);
+			flush_dmap = 1;
 		}
 	}
 
@@ -2172,7 +2174,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	 * reset the direct map permissions to the default.
 	 */
 	set_area_direct_map(area, set_direct_map_invalid_noflush);
-	_vm_unmap_aliases(start, end, 1);
+	_vm_unmap_aliases(start, end, flush_dmap);
 	set_area_direct_map(area, set_direct_map_default_noflush);
 }
 
