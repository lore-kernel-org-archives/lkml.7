Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFE4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA8020863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582323;
	bh=1OaqqUXJDrI7dfSfYr7b/X6MysTBFQofNoFwE/0B3Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O78jzvAgT5lVN6LMTbOW4RQstlbmmMbpjEPrjIGQfimpYCe51by3v4sJvMbirMF+C
	 pOuXGac+JDVOPjRAsAjDW3ruyWjnVj1pFwo1jdvYmXZvhNQoK5O9lYufRsj7mctpNn
	 1Bvx0AJGwOFbt/iubxGiiCWoaQ1JL8ASi8iBkGbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfCZGil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbfCZGii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:38:38 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FBB42070B;
        Tue, 26 Mar 2019 06:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582317;
        bh=1OaqqUXJDrI7dfSfYr7b/X6MysTBFQofNoFwE/0B3Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aImW/nvqdFV5xUrXye90R+e/VI279iWl49R9n7bad4mMt+OqxuTwy9NKog8wJaX+K
         PdvEUe7/QzrKW+qUtDzPiwWVkyhVbYm5yUTXz3jzIcIG7XZfMFgl/sFneBXTyeXnwc
         6Fq7oX3R7woFXlw/RxCV8BLgSUQ0Ik4UK+/elNLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.0 04/52] mmc: alcor: fix DMA reads
Date:   Tue, 26 Mar 2019 15:29:51 +0900
Message-Id: <20190326042701.190923076@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

From: Daniel Drake <drake@endlessm.com>

commit 5ea47691bd99e1100707ec63364aff72324e2af4 upstream.

Setting max_blk_count to 1 here was causing the mmc block layer
to always use the MMC_READ_SINGLE_BLOCK command here, which the
driver does not DMA-accelerate.

Drop the max_blk_ settings here. The mmc host defaults suffice,
along with the max_segs and max_seg_size settings, which I have
now documented in more detail.

Now each MMC command reads 4 512-byte blocks, using DMA instead of
PIO. On my SD card, this increases read performance (measured with dd)
from 167kb/sec to 4.6mb/sec.

Link: http://lkml.kernel.org/r/CAD8Lp47L5T3jnAjBiPs1cQ+yFA3L6LJtgFvMETnBrY63-Zdi2g@mail.gmail.com
Signed-off-by: Daniel Drake <drake@endlessm.com>
Reviewed-by: Oleksij Rempel <linux@rempel-privat.de>
Fixes: c5413ad815a6 ("mmc: add new Alcor Micro Cardreader SD/MMC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/alcor.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1044,14 +1044,27 @@ static void alcor_init_mmc(struct alcor_
 	mmc->caps2 = MMC_CAP2_NO_SDIO;
 	mmc->ops = &alcor_sdc_ops;
 
-	/* Hardware cannot do scatter lists */
+	/* The hardware does DMA data transfer of 4096 bytes to/from a single
+	 * buffer address. Scatterlists are not supported, but upon DMA
+	 * completion (signalled via IRQ), the original vendor driver does
+	 * then immediately set up another DMA transfer of the next 4096
+	 * bytes.
+	 *
+	 * This means that we need to handle the I/O in 4096 byte chunks.
+	 * Lacking a way to limit the sglist entries to 4096 bytes, we instead
+	 * impose that only one segment is provided, with maximum size 4096,
+	 * which also happens to be the minimum size. This means that the
+	 * single-entry sglist handled by this driver can be handed directly
+	 * to the hardware, nice and simple.
+	 *
+	 * Unfortunately though, that means we only do 4096 bytes I/O per
+	 * MMC command. A future improvement would be to make the driver
+	 * accept sg lists and entries of any size, and simply iterate
+	 * through them 4096 bytes at a time.
+	 */
 	mmc->max_segs = AU6601_MAX_DMA_SEGMENTS;
 	mmc->max_seg_size = AU6601_MAX_DMA_BLOCK_SIZE;
-
-	mmc->max_blk_size = mmc->max_seg_size;
-	mmc->max_blk_count = mmc->max_segs;
-
-	mmc->max_req_size = mmc->max_seg_size * mmc->max_segs;
+	mmc->max_req_size = mmc->max_seg_size;
 }
 
 static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)


