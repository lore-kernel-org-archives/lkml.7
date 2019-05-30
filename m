Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D9C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51D324A33
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186631;
	bh=nQWv/pQ9TneryxCoIWHr+e55gDaqdyjRUi4cNskNqwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZaXFr/mKCuJopltPpcg2c0jMIgcS/IijZ64c8litek6prmBWHFkZn95sVlSavg6CE
	 7/wPNRPPhzD2uqh3iqcBmFO9DB7kvifksuRMkLM1aBvfJGvdmV2riG6GrNnvd55c4z
	 vqsa/YEUea77EL3fFPQKm2eaRgdehwY57/ihS09c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfE3DXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbfE3DRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:41 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54A8124664;
        Thu, 30 May 2019 03:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186260;
        bh=nQWv/pQ9TneryxCoIWHr+e55gDaqdyjRUi4cNskNqwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FrPOntBsMfKh5H/glEiFN16/X4how600IJM2SYADsAI1HfEGiQfZJhHlrTkreKri
         8UesgQ0w42oyC6xMhSGDA+w36NP5O/YZ9LanXinMXvszSJLbWexVUHQgpby6pRa+FH
         xWOlec9Xx4lgYWWjocESZmDTtAGdhwCSmMyGI2ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 175/276] s390/mm: silence compiler warning when compiling without CONFIG_PGSTE
Date:   Wed, 29 May 2019 20:05:33 -0700
Message-Id: <20190530030536.278675697@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 81a8f2beb32a5951ecf04385301f50879abc092b ]

If CONFIG_PGSTE is not set (e.g. when compiling without KVM), GCC complains:

  CC      arch/s390/mm/pgtable.o
arch/s390/mm/pgtable.c:413:15: warning: ‘pmd_alloc_map’ defined but not
 used [-Wunused-function]
 static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
               ^~~~~~~~~~~~~

Wrap the function with "#ifdef CONFIG_PGSTE" to silence the warning.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/pgtable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index f2cc7da473e4e..ae894ac83fd61 100644
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
2.20.1



