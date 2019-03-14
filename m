Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62FB2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TKT5mQeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfCNL7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:59:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40940 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCNL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:59:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id r23so4355226edm.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T/4Ff1S3DJ5FVnugqnONcYb2lICqShIEda2oGl7KdeU=;
        b=TKT5mQebW4FayJlbn4mJEx0E6yv5DZGOR9gyyTpku7nIphFHzDKH16unzfLgeu2NLb
         3DZBp3YLjX2JofTqHQ5nur46V8bvv5fJ8+XPx4pX2dPZ2WMcVYTduCWPm7ii2A5Mu0TH
         VcrDHwGOvNyrnAZZvDkLMD0pkl+qhuLyC6MOu6hKzdYzzA6LLnRfWwheVuF4z02E4ixi
         3Lyo8Du2ZlBWLVFGF91lIejXpniHKUG6EwO6Tgzp4q0Uojq10NN2qwNkKRDXey9NLP7+
         Sb8RFo6LSTtcnXfrLEAsXxLdvp+TDrSpMmZRhbB2CR4kBjNyBV6wdtDYkdjDyqhVRssu
         FnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T/4Ff1S3DJ5FVnugqnONcYb2lICqShIEda2oGl7KdeU=;
        b=iAjpEdg2QCZMwfrLtM+m9/TkbwSsO1Labfh+yykLiEHFYIqDpMCQF2DuzLm09i19mF
         1TL+iefJMGfVc6QnrAgRct0/nv61w9aD3jFAjwP0YcmVnh8HcbcTjSmusgIJyYzHxeq6
         nNiNChOStD5kg8V7WUCxkquBZL3irofDmuUmadke9D01O0gLumNpTYcjhRB+U4yF78Yg
         lJv4zGXsCh3IRNgAWQWTspWM/ydrL9oBKh/kUf3SjIqKtjEqrGgmpsd9YNkNUBC8D5Te
         tPutNP799Q+B+glIPurczeC+0UqeBskolhk2fQKMuLBT+Jgdwpyborymhjj5/1JfSdSY
         ijLA==
X-Gm-Message-State: APjAAAXH4rkKWFL59a/P1DZJ7Fmex1t7ghD9+DwTKkJDBip7OuMVBb9J
        +eIseGOyJtbcicqQBi/3zDIFIg==
X-Google-Smtp-Source: APXvYqxxk2JmKZb9ev/DL1cY0GWCFWhQa0jJ9NnyhGUEPKoPhZwjoA56gnFdOK/R202PPG9hjRjttg==
X-Received: by 2002:aa7:c650:: with SMTP id z16mr5739181edr.252.1552564776082;
        Thu, 14 Mar 2019 04:59:36 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w6sm1360862eds.0.2019.03.14.04.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:59:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via 
 iommu_get_resv_regions
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Date:   Thu, 14 Mar 2019 11:58:27 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support mapping ISA region via iommu_group_create_direct_mappings,
make sure its exposed by iommu_get_resv_regions. This allows
deduplication of reserved region mappings

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 42 +++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8e0a4e2ff77f..2e00e8708f06 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -337,6 +337,8 @@ static LIST_HEAD(dmar_rmrr_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
=20
+static struct iommu_resv_region *isa_resv_region;
+
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
=20
@@ -2780,26 +2782,34 @@ static inline int iommu_prepare_rmrr_dev(struct =
dmar_rmrr_unit *rmrr,
 					  rmrr->end_address);
 }
=20
+static inline struct iommu_resv_region *iommu_get_isa_resv_region(void)
+{
+	if (!isa_resv_region)
+		isa_resv_region =3D iommu_alloc_resv_region(0,
+				16*1024*1024,
+				0, IOMMU_RESV_DIRECT);
+
+	return isa_resv_region;
+}
+
 #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
-static inline void iommu_prepare_isa(void)
+static inline void iommu_prepare_isa(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev;
 	int ret;
+	struct iommu_resv_region *reg =3D iommu_get_isa_resv_region();
=20
-	pdev =3D pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (!pdev)
+	if (!reg)
 		return;
=20
 	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
-	ret =3D iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - =
1);
+	ret =3D iommu_prepare_identity_map(&pdev->dev, reg->start,
+			reg->start + reg->length - 1);
=20
 	if (ret)
 		pr_err("Failed to create 0-16MiB identity map - floppy =
might not work\n");
-
-	pci_dev_put(pdev);
 }
 #else
-static inline void iommu_prepare_isa(void)
+static inline void iommu_prepare_isa(struct pci_dev *pdev)
 {
 	return;
 }
@@ -3289,6 +3299,7 @@ static int __init init_dmars(void)
 	struct dmar_rmrr_unit *rmrr;
 	bool copied_tables =3D false;
 	struct device *dev;
+	struct pci_dev *pdev;
 	struct intel_iommu *iommu;
 	int i, ret;
=20
@@ -3469,7 +3480,11 @@ static int __init init_dmars(void)
 		}
 	}
=20
-	iommu_prepare_isa();
+	pdev =3D pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
+	if (pdev) {
+		iommu_prepare_isa(pdev);
+		pci_dev_put(pdev);
+	}
=20
 domains_done:
=20
@@ -5266,6 +5281,7 @@ static void intel_iommu_get_resv_regions(struct =
device *device,
 	struct iommu_resv_region *reg;
 	struct dmar_rmrr_unit *rmrr;
 	struct device *i_dev;
+	struct pci_dev *pdev;
 	int i;
=20
 	rcu_read_lock();
@@ -5280,6 +5296,14 @@ static void intel_iommu_get_resv_regions(struct =
device *device,
 	}
 	rcu_read_unlock();
=20
+	if (dev_is_pci(device)) {
+		pdev =3D to_pci_dev(device);
+		if ((pdev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_ISA) {
+			reg =3D iommu_get_isa_resv_region();
+			list_add_tail(&reg->list, head);
+		}
+	}
+
 	reg =3D iommu_alloc_resv_region(IOAPIC_RANGE_START,
 				      IOAPIC_RANGE_END - =
IOAPIC_RANGE_START + 1,
 				      0, IOMMU_RESV_MSI);
--=20
2.17.1

