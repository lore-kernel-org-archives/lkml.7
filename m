Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE201206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="M2J1U+bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCDPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:47:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42093 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:47:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id j89so4622003edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rb1DX0fbPDlWcvDTnIgQPh+EKQmJitjqYYITJiAZYlE=;
        b=M2J1U+bk5OGUTzEXy+FzdeN08HFtCgNAvz4yBoQgssJWoy9rFcqetLdtODnVyOVdpN
         fJ3XjVUrzvDOOVf4nAW/ZZoApbPlXSxgY2ukEm6+c8ADxkAzKDOy7V/mMOBamIciWtGT
         5d/p4NqaWvCgFV3zEPiawi6mnFr+aVSKAiOPfLn5ExhJEhnHJyhpXq4rxKE0H9s8m6Jx
         rKBJRtFEIqNhs70KbEs/E9crTy6UX7KQKt7eWj7xKELbR74OUZ7gXbMUBNxSSVdHfvGd
         5aVnGiuTKfJNV0HXpzimWwaOPF9WtdukvuE4KObZxxEpnxoeVta4ZpVylzvTVHN5IXX4
         j3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rb1DX0fbPDlWcvDTnIgQPh+EKQmJitjqYYITJiAZYlE=;
        b=RbGmbpm8p1E36eISqXf2EA4LKbDN5LzZalYCo5PRphe8EqCzmplkEondiBBKH68FVs
         hJcDiGfQOamTUFLUhM3GHLRerMLluheZpiiWIedlocbQxhL4h29vb99Mq5L/iCT3Xgri
         C/aq1eCQz6zNVjZF/QRL3LAFmRofD1zNbSxjEm2gCwxZThbIpEWvlqVskmMRVf/4iqAt
         OwaYdO1hGzoj3cHYWKP1WfqYT0Jpz6oswL6O/jL+j1EaVvZEvwso8qEriIMgTMswGbeP
         jkOA+bel52dBHWvrfXhVP3uPp79eX1jU2nMTgQTkUQf+Flb5kGLWSlXZJf4aF7f0Ciyi
         +p+g==
X-Gm-Message-State: APjAAAVbWb5TKv0eKzlEltPszE3hDlwTYP3syShlYwB7DjU1nomIB/dI
        mo2ZGLPJ9d/ZGljWpkrLEZoP5BkETPk=
X-Google-Smtp-Source: APXvYqy3KyJVAZTc9twgQZFVSjkgLJ+Tpp0cOsifKIm5g3Qn9G0DKMI2tmv/DaTp6yDG9PL4wvhUbg==
X-Received: by 2002:a17:906:b6d6:: with SMTP id ec22mr8789206ejb.163.1551714421180;
        Mon, 04 Mar 2019 07:47:01 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n25sm2183785edd.83.2019.03.04.07.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:47:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH 2/4] iommu/vt-d: Implement apply_resv_region for reserving
 IOVA ranges
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Date:   Mon, 4 Mar 2019 15:46:02 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used by iommu.c before creating identity mappings for reserved ranges to
ensure dma-map-ops won't ever remap these addresses.

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

