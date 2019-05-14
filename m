Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896AEC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6092D20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfENNRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:17:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35715 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfENNRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:17:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so19206408wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vA0P95K9fRheR4E+ESk+WXsmN1wAOY/rldukfhup8+8=;
        b=RROK6Fm3RUoJdiTQGiYDJ8MbpYNvqI/eigb98ddEcEYucRmuLVqBzBA9WvtcwWbmcu
         xgP7XKsFuWO1Hz7Vb9FSoOVtYlnhaMkbLHkqoHkPVdtlkIBFFgreS7BWSwJPFIzRPWGj
         bJe+4Olwgk8PyefzlHhWPpLe/ELAywW0xtdsveNbl/dPzJGdSqPRuWZaOf7AWSstLDtH
         FpQLf40ZE4O9I9rtRQtohIj8XWrLK6UdH9tQxMm4U/uqfYdgN8QshhvX/bwdk6Fg1Q8M
         sutuOdRY3O18whwDVfBog1qtbDCr6DhbfF1NYbk6vyt2VdTsZ2VTstcjTlJtVj+uxatH
         wpqg==
X-Gm-Message-State: APjAAAWUbU2rCmk/hmuUIjp8WndgY1+7hfVSm87LmkaFjG/3awc3zOv1
        xPwenPF9+rOaEDpdsrzaNaG+Or9GUrZT8A==
X-Google-Smtp-Source: APXvYqyA7ev1bORFUVmblymk/lrv+ZsAH07hD7NalfDAhNsPNHuNGBskFQiodfLrs4do1an3hLlNeQ==
X-Received: by 2002:adf:c149:: with SMTP id w9mr10697762wre.40.1557839818301;
        Tue, 14 May 2019 06:16:58 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b2sm16325220wrt.20.2019.05.14.06.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:16:57 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC v2 1/4] mm/ksm: introduce ksm_enter() helper
Date:   Tue, 14 May 2019 15:16:51 +0200
Message-Id: <20190514131654.25463-2-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514131654.25463-1-oleksandr@redhat.com>
References: <20190514131654.25463-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MADV_MERGEABLE part of ksm_madvise() into a dedicated helper since
it will be further used for marking VMAs to be merged forcibly.

This does not bring any functional changes.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/ksm.c | 60 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index fc64874dc6f4..02fdbee394cc 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2442,41 +2442,53 @@ static int ksm_scan_thread(void *nothing)
 	return 0;
 }
 
-int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, unsigned long *vm_flags)
+static int ksm_enter(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long *vm_flags)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	int err;
 
-	switch (advice) {
-	case MADV_MERGEABLE:
-		/*
-		 * Be somewhat over-protective for now!
-		 */
-		if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
-				 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
-				 VM_HUGETLB | VM_MIXEDMAP))
-			return 0;		/* just ignore the advice */
+	/*
+	 * Be somewhat over-protective for now!
+	 */
+	if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
+			 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
+			 VM_HUGETLB | VM_MIXEDMAP))
+		return 0;		/* just ignore the advice */
 
-		if (vma_is_dax(vma))
-			return 0;
+	if (vma_is_dax(vma))
+		return 0;
 
 #ifdef VM_SAO
-		if (*vm_flags & VM_SAO)
-			return 0;
+	if (*vm_flags & VM_SAO)
+		return 0;
 #endif
 #ifdef VM_SPARC_ADI
-		if (*vm_flags & VM_SPARC_ADI)
-			return 0;
+	if (*vm_flags & VM_SPARC_ADI)
+		return 0;
 #endif
 
-		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
-			err = __ksm_enter(mm);
-			if (err)
-				return err;
-		}
+	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
+		err = __ksm_enter(mm);
+		if (err)
+			return err;
+	}
+
+	*vm_flags |= VM_MERGEABLE;
+
+	return 0;
+}
 
-		*vm_flags |= VM_MERGEABLE;
+int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end, int advice, unsigned long *vm_flags)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int err;
+
+	switch (advice) {
+	case MADV_MERGEABLE:
+		err = ksm_enter(mm, vma, vm_flags);
+		if (err)
+			return err;
 		break;
 
 	case MADV_UNMERGEABLE:
-- 
2.21.0

