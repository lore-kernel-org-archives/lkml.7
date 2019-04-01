Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B66C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FBA21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139257;
	bh=qh9dSC56sTBbu3I7G7fC3iNgW0WaZfMsaVebcT9ZKZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pvF9vTPEMo3rLpc3gCLLIjj3Y8FqmCMm1HIDWu55ks9yPwxsDvmD9ZXcaNJQtlron
	 fFTa1VEPD4YD4R40DJW3ihvpjsPyyT3OlC/WCrs+ARa3MPkJrxJl+TgiljR3EDLoPQ
	 Pj7/WroTxxmZg61GF4nH9eEsnGvdQyzumUpR9xXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfDARU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbfDARUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:20:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B236206C0;
        Mon,  1 Apr 2019 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139248;
        bh=qh9dSC56sTBbu3I7G7fC3iNgW0WaZfMsaVebcT9ZKZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bi40GqH26t2n2WKmK35jaW07xTBL8NCOvttp81LQEs3q5XtnFHVCBx4fj2EmFt/p8
         xO03fu/O8LkfGwaVviHFBCRkUyXCHIPXKWCNWlcQSWE9l2GQkXGmi9vKQxz91xtTeF
         is8O1/k+xTmGIWNPSZ3yWOQ75f/IKV/PA8bZbo1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Russkikh <igor.russkikh@aquantia.com>,
        Nikita Danilov <nikita.danilov@aquantia.com>,
        Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 020/107] net: aquantia: fix rx checksum offload for UDP/TCP over IPv6
Date:   Mon,  1 Apr 2019 19:01:35 +0200
Message-Id: <20190401170047.388409841@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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
@@ -270,11 +270,12 @@ int aq_ring_rx_clean(struct aq_ring_s *s
 		} else {
 			if (buff->is_ip_cso) {
 				__skb_incr_checksum_unnecessary(skb);
-				if (buff->is_udp_cso || buff->is_tcp_cso)
-					__skb_incr_checksum_unnecessary(skb);
 			} else {
 				skb->ip_summed = CHECKSUM_NONE;
 			}
+
+			if (buff->is_udp_cso || buff->is_tcp_cso)
+				__skb_incr_checksum_unnecessary(skb);
 		}
 
 		skb_set_hash(skb, buff->rss_hash,


