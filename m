Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D7C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7520880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWC4/3S+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfCRQVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:21:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37252 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfCRQVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:21:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so8194857pfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CgwRVS2Q+Iae+lbffdt/SU+OjpN+MyifpJVYq7Y3K8k=;
        b=MWC4/3S+X+/VHhs7voniM9phy/o7yqCWtKuyosSnpIUCAAnZP/Mn/DsNv3XRJweEef
         jZRIeMihSOp1ASm83jxCAnAw3ViWzpZEBFUOSHzcpfJkGeBaG6F/TBcR6Kz4BH0AIqBf
         Gzh9PBQPZ8pr/EcJVjRnUxjFWMrNxn3irZNRu3wMiyf1wognYBMph+ebK+gbMx7LhXoJ
         oV0M9D36FS81wHAnGWahxYbcx4RxJ7lvr83vXwqLdwO4IYJZouer23ny/kJ1LkOP6sHP
         AVVxXnLoumIaK6WbT6AKyhnGkge0WKU7awH8NUq8MTaMAlpkjQHFIeNFGlDycX5EI5GY
         xXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CgwRVS2Q+Iae+lbffdt/SU+OjpN+MyifpJVYq7Y3K8k=;
        b=hG6hU3dmw5daPCp3QT3bSZf9cDiWfjHgw/1VVXSrhSj7OLGwfke/fHOLQjGOcL7FNX
         jV27byybGkA7Ing6YRzA+Es5xwOkvb3yi7n2xqfFlz/qlOf5SjZj0AnV0tv0O4mGCCwF
         TL+ExadxqskB5bRAQ2IJFC7ayY/uwvpD507zsLaz5XgdWL/Utvidj0fBOuLHo7esMkM6
         WJAgHiT96Hgs0RGjENSLVJgRFegjljLXIiOaIjWK0S27/pR35+Tcg08MD4YHZhtJxJhd
         EuAj3tG+CMs7TKAhYgvpMx3rf4e+NOL2PZjb3jZ36mpZMSvKpLMwN+WKTjElSbE4s515
         lbMg==
X-Gm-Message-State: APjAAAVmfNkjeyAvLGy26dMW8Aei0ozPMu7jcARtoLQ9HNMhuSSEJiHx
        FVCDZJq7FYvtnACzsfigJDg=
X-Google-Smtp-Source: APXvYqyw1Bx/onz96XVk/VzfT2P30uQI4lOEdkGn1FqYErJitQaCHsJU2FF6AK2yAnsDrfL2aeQc4A==
X-Received: by 2002:a65:52c9:: with SMTP id z9mr5436469pgp.227.1552926091321;
        Mon, 18 Mar 2019 09:21:31 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.188])
        by smtp.gmail.com with ESMTPSA id h184sm24617707pfc.78.2019.03.18.09.21.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 09:21:30 -0700 (PDT)
Date:   Mon, 18 Mar 2019 21:56:05 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] include/linux/hugetlb.h: Convert to use vm_fault_t
Message-ID: <20190318162604.GA31553@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild produces the below warning ->

tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5453a3df2a5eb49bc24615d4cf0d66b2aae05e5f
commit 3d3539018d2c ("mm: create the new vm_fault_t type")
reproduce:
        # apt-get install sparse
        git checkout 3d3539018d2cbd12e5af4a132636ee7fd8d43ef0
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

>> mm/memory.c:3968:21: sparse: incorrect type in assignment (different
>> base types) @@    expected restricted vm_fault_t [usertype] ret @@
>> got e] ret @@
   mm/memory.c:3968:21:    expected restricted vm_fault_t [usertype] ret
   mm/memory.c:3968:21:    got int

This patch will convert to return vm_fault_t type for hugetlb_fault()
when CONFIG_HUGETLB_PAGE =n.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/linux/hugetlb.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 087fd5f4..0ee502a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -203,7 +203,6 @@ static inline void hugetlb_show_meminfo(void)
 #define pud_huge(x)	0
 #define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
-#define hugetlb_fault(mm, vma, addr, flags)	({ BUG(); 0; })
 #define hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
 				src_addr, pagep)	({ BUG(); 0; })
 #define huge_pte_offset(mm, address, sz)	0
@@ -234,6 +233,13 @@ static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
 {
 	BUG();
 }
+static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
+				struct vm_area_struct *vma, unsigned long address,
+				unsigned int flags)
+{
+	BUG();
+	return 0;
+}
 
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
-- 
1.9.1

