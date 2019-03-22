Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC783C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8DC20830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256776;
	bh=uRt35v9dF3s+5gCN2IzNdtFuxXyWG2zilNfskK19dyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vM1XoEvY8Z78mVTrfILRY5zPBEHac2Z700QT6ChYii7pc90wTtcjZIkNHZZvxC5Fd
	 znR81d1xQukUTpIHCaK+FQluAjx41yxNoKnojgOR4u4P9y2m04zuKDf6tc6aOXBeKd
	 b02EBIbspakYG9Y8SrUSCmZYu7EP/YRQpVGtYOlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbfCVMMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389521AbfCVMMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D022082C;
        Fri, 22 Mar 2019 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256769;
        bh=uRt35v9dF3s+5gCN2IzNdtFuxXyWG2zilNfskK19dyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJCuPDGFuMma2kd+magqw1K4piiEDmSwP3AzMtlfHb57mCMDnfvHCOC4gNIwkcBRF
         6wAtidryEhdpaweuWak5gr37dZ65qhM0nghwT9ebhIVcItUvu+/9ENCuVKgehxPuhx
         h/vrKC3XbfDErG4BaJzG5XSWdmXgTske7s3Pkb0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yang <richardw.yang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 5.0 032/238] libnvdimm, pfn: Fix over-trim in trim_pfn_device()
Date:   Fri, 22 Mar 2019 12:14:11 +0100
Message-Id: <20190322111300.193675393@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yang <richardw.yang@linux.intel.com>

commit f101ada7da6551127d192c2f1742c1e9e0f62799 upstream.

When trying to see whether current nd_region intersects with others,
trim_pfn_device() has already calculated the *size* to be expanded to
SECTION size.

Do not double append 'adjust' to 'size' when calculating whether the end
of a region collides with the next pmem region.

Fixes: ae86cbfef381 "libnvdimm, pfn: Pad pfn namespaces relative to other regions"
Cc: <stable@vger.kernel.org>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/pfn_devs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -678,7 +678,7 @@ static void trim_pfn_device(struct nd_pf
 	if (region_intersects(start, size, IORESOURCE_SYSTEM_RAM,
 				IORES_DESC_NONE) == REGION_MIXED
 			|| !IS_ALIGNED(end, nd_pfn->align)
-			|| nd_region_conflict(nd_region, start, size + adjust))
+			|| nd_region_conflict(nd_region, start, size))
 		*end_trunc = end - phys_pmem_align_down(nd_pfn, end);
 }
 


