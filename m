Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1B9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F94B218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYWvseix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCOTBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:01:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39111 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfCOTBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:01:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id y9so8596267ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yesOFHHDBY3QkCI/a9ODnYSonunyDSZhtIejo7P4ch0=;
        b=AYWvseixV2GFDujELCi41k4cxxBpvBExorfgtyEBfxe2MvHSXwZJCDenPNO31Q+aqM
         iP6MtImJUUutMErdXrKSjwxWn/tWklmfl7Mb4Il+gDimQacOc/lvoXoa50AJ+RxGUVrc
         zLr4v85sPJA1VdS1HiVJVGpBsYr0Dgzc0dCIoGiSAJdGKHFjCG7gpsF10WR9NsU1QpHV
         omFdJO1HcmiXuoO89VVn9M7Du2jz+kM8nlCzWh1VGbok2QA2zvpvTII04m2Kc6I7oAx+
         wVbTzakAna+jQ+Co6DjoohoM6q14c1HcLiyB8g/OtROS5ec1i0U+rdofmVvbhXEjvtzO
         wLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yesOFHHDBY3QkCI/a9ODnYSonunyDSZhtIejo7P4ch0=;
        b=LC2VwuVsjNv2YdVczMj1tVXi3EwDPwEvAyzVOklEFZiLjxmFhLR7i/0e5jBLSZe0v9
         cSk0r9IUKkCQpbh8T4UGpz6t5rM2kiTIaBdiVoM8rexN82HGCvSKSkBTx2gN3B4+Wnim
         hDeSRyP85dvhzdLbIoDqUa2fdX7gh7YBU9iCr6dYqRirPkr1MpGE8aXpF6nkbj4+deo7
         JnA+eQEgqOGLRQ+cpaVhW8sI9w2SPEdDSVKT1kMzw3IXVqpQPUQWK/GRi+c/+Cx+m/wn
         ILURe0+Y1Lskb3Y3FI5x/BibJ4vd/I0zp8lKPbr0TFO6KxwfAZH75Xo65rPpgocGop4i
         QlTQ==
X-Gm-Message-State: APjAAAULqWeiJEM01VvFMb5Pr1KTeXupn3+NRGNLaDoXH4qysynilodN
        x5BxuqZx2jfVKkEPCM29nmpgWMO9Cz5n7A1wRlU=
X-Google-Smtp-Source: APXvYqzxdACwe10cqCQ6v30ixuPB1+IrIlbx/VIYIXm/YzG/CFFOY/ktNEq4MES1VVdU2v4CgAG8owa9gdbB4i0Eu7k=
X-Received: by 2002:a2e:8793:: with SMTP id n19mr3077313lji.9.1552676473554;
 Fri, 15 Mar 2019 12:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <201903140301.VeDCo2VR%lkp@intel.com> <CAFqt6zaA1t1+vPL8hk7Rm6B4ZqG6maK+Z1HAkL0aF93=q4MeOQ@mail.gmail.com>
 <20190314160052.GM19508@bombadil.infradead.org>
In-Reply-To: <20190314160052.GM19508@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 16 Mar 2019 00:35:37 +0530
Message-ID: <CAFqt6za4x8DCoRdyFDcmR8A+CczebqNRKDKhvkz06JRN5_Hnrg@mail.gmail.com>
Subject: Re: mm/memory.c:3968:21: sparse: incorrect type in assignment
 (different base types)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Thu, Mar 14, 2019 at 9:30 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Mar 14, 2019 at 03:10:19PM +0530, Souptick Joarder wrote:
> > > >> mm/memory.c:3968:21: sparse: incorrect type in assignment (different base types) @@    expected restricted vm_fault_t [usertype] ret @@    got e] ret @@
> > >    mm/memory.c:3968:21:    expected restricted vm_fault_t [usertype] ret
> > >    mm/memory.c:3968:21:    got int
> >
> > Looking into https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > hugetlb_fault() is converted to return vm_fault_t. Not sure, why sparse is
> > still throwing warnings.
>
> Because there are two definitions of hugetlb_fault():
>
> $ git grep -wn hugetlb_fault
> include/linux/hugetlb.h:108:vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> include/linux/hugetlb.h:206:#define hugetlb_fault(mm, vma, addr, flags) ({ BUG(); 0; })

make ARCH=x86_64 allmodconfig will set CONFIG_HUGETLB_PAGE =y
which means it shouldn't use the hugetlb_fault() macro in this case.
With *make ARCH=x86_64 allmodconfig* I am unable to reproduce the issue.

But consider the warnings, does the below change is fine ?

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 087fd5f4..0ee502a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -203,7 +203,6 @@ static inline void hugetlb_show_meminfo(void)
 #define pud_huge(x)    0
 #define is_hugepage_only_range(mm, addr, len)  0
 #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
-#define hugetlb_fault(mm, vma, addr, flags)    ({ BUG(); 0; })
 #define hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
                                src_addr, pagep)        ({ BUG(); 0; })
 #define huge_pte_offset(mm, address, sz)       0
@@ -234,6 +233,13 @@ static inline void __unmap_hugepage_range(struct
mmu_gather *tlb,
 {
        BUG();
 }
+static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
+                               struct vm_area_struct *vma, unsigned
long address,
+                               unsigned int flags)
+{
+       BUG();
+       return 0;
+}

 #endif /* !CONFIG_HUGETLB_PAGE */
