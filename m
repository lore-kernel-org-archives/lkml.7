Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE371206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642303;
	bh=18jO5xaFDERdyOV7io7aSLzAQta4hBJaafpYNrc6a2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m4dHahdyHDJeTOXdwZ6g4L9dfW7BbjD6TIWOeZoCZ/ZVxr/dTwss3tQ+cTVonxXe1
	 dWc0PYYTLByqekZhHCjz847E9qFrVFQuWpjfyexE55jBVZiPjLlPntBgJIIqljTB+b
	 gpzBRbw8C8yoE8vlVfIx5PTTg+xfLMsujuunDxF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbfL2R6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:58:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387479AbfL2R6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:58:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D046208C4;
        Sun, 29 Dec 2019 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642294;
        bh=18jO5xaFDERdyOV7io7aSLzAQta4hBJaafpYNrc6a2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMhZ8taUf1dCHuB5Yi+SaCfyB0IfHeC2F+VZWumBj8jC7c1YpGbdpsUdMUoujwfQ1
         l4z+3pTXUG2yz5cAL5Taekt6O64j3KeqIkg5uMEb3tcO5ZGXbULFbsw+pK94adva9b
         Chea5xtoEdVnPGIB+sSVnz1p2RhVDF8BUrplshuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, cprt <cprt@protonmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.4 370/434] iommu/vt-d: Set ISA bridge reserved region as relaxable
Date:   Sun, 29 Dec 2019 18:27:03 +0100
Message-Id: <20191229172726.563166748@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williamson <alex.williamson@redhat.com>

commit d8018a0e9195ba9f0fb9cf0fd3843807c8b952d5 upstream.

Commit d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via
iommu_get_resv_regions") created a direct-mapped reserved memory region
in order to replace the static identity mapping of the ISA address
space, where the latter was then removed in commit df4f3c603aeb
("iommu/vt-d: Remove static identity map code").  According to the
history of this code and the Kconfig option surrounding it, this direct
mapping exists for the benefit of legacy ISA drivers that are not
compatible with the DMA API.

In conjuntion with commit 9b77e5c79840 ("vfio/type1: check dma map
request is within a valid iova range") this change introduced a
regression where the vfio IOMMU backend enforces reserved memory regions
per IOMMU group, preventing userspace from creating IOMMU mappings
conflicting with prescribed reserved regions.  A necessary prerequisite
for the vfio change was the introduction of "relaxable" direct mappings
introduced by commit adfd37382090 ("iommu: Introduce
IOMMU_RESV_DIRECT_RELAXABLE reserved memory regions").  These relaxable
direct mappings provide the same identity mapping support in the default
domain, but also indicate that the reservation is software imposed and
may be relaxed under some conditions, such as device assignment.

Convert the ISA bridge direct-mapped reserved region to relaxable to
reflect that the restriction is self imposed and need not be enforced
by drivers such as vfio.

Fixes: 1c5c59fbad20 ("iommu/vt-d: Differentiate relaxable and non relaxable RMRRs")
Cc: stable@vger.kernel.org # v5.3+
Link: https://lore.kernel.org/linux-iommu/20191211082304.2d4fab45@x1.home
Reported-by: cprt <cprt@protonmail.com>
Tested-by: cprt <cprt@protonmail.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5698,7 +5698,7 @@ static void intel_iommu_get_resv_regions
 
 		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
 			reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
-						      IOMMU_RESV_DIRECT);
+						   IOMMU_RESV_DIRECT_RELAXABLE);
 			if (reg)
 				list_add_tail(&reg->list, head);
 		}


