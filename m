Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15BBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E112070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDBUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:20:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36439 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfDBUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:20:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so16897561qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 13:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oosopXziaXwx8TMe+1eItuvdTyEmEevJ5glmjuv0wSQ=;
        b=XsF/sf/LUVy3vEwa6hzdklFDmJBF0vKxmhAd4R2fulE3BPT4qLtXAT6BGsH2b20wnq
         ylgHd3Z7Q8MUnLWimLRri6aRHqlnjFFGMh7qIewVLu+bkAcm622qRtPlzHOV1gZUQr8a
         mV8NibrVD2Pd2BCsFikAJRxTmVQtLwauIdeBnlublFcM6v5FZyhZojTmhJJavHdPQZTJ
         f6bgMUZNNagSl5US2BSKIvKg/UbqR+Lz+ECfGCVliDm6hcP3j9Vd9WKUxdrx572lRtIc
         j4sHEBB5LGFXosDw47zoJSJPWetKNg0JLIhKOkWnoPo3K95OTE4GTWfaZTaRlyc6GSkV
         kH4g==
X-Gm-Message-State: APjAAAXhZUMMrQ2S/MAoMbOaBs9GHEVsMqplQfryC0u7bszEgyWvxLSX
        mSBXRZpmyFiotP/tOW9YqaJ1bw==
X-Google-Smtp-Source: APXvYqxJ1IooW3nqV1xlckUdCNp9UpcYAyBN3hNGh9m/XrXQdQ2yQC7/4pW8ufLEMthwPcoMjbEUew==
X-Received: by 2002:a0c:b051:: with SMTP id l17mr43373858qvc.96.1554236416781;
        Tue, 02 Apr 2019 13:20:16 -0700 (PDT)
Received: from localhost (ip72-201-117-66.ph.ph.cox.net. [72.201.117.66])
        by smtp.gmail.com with ESMTPSA id i11sm6617568qkg.33.2019.04.02.13.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 13:20:16 -0700 (PDT)
Date:   Tue, 2 Apr 2019 13:20:14 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gary R Hook <ghook@amd.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2] iommu/amd: Reserve exclusion range in iova-domain
Message-ID: <20190402202014.bzjw6eidksg6vymj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gary R Hook <ghook@amd.com>, Joerg Roedel <jroedel@suse.de>
References: <20190329151037.19112-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190329151037.19112-1-joro@8bytes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Mar 29 19, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>If a device has an exclusion range specified in the IVRS
>table, this region needs to be reserved in the iova-domain
>of that device. This hasn't happened until now and can cause
>data corruption on data transfered with these devices.
>
>Treat exclusion ranges as reserved regions in the iommu-core
>to fix the problem.
>
>Fixes: be2a022c0dd0 ('x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices')
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

I have a version of this that applies to 4.4 and 4,9 using the older
dm_region code if that would be useful for stable.


--8<--

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0ad8b7c78a43..f388458624cf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3165,11 +3165,14 @@ static void amd_iommu_get_dm_regions(struct device *dev,
 		}
 
 		region->start = entry->address_start;
+		region->type = IOMMU_RESV_DIRECT;
 		region->length = entry->address_end - entry->address_start;
 		if (entry->prot & IOMMU_PROT_IR)
 			region->prot |= IOMMU_READ;
 		if (entry->prot & IOMMU_PROT_IW)
 			region->prot |= IOMMU_WRITE;
+		if (entry->prot & IOMMU_UNITY_MAP_FLAG_EXCL_RANGE)
+			region->type = IOMMU_RESV_RESERVED;
 
 		list_add_tail(&region->list, head);
 	}
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 94f1bf772ec9..d84041bc77ac 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1495,6 +1495,9 @@ static int __init init_unity_map_range(struct ivmd_header *m)
 	if (e == NULL)
 		return -ENOMEM;
 
+	if (m->flags & IVMD_FLAG_EXCL_RANGE)
+		init_exclusion_range(m);
+
 	switch (m->type) {
 	default:
 		kfree(e);
@@ -1541,9 +1544,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
-		if (m->flags & IVMD_FLAG_EXCL_RANGE)
-			init_exclusion_range(m);
-		else if (m->flags & IVMD_FLAG_UNITY_MAP)
+		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
 			init_unity_map_range(m);
 
 		p += m->length;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index b08cf57bf455..31d27eb70565 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -324,6 +324,8 @@
 #define IOMMU_PROT_IR 0x01
 #define IOMMU_PROT_IW 0x02
 
+#define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE        (1 << 2)
+
 /* IOMMU capabilities */
 #define IOMMU_CAP_IOTLB   24
 #define IOMMU_CAP_NPCACHE 26
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a070fa39521a..ef4aa2879952 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -351,6 +351,9 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
 
+		if (entry->type != IOMMU_RESV_DIRECT)
+			continue;
+
 		for (addr = start; addr < end; addr += pg_size) {
 			phys_addr_t phys_addr;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f28dff313b07..15b7378f67f3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -115,18 +115,23 @@ enum iommu_attr {
 	DOMAIN_ATTR_MAX,
 };
 
+#define IOMMU_RESV_DIRECT	(1 << 0)
+#define IOMMU_RESV_RESERVED	(1 << 1)
+
 /**
  * struct iommu_dm_region - descriptor for a direct mapped memory region
  * @list: Linked list pointers
  * @start: System physical start address of the region
  * @length: Length of the region in bytes
  * @prot: IOMMU Protection flags (READ/WRITE/...)
+ * @type: Type of region (DIRECT, RESERVED)
  */
 struct iommu_dm_region {
 	struct list_head	list;
 	phys_addr_t		start;
 	size_t			length;
 	int			prot;
+	int			type;
 };
 
 #ifdef CONFIG_IOMMU_API
-- 
2.21.0

