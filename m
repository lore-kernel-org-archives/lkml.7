Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44463C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146AC2339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620325;
	bh=XnvH6o0Rl557Wo2DardOGKkFMZFDIAy9WaKXsHFwfoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gfdu00pwwlUfbkkjC/eQ1x9KCY8M5S5jyhIIL+GQ5LtdqQc4puZaXqo2JyMK4pPxw
	 66Ce3oyuYJcU1foapXLaYDrCx+OdJosfHcubQAZ/LPlZ7YiL6m6bta7XY+QCXW4LAk
	 MRgJT9QvX0pDAAKKS2ziI1cYCEedZwCk/1VKKpy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbfIDSFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388893AbfIDSFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:05:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DE852339E;
        Wed,  4 Sep 2019 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620321;
        bh=XnvH6o0Rl557Wo2DardOGKkFMZFDIAy9WaKXsHFwfoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wILye/DVJAG1X8AUL6vHj9PJTk+si7kH+0qT6LuYg3JrRU5zDx/UWGydp2D/BMtz4
         LtYeDPEBumieGOwoOBYy1dP3M10noHplI9ig682dIQVC4uDdAjbCiZqKCOyPzZRDcT
         gD5iHR2UXB7dLs3FQilzOii8TIdAPjO7BxPHdabk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/93] iommu/dma: Handle SG length overflow better
Date:   Wed,  4 Sep 2019 19:53:17 +0200
Message-Id: <20190904175304.464031756@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ab2cbeb0ed301a9f0460078e91b09f39958212ef ]

Since scatterlist dimensions are all unsigned ints, in the relatively
rare cases where a device's max_segment_size is set to UINT_MAX, then
the "cur_len + s_length <= max_len" check in __finalise_sg() will always
return true. As a result, the corner case of such a device mapping an
excessively large scatterlist which is mergeable to or beyond a total
length of 4GB can lead to overflow and a bogus truncated dma_length in
the resulting segment.

As we already assume that any single segment must be no longer than
max_len to begin with, this can easily be addressed by reshuffling the
comparison.

Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 511ff9a1d6d94..f9dbb064f9571 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -675,7 +675,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		 * - and wouldn't make the resulting output segment too long
 		 */
 		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
-		    (cur_len + s_length <= max_len)) {
+		    (max_len - cur_len >= s_length)) {
 			/* ...then concatenate it with the previous one */
 			cur_len += s_length;
 		} else {
-- 
2.20.1



