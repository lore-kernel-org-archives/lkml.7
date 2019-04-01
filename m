Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541EAC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2417820830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140989;
	bh=gcXop/B0Ku+RQivk01G+/HugZYTAMzdHTay98w5BtjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPpKD1lKL8/VOA4s6LcmGw9PV/fLxbzXsvblInUMRc9831WHgpAlp5oG0kwm2i1qz
	 VhKZsOmRhNJJXjHJfX7dDLBC00WIA1VnBmArWRYpLcCTG9jlJd8NynsDxPkb3Atl3/
	 AWYSqGhJz02BVrt2oplK3dlBccZ8tC6A4TW/u/X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbfDAR3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732945AbfDAR33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A087420856;
        Mon,  1 Apr 2019 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139769;
        bh=gcXop/B0Ku+RQivk01G+/HugZYTAMzdHTay98w5BtjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KR6RWV3FDQf8yK2J71Hi+ajd4P9eQcoPAxpSIvfAiuRPaQ59CYxQUKIBRX0hXilYk
         nQsOLTIo/h+Rqk9YTdgKS8a37bKpBwrSjwvz9ix02izcUUp8AMW4kwGlkisyqRoesg
         6/LieHC5vtex5gUgRISUH9KoGs03UKMpTXyEaG4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.4 001/131] mmc: pxamci: fix enum type confusion
Date:   Mon,  1 Apr 2019 19:01:11 +0200
Message-Id: <20190401170051.785356404@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -181,7 +181,7 @@ static void pxamci_dma_irq(void *param);
 static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 {
 	struct dma_async_tx_descriptor *tx;
-	enum dma_data_direction direction;
+	enum dma_transfer_direction direction;
 	struct dma_slave_config	config;
 	struct dma_chan *chan;
 	unsigned int nob = data->blocks;


