Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ABAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2FD218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfC2SSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:18:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40069 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfC2SSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:18:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so3663102qts.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Sgs2rYMOHnC5kvt0WX7uidiNxem2xbxols9lAFHRNyQ=;
        b=m4AkdFCqDsMGBMzqtAQCLO2bdgBF4oeAz2Ym5Gx28epg0EEn3RPAEGVk0gn4smQnxG
         qM9+s2XvSRwoTxs3V+DA9jXYF+40HBCbgjtmU/0llGXo4EunB77V9+E+SSoptTvOB8Yn
         hnV037Zf7PXmY+M6ug8T3+l2NZKy186xDdNB31DOvdyj6thS88d5j/mKJTY9I6DuhVWn
         FnIUG+ylmoXH7GV51qDxEB0BNViHZ0hPtLXhdbBdqXVDJqOvhUDy7G4GR2aV6fl8bz0d
         TJEac0f4/e5LNN5r8XHb8MmiN4raHKLkDq0H7H73eWfe8+9cYeTLyzpGh6EQlzRkfR0f
         HUwQ==
X-Gm-Message-State: APjAAAXY3Qek3oa8mXx6w0+k3XYHXee7t2zk8a9W3uRyYxuJLMbse929
        0Qjefey5M6qDEgnPMP8qi6Gb51gCjuI=
X-Google-Smtp-Source: APXvYqz1GM0rzdUFlTIy56tE9hjmER8Q0XKKc+f4Dl+IeVvkYeCxvTsun15Dzzsss+bWFXKoJz4VUw==
X-Received: by 2002:a0c:8a54:: with SMTP id 20mr42132656qvu.167.1553883528562;
        Fri, 29 Mar 2019 11:18:48 -0700 (PDT)
Received: from localhost (ip72-201-117-66.ph.ph.cox.net. [72.201.117.66])
        by smtp.gmail.com with ESMTPSA id r15sm1403839qte.65.2019.03.29.11.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 11:18:47 -0700 (PDT)
Date:   Fri, 29 Mar 2019 11:18:46 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gary R Hook <ghook@amd.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2] iommu/amd: Reserve exclusion range in iova-domain
Message-ID: <20190329181846.jjo2wijxkibfs35m@cantor>
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
>---
> drivers/iommu/amd_iommu.c       | 9 ++++++---
> drivers/iommu/amd_iommu_init.c  | 7 ++++---
> drivers/iommu/amd_iommu_types.h | 2 ++
> 3 files changed, 12 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 21cb088d6687..f7cdd2ab7f11 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -3169,21 +3169,24 @@ static void amd_iommu_get_resv_regions(struct device *dev,
> 		return;
>
> 	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
>+		int type, prot = 0;
> 		size_t length;
>-		int prot = 0;
>
> 		if (devid < entry->devid_start || devid > entry->devid_end)
> 			continue;
>
>+		type   = IOMMU_RESV_DIRECT;
> 		length = entry->address_end - entry->address_start;
> 		if (entry->prot & IOMMU_PROT_IR)
> 			prot |= IOMMU_READ;
> 		if (entry->prot & IOMMU_PROT_IW)
> 			prot |= IOMMU_WRITE;
>+		if (entry->prot & IOMMU_UNITY_MAP_FLAG_EXCL_RANGE)
>+			/* Exclusion range */
>+			type = IOMMU_RESV_RESERVED;
>
> 		region = iommu_alloc_resv_region(entry->address_start,
>-						 length, prot,
>-						 IOMMU_RESV_DIRECT);
>+						 length, prot, type);
> 		if (!region) {
> 			dev_err(dev, "Out of memory allocating dm-regions\n");
> 			return;
>diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
>index f773792d77fd..1b1378619fc9 100644
>--- a/drivers/iommu/amd_iommu_init.c
>+++ b/drivers/iommu/amd_iommu_init.c
>@@ -2013,6 +2013,9 @@ static int __init init_unity_map_range(struct ivmd_header *m)
> 	if (e == NULL)
> 		return -ENOMEM;
>
>+	if (m->flags & IVMD_FLAG_EXCL_RANGE)
>+		init_exclusion_range(m);
>+
> 	switch (m->type) {
> 	default:
> 		kfree(e);
>@@ -2059,9 +2062,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
>
> 	while (p < end) {
> 		m = (struct ivmd_header *)p;
>-		if (m->flags & IVMD_FLAG_EXCL_RANGE)
>-			init_exclusion_range(m);
>-		else if (m->flags & IVMD_FLAG_UNITY_MAP)
>+		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
> 			init_unity_map_range(m);
>
> 		p += m->length;
>diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
>index eae0741f72dc..87965e4d9647 100644
>--- a/drivers/iommu/amd_iommu_types.h
>+++ b/drivers/iommu/amd_iommu_types.h
>@@ -374,6 +374,8 @@
> #define IOMMU_PROT_IR 0x01
> #define IOMMU_PROT_IW 0x02
>
>+#define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
>+
> /* IOMMU capabilities */
> #define IOMMU_CAP_IOTLB   24
> #define IOMMU_CAP_NPCACHE 26
>-- 
>2.16.4
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
