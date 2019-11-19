Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AE3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4152222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141057;
	bh=ZX84ZWcKU4UrMMG75fwy0D7FF1ofTVbu34hPEUyZCEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zqsHc34CcFVu1Xug+mhu0KU3HApFqdNuAwa7s3c+YbF4bvCKygG+aCkrZ6YvvSEqO
	 nRcyQETv2+15SHoDCjdGkWH+AtJzF7jDAzNzrV5MJusxDb7sz/4s/hUlZyZd232rB/
	 UsKuqmLzLxafBqIbyYkcgbnWYsWX64fVtzh/VuFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfKSFYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbfKSFYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:24:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0144D208C3;
        Tue, 19 Nov 2019 05:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141051;
        bh=ZX84ZWcKU4UrMMG75fwy0D7FF1ofTVbu34hPEUyZCEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTA6M6NUeXLqJaPo2kMZQh6B8YV6YzKuU6wP1AISOV12ZjEta6DpO2b4213S1ROSo
         JhE0wchnkflUu+W4V0oCzX2I4dHP3N6OHAP8f7pS7U+i51IBJclQOkie8O2DqTcArh
         d1zp29mc2TOzEj2wN4QsPdvVSM8KXDafmXxMHChA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.19 028/422] iommu/vt-d: Fix QI_DEV_IOTLB_PFSID and QI_DEV_EIOTLB_PFSID macros
Date:   Tue, 19 Nov 2019 06:13:45 +0100
Message-Id: <20191119051401.887365453@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Auger <eric.auger@redhat.com>

commit 4e7120d79edb31e4ee68e6f8421448e4603be1e9 upstream.

For both PASID-based-Device-TLB Invalidate Descriptor and
Device-TLB Invalidate Descriptor, the Physical Function Source-ID
value is split according to this layout:

PFSID[3:0] is set at offset 12 and PFSID[15:4] is put at offset 52.
Fix the part laid out at offset 52.

Fixes: 0f725561e1684 ("iommu/vt-d: Add definitions for PFSID")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: stable@vger.kernel.org # v4.19+
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/intel-iommu.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -286,7 +286,8 @@ enum {
 #define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
 #define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
 #define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
-#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff) << 52))
+#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
+				   ((u64)((pfsid >> 4) & 0xfff) << 52))
 #define QI_DEV_IOTLB_SIZE	1
 #define QI_DEV_IOTLB_MAX_INVS	32
 
@@ -311,7 +312,8 @@ enum {
 #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
 #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
 #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
-#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff) << 52))
+#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
+				    ((u64)((pfsid >> 4) & 0xfff) << 52))
 #define QI_DEV_EIOTLB_MAX_INVS	32
 
 #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)


