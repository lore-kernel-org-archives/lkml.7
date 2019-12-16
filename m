Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3A6C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B4B20733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519138;
	bh=CIOEINeAN7LvyrE7wcED0uhSQ+QXU6eHBgG2IWOUgaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IRFQF8/icHbGdpbWZsPfz/JFiiyIE0lGShfv9Qm6RdeEbmcyjSeBCpfwwrr2irSsj
	 UWt3f11NRVbJXQl/YLOnxMfkpbmBhOoxCv3GAi7Im4tkYnD0F9rSs1acMF4RET+6q1
	 A3xBAvkcBzyOm8qDnBMivdIKWNTOPzFkwUtFquO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfLPR64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:58:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbfLPR6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:58:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A33024686;
        Mon, 16 Dec 2019 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519129;
        bh=CIOEINeAN7LvyrE7wcED0uhSQ+QXU6eHBgG2IWOUgaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsLwHJi8voGAYEbVo7bxosFWQ6/6Ujh97cHCrvvwl1LWdvqk0XrvVQOJZPqGfgECR
         LR6t9t+kGDwTG/U5qbVAkLU9Fn79l977CCNBR4EiHR0Bp7gkGcS386vdHQE1fz977r
         fyzKKDR2a/l04wagsadFWZDHT7Uk9xnZbnAnYmNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 4.14 207/267] s390/mm: properly clear _PAGE_NOEXEC bit when it is not supported
Date:   Mon, 16 Dec 2019 18:48:53 +0100
Message-Id: <20191216174913.876284964@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

commit ab874f22d35a8058d8fdee5f13eb69d8867efeae upstream.

On older HW or under a hypervisor, w/o the instruction-execution-
protection (IEP) facility, and also w/o EDAT-1, a translation-specification
exception may be recognized when bit 55 of a pte is one (_PAGE_NOEXEC).

The current code tries to prevent setting _PAGE_NOEXEC in such cases,
by removing it within set_pte_at(). However, ptep_set_access_flags()
will modify a pte directly, w/o using set_pte_at(). There is at least
one scenario where this can result in an active pte with _PAGE_NOEXEC
set, which would then lead to a panic due to a translation-specification
exception (write to swapped out page):

do_swap_page
  pte = mk_pte (with _PAGE_NOEXEC bit)
  set_pte_at   (will remove _PAGE_NOEXEC bit in page table, but keep it
                in local variable pte)
  vmf->orig_pte = pte (pte still contains _PAGE_NOEXEC bit)
  do_wp_page
    wp_page_reuse
      entry = vmf->orig_pte (still with _PAGE_NOEXEC bit)
      ptep_set_access_flags (writes entry with _PAGE_NOEXEC bit)

Fix this by clearing _PAGE_NOEXEC already in mk_pte_phys(), where the
pgprot value is applied, so that no pte with _PAGE_NOEXEC will ever be
visible, if it is not supported. The check in set_pte_at() can then also
be removed.

Cc: <stable@vger.kernel.org> # 4.11+
Fixes: 57d7f939e7bd ("s390: add no-execute support")
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/include/asm/pgtable.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1126,8 +1126,6 @@ int pgste_perform_essa(struct mm_struct
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t entry)
 {
-	if (!MACHINE_HAS_NX)
-		pte_val(entry) &= ~_PAGE_NOEXEC;
 	if (pte_present(entry))
 		pte_val(entry) &= ~_PAGE_UNUSED;
 	if (mm_has_pgste(mm))
@@ -1144,6 +1142,8 @@ static inline pte_t mk_pte_phys(unsigned
 {
 	pte_t __pte;
 	pte_val(__pte) = physpage + pgprot_val(pgprot);
+	if (!MACHINE_HAS_NX)
+		pte_val(__pte) &= ~_PAGE_NOEXEC;
 	return pte_mkyoung(__pte);
 }
 


