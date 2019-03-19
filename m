Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E1AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053F72186A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOnhA/MD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfCSCUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:20:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38069 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCSCUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id n125so12591418pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
        b=VOnhA/MDlDMHBFaInuaNe3cfsXYmEZjRFVXoCsCvPASLnJY77sdXAjcR8dnJyvEra/
         TctQPyWRtZk4YYyZ8MIJMWVLbuxLBqhmhabEiwwbgGT22L9zx6wJM1NyS3EbxPR0m1vO
         X1EMKve1wDE+kmcyF4z6OLcEOvxaBXx3c7JeyHCNY6qxhg6sbFQy5YI6I2cUilB20+X+
         upbL3vjIJWgjyifYZeK72e0KMXcdOn/0wnixdqV3N06lQW5R1d83nf+aGOSo3Dcnj4/e
         z8nH3wy4Aj5SPh7W3RVqkHa5jes7LSVPc6mfTcFP1dhEAt5OZSn17jRrX6azuxOWythp
         dctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
        b=TcQaQH0CBHpFEvc5YND19h8gBTUrNDcNDJiMLaI/m5dZ4h/80f+1pvLEr2tdTC8Rfu
         btBFEFU0IFfOwFLMF9JZpQqvLfjAaDo9cfXtcVe/0UVrl3Vrmt1srM7YC1JCKRBOWLd6
         KTwWfVjLjWsbG0+mJVlFn6uUejW/UMiXN4aeK4nI8XrPUW1C4Su6oJuL+GvZzVeYwSqp
         i141KZBTLJoWcZg880ryaSTAqm0IYtfjldpy+ItJfbMj13hEOzgcGxAwVMCup/dXZgVK
         +apxOTCc9BBQuLSBwsAek2n1N4Wl31JaPtmct2xFmjBuExvV6lpBQlCXCPHgonGp/BEj
         2m3A==
X-Gm-Message-State: APjAAAV2rWseYEF1ORz/SMXbZ4q1tsQO5AX3DdhPY/SELMlVxDmE0oq0
        ta0jyglgOSzftZbYdSr6IdU=
X-Google-Smtp-Source: APXvYqwnpYkFRUlh9SBEWyxbj77gYEMqcn8K1StKeULFpbauHJB0wxPLdatqpQh1Gi/kI9riB6lg3g==
X-Received: by 2002:a17:902:864a:: with SMTP id y10mr862592plt.76.1552962014189;
        Mon, 18 Mar 2019 19:20:14 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([106.51.22.39])
        by smtp.gmail.com with ESMTPSA id 20sm8457175pfp.98.2019.03.18.19.20.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 19:20:13 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:54:48 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v4 2/9] arm: mm: dma-mapping: Convert to use
 vm_map_pages()
Message-ID: <936e5e107c746a7310e3a3c471188ca3ac8f9754.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

