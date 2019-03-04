Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5697C20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688398;
	bh=fiDpOJp1WUJ/jaKonkzsN/lNGvUa3i0YVdblfXjejrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ycKYWc8B4Ykud6zBeIOkcnkMb55cK+V/oB9H3fYjt5hTyHBldpypcidWId39OUB7
	 JMMtZ4Y2CMy/g/e54/JOKmfUjkGe7NqsnkvgtcXCi/Hiawm7vjZgXKmEG9UOpG0V0l
	 7rTFKhcoafI/fdYUPgYllYBa5jJoMGS72+9OJDAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfCDIdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfCDIbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:31:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E5120823;
        Mon,  4 Mar 2019 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688266;
        bh=fiDpOJp1WUJ/jaKonkzsN/lNGvUa3i0YVdblfXjejrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ySHP0FvRX4k7K1fBVG4xMGiXt+6B1w1Hju3Ei34qG2yqd2wp0x4iL7cUJyU5rTnML
         0nY9fLjxIxeV5aUSCB5m60pCpCvlhkh9Qv5F0efCq+hX05Z03+O+jtSlQegwDYliQ+
         H4lJAeE/ALyaKcw8Du5GtzBj4o41zPNwnmnHPMXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alamy Liu <alamy.liu@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 70/78] mmc: cqhci: Fix a tiny potential memory leak on error condition
Date:   Mon,  4 Mar 2019 09:22:53 +0100
Message-Id: <20190304081628.721507854@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


