Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA89C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569DE208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifiOqyLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfGUP61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 11:58:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42703 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGUP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 11:58:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so16168612pff.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPxj1xULAmyThBZtHUXs4RUTpVotq1m6ArGML4hnd9o=;
        b=ifiOqyLuR2fVpSX7LgALyQR4fLm8I1fH/HPzFhDKareH7Mat4AeFK7FriOec5kkIK2
         wrkY60M1g9T4xGKZPATWmMcmqyzUnhouyS8jLdWqlmaw7Uhyw/yfS0tLX1lp5rQKJaLB
         fSm4JJfRR3RL77klHIt1fyvoW6veo0UFmmjnBE0gck+i8fxq2rd44U40PHlylpJTqIFg
         +L6uKhgtV6nQN6+xT9aOPjVaCGAp/jC3uuTmzJ4x6M5L8PFe1TRJ2Dg9yYZ8tyYsO4mz
         WffynzmJeO020XEI+EyeM/h1PfhhEpTI0MK5P2rjMCAKJbRMywzH8bFyVmkubOP7fvDa
         Bwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPxj1xULAmyThBZtHUXs4RUTpVotq1m6ArGML4hnd9o=;
        b=sRtbXbj107BF4n+E/gqeFXUbg05KzunvbKVlzei0STkOYlQ7M1S08IY8c+R5djTNbH
         sSPT3ECe2n+plmoBvm2b0LMbRf4rMOZDvaZCuMpFhiFQG0/2xmQPYtgimcRDtYSVHWOb
         ta4eFKv+C0tfO1PJiQGYAzNk66IikqxZ4ortX1/vnikbUgMNwM/qt06qsXscTJk6FvGh
         eRRCHxfyqDltz4ye9hhYuVW/0yQPzgY1cqye2sl4uML1WRhAhA/oJHG6Ux3Qy/8kQuXG
         fLj/qev2xQu+Ng654KTwv0KG5BU0RS3jKLIaxNTlw+LndoTMiarveMfc80fF2VfzzAlw
         n/qQ==
X-Gm-Message-State: APjAAAU3Ltdfyf9iv/Sq7Xo2HD0a+8Ivc3chrJS9oaPiPSDhMRv8SjKQ
        v7rjVFCQj7WL5/yFdQcv80E=
X-Google-Smtp-Source: APXvYqzyvqZLIxg67pxkdxLJpTK/51NalCRn7KTGd70dRGh3NJlFIdRe+Ue6E9oqJ+ciSF87NclM4A==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr67183457pgl.103.1563724705973;
        Sun, 21 Jul 2019 08:58:25 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id e17sm27335437pgm.21.2019.07.21.08.58.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jul 2019 08:58:25 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org
Cc:     ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH 2/3] sgi-gru: Remove CONFIG_HUGETLB_PAGE ifdef
Date:   Sun, 21 Jul 2019 21:28:04 +0530
Message-Id: <1563724685-6540-3-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_vm_hugetlb_page has checks for whether CONFIG_HUGETLB_PAGE is defined
or not. If CONFIG_HUGETLB_PAGE is not defined is_vm_hugetlb_page will
always return false. There is no need to have an uneccessary
CONFIG_HUGETLB_PAGE check in the code.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/misc/sgi-gru/grufault.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 61b3447..75108d2 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -180,11 +180,8 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
 {
 	struct page *page;
 
-#ifdef CONFIG_HUGETLB_PAGE
 	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
+
 	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
 		return -EFAULT;
 	*paddr = page_to_phys(page);
@@ -238,11 +235,9 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
 		return 1;
 
 	*paddr = pte_pfn(pte) << PAGE_SHIFT;
-#ifdef CONFIG_HUGETLB_PAGE
+
 	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
+
 	return 0;
 
 err:
-- 
2.7.4

