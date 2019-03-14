Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E6EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D55A2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="h7HwSxQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCNMAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:00:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46323 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCNMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:00:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so4341494edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2PFINuUVxIl8ZJywXk/Xh4rAhG4gAZbvqnwzK7un3mo=;
        b=h7HwSxQ+PgPCTmuSmNHlK2m98qhvJN4oQ3avDaCKlEoNVbbaF1w5zPC8j+7s5cSHiO
         2qCNkO0Ymq+PEvKZ5QTKAaX9mAunWcDPwZwfuBOnM2miw0BcpwiO24lO9hK8AaPGrqbN
         l82fo0VCbwwA8dIxndUKt9/5IYk8kZNEXWgPFOwKQtd11o3Eom+WrPr37qND3ArpdS4D
         6ZPLjk6ZtYzB537crJp5zVXDutu1CR+o6aAJ5ploDZKSIk7mZu5P70fzkGv4uCj+bOWX
         FITQKwlZ8sbXKAlvUIMZ3W+UhJ+BZu4VFLgshS+0I94W5DfvxbyokdFP+pFGoi3ghdQJ
         0ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2PFINuUVxIl8ZJywXk/Xh4rAhG4gAZbvqnwzK7un3mo=;
        b=pLJH3iwQvrAy4NLIMouHAmjKLkyBFw/B4PEyrv/MBPAIb2i9pvilKFGmevlS8x1zhs
         dFunxTXY3dBmUdAe/rZf55QQjfIEPu11UT2JqEp0tAcBCzaJggaexCJqYrhE6s/JTBkc
         R1Vt3+WsIHf/Y0BTucOIDvuY8XZny9EGhHcTn1QtJPs/0PZN2RkEeF1rt+O0/1Ntx7f7
         uGyLtLhDUtE2gQCaBoKLbo/+ePcFzqsflxjSw6w40iFifSwFfvoY/PoyKobUAz7NWyEc
         QGPdRHSWpxvn97d8lRf/S66+IDrottuH0kqpoLWr/nXURfOdRXCSMtHOKfh/O9MbfT5t
         HnYg==
X-Gm-Message-State: APjAAAXi6qIIgr4K5yg9QldKNd0XSqSJecaem78jN4Brg9Iogrjj/1En
        8Mk+8JKFcSWBPxCNkjSi1UCw1g==
X-Google-Smtp-Source: APXvYqyy0BSB+VJ/QiZJN13WBbAr7qiQGLZu2+ocfxL9K+m6nb8+tbDFznJS6BGmJ4xCTfQDlfjSSA==
X-Received: by 2002:a50:9984:: with SMTP id m4mr11391543edb.279.1552564844413;
        Thu, 14 Mar 2019 05:00:44 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w6sm1360862eds.0.2019.03.14.05.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:00:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2 7/7] iommu/vt-d: Remove lazy allocation of domains
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Date:   Thu, 14 Mar 2019 11:59:36 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4D76093-3F9F-4184-9F92-191A01126D0F@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic IOMMU code will allocate and attach a default domain to each
device that comes online. This patch removes the lazy domain allocation
and early reserved region mapping that is now redundant.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 300 +-----------------------------------
 1 file changed, 5 insertions(+), 295 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2c9d793af394..f8c0c3e16935 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2605,118 +2605,6 @@ static struct dmar_domain =
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
@@ -2742,73 +2630,6 @@ static int iommu_domain_identity_map(struct =
dmar_domain *domain,
 				DMA_PTE_READ|DMA_PTE_WRITE);
 }
=20
-static int domain_prepare_identity_map(struct device *dev,
-				       struct dmar_domain *domain,
-				       unsigned long long start,
-				       unsigned long long end)
-{
-	/* For _hardware_ passthrough, don't bother. But for software
-	   passthrough, we do it anyway -- it may indicate a memory
-	   range which is reserved in E820, so which didn't get set
-	   up to start with in si_domain */
-	if (domain =3D=3D si_domain && hw_pass_through) {
-		pr_warn("Ignoring identity map for HW passthrough device =
%s [0x%Lx - 0x%Lx]\n",
-			dev_name(dev), start, end);
-		return 0;
-	}
-
-	pr_info("Setting identity map for device %s [0x%Lx - 0x%Lx]\n",
-		dev_name(dev), start, end);
-
-	if (end < start) {
-		WARN(1, "Your BIOS is broken; RMRR ends before it =
starts!\n"
-			"BIOS vendor: %s; Ver: %s; Product Version: =
%s\n",
-			dmi_get_system_info(DMI_BIOS_VENDOR),
-			dmi_get_system_info(DMI_BIOS_VERSION),
-		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		return -EIO;
-	}
-
-	if (end >> agaw_to_width(domain->agaw)) {
-		WARN(1, "Your BIOS is broken; RMRR exceeds permitted =
address width (%d bits)\n"
-		     "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		     agaw_to_width(domain->agaw),
-		     dmi_get_system_info(DMI_BIOS_VENDOR),
-		     dmi_get_system_info(DMI_BIOS_VERSION),
-		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		return -EIO;
-	}
-
-	return iommu_domain_identity_map(domain, start, end);
-}
-
-static int iommu_prepare_identity_map(struct device *dev,
-				      unsigned long long start,
-				      unsigned long long end)
-{
-	struct dmar_domain *domain;
-	int ret;
-
-	domain =3D get_domain_for_dev(dev, =
DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain)
-		return -ENOMEM;
-
-	ret =3D domain_prepare_identity_map(dev, domain, start, end);
-	if (ret)
-		domain_exit(domain);
-
-	return ret;
-}
-
-static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
-					 struct device *dev)
-{
-	if (dev->archdata.iommu =3D=3D DUMMY_DEVICE_DOMAIN_INFO)
-		return 0;
-	return iommu_prepare_identity_map(dev, rmrr->base_address,
-					  rmrr->end_address);
-}
-
 static inline struct iommu_resv_region *iommu_get_isa_resv_region(void)
 {
 	if (!isa_resv_region)
@@ -2819,29 +2640,6 @@ static inline struct iommu_resv_region =
*iommu_get_isa_resv_region(void)
 	return isa_resv_region;
 }
=20
-#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
-static inline void iommu_prepare_isa(struct pci_dev *pdev)
-{
-	int ret;
-	struct iommu_resv_region *reg =3D iommu_get_isa_resv_region();
-
-	if (!reg)
-		return;
-
-	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
-	ret =3D iommu_prepare_identity_map(&pdev->dev, reg->start,
-			reg->start + reg->length - 1);
-
-	if (ret)
-		pr_err("Failed to create 0-16MiB identity map - floppy =
might not work\n");
-}
-#else
-static inline void iommu_prepare_isa(struct pci_dev *pdev)
-{
-	return;
-}
-#endif /* !CONFIG_INTEL_IOMMU_FLPY_WA */
-
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
=20
 static int __init si_domain_init(int hw)
@@ -3065,18 +2863,10 @@ static int __init =
dev_prepare_static_identity_mapping(struct device *dev, int hw
=20
 static int __init iommu_prepare_static_identity_mapping(int hw)
 {
-	struct pci_dev *pdev =3D NULL;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	struct device *dev;
-	int i;
-	int ret =3D 0;
-
-	for_each_pci_dev(pdev) {
-		ret =3D dev_prepare_static_identity_mapping(&pdev->dev, =
hw);
-		if (ret)
-			return ret;
-	}
+	int i, ret =3D 0;
=20
 	for_each_active_iommu(iommu, drhd)
 		for_each_active_dev_scope(drhd->devices, =
drhd->devices_cnt, i, dev) {
@@ -3323,12 +3113,9 @@ static int copy_translation_tables(struct =
intel_iommu *iommu)
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
-	struct dmar_rmrr_unit *rmrr;
 	bool copied_tables =3D false;
-	struct device *dev;
-	struct pci_dev *pdev;
 	struct intel_iommu *iommu;
-	int i, ret;
+	int ret;
=20
 	/*
 	 * for each drhd
@@ -3482,36 +3269,6 @@ static int __init init_dmars(void)
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
-	pdev =3D pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (pdev) {
-		iommu_prepare_isa(pdev);
-		pci_dev_put(pdev);
-	}
=20
 domains_done:
=20
@@ -3595,53 +3352,6 @@ static unsigned long intel_alloc_iova(struct =
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
@@ -3704,7 +3414,7 @@ static dma_addr_t __intel_map_page(struct device =
*dev, struct page *page,
 	if (iommu_no_mapping(dev))
 		return paddr;
=20
-	domain =3D get_valid_domain_for_dev(dev);
+	domain =3D find_domain(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
=20
@@ -3914,7 +3624,7 @@ static int intel_map_sg(struct device *dev, struct =
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
@@ -5412,7 +5122,7 @@ int intel_iommu_enable_pasid(struct intel_iommu =
*iommu, struct intel_svm_dev *sd
 	u64 ctx_lo;
 	int ret;
=20
-	domain =3D get_valid_domain_for_dev(sdev->dev);
+	domain =3D find_domain(sdev->dev);
 	if (!domain)
 		return -EINVAL;
=20
--=20
2.17.1

