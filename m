Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EB9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3713213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370641;
	bh=JWqJ10LC5TLyhc8A68K9D+71ZSvVHNNpJzgx5/ED/RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c9rncvJN6BdiPyaqMA38CYhUtKKY2HWyHOMg85tdKS1D2OevHnCIwwB9R64LliXkC
	 FRu/b+s2fQZITZtaywUT9K1wRRx481fZx522+7z5hL86hjvAb1zn2EAmohOMmY4/e8
	 q0QfXdhSupJMr8TME4Mzms5sYfqpia7NG+mY5SFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfFXKEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbfFXKD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:03:57 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229D9208E4;
        Mon, 24 Jun 2019 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370636;
        bh=JWqJ10LC5TLyhc8A68K9D+71ZSvVHNNpJzgx5/ED/RM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIm0EoYBznFJahiLQkud/GECunR3wJFrxePixgszUAzPVQxE8l0h9HNiAg8+ehvYl
         zjpUAoDMyJm8DGQ/u0zsL1S7H4Wnr4i2104GyQ5X7oQlmGBV0Yqh9P93Wv702W+MZi
         S+Zz5zOqFzYymB2CvQf9BgBMRQ+dm+4uwdDVOLZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <swood@redhat.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Alan Tull <atull@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/90] fpga: dfl: afu: Pass the correct device to dma_mapping_error()
Date:   Mon, 24 Jun 2019 17:56:25 +0800
Message-Id: <20190624092316.604950455@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 13069847a475b60069918dc9971f5adb42811ce3 ]

dma_mapping_error() was being called on a different device struct than
what was passed to map/unmap.  Besides rendering the error checking
ineffective, it caused a debug splat with CONFIG_DMA_API_DEBUG.

Signed-off-by: Scott Wood <swood@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/dfl-afu-dma-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 0e81d33af856..c9a613dc9eb7 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -399,7 +399,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 				    region->pages[0], 0,
 				    region->length,
 				    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
+	if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
 		dev_err(&pdata->dev->dev, "failed to map for dma\n");
 		ret = -EFAULT;
 		goto unpin_pages;
-- 
2.20.1



