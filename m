Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC468C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8985D206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="P/HAsIDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfCDPrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:47:40 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43904 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDPrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:47:39 -0500
Received: by mail-ed1-f67.google.com with SMTP id m35so4610579ede.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 07:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6V7dpWVj4rrKYctGiqeGfa8YfTpmrLNmSPVJLPcsmus=;
        b=P/HAsIDGVwwrYi8ktcGEqg2i+OE1qvsxuGf8S2zWbr/pW0r7nkwJ40p/HQIe7PtWhe
         1VW70Pdsnz+I9+fGk960+raDs+o9TJ0lOQm+qQWP7Fa4+1Uub/SvL07u+6odrHIZe8Sj
         PbTPvPBfDNF6US4psUd6XCbDoouYMh2vJe6CyeKABvQIpw4/NyeMhIsg1vOY+wDBHb9F
         sYyOcMQ7iXylvol7MYvwiw1ZKFhMhvTa7avE4x/1lOh8O1ZN/6zOmB8j1ytjdOPLVxBF
         Xec5neACbjg6v8wTwhd3tzY254LsTI3Q2UGYYu+4NSQliSewiP6IctId+Uq3mKR4zq3j
         72tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6V7dpWVj4rrKYctGiqeGfa8YfTpmrLNmSPVJLPcsmus=;
        b=cPtlefwh2ly6f2YHOFoYe9mCNZ1jCJEmCbFe3hxrugfFvvzxKMwTNPkZtGqPkS8GLS
         yIvoKfr3kqpAoBmSM24vi85oyGuqgSikRzboEf0xBomrl8GO/mpIH0+N3QaKvVVjQKZz
         TLl30FIzJfhYHJNkzOdwilyE1YKR7oCqjIgivPlxvQeKhGVpRzFXvMTylE+WMCWq3B99
         DWEvvMQsb4E1ouQWlJ2UhtPjvB2D+fKudz+kVHb3oPQj0F7AZosysAdqU2rM9Y7vY1ir
         jITaX2TkzP/YFMmj7Eph6kOt0BzXcIsSy6afOQ11sfN6Mt2d01ONorOy+CB3Jw91yU7o
         fQJA==
X-Gm-Message-State: APjAAAXjbDxsPMe8VfdNZMrr8DhU6pCpFk1aLyWwNYpqoSm112dbeTA8
        JVl7lJhxeAmvoKIx5otVo1fXkw==
X-Google-Smtp-Source: APXvYqwNvfc8xhJUoNsMTpkdCIU9fgzqZXLmV2y7P/TzmyTnDemDPs/sMAg+AdtJE6iYKrMUEEo/sA==
X-Received: by 2002:a17:906:2969:: with SMTP id x9mr12656841ejd.223.1551714456839;
        Mon, 04 Mar 2019 07:47:36 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n25sm2183785edd.83.2019.03.04.07.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:47:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH 3/4] iommu/vt-d: Allow IOMMU_DOMAIN_DMA and
 IOMMU_DOMAIN_IDENTITY to be allocated
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
Date:   Mon, 4 Mar 2019 15:46:37 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
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
 drivers/iommu/intel-iommu.c | 113 +++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8e0a4e2ff77f..71cd6bbfec05 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -309,6 +309,14 @@ static int hw_pass_through =3D 1;
 /* si_domain contains mulitple devices */
 #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
=20
+/* Domain managed externally, don't cleanup if it isn't attached
+ * to any devices. */
+#define DOMAIN_FLAG_MANAGED_EXTERNALLY	(1 << 2)
+
+/* Set after domain initialisation. Used when allocating dma domains to
+ * defer domain initialisation until it is attached to a device */
+#define DOMAIN_FLAG_INITIALISED	(1 << 4)
+
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx =3D 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
@@ -558,6 +566,16 @@ static inline int domain_type_is_vm_or_si(struct =
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
@@ -1662,7 +1680,7 @@ static void disable_dmar_iommu(struct intel_iommu =
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
@@ -1895,6 +1913,7 @@ static int domain_init(struct dmar_domain *domain, =
struct intel_iommu *iommu,
 	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
 	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -2807,14 +2826,10 @@ static inline void iommu_prepare_isa(void)
=20
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
=20
-static int __init si_domain_init(int hw)
+static int __init si_domain_init(struct dmar_domain *si_domain, int hw)
 {
 	int nid, ret =3D 0;
=20
-	si_domain =3D alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
-	if (!si_domain)
-		return -EFAULT;
-
 	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
 		domain_exit(si_domain);
 		return -EFAULT;
@@ -3417,9 +3432,16 @@ static int __init init_dmars(void)
 	check_tylersburg_isoch();
=20
 	if (iommu_identity_mapping) {
-		ret =3D si_domain_init(hw_pass_through);
-		if (ret)
+		si_domain =3D alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
+		if (!si_domain) {
+			ret =3D -EFAULT;
 			goto free_iommu;
+		}
+		ret =3D si_domain_init(si_domain, hw_pass_through);
+		if (ret) {
+			domain_exit(si_domain);
+			goto free_iommu;
+		}
 	}
=20
=20
@@ -4575,7 +4597,7 @@ static int device_notifier(struct notifier_block =
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
@@ -5020,6 +5042,7 @@ static int md_domain_init(struct dmar_domain =
*domain, int guest_width)
 	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -5028,28 +5051,54 @@ static struct iommu_domain =
*intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	int flags =3D DOMAIN_FLAG_MANAGED_EXTERNALLY;
=20
-	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
-
-	dmar_domain =3D alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
-	if (!dmar_domain) {
-		pr_err("Can't allocate dmar_domain\n");
-		return NULL;
-	}
-	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-		pr_err("Domain initialization failed\n");
-		domain_exit(dmar_domain);
+	switch (type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		flags |=3D DOMAIN_FLAG_VIRTUAL_MACHINE | =
DOMAIN_FLAG_INITIALISED;
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		if (md_domain_init(dmar_domain, =
DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+			pr_err("Domain initialization failed\n");
+			domain_exit(dmar_domain);
+			return NULL;
+		}
+		domain_update_iommu_cap(dmar_domain);
+		domain =3D &dmar_domain->domain;
+		domain->geometry.aperture_start =3D 0;
+		domain->geometry.aperture_end   =3D =
__DOMAIN_MAX_ADDR(dmar_domain->gaw);
+		domain->geometry.force_aperture =3D true;
+		break;
+	case IOMMU_DOMAIN_DMA:
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		// init domain in device attach when we know IOMMU =
capabilities
+		break;
+	case IOMMU_DOMAIN_IDENTITY:
+		flags |=3D DOMAIN_FLAG_STATIC_IDENTITY | =
DOMAIN_FLAG_INITIALISED;
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		if (si_domain_init(dmar_domain, 0)) {
+			pr_err("Domain initialization failed\n");
+			domain_exit(dmar_domain);
+			return NULL;
+		}
+		break;
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
+	dmar_domain->domain.type =3D type;
+	return &dmar_domain->domain;
 }
=20
 static void intel_iommu_domain_free(struct iommu_domain *domain)
@@ -5080,8 +5129,8 @@ static int intel_iommu_attach_device(struct =
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
@@ -5090,6 +5139,12 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
=20
+	// Initialise domain with IOMMU capabilities if it isn't already =
initialised
+	if (!domain_is_initialised(dmar_domain)) {
+		if (domain_init(dmar_domain, iommu, =
DEFAULT_DOMAIN_ADDRESS_WIDTH))
+			return -ENOMEM;
+	}
+
 	/* check if this iommu agaw is sufficient for max mapped address =
*/
 	addr_width =3D agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
--=20
2.17.1

