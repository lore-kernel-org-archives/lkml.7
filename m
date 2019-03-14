Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2FA2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EYvx5Wn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCNMA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:00:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36638 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCNMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:00:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so4386982edi.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dtrQa6wpPtPwRYUDA7ynDlQ8alPt9Utk7MbfG6oxbVc=;
        b=EYvx5Wn9JoAvQGL2dhW5ziXdKZUxQDxBAamdkVuxarR/KBpnh2voI5TRH+rtv1aAqt
         IbczwJr6SE8W6MIfGj6+drjp6QauIBY12NZ5mqeHMDyxfn+iS7/yw98P+2p2Vl1BB+4J
         k4WsqU/Daa0HrUkfootrmXSO7TNAzu2gVq1fD+AhfMWu03oWrU8IJ/11lb+NPFuWIwtu
         YnC0p5v7Ww2KM5Y2ajUKhxv9HDMLPrSdI9WC+b+ULiZRs4wqUKTi+yEqSI385ASbn6VB
         gjrRAmZFYrWWCM22B3LpYz/CHQBM6uDjXMjcaXT5W9LJ/ECmOEkg+KYGxH1r6CgfMnr3
         edEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dtrQa6wpPtPwRYUDA7ynDlQ8alPt9Utk7MbfG6oxbVc=;
        b=CU5T7YeT/bOFHsROZj0Md7MzdTxy2mRl96Q4eaa7fGzkb/cZvf9DJb8FDFUMlyFyRk
         VqEiqJThH8YHAkdoymJRFU86W5i0tqpWZ6J1HG90DmwobXqtMwl5BpdELES7zUWsglw6
         Gd2s4sO8jhlWF0obUHIae4drTLSUPvPhJYvV6T9LMK1D8GPr5nDQE9xUFJTMXjlfN6hK
         48PobhMR5L4C/qKX8Q4Kae03R+sDB/CaZ0rySBsyk5U5Swld0Vmvu/IY4rZyWwjHfkou
         8wCOrXwhyqQ2y87TggMmkFPbwN39/jRp4Go6MTbGmDDnJQyw5kbwWZhx3om66LeiMhlj
         Icvw==
X-Gm-Message-State: APjAAAVa/GLuNPQBNjvqLNnmGbznDYyUnhXeKbmaAlJu9VmlBZikmP20
        tsYm7dcgBgCzcIC+eOTgNrRP9g==
X-Google-Smtp-Source: APXvYqxR0xRJAmS4gnhZe3KfeoP7lieR3RzAhlL7WR+TF9lDcwbOUQvYOvFAfXCsFWaVDqQMu5BSfg==
X-Received: by 2002:a50:a4f1:: with SMTP id x46mr11577879edb.62.1552564825864;
        Thu, 14 Mar 2019 05:00:25 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w6sm1360862eds.0.2019.03.14.05.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:00:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2 6/7] iommu/vt-d: Allow IOMMU_DOMAIN_DMA to be allocated by 
 iommu_ops
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Date:   Thu, 14 Mar 2019 11:59:17 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8765B75-BA3F-4DBE-8281-363A586BD8C3@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allowing IOMMU_DOMAIN_DMA type IOMMU domain to be allocated allows the
default_domain of an iommu_group to be set. This delegates device-domain
relationships to the generic IOMMU code.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 99 +++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 35821df70f78..2c9d793af394 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -309,6 +309,18 @@ static int hw_pass_through =3D 1;
 /* si_domain contains mulitple devices */
 #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
=20
+/*
+ * Domain managed externally, don't cleanup if it isn't attached
+ * to any devices.
+ */
+#define DOMAIN_FLAG_MANAGED_EXTERNALLY	(1 << 2)
+
+/*
+ * Set after domain initialisation. Used when allocating dma domains to
+ * defer domain initialisation until it is attached to a device
+ */
+#define DOMAIN_FLAG_INITIALISED	(1 << 3)
+
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx =3D 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
@@ -560,6 +572,16 @@ static inline int domain_type_is_vm_or_si(struct =
dmar_domain *domain)
 				DOMAIN_FLAG_STATIC_IDENTITY);
 }
=20
+static inline int domain_managed_externally(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_MANAGED_EXTERNALLY;
+}
+
+static inline int domain_is_initialised(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_INITIALISED;
+}
+
 static inline int domain_pfn_supported(struct dmar_domain *domain,
 				       unsigned long pfn)
 {
@@ -1664,7 +1686,7 @@ static void disable_dmar_iommu(struct intel_iommu =
*iommu)
=20
 		__dmar_remove_one_dev_info(info);
=20
-		if (!domain_type_is_vm_or_si(domain)) {
+		if (!domain_managed_externally(domain)) {
 			/*
 			 * The domain_exit() function  can't be called =
under
 			 * device_domain_lock, as it takes this lock =
itself.
@@ -1897,6 +1919,7 @@ static int domain_init(struct dmar_domain *domain, =
struct intel_iommu *iommu,
 	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
 	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -1909,6 +1932,9 @@ static void domain_exit(struct dmar_domain =
*domain)
 	if (!domain)
 		return;
=20
+	if (!domain_is_initialised(domain))
+		goto free_mem;
+
 	/* Remove associated devices and clear attached or cached =
domains */
 	rcu_read_lock();
 	domain_remove_dev_info(domain);
@@ -1921,6 +1947,7 @@ static void domain_exit(struct dmar_domain =
*domain)
=20
 	dma_free_pagelist(freelist);
=20
+free_mem:
 	free_domain_mem(domain);
 }
=20
@@ -4585,7 +4612,7 @@ static int device_notifier(struct notifier_block =
*nb,
 		return 0;
=20
 	dmar_remove_one_dev_info(domain, dev);
-	if (!domain_type_is_vm_or_si(domain) && =
list_empty(&domain->devices))
+	if (!domain_managed_externally(domain) && =
list_empty(&domain->devices))
 		domain_exit(domain);
=20
 	return 0;
@@ -5039,6 +5066,7 @@ static int md_domain_init(struct dmar_domain =
*domain, int guest_width)
 	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -5047,28 +5075,43 @@ static struct iommu_domain =
*intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	int flags =3D DOMAIN_FLAG_MANAGED_EXTERNALLY;
=20
-	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
+	switch (type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		flags |=3D DOMAIN_FLAG_VIRTUAL_MACHINE | =
DOMAIN_FLAG_INITIALISED;
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain)
+			return NULL;
=20
-	dmar_domain =3D alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
-	if (!dmar_domain) {
-		pr_err("Can't allocate dmar_domain\n");
-		return NULL;
-	}
-	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-		pr_err("Domain initialization failed\n");
-		domain_exit(dmar_domain);
+		if (md_domain_init(dmar_domain, =
DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+			pr_err("Domain initialization failed\n");
+			domain_exit(dmar_domain);
+			return NULL;
+		}
+		domain_update_iommu_cap(dmar_domain);
+		domain =3D &dmar_domain->domain;
+		domain->geometry.aperture_start =3D 0;
+		domain->geometry.aperture_end =3D
+			__DOMAIN_MAX_ADDR(dmar_domain->gaw);
+		domain->geometry.force_aperture =3D true;
+		break;
+	case IOMMU_DOMAIN_DMA:
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain)
+			return NULL;
+		/*
+		 * init domain in device attach when we know IOMMU
+		 * capabilities
+		 */
+		break;
+	case IOMMU_DOMAIN_IDENTITY:
+		return &si_domain->domain;
+	default:
 		return NULL;
 	}
-	domain_update_iommu_cap(dmar_domain);
-
-	domain =3D &dmar_domain->domain;
-	domain->geometry.aperture_start =3D 0;
-	domain->geometry.aperture_end   =3D =
__DOMAIN_MAX_ADDR(dmar_domain->gaw);
-	domain->geometry.force_aperture =3D true;
=20
-	return domain;
+	return &dmar_domain->domain;
 }
=20
 static void intel_iommu_domain_free(struct iommu_domain *domain)
@@ -5099,8 +5142,8 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 			dmar_remove_one_dev_info(old_domain, dev);
 			rcu_read_unlock();
=20
-			if (!domain_type_is_vm_or_si(old_domain) &&
-			     list_empty(&old_domain->devices))
+			if (list_empty(&old_domain->devices) &&
+			     !domain_managed_externally(old_domain))
 				domain_exit(old_domain);
 		}
 	}
@@ -5114,6 +5157,16 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
=20
+	/*
+	 * Initialise domain with IOMMU capabilities if it isn't already
+	 * initialised
+	 */
+	if (!domain_is_initialised(dmar_domain)) {
+		if (domain_init(dmar_domain, iommu,
+				DEFAULT_DOMAIN_ADDRESS_WIDTH))
+			return -ENOMEM;
+	}
+
 	/* check if this iommu agaw is sufficient for max mapped address =
*/
 	addr_width =3D agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -5160,6 +5213,10 @@ static int intel_iommu_map(struct iommu_domain =
*domain,
 	int prot =3D 0;
 	int ret;
=20
+	/* Don't bother if hardware passthrough used. */
+	if (dmar_domain =3D=3D si_domain && hw_pass_through)
+		return 0;
+
 	if (iommu_prot & IOMMU_READ)
 		prot |=3D DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
--=20
2.17.1

