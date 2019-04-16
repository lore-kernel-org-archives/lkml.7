Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A55C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0A20870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU7zypPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfDPLrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39405 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbfDPLre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so10290240pfo.6;
        Tue, 16 Apr 2019 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XQSNSZywn2J5tIibcMqEyCRYg0DoENdsUd09NDa1qxo=;
        b=QU7zypPw1WcpMxPNCjSaR++TBxlQknuhjLVn/zaIQwjmOn12W8kM5SRWXeRSniSIiQ
         nvWs4u3O61QXyzVFht2ICP1gsPHIZUm3ad2VsCN/SyjHCTFWoSHyQfjmYp9DdtyUBaTQ
         BJawsaXLI03EMX2IZPCe6XRNLtbXberYyZ3mJqTPPZ5MQ3FMuPF6guMSfqSb+RWysVuC
         8lRcAAUhKgdn9Aeu7inwA3G4VSt0hChEPqIvDaTLmxEMhuLSrCEonk3ftiCQIyMRXs6b
         uGyLPtBauzLGcvw+vV+Kix8kWY2mAa4ADOTTyJKgDjXtcsidFwBHAyNWYPc19m8AkhM7
         YFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XQSNSZywn2J5tIibcMqEyCRYg0DoENdsUd09NDa1qxo=;
        b=pIFjtiitxH835UJwvgwfLnfayZ1eJ3LYn52EWKgbB79fvjIuSS4WveA+4bHvou9flE
         abokaCZM/VA05En1j3gFAb/P2l53Dwg5ZdJDnKG1mGPmjAjypaouraX+t88YwwRWE8Px
         r4FuCM2sle9k/T9x6unKD1/1ic5sMImf0QBwXQq5c9m/QuoLU2E91tVfcJ2w4zSx1wZM
         v9D1K0RzivHt412OpnS/l9sCaOd24aVPo95j5OUfnLDlVibpIy+g4sQzNaZ7WqwZ9uvj
         BnYdrCdzXGsg15JHHVcb5JAtbWYb8oNaJcOiVzkOsd8xXBs7nbjY+M7lkjwDzWPVHUC/
         bLHA==
X-Gm-Message-State: APjAAAWDqaU0NkBRAH54sU2kOagb7YjuUnGUN/iqM4Ww+rgx3sWkfWT4
        2OMYO/81juKib0ZIkr8kVK8=
X-Google-Smtp-Source: APXvYqyMCj+Ghsusn8bhw1pE9GkbUM8F5CYPfXi5LJf73fYESAfpDuXDqO4AOj4QsBAxm3YNHO4Aug==
X-Received: by 2002:a62:6086:: with SMTP id u128mr82559935pfb.148.1555415253653;
        Tue, 16 Apr 2019 04:47:33 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
        by smtp.gmail.com with ESMTPSA id p6sm55942835pfd.122.2019.04.16.04.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 04:47:32 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
        sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com,
        peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 6/9] iommu/dma-iommu.c: Convert to use vm_map_pages()
Date:   Tue, 16 Apr 2019 17:19:47 +0530
Message-Id:
 <80c3d220fc6ada73a88ce43ca049afb55a889258.1552921225.git.jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416114947._IBldJHyAxqg0sgh7I_Vxb5GisxWAv_C1oTJMSzIXu8@z>

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/iommu/dma-iommu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6..bacebff 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -620,17 +620,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 
 int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	int ret = -ENXIO;
-
-	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
-		ret = vm_insert_page(vma, uaddr, pages[i]);
-		if (ret)
-			break;
-		uaddr += PAGE_SIZE;
-	}
-	return ret;
+	return vm_map_pages(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
1.9.1

