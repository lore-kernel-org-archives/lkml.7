Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B63C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70996206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ZlAfN73F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCDPsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:48:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33683 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDPsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:48:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id c55so4645910edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CxxHzjq5yhuVOtEa7Oh3mvDVd5hyw7vMyYDnyb9c1Qw=;
        b=ZlAfN73FynObhQaRqgnKU6tDMAfweodyiEzrT7NaUMu+0cY9SBIWWrH74P3Cx8OWsM
         qXUPelN4qRg/T3HZIuRKHG9H3w+27dznOHJbWXIwBvWYsTh11265ylNuBX9IwNe0rRjA
         z22TQxwlcNvYEAt3D1GASXzn4+fnNyoFTpjUvr/el5tifeaBJ2cOMNVIrplH75euEHAO
         bxBixMnnzfXzPeRwfEcGx+QDUqyLHua9fZZXTbM+M6ny8gmO3Ydb3uJQxbcJv0dOp5Ix
         ZN0vTYvKxxF3+FwdnTMiXbTrT4JUbF6+/UXqGdPn65azsPOxd7hp0TcgadgwNG5eBRdT
         NhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CxxHzjq5yhuVOtEa7Oh3mvDVd5hyw7vMyYDnyb9c1Qw=;
        b=iIqnChOPv+7SIi6wdCpS2I9NYBBQsQfSYXxfru4WHKhG373Ngejqlg5/VfXpLYp2wj
         jCssd8tt3z9cZjFo5kmD3JggrtKohN2tZM4DVF0bRsVh0tIW7scCmElpO052ycVRLdWX
         aHxQKsaTGVrMjJN3ikxc/CHtKSdzngTzRiaXbgNLkvCJycr//aXvccZSKt8Efh8rBaAb
         LcRo9i0UqLJz8UB1Q6PtfUrbBhRTG+rkCjVfACKUiJZRJjkY5WBk0bKA0p6Zs/iAAo0R
         86n2WULhJsPa7LySHACOOSt6CiE7umx/zP88Boj+THNQ3iuIyGyhA9iYoVcUJmWf57C5
         M25w==
X-Gm-Message-State: APjAAAVA+vb2+gACpu5BKjF/b6uQEfYrzIVoCXpbxfqO0rmEl0izI3wZ
        D1CviH3IsJyi3f1Ll0dW8wQEFwY+3ck=
X-Google-Smtp-Source: APXvYqz2/ZzFJROkk9hxitmMrY7/8tmxgl1sjf+Xt/UYZPXp+3m9XODRb90X7bFo0l/pwC1b0UuYlg==
X-Received: by 2002:a50:eb82:: with SMTP id y2mr15757030edr.38.1551714498334;
        Mon, 04 Mar 2019 07:48:18 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n25sm2183785edd.83.2019.03.04.07.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:48:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
Date:   Mon, 4 Mar 2019 15:47:18 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic IOMMU code will allocate and attach a dma ops domain to each
device that comes online, replacing any lazy allocated domain. Removes
RMRR application at iommu init time as we won't have a domain attached
to any device. iommu.c will do this after attaching a device using
create_direct_mappings.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 202 ++----------------------------------
 1 file changed, 8 insertions(+), 194 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 71cd6bbfec05..282257e2628d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2595,118 +2595,6 @@ static struct dmar_domain =
*dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	return domain;
 }
=20
-static int get_last_alias(struct pci_dev *pdev, u16 alias, void =
*opaque)
-{
-	*(u16 *)opaque =3D alias;
-	return 0;
-}
-
-static struct dmar_domain *find_or_alloc_domain(struct device *dev, int =
gaw)
-{
-	struct device_domain_info *info =3D NULL;
-	struct dmar_domain *domain =3D NULL;
-	struct intel_iommu *iommu;
-	u16 dma_alias;
-	unsigned long flags;
-	u8 bus, devfn;
-
-	iommu =3D device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return NULL;
-
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev =3D to_pci_dev(dev);
-
-		pci_for_each_dma_alias(pdev, get_last_alias, =
&dma_alias);
-
-		spin_lock_irqsave(&device_domain_lock, flags);
-		info =3D =
dmar_search_domain_by_dev_info(pci_domain_nr(pdev->bus),
-						      =
PCI_BUS_NUM(dma_alias),
-						      dma_alias & 0xff);
-		if (info) {
-			iommu =3D info->iommu;
-			domain =3D info->domain;
-		}
-		spin_unlock_irqrestore(&device_domain_lock, flags);
-
-		/* DMA alias already has a domain, use it */
-		if (info)
-			goto out;
-	}
-
-	/* Allocate and initialize new domain for the device */
-	domain =3D alloc_domain(0);
-	if (!domain)
-		return NULL;
-	if (domain_init(domain, iommu, gaw)) {
-		domain_exit(domain);
-		return NULL;
-	}
-
-out:
-
-	return domain;
-}
-
-static struct dmar_domain *set_domain_for_dev(struct device *dev,
-					      struct dmar_domain =
*domain)
-{
-	struct intel_iommu *iommu;
-	struct dmar_domain *tmp;
-	u16 req_id, dma_alias;
-	u8 bus, devfn;
-
-	iommu =3D device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return NULL;
-
-	req_id =3D ((u16)bus << 8) | devfn;
-
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev =3D to_pci_dev(dev);
-
-		pci_for_each_dma_alias(pdev, get_last_alias, =
&dma_alias);
-
-		/* register PCI DMA alias device */
-		if (req_id !=3D dma_alias) {
-			tmp =3D dmar_insert_one_dev_info(iommu, =
PCI_BUS_NUM(dma_alias),
-					dma_alias & 0xff, NULL, domain);
-
-			if (!tmp || tmp !=3D domain)
-				return tmp;
-		}
-	}
-
-	tmp =3D dmar_insert_one_dev_info(iommu, bus, devfn, dev, =
domain);
-	if (!tmp || tmp !=3D domain)
-		return tmp;
-
-	return domain;
-}
-
-static struct dmar_domain *get_domain_for_dev(struct device *dev, int =
gaw)
-{
-	struct dmar_domain *domain, *tmp;
-
-	domain =3D find_domain(dev);
-	if (domain)
-		goto out;
-
-	domain =3D find_or_alloc_domain(dev, gaw);
-	if (!domain)
-		goto out;
-
-	tmp =3D set_domain_for_dev(dev, domain);
-	if (!tmp || domain !=3D tmp) {
-		domain_exit(domain);
-		domain =3D tmp;
-	}
-
-out:
-
-	return domain;
-}
-
 static int iommu_domain_identity_map(struct dmar_domain *domain,
 				     unsigned long long start,
 				     unsigned long long end)
@@ -2779,7 +2667,7 @@ static int iommu_prepare_identity_map(struct =
device *dev,
 	struct dmar_domain *domain;
 	int ret;
=20
-	domain =3D get_domain_for_dev(dev, =
DEFAULT_DOMAIN_ADDRESS_WIDTH);
+	domain =3D find_domain(dev);
 	if (!domain)
 		return -ENOMEM;
=20
@@ -3301,11 +3189,9 @@ static int copy_translation_tables(struct =
intel_iommu *iommu)
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
-	struct dmar_rmrr_unit *rmrr;
 	bool copied_tables =3D false;
-	struct device *dev;
 	struct intel_iommu *iommu;
-	int i, ret;
+	int ret;
=20
 	/*
 	 * for each drhd
@@ -3466,32 +3352,6 @@ static int __init init_dmars(void)
 			goto free_iommu;
 		}
 	}
-	/*
-	 * For each rmrr
-	 *   for each dev attached to rmrr
-	 *   do
-	 *     locate drhd for dev, alloc domain for dev
-	 *     allocate free domain
-	 *     allocate page table entries for rmrr
-	 *     if context not allocated for bus
-	 *           allocate and init context
-	 *           set present in root table for this bus
-	 *     init context with domain, translation etc
-	 *    endfor
-	 * endfor
-	 */
-	pr_info("Setting RMRR:\n");
-	for_each_rmrr_units(rmrr) {
-		/* some BIOS lists non-exist devices in DMAR table. */
-		for_each_active_dev_scope(rmrr->devices, =
rmrr->devices_cnt,
-					  i, dev) {
-			ret =3D iommu_prepare_rmrr_dev(rmrr, dev);
-			if (ret)
-				pr_err("Mapping reserved region =
failed\n");
-		}
-	}
-
-	iommu_prepare_isa();
=20
 domains_done:
=20
@@ -3580,53 +3440,6 @@ static unsigned long intel_alloc_iova(struct =
device *dev,
 	return iova_pfn;
 }
=20
-struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
-{
-	struct dmar_domain *domain, *tmp;
-	struct dmar_rmrr_unit *rmrr;
-	struct device *i_dev;
-	int i, ret;
-
-	domain =3D find_domain(dev);
-	if (domain)
-		goto out;
-
-	domain =3D find_or_alloc_domain(dev, =
DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain)
-		goto out;
-
-	/* We have a new domain - setup possible RMRRs for the device */
-	rcu_read_lock();
-	for_each_rmrr_units(rmrr) {
-		for_each_active_dev_scope(rmrr->devices, =
rmrr->devices_cnt,
-					  i, i_dev) {
-			if (i_dev !=3D dev)
-				continue;
-
-			ret =3D domain_prepare_identity_map(dev, domain,
-							  =
rmrr->base_address,
-							  =
rmrr->end_address);
-			if (ret)
-				dev_err(dev, "Mapping reserved region =
failed\n");
-		}
-	}
-	rcu_read_unlock();
-
-	tmp =3D set_domain_for_dev(dev, domain);
-	if (!tmp || domain !=3D tmp) {
-		domain_exit(domain);
-		domain =3D tmp;
-	}
-
-out:
-
-	if (!domain)
-		pr_err("Allocating domain for %s failed\n", =
dev_name(dev));
-
-
-	return domain;
-}
-
 /* Check if the dev needs to go through non-identity map and unmap =
process.*/
 static int iommu_no_mapping(struct device *dev)
 {
@@ -3689,7 +3502,7 @@ static dma_addr_t __intel_map_page(struct device =
*dev, struct page *page,
 	if (iommu_no_mapping(dev))
 		return paddr;
=20
-	domain =3D get_valid_domain_for_dev(dev);
+	domain =3D find_domain(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
=20
@@ -3753,7 +3566,8 @@ static void intel_unmap(struct device *dev, =
dma_addr_t dev_addr, size_t size)
 		return;
=20
 	domain =3D find_domain(dev);
-	BUG_ON(!domain);
+	if (!domain)
+		return;
=20
 	iommu =3D domain_get_iommu(domain);
=20
@@ -3899,7 +3713,7 @@ static int intel_map_sg(struct device *dev, struct =
scatterlist *sglist, int nele
 	if (iommu_no_mapping(dev))
 		return intel_nontranslate_map_sg(dev, sglist, nelems, =
dir);
=20
-	domain =3D get_valid_domain_for_dev(dev);
+	domain =3D find_domain(dev);
 	if (!domain)
 		return 0;
=20
@@ -5377,9 +5191,9 @@ int intel_iommu_enable_pasid(struct intel_iommu =
*iommu, struct intel_svm_dev *sd
 	u64 ctx_lo;
 	int ret;
=20
-	domain =3D get_valid_domain_for_dev(sdev->dev);
+	domain =3D find_domain(sdev->dev);
 	if (!domain)
-		return -EINVAL;
+		return -ENOMEM;
=20
 	spin_lock_irqsave(&device_domain_lock, flags);
 	spin_lock(&iommu->lock);
--=20
2.17.1

