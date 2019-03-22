Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A163C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D897921916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253819;
	bh=XDhqWP88MH6PuPJ8I5ZEfcn+Fwpi7muDGJeSRyzdXQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1xF0aE0j15+tQYgJyLaIIwoxHX6D/KP7IEfvavFJ7PVkylKBZYqpZFCCB0+kq2MTj
	 /bWJvNQbxMryrE9j2CtyGBBwID5zzz2OdJENPahDpmDItGDCZmGgtRr9rYyhQ5EwYE
	 BOfE6k+56G+NDbXoH2dB5Fo2VfLOeembrzQiClbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfCVLXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfCVLXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:23:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F4F218A2;
        Fri, 22 Mar 2019 11:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253815;
        bh=XDhqWP88MH6PuPJ8I5ZEfcn+Fwpi7muDGJeSRyzdXQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MG5HdaOqXQe3hseXPbMzgoZWEABs1tIHI5Ijnp6DhlPAd17XRJW9PhJPrYrteN8Uo
         J9axneSsZoXJjCwqAs+8X42n8WvdNjT65x1n88AcWUneWyT8IEFr2hQOpxTqCPVAnN
         e0tB3adlVspvZ+H0q/NIKMY2Etj6+e+MxnvBMQ1U=
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
Subject: [PATCH 3.18 063/134] net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case
Date:   Fri, 22 Mar 2019 12:14:36 +0100
Message-Id: <20190322111214.596798602@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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



