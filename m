Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B14FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72A12083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mYRUpQ85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfCAWUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:20:11 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34697 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCAWUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:20:11 -0500
Received: by mail-qt1-f195.google.com with SMTP id w4so29746474qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 14:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iQozw9AJ+KagTRxIhD3lA5iUQt/T2sO/BmSDzwBmI0I=;
        b=mYRUpQ85kazeSJtNKWBFjpoQ0z+813L+c52GVx7Z1Wbn2Zgloz8PHCIM+/3IWZy8zG
         qcUh6dELXtCb3AckNCC5U4AxmDj+IXsJFnV0nHhJqZFR521wBhKRv7fro7YuxHoU6WKl
         09lIITb1V+71mPeAJKAFPKdyM+Q7O2FGiPchNe0NV7++VqYlOJZj/hgjxQXlHBeaaYxu
         as2BY/iZg4f4BWG3kicSAfmXlzlcmTPTKGNODk741KJQCgrN4VG5C0QnzECzEeI/Kw8q
         QUv/Y3yKe+SimYQk027lH3ynSOmiIpXb/8z5SrkZOvxK2ENEkuOL1rZFAiWHh6zHvv+d
         hJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iQozw9AJ+KagTRxIhD3lA5iUQt/T2sO/BmSDzwBmI0I=;
        b=NiHHextdeO+ga+LqfuiOP1IrcvTw3UjR/Cr/N7Boh0KAsi3i1hnsAVTlGiqi8h1RS9
         4UuTFCiOL3oYkCGwXq2H1tBcMCnAdmjq1MQ+hFBmC8IEtHzEeRfWivkrAT5NaQz4c0FF
         nbQOG8ltank3s8arnt4lBgWMjyoP25WW51v46lOKV4yKB6ZQR4ntFKGcnj3ekEbXconX
         lU4L067j51DCzqhC/HafqFFIjGjSNhTbrNIFz40918EQynzOfR6QIgsHBHoxlqx4pVIn
         tBKuL72lYduL/PoomhMQIgNr4NdLjfiv6LdmpXTdsF1uMz7yJdi0QzBlNaTv1oA4g/J4
         +P+A==
X-Gm-Message-State: APjAAAU2baqUeNYgFk28KKAGpT/w2CRLwI8wGh9R7mkgmOi/dgQesPxg
        thIKfTZmuyyi8cwIUeKnP97joXnvCN4=
X-Google-Smtp-Source: APXvYqxG8gmw9QAG+TGB/Z7N2VKpO1wzDf+27D3H4y1MkNc3p8mhaYXLaHZMygfEg9ZbU6WUjjlOuQ==
X-Received: by 2002:aed:3574:: with SMTP id b49mr5864696qte.235.1551478809856;
        Fri, 01 Mar 2019 14:20:09 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q23sm11364857qkc.64.2019.03.01.14.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 14:20:09 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] mm/hugepages: fix "orig_pud" set but not used
Date:   Fri,  1 Mar 2019 17:19:56 -0500
Message-Id: <20190301221956.97493-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent
hugepages") introduced pudp_huge_get_and_clear_full() but no one uses
its return code. In order to not diverge from
pmdp_huge_get_and_clear_full(), just change zap_huge_pud() to not assign
the return value from pudp_huge_get_and_clear_full().

mm/huge_memory.c: In function 'zap_huge_pud':
mm/huge_memory.c:1982:8: warning: variable 'orig_pud' set but not used
[-Wunused-but-set-variable]
  pud_t orig_pud;
        ^~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: keep returning a code from pudp_huge_get_and_clear_full() for possible
    future uses.

 mm/huge_memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index faf357eaf0ce..9f57a1173e6a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1979,7 +1979,6 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pud_t *pud, unsigned long addr)
 {
-	pud_t orig_pud;
 	spinlock_t *ptl;
 
 	ptl = __pud_trans_huge_lock(pud, vma);
@@ -1991,8 +1990,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * pgtable_trans_huge_withdraw after finishing pudp related
 	 * operations.
 	 */
-	orig_pud = pudp_huge_get_and_clear_full(tlb->mm, addr, pud,
-			tlb->fullmm);
+	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
 	if (vma_is_dax(vma)) {
 		spin_unlock(ptl);
-- 
2.17.2 (Apple Git-113)

