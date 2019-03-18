Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40AC2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902052;
	bh=YT7A7BZguh/YyoTLGnlCyDKzsqkqj6bNczYoi5krGXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gvsNpO+MaydQopCvHIsjXzoYZ3NpwSuyzcS0HDDwvKbU2rms3tcWCC/a0duzN8x67
	 mhKSKha7yrfIcK0PAVvIk44J1oAWvd34rVhO59okddcdx6HjEEdnyyBwzltMeA68F6
	 FQBjxoLILCurAMYv4GczBwivNFQNo6YCIToVvTMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbfCRJeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbfCRJe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:27 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA95321734;
        Mon, 18 Mar 2019 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901666;
        bh=YT7A7BZguh/YyoTLGnlCyDKzsqkqj6bNczYoi5krGXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXT989ZHnegzdz6IOP8bEqCqUc92zQBqTGMdvx9brunioe1Gb/wk133qW+qrEG3Lk
         HEQfd1uY3dFFZNmYzFRpR7E9PBrW1Adt/mgIRH8hx+zVOtMKMn8lSyGJDxIGi7pLse
         qK5K95brqCyWaXpupvIsSOju/KAFBVJgv2mRFHC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masaru Nagai <masaru.nagai.vx@renesas.com>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 12/34] ravb: Decrease TxFIFO depth of Q3 and Q2 to one
Date:   Mon, 18 Mar 2019 10:25:36 +0100
Message-Id: <20190318084146.360353506@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
References: <20190318084144.657740413@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -458,7 +458,7 @@ static int ravb_dmac_init(struct net_dev
 		   RCR_EFFS | RCR_ENCF | RCR_ETS0 | RCR_ESF | 0x18000000, RCR);
 
 	/* Set FIFO size */
-	ravb_write(ndev, TGC_TQP_AVBMODE1 | 0x00222200, TGC);
+	ravb_write(ndev, TGC_TQP_AVBMODE1 | 0x00112200, TGC);
 
 	/* Timestamp enable */
 	ravb_write(ndev, TCCR_TFEN, TCCR);


