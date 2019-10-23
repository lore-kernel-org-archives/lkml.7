Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CDECA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BA9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571823046;
	bh=ss5iwOCaTTohO1+h+WanXEa9AqPGBFhd7er3FFF4krg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nMGFjS77svRPBRXvOmeWCegswOX1AhnQ0/XndQN3jNoklsZz6H//v6gRmxzM9yBw6
	 QpIzrk33Acek6Dvr+dkh1G8Qb388J8uh9yXgqZjhUJjlaIZLmNre/WlSRG51PW1jb5
	 ATuWKuAifKbvcik1+J8IUxtwEv/qfMD73KSAhlCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404035AbfJWJap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403790AbfJWJao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:30:44 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2165321929;
        Wed, 23 Oct 2019 09:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571823044;
        bh=ss5iwOCaTTohO1+h+WanXEa9AqPGBFhd7er3FFF4krg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxeGbjHegPpv6m01wl7sD2y/NPmPe4vZ6pdqJL2/RyuDRnUZh6FrnqqbInZAv6qgi
         JigLf8jRNnqoTvEJf9oemgFkcivNpHAI9ROeIWlqb8hA7AmECUqpp1opI/D0LYY6ys
         ItEUOMC7ou7303Uzev0WZmSn88Wl5ctOHkP/aUBY=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Mike Rapoport <rppt@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 10/12] um: remove unused pxx_offset_proc() and addr_pte() functions
Date:   Wed, 23 Oct 2019 12:28:59 +0300
Message-Id: <1571822941-29776-11-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571822941-29776-1-git-send-email-rppt@kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The pxx_offset_proc() and addr_pte() functions are never used.
Remove them.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/um/kernel/tlb.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index b7eaf65..8425a22 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -490,35 +490,6 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	force_sig(SIGKILL);
 }
 
-pgd_t *pgd_offset_proc(struct mm_struct *mm, unsigned long address)
-{
-	return pgd_offset(mm, address);
-}
-
-pud_t *pud_offset_proc(pgd_t *pgd, unsigned long address)
-{
-	return pud_offset(pgd, address);
-}
-
-pmd_t *pmd_offset_proc(pud_t *pud, unsigned long address)
-{
-	return pmd_offset(pud, address);
-}
-
-pte_t *pte_offset_proc(pmd_t *pmd, unsigned long address)
-{
-	return pte_offset_kernel(pmd, address);
-}
-
-pte_t *addr_pte(struct task_struct *task, unsigned long addr)
-{
-	pgd_t *pgd = pgd_offset(task->mm, addr);
-	pud_t *pud = pud_offset(pgd, addr);
-	pmd_t *pmd = pmd_offset(pud, addr);
-
-	return pte_offset_map(pmd, addr);
-}
-
 void flush_tlb_all(void)
 {
 	/*
-- 
2.7.4

