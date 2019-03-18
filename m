Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C59214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901484;
	bh=9TO5CNIG4xUkqxZA8kwyeGfw22DO1AHtYJF8mFtBftg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6AfADvWu21fN9KRV62KBa7c0KLnSuoDc2iQ0cS7928e+16Lg32hMxea8HsB/TNW1
	 nZoBa3RTOwbDjUsutf3NlujXjWi5joU4IH21ALwbKuOj9q0Z9Udq76JvwANwR6gAFx
	 /8sXMOxMJfvdCFwPjL5NtGp/AzRPuLPH/MhX1J58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfCRJbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbfCRJbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:31:16 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C7A2087C;
        Mon, 18 Mar 2019 09:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901475;
        bh=9TO5CNIG4xUkqxZA8kwyeGfw22DO1AHtYJF8mFtBftg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7TGJWkAIZw4ijdm8hFflGy5dvt16mrO0TidFEiEFgj3KKpaF91zb3REVnVFjiyWS
         RBV3HzRo8X7iFkjpGgqTXxBLE3DGH0TjloLtYUZXWQkCcI65IbYwAt8ckT2q+0lzqI
         RXnJXtDP6hpGTE8c/Fvvhn7sYDI2E3CeWi7EXbaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masaru Nagai <masaru.nagai.vx@renesas.com>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 14/52] ravb: Decrease TxFIFO depth of Q3 and Q2 to one
Date:   Mon, 18 Mar 2019 10:25:01 +0100
Message-Id: <20190318083845.107485810@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

From: Masaru Nagai <masaru.nagai.vx@renesas.com>

[ Upstream commit ae9819e339b451da7a86ab6fe38ecfcb6814e78a ]

Hardware has the CBS (Credit Based Shaper) which affects only Q3
and Q2. When updating the CBS settings, even if the driver does so
after waiting for Tx DMA finished, there is a possibility that frame
data still remains in TxFIFO.

To avoid this, decrease TxFIFO depth of Q3 and Q2 to one.

This patch has been exercised this using netperf TCP_MAERTS, TCP_STREAM
and UDP_STREAM tests run on an Ebisu board. No performance change was
detected, outside of noise in the tests, both in terms of throughput and
CPU utilisation.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Masaru Nagai <masaru.nagai.vx@renesas.com>
Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
[simon: updated changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/ravb_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -467,7 +467,7 @@ static int ravb_dmac_init(struct net_dev
 		   RCR_EFFS | RCR_ENCF | RCR_ETS0 | RCR_ESF | 0x18000000, RCR);
 
 	/* Set FIFO size */
-	ravb_write(ndev, TGC_TQP_AVBMODE1 | 0x00222200, TGC);
+	ravb_write(ndev, TGC_TQP_AVBMODE1 | 0x00112200, TGC);
 
 	/* Timestamp enable */
 	ravb_write(ndev, TCCR_TFEN, TCCR);


