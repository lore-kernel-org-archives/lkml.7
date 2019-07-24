Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BBDC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D427820657
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033683;
	bh=GfGjMnWLUUSxT6IFd61blMI2JbmrwLzDJpqgTbFUelA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XoO0/PKzWXSrme1FyFTyW2L2DnKvWwAJMA91lY0R252yHxI2NnWnK8WXwneNXZ25c
	 t37xkDGb83bQRI0C5wUr94WzcgpmjZ/BasZ84DBYjqlvsruIkQ6BQSyWeeZg66U2RM
	 q9xV9gBg/lOKby2FOuWqPE4jathBUt2kpLZX4mo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfGYFqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbfGYFqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:46:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E55B20828;
        Thu, 25 Jul 2019 05:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033596;
        bh=GfGjMnWLUUSxT6IFd61blMI2JbmrwLzDJpqgTbFUelA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BISc9SQi1zGPbUJjSZoM2uXMVapgdAiR2XxCBH3T1jfnYRb9e0/RDISGlOuYW/piC
         Z2vagxvGkJtIyO1SId0Fh5xEfa+gnZFY2+5fhIi4apUq6J9ZLUNP3SPnUY5rUg6qyV
         Q3F9QtEN3gJqeYzHO8bfjJxya/yjpm1AvuWaTfFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH 4.19 263/271] intel_th: msu: Fix single mode with disabled IOMMU
Date:   Wed, 24 Jul 2019 21:22:12 +0200
Message-Id: <20190724191717.758704850@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
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
@@ -632,7 +632,7 @@ static int msc_buffer_contig_alloc(struc
 		goto err_out;
 
 	ret = -ENOMEM;
-	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32, order);
 	if (!page)
 		goto err_free_sgt;
 


