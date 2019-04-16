Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96AEC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C5F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeEcKFpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfDPLq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:46:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42001 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfDPLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:46:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id w25so10277604pfi.9;
        Tue, 16 Apr 2019 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
        b=oeEcKFpL3vmK9+DpAkDM2pqJ4cwz8D1E2liXXkVcMS/mCROTNxreZ3tJiZU7AMhYGa
         jdvIuxFSG51quKMSoG7eGUWo0OFVjsfwlsv0j6QgATWKo4Y/zRlxt4YEDfEpCBvwBcDU
         oLh7KOdm3sUnBXGsWZumlJIoubWl0FlACsdqSTDMD22x9YueAbdJduUdqxf+Fzo+qE4b
         G/2XochB6n9yIyfIIw7vwaFhmKiDJzF2ILx3ft6jONO/3Tp5olQ3mZrspX0N7+OtxUzw
         L3gftE9ttJboi/nhCsZ8IHvh1byiu+1G+2wjx/i6t9Le5dXmn/WMY4e9g4nRHdsI6qmW
         KGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
        b=fc3QeohuCKOjnTcS+mSS2L8jVA6sxY+DPiIhZDW4jN9c++rstgwdMSkILrA+1D6Bju
         htCHmcC9fCb5bCith6e7K1TLwDF0b+baXmayj2/VQwqKcHg1DtcokCX+avtWJwXbzQR1
         +X1zXbZwttVCrp0GLiwFrFw687yui65bbO3yK8wTiXQK22iuUpnxmXVzilb/FenodViB
         MrPxt80Ip/iIHLuUIlC+pkcqYdhPjn3A2yPRpw8YirD30DIAuj1MgGtqXW/aUTArrPhX
         Vt3QILNZuN26qrnaO6wQhKjhBqCfP8ainnooN+FL8DFdU3dpM5Dm3Wm02ts58kl13Gne
         cZug==
X-Gm-Message-State: APjAAAV1afdhR+X3q15iYXVN1TX+AvWgF5bTZutdQOw+tp9myC53QDEN
        OzbKXZ7SPMth1Kz8ka8ApMA=
X-Google-Smtp-Source: APXvYqzT/G52JjPlhhzDjlzXSHHg4UNZ4b12u0OW4Mw/nQ9ugBF4FdGP/KIWXfE/EW5Pz1mzLpMj5g==
X-Received: by 2002:a62:6ec6:: with SMTP id j189mr346760pfc.195.1555415215118;
        Tue, 16 Apr 2019 04:46:55 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
        by smtp.gmail.com with ESMTPSA id p6sm55942835pfd.122.2019.04.16.04.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 04:46:54 -0700 (PDT)
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
Subject: [REBASE PATCH v5 2/9] arm: mm: dma-mapping: Convert to use vm_map_pages()
Date:   Tue, 16 Apr 2019 17:19:43 +0530
Message-Id:
 <936e5e107c746a7310e3a3c471188ca3ac8f9754.1552921225.git.jrdr.linux@gmail.com>
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
Message-ID: <20190416114943.F2scbFcDy7LLKoRdYxkTPu8lOwMwKxsmSovG5iYuyXc@z>

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922..de7c76e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1575,31 +1575,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
+	int err;
 
 	if (!pages)
 		return -ENXIO;
 
-	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
+	if (vma->vm_pgoff >= nr_pages)
 		return -ENXIO;
 
-	pages += off;
-
-	do {
-		int ret = vm_insert_page(vma, uaddr, *pages++);
-		if (ret) {
-			pr_err("Remapping memory failed: %d\n", ret);
-			return ret;
-		}
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
+	err = vm_map_pages(vma, pages, nr_pages);
+	if (err)
+		pr_err("Remapping memory failed: %d\n", err);
 
-	return 0;
+	return err;
 }
 static int arm_iommu_mmap_attrs(struct device *dev,
 		struct vm_area_struct *vma, void *cpu_addr,
-- 
1.9.1

