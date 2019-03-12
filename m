Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6D42077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411480;
	bh=E2nVuON5xSZJJb9+9ltVHr4IXtfTDAkuOX+RgGn9YTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iaal4Z6rQiwCDUdLijiuQTn4daIH1MFymu+NDbXTM+//W/owzwk7pG/CNV8KZ9txK
	 Z/xmQXsUyIeUQo15/toSkW5M75kAk13D3elz6sv880Q7pQW1WPeLCTOt6XZWHsQ7eK
	 B4UKPHL/+x1YmPnX32wLMi8BNaQ9WTtZPTqqSX+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfCLRYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729800AbfCLRRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:54 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56BEA2087C;
        Tue, 12 Mar 2019 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411073;
        bh=E2nVuON5xSZJJb9+9ltVHr4IXtfTDAkuOX+RgGn9YTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7ftR2r4Oy06O8foXZ2fwYfrayJcoqYjHMvAg47HXMrwM1JumfM9ARMcmBjEGiHis
         3TXBVWBuPz4fiDpODIMWjvsrH6uvEiafkZDkUeYaiiogq93mBTEsXmOStSGzRJeVz/
         VvUNLGQpjcL+Z/WFzGKdB9Q90JlC5XL6E5ws6WXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tomonori Sakita <tomonori.sakita@sord.co.jp>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Dalon L Westergreen <dalon.westergreen@linux.intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 47/96] net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case
Date:   Tue, 12 Mar 2019 10:10:05 -0700
Message-Id: <20190312171038.115818890@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6571ebce112a21ec9be68ef2f53b96fcd41fd81b ]

If fill_level was not zero and status was not BUSY,
result of "tx_prod - tx_cons - inuse" might be zero.
Subtracting 1 unconditionally results invalid negative return value
on this case.
Make sure not to return an negative value.

Signed-off-by: Tomonori Sakita <tomonori.sakita@sord.co.jp>
Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Reviewed-by: Dalon L Westergreen <dalon.westergreen@linux.intel.com>
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/altera/altera_msgdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/altera_msgdma.c b/drivers/net/ethernet/altera/altera_msgdma.c
index 0fb986ba3290..0ae723f75341 100644
--- a/drivers/net/ethernet/altera/altera_msgdma.c
+++ b/drivers/net/ethernet/altera/altera_msgdma.c
@@ -145,7 +145,8 @@ u32 msgdma_tx_completions(struct altera_tse_private *priv)
 			& 0xffff;
 
 	if (inuse) { /* Tx FIFO is not empty */
-		ready = priv->tx_prod - priv->tx_cons - inuse - 1;
+		ready = max_t(int,
+			      priv->tx_prod - priv->tx_cons - inuse - 1, 0);
 	} else {
 		/* Check for buffered last packet */
 		status = csrrd32(priv->tx_dma_csr, msgdma_csroffs(status));
-- 
2.19.1



