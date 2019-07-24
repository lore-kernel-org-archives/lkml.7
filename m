Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BCC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6CA229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fABmKKov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfGXLlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:41:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40591 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfGXLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:41:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so21110635pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORy6NrKMahXgXjCFxtBMjvZtj+K0mFoX1H4GDy2eV+0=;
        b=fABmKKovZIa7BVn8ihmTaxmHzv2Wkkhsm0ffh+FTnE7+zcgHg0cU75n5KQOmW+Dl0r
         24F/bxwikeAXCzY7FWcBinMMg93Lqk6FZ0pLi5Ri+YUAzEiXrLL4RXPQhBkqKaAOPnLS
         BS6Yma/G8h23jbwDh9OCQFKe+mj8zFp3HpG59+0SPoxfl+3k7K9NQknftfi38SC2Prmu
         KJbF22DRE3X8ak6G2CbJWSD3ASdxhTeqiUzm/ag1eQ3zncxUnM1g0iH5yi7B1/5FKoBl
         fQhNDAgQx2VmuoDhYL1t+J2Q/pQvWsWmLDwsgecFXVTBgMNn68IiqDAtBau4jch7JOXI
         hLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORy6NrKMahXgXjCFxtBMjvZtj+K0mFoX1H4GDy2eV+0=;
        b=L7E2x26xtOacUQs1O3mveIW3pVR65jACs299hw9HAJmuwwfmVhaR3gaQO++cof/fWc
         TwkqDTbNcd7eSFIK8j3Kh/LsqIEf2/MZue9culNyVB9e3V2y1Iebb9utVmcNcVCaRJro
         8ADZ5XrVX8VhUb/EXDcguLa/hsea8s+CteCf04xc7s6W0LCip4ECp/Up5t9UUTkqJbAN
         Xjjqt13xhzj7pv3SqwjBDckxLTjthVn1ybMrV7/dDUN93qLvLsO1MKKQ+udPBRlbvc/D
         rD8+rB4ZWj7NtvUC9rg19+LuM9BdFUi/CMFSU/g8ZescQleJfZ7NM0Nep0tKmurg7kjo
         DS4A==
X-Gm-Message-State: APjAAAX0dpQJpC9uwDn6tWFr6k4psDsUzU4rhrJgsaKE43xIHStDLawQ
        KzieMNQakiGE9eHbsWv835c=
X-Google-Smtp-Source: APXvYqzp2fHJi0yy0Ks5Ez2LolTZSaJhGmodS4FvD3yCpT3yql7W9SKJXRj+FwZauVCERIQa/kPf+A==
X-Received: by 2002:a62:1d11:: with SMTP id d17mr10998103pfd.249.1563968499724;
        Wed, 24 Jul 2019 04:41:39 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id b30sm69751860pfr.117.2019.07.24.04.41.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jul 2019 04:41:39 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, arnd@arndb.de, jhubbard@nvidia.com
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH v2 2/3] sgi-gru: Remove CONFIG_HUGETLB_PAGE ifdef
Date:   Wed, 24 Jul 2019 17:11:15 +0530
Message-Id: <1563968476-12785-3-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563968476-12785-1-git-send-email-linux.bhar@gmail.com>
References: <1563968476-12785-1-git-send-email-linux.bhar@gmail.com>
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
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v2
	- Added an 'unlikely' if statement as suggested by William
	  Kucharski. This is because of the fact that most systems
	  using this driver won't have CONFIG_HUGE_PAGE enabled and we
	  optimize the branch with an unlikely.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/misc/sgi-gru/grufault.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 61b3447..bce47af 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -180,11 +180,11 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
 {
 	struct page *page;
 
-#ifdef CONFIG_HUGETLB_PAGE
-	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
+	if (unlikely(is_vm_hugetlb_page(vma)))
+		*pageshift = HPAGE_SHIFT;
+	else
+		*pageshift = PAGE_SHIFT;
+
 	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
 		return -EFAULT;
 	*paddr = page_to_phys(page);
@@ -238,11 +238,12 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
 		return 1;
 
 	*paddr = pte_pfn(pte) << PAGE_SHIFT;
-#ifdef CONFIG_HUGETLB_PAGE
-	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
+
+	if (unlikely(is_vm_hugetlb_page(vma)))
+		*pageshift = HPAGE_SHIFT;
+	else
+		*pageshift = PAGE_SHIFT;
+
 	return 0;
 
 err:
-- 
2.7.4

