Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E88C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BF521924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138370;
	bh=GRRBHM7wfPZeNyQS1sUyaUM+bSWW64L009aIfds/6iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IqLiqOKPGnuM/2TmeGwqJDXBDoBWhDUUeaFQwykVdNNvF48lbR6CX1NxRWW/FMnxB
	 v6yPKM7CUv7TZHwr9uRcQiMVsL21xVO0ADPM+ZKVVV48/6SD59A0v2PKcqu9Mks+Ms
	 /IFWcNAjGRCd3ylSymCfcYe8DLJcxQfYf3Gy1nbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfDARGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfDARGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB3B21925;
        Mon,  1 Apr 2019 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138366;
        bh=GRRBHM7wfPZeNyQS1sUyaUM+bSWW64L009aIfds/6iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRuIwKctl4O3xg2ZxbgSMlrhkgwQypUrk2Y8qjXPti1Dt27lGSRuCYXzXvzTTgfQS
         /PD9vRA67SQHynY3sGq0jCwzxoFSwxSk+jBLxeQJ/Mou+RYxpgdp0gn8gYtgwqTl8r
         R4RHM2jToKi64dMOppFBvX3TyT6kox1YRfi7vZyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Russkikh <igor.russkikh@aquantia.com>,
        Nikita Danilov <nikita.danilov@aquantia.com>,
        Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 010/146] net: aquantia: fix rx checksum offload for UDP/TCP over IPv6
Date:   Mon,  1 Apr 2019 19:00:22 +0200
Message-Id: <20190401170049.307853928@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>

[ Upstream commit a7faaa0c5dc7d091cc9f72b870d7edcdd6f43f12 ]

TCP/UDP checksum validity was propagated to skb
only if IP checksum is valid.
But for IPv6 there is no validity as there is no checksum in IPv6.
This patch propagates TCP/UDP checksum validity regardless of IP checksum.

Fixes: 018423e90bee ("net: ethernet: aquantia: Add ring support code")
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: Nikita Danilov <nikita.danilov@aquantia.com>
Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -186,11 +186,12 @@ static void aq_rx_checksum(struct aq_rin
 	}
 	if (buff->is_ip_cso) {
 		__skb_incr_checksum_unnecessary(skb);
-		if (buff->is_udp_cso || buff->is_tcp_cso)
-			__skb_incr_checksum_unnecessary(skb);
 	} else {
 		skb->ip_summed = CHECKSUM_NONE;
 	}
+
+	if (buff->is_udp_cso || buff->is_tcp_cso)
+		__skb_incr_checksum_unnecessary(skb);
 }
 
 #define AQ_SKB_ALIGN SKB_DATA_ALIGN(sizeof(struct skb_shared_info))


