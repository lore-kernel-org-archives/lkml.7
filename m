Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C05C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10E6252B3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189973;
	bh=vEOByxn9z6ZCUFQN8HmDmoIcUw5cBKWjZLs5n98wcSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=joSI4FkubOOKuD6Q9MIicWFfzgpnbxNL2/HlSe2A7y1JDnrG++0vWCwMKek1w7iPv
	 WvGAEZHazT+/+N1gHJSsohZ1lxf8hb8njGjEgQlfWCleTLW5r38SdVQm7WNWnyr8x/
	 6y7N8nqyUhom58U1ONGFdsxntFqsbd6lyU5Rq4OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfE3ET2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbfE3DP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:26 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E628924559;
        Thu, 30 May 2019 03:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186126;
        bh=vEOByxn9z6ZCUFQN8HmDmoIcUw5cBKWjZLs5n98wcSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1abXzmnqyTH4x+FQiDBmz2aah68LdNoEfxYrx1R45iG42/XWGh054bFRFqUZeJ0Ds
         mUdTWZzN1Ety/+KzJ11TpfmPUehmJL3Szt20W0pfgq8jOGCpEILE6qjnk2em623I4b
         eUf4kp+/tAhyBmhn0q+fbqOrivqia2/0/3Do29Mw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 284/346] staging: mt7621-mmc: Check for nonzero number of scatterlist entries
Date:   Wed, 29 May 2019 20:05:57 -0700
Message-Id: <20190530030555.299268806@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d4223e06b6aed581625f574ad8faa71b6c0fc903 ]

The buffer descriptor setup loop is correct only if it is setting up at
least one bd struct.  Besides, there is an error if dma_map_sg() returns
0, which is possible and must be handled.

Additionally, remove the BUG_ON() checking sglen, which is unnecessary
because we configure DMA with that constraint during init.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/mt7621-mmc/sd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 74f0e57ad2f15..38f9ea02ee3a9 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -596,8 +596,6 @@ static void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 	struct bd *bd;
 	u32 j;
 
-	BUG_ON(sglen > MAX_BD_NUM); /* not support currently */
-
 	gpd = dma->gpd;
 	bd  = dma->bd;
 
@@ -692,6 +690,13 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		data->sg_count = dma_map_sg(mmc_dev(mmc), data->sg,
 					    data->sg_len,
 					    mmc_get_dma_dir(data));
+
+		if (data->sg_count == 0) {
+			dev_err(mmc_dev(host->mmc), "failed to map DMA for transfer\n");
+			data->error = -ENOMEM;
+			goto done;
+		}
+
 		msdc_dma_setup(host, &host->dma, data->sg,
 			       data->sg_count);
 
-- 
2.20.1



