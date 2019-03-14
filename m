Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A227720657
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iS263EhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCNL7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:59:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36519 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCNL7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:59:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id e4so4383770edi.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RUIngzJUvLQtLGrbRaymdnQUCRjYrsBvIHiCEamCxWw=;
        b=iS263EhJKVRyKyc+pKC0p+kN3xHCO1U2Ri1lf6o2edksh/6W17hUUGATHM/+Qa4B9J
         a7r6SL1ywWsOzfMO+UAtJvbUNFQbZS34XAy36pG7C7kqgUIbx9MSPPwRL5ZZOKLrCwe1
         1oYGX7L3kgWbfhCmkMh04JNd7XOey8KUXmzZC+MVggeHp/voWHyqtBQTcS+ueyb574BI
         NTIDYRNqXbnYoiKyy++0R4yKLyPCAZa/jUtXiZySFu10yVssP2/m6nictt3K0lF3vetl
         YF3AKJakyudRP2LHN6x8EEJ1t2W+JRxWfEIFJ6ru2QOhFeNTLSdWKrvsL+4mCnyvIrij
         mQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RUIngzJUvLQtLGrbRaymdnQUCRjYrsBvIHiCEamCxWw=;
        b=d+yW6+wz70wiRiC/sSER93NATjaU9NCNd1CL3lkA+N4xG3g9SfYlLJMQIl23TNy92R
         onhZeYV8hiXbm7gsf36Gsn7tmHMo2onLgPDPbmPeJmzxc5LTyg9lpdo8RbcUiXHakv8Z
         H1GbCwXCmCIOlLEmDxhoBomahKC3FZfPJZIIcLQRSdtr9IuwLRgHxSabx1VbibzT4Rl1
         c21/kTvoRcJHbzxBNv6Zg+1Zq7j/Jm5xJefD3gPJQIQeYRPxuHbOigc2DpNikhvpNgDA
         jKoi+E3ZykNNiRjZFpwVFhWm0BmaBroYc4CjuElC8/pTAkks/SZ5gq/XTxa6lDMTVL9y
         FYtg==
X-Gm-Message-State: APjAAAUoNCPEOf2AO+6LB3cwXV54KehTmtkOEH+7DrZTUIC+w99Hs7H2
        xMo/YaNn+cIsTBvzqrKB3c3UZQ==
X-Google-Smtp-Source: APXvYqyDew++1aSjngCjLXYMF+1OJP/vTfL8/foB1RPij/APh4sgSYGB8Pcanuwr7BS9jRWFyNsnsQ==
X-Received: by 2002:a50:a4f1:: with SMTP id x46mr11574019edb.62.1552564751701;
        Thu, 14 Mar 2019 04:59:11 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w6sm1360862eds.0.2019.03.14.04.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:59:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2 2/7] iommu/vt-d: Implement apply_resv_region for reserving
 IOVA ranges
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Date:   Thu, 14 Mar 2019 11:58:03 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE9FFC59-ECC0-44FF-90D4-7B5ABD61909F@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used by iommu.c before creating identity mappings for reserved ranges to
ensure dma-ops won't ever remap these ranges

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..8e0a4e2ff77f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5299,6 +5299,19 @@ static void intel_iommu_put_resv_regions(struct =
device *dev,
 	}
 }
=20
+static void intel_iommu_apply_resv_region(struct device *dev,
+		struct iommu_domain *domain,
+		struct iommu_resv_region *region)
+{
+	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
+	unsigned long start, end;
+
+	start =3D IOVA_PFN(region->start);
+	end   =3D IOVA_PFN(region->start + region->length - 1);
+
+	WARN_ON_ONCE(reserve_iova(&dmar_domain->iovad, start, end) =3D=3D =
NULL);
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct =
intel_svm_dev *sdev)
 {
@@ -5392,6 +5405,7 @@ const struct iommu_ops intel_iommu_ops =3D {
 	.remove_device		=3D intel_iommu_remove_device,
 	.get_resv_regions	=3D intel_iommu_get_resv_regions,
 	.put_resv_regions	=3D intel_iommu_put_resv_regions,
+	.apply_resv_region	=3D intel_iommu_apply_resv_region,
 	.device_group		=3D pci_device_group,
 	.pgsize_bitmap		=3D INTEL_IOMMU_PGSIZES,
 };
--=20
2.17.1

