Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65BAC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850922064A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TZMym48p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfJHOP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:15:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46827 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJHOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:15:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id u22so25452745qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uwFtPUZwVRjZpH4kYXqEMZKLuNiu2uGm9J01G5C31U4=;
        b=TZMym48pDuPlxKUUJxLI1VhchjsRC2fmrqBBPap+SODl1xzDYd05ajV2SylRND62bO
         bsbi9QiNsOeHyrkxc1T8PMfnEVyGtZU/tstXPZPdqpi/r/SG03aKj6IL8MkWEFOKQ4DN
         3f4YBg6x0du9c/0m7Zff5oT6cG+1xLylMOdmnT76XH6MVzW5/VfQJB7D8Wp93g8Fj5OF
         u1BDxyOZalZh7/RdjWMs1UaWwvdaHTmimJ5ck0CeTwUeTkZOCXu8/AP8Z7OTxF45ANzG
         ue3iKCq0AQ6K3jMwQDMrFVn/OsXjgGpjgc/e/687dO0aE0fzoRrhRMeZaN1QBSKp8cQ7
         rlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uwFtPUZwVRjZpH4kYXqEMZKLuNiu2uGm9J01G5C31U4=;
        b=TpKrCql9zO7xGG3LnoSyBj8BV1mYeruvNkapstkgNzS4XQR/7uNJEmdAuvhKFqsUY0
         RRs/NP+GHr5dQm4AzLNYVxgFun7joZvVaGzoBYFYxfcdf6DO4RKaAojKolXf18MOkOng
         3/xyJ9WGUHcCuN7oeD/oKlBMGPnJeaSHIa3pXZf1hlAW7iaigsIWYkzZ+uggByB3FXhZ
         9Ytiw9AOOjTc12RtU7oEf6V1xjU24hTYi0VcZlRXOs8bIkEbE+Gy7yNTx4yPxDvOCtjI
         gdBubfu3ejIE1opNSulqO9t2oMIc3RrnZm1XYsA2QmZT/sirGzraSXbmMdXKNbi+Arma
         A11w==
X-Gm-Message-State: APjAAAWmd4Uk/5fvQDPtpbeLSHsAVc8a8TBH8e+9OGWz4YH6eUiw8m3l
        HbN/H8/5tTzy4ARKilFDBg/yHg==
X-Google-Smtp-Source: APXvYqwD03tQqikk2X5yhay3dM1yanfnAHyiYLgkAuyI8Spf2jLueDyyZ1kZCYsdrYuY0WXdQg5TcA==
X-Received: by 2002:aed:2a3d:: with SMTP id c58mr37138594qtd.263.1570544125543;
        Tue, 08 Oct 2019 07:15:25 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d133sm9563134qkg.31.2019.10.08.07.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 07:15:24 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/userfaultfd: fix a GCC compilation warning
Date:   Tue,  8 Oct 2019 10:15:08 -0400
Message-Id: <1570544108-32331-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit
"hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash-fix" seems
accidentally add back an unused variable that was correctly removed in
the commit "hugetlb: remove unused hstate in hugetlb_fault_mutex_hash()"
[1].

mm/userfaultfd.c: In function '__mcopy_atomic_hugetlb':
mm/userfaultfd.c:217:17: warning: variable 'h' set but not used
[-Wunused-but-set-variable]
  struct hstate *h;
                 ^

[1] http://lkml.kernel.org/r/20191005003302.785-1-richardw.yang@linux.intel.com

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/userfaultfd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4cb4ef3d9128..1b0d7abad1d4 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -214,7 +214,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct page *page;
-	struct hstate *h;
 	unsigned long vma_hpagesize;
 	pgoff_t idx;
 	u32 hash;
@@ -271,8 +270,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 	}
 
-	h = hstate_vma(dst_vma);
-
 	while (src_addr < src_start + len) {
 		pte_t dst_pteval;
 
-- 
1.8.3.1

