Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FBBC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D5021773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738389;
	bh=vgCLMKW+NQvuHw3CHGVcHXOkLZcyuLSi4AZxwb9uRkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YUyfxPkMTHMVRecKCbWQ1fCZOmNuslKp0J9hMYRMFbl7h2DV9WHtVvmug/mNejt9F
	 AnRayb9OgtCbtZdf54wohoxVmIF+5fYRzSf4sU3Rkqa+9lNN4FEI1zQnQv6jAgMS8M
	 dU5p6c8GXREyNoREn8JuWIx1//7U4WTr1Jtz7I1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404777AbfHBJdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404773AbfHBJdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:33:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF2B8217D7;
        Fri,  2 Aug 2019 09:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738382;
        bh=vgCLMKW+NQvuHw3CHGVcHXOkLZcyuLSi4AZxwb9uRkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o60p+NQKJi9Sth+Tkvlobfp82u9Is+ouUJCPMmUt2sq6Nvvk8jBe/ltNOcR8v/GLR
         8eugv/NsPaK/HfeRCVw4gJklgkN4X8OaL2Lm/Nkoq/MIhwGJOogUUqF6Hjhv9GWWFI
         ThmFsIXBWTd2ZD/jVpNI+LAhE1xc+ZruZONUoNsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH 4.4 082/158] intel_th: msu: Fix single mode with disabled IOMMU
Date:   Fri,  2 Aug 2019 11:28:23 +0200
Message-Id: <20190802092220.878378356@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 918b8646497b5dba6ae82d4a7325f01b258972b9 upstream.

Commit 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU") switched
the single mode code to use dma mapping pages obtained from the page
allocator, but with IOMMU disabled, that may lead to using SWIOTLB bounce
buffers and without additional sync'ing, produces empty trace buffers.

Fix this by using a DMA32 GFP flag to the page allocation in single mode,
as the device supports full 32-bit DMA addressing.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: Ammy Yi <ammy.yi@intel.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190621161930.60785-4-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/msu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -625,7 +625,7 @@ static int msc_buffer_contig_alloc(struc
 		goto err_out;
 
 	ret = -ENOMEM;
-	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32, order);
 	if (!page)
 		goto err_free_sgt;
 


