Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067782070B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OHyw6Dfj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iS0+5jQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfCATix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:38:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCATiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:38:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 59CA16137D; Fri,  1 Mar 2019 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469129;
        bh=yiM3MHxtEWnuKGlpNzeBQzZIjM/3LSdBrGjOjD3denE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHyw6DfjBkaBgLxeHlOi1ips/LncsNAdmVJ1W/lfLbYsxryGcWo+bU4GT2nQlrA4y
         nPTMtSJEYBjZ/XbJO8hyxK+w4v8u0KRPlXysoOnPYuHbNBPCgaOPKKSzhJQF4bX5Ky
         LpYzLT+1ddIw/rkxc2EwAli+j6DWGnr+XoXaDErI=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C0A66118F;
        Fri,  1 Mar 2019 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469127;
        bh=yiM3MHxtEWnuKGlpNzeBQzZIjM/3LSdBrGjOjD3denE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iS0+5jQGHS7NSjotRfx0f6XPrg4BdV9K/8qxL3jpIylLxaMaW6AL90uuUylwgk33H
         1bicE/EzGjmqeT5pawvYXgjVnJkLUGwM2DpNPUxFaUF9DM0WBfxHpukNy4VnEzCOcm
         7ff1qyO3DdsI4QRQu27s7GRISKAZ20wbHc1reuuI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C0A66118F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 03/15] iommu/io-pgtable: Allow TLB operations to be optional
Date:   Fri,  1 Mar 2019 12:38:25 -0700
Message-Id: <1551469117-3404-4-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An upcoming change to arm-smmu will add auxiliary domains that will allow
a leaf driver to create and map additional pagetables for device
specific uses. By definition aux arm-smmu domains will not be allowed
to touch the hardware directly so allow for the TLB operations for
a given pagetable configuration to be NULL just in case the caller
accidentally calls for a flush with the wrong device.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/io-pgtable.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 47d5ae5..fbfd3c9 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -178,18 +178,22 @@ struct io_pgtable {
 
 static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
 {
-	iop->cfg.tlb->tlb_flush_all(iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_flush_all(iop->cookie);
 }
 
 static inline void io_pgtable_tlb_add_flush(struct io_pgtable *iop,
 		unsigned long iova, size_t size, size_t granule, bool leaf)
 {
-	iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf, iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf,
+			iop->cookie);
 }
 
 static inline void io_pgtable_tlb_sync(struct io_pgtable *iop)
 {
-	iop->cfg.tlb->tlb_sync(iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_sync(iop->cookie);
 }
 
 /**
-- 
2.7.4

