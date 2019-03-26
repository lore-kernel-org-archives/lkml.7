Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2632075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582149;
	bh=0ZWpSgbyG/SLM1tloAc/EWkO3FEyzQMnKabwcVQ0214=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FuDOCrcdKIKsH4y3QCnVhfbP9Pl7cM+VxK6f0shZ5lsU6hfq0UeimHV7RDR3qzFO0
	 Ly5O9KZ8oTHxz9VZLfMmJg247jmSBg/djdIM2POku4jv15WtnvwgA5ZxwPUJDJKktz
	 TBLWphnN0hf1vGHe3fR/jmL5SvP3bmzYGN67ag4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfCZGfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfCZGfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:44 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F092070B;
        Tue, 26 Mar 2019 06:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582144;
        bh=0ZWpSgbyG/SLM1tloAc/EWkO3FEyzQMnKabwcVQ0214=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncekXd2d1TozH1S0Kj685loaFtylDZdl+yDn5kvP/4X7YqU1wgDhuyek10zcPll3q
         i4t1eInoqY3cbjKoZezkaVv1BJOXMpBDYLydbCznfahWawWR94H/P0K5vFoGB6ABEv
         ePJBlf2/8d+7Vl6Sj3UKwT982b6ELOiuV9kqdNmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 03/45] mmc: pxamci: fix enum type confusion
Date:   Tue, 26 Mar 2019 15:29:46 +0900
Message-Id: <20190326042702.870641145@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit e60a582bcde01158a64ff948fb799f21f5d31a11 upstream.

clang points out several instances of mismatched types in this drivers,
all coming from a single declaration:

drivers/mmc/host/pxamci.c:193:15: error: implicit conversion from enumeration type 'enum dma_transfer_direction' to
      different enumeration type 'enum dma_data_direction' [-Werror,-Wenum-conversion]
                direction = DMA_DEV_TO_MEM;
                          ~ ^~~~~~~~~~~~~~
drivers/mmc/host/pxamci.c:212:62: error: implicit conversion from enumeration type 'enum dma_data_direction' to
      different enumeration type 'enum dma_transfer_direction' [-Werror,-Wenum-conversion]
        tx = dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, direction,

The behavior is correct, so this must be a simply typo from
dma_data_direction and dma_transfer_direction being similarly named
types with a similar purpose.

Fixes: 6464b7140951 ("mmc: pxamci: switch over to dmaengine use")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/pxamci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -164,7 +164,7 @@ static void pxamci_dma_irq(void *param);
 static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 {
 	struct dma_async_tx_descriptor *tx;
-	enum dma_data_direction direction;
+	enum dma_transfer_direction direction;
 	struct dma_slave_config	config;
 	struct dma_chan *chan;
 	unsigned int nob = data->blocks;


