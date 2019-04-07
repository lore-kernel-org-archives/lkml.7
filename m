Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B920C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034FC20880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 12:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDGMzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 08:55:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDGMzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 08:55:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2B2E30642AA;
        Sun,  7 Apr 2019 12:55:15 +0000 (UTC)
Received: from thuth.com (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8E1C600C1;
        Sun,  7 Apr 2019 12:55:11 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/mm: Silence compiler warning when compiling without CONFIG_PGSTE
Date:   Sun,  7 Apr 2019 14:55:09 +0200
Message-Id: <20190407125509.6380-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 07 Apr 2019 12:55:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PGSTE is not set (e.g. when compiling without KVM), GCC complains:

  CC      arch/s390/mm/pgtable.o
arch/s390/mm/pgtable.c:413:15: warning: ‘pmd_alloc_map’ defined but not
 used [-Wunused-function]
 static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
               ^~~~~~~~~~~~~

Wrap the function with "#ifdef CONFIG_PGSTE" to silence the warning.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/mm/pgtable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 8485d6dc2754..9ebd01219812 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -410,6 +410,7 @@ static inline pmd_t pmdp_flush_lazy(struct mm_struct *mm,
 	return old;
 }
 
+#ifdef CONFIG_PGSTE
 static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -427,6 +428,7 @@ static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
 	pmd = pmd_alloc(mm, pud, addr);
 	return pmd;
 }
+#endif
 
 pmd_t pmdp_xchg_direct(struct mm_struct *mm, unsigned long addr,
 		       pmd_t *pmdp, pmd_t new)
-- 
2.21.0

