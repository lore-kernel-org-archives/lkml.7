Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE368C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA1520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688538;
	bh=c8ywWndswt5xGes/Na60ZfhXIS1pdeT1SrDH558/2Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VdaaW+eg4NCLrF2+xaKLl9dfwE1KxoVe3NDIVhGznACZbFrNd7C37JeZ/uS+cFOGY
	 VmRGI0Ss6MLusTzpJaXdjYcMBJAe2BIJsI7jQRMn471iPtHVAYMeSoo6mR9pnO1sYl
	 DPpXworoA9yk+7eSCq3OzSfIBXsVEbJzrH6J7a6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfCDIfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfCDIfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:35:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62EA20823;
        Mon,  4 Mar 2019 08:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688530;
        bh=c8ywWndswt5xGes/Na60ZfhXIS1pdeT1SrDH558/2Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4gCBPBwbs5nkf3F3TNJNXZecnlUTIYSUzOrURh+Eep4Sq7EvMMnUYVwLV1If89P3
         1XluQZB3dmcu6vqYVKATId2TCFxiNY0NaCwIXjTjnPpWKNSV2cElSN/xszxPiozlQD
         LRrusyWj5Hm+cobc07cn+5mV6RTDpZ+ncfzpm3wY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alamy Liu <alamy.liu@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 73/88] mmc: cqhci: Fix a tiny potential memory leak on error condition
Date:   Mon,  4 Mar 2019 09:22:56 +0100
Message-Id: <20190304081633.514494770@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alamy Liu <alamy.liu@gmail.com>

commit d07e9fadf3a6b466ca3ae90fa4859089ff20530f upstream.

Free up the allocated memory in the case of error return

The value of mmc_host->cqe_enabled stays 'false'. Thus, cqhci_disable
(mmc_cqe_ops->cqe_disable) won't be called to free the memory.  Also,
cqhci_disable() seems to be designed to disable and free all resources, not
suitable to handle this corner case.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/cqhci.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -217,12 +217,21 @@ static int cqhci_host_alloc_tdl(struct c
 						 cq_host->desc_size,
 						 &cq_host->desc_dma_base,
 						 GFP_KERNEL);
+	if (!cq_host->desc_base)
+		return -ENOMEM;
+
 	cq_host->trans_desc_base = dmam_alloc_coherent(mmc_dev(cq_host->mmc),
 					      cq_host->data_size,
 					      &cq_host->trans_desc_dma_base,
 					      GFP_KERNEL);
-	if (!cq_host->desc_base || !cq_host->trans_desc_base)
+	if (!cq_host->trans_desc_base) {
+		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
+				   cq_host->desc_base,
+				   cq_host->desc_dma_base);
+		cq_host->desc_base = NULL;
+		cq_host->desc_dma_base = 0;
 		return -ENOMEM;
+	}
 
 	pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,


