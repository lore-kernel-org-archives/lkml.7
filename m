Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8250C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AC823400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566496102;
	bh=DlzoR4D5vHmVnrWk8JsBCfUvGrSM6xzpiLEVKImfTjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3Lclu4KmUQZNmsxzm0r6Rs2zUX4pNiM7uGB+3a2DtQ1C6iYWGRVlRasyKT9A5z0S
	 NbIik+JE3N6jGOiP1GW+YnmGOIigr7/UFlCeQYGaWCSGUsOVY15dZkfq2OjE103/wE
	 OI+FzJDFYxfcHFBYnC2WTiq87qnDMyDReHicj8v4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbfHVRsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390153AbfHVRWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:30 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88CED23400;
        Thu, 22 Aug 2019 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494549;
        bh=DlzoR4D5vHmVnrWk8JsBCfUvGrSM6xzpiLEVKImfTjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akx2twHQ4i+hkaX7fvZqkJOvbR2Xix5lE3DaucEIOLMi69/u3YJDDMdkO+yKFqka/
         f8U4JcfVbu7WFU+YSXg0qeorcOkw5aPC+xP1wfdqZwRT3cJLA2gEKq/R6/cWc0GFEn
         CSaZNMgmmz6DeXzu0aQIpZFGmLDN40gFPflRZ4ls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 4.4 04/78] x86/mm: Sync also unmappings in vmalloc_sync_all()
Date:   Thu, 22 Aug 2019 10:18:08 -0700
Message-Id: <20190822171832.173463709@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

commit 8e998fc24de47c55b47a887f6c95ab91acd4a720 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/fault.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -216,11 +216,12 @@ static inline pmd_t *vmalloc_sync_one(pg
 
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
 
@@ -242,17 +243,13 @@ void vmalloc_sync_all(void)
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


