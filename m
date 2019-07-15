Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6FFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7E92086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198078;
	bh=RCERVD4EomtNaF+pux6n2NXGbPprNAKJkf7ml5FnTmk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=agJya1Ew3q45uN5xuUbn+/LBbJGjN9iO8Ix2DLP0EIs/Ukmb+q6NJs+Z8Ilyfrymq
	 gtrm5n6YYn666vFN2gN1Ndh1459+597i5PnaV4khLiTtSsZp1keQl0Nx30PYwdJIbw
	 /oNliBzAo0fbceQR11ezgqyLql27P/CbvTRmebQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfGONja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbfGONj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:39:28 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E9B12080A;
        Mon, 15 Jul 2019 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563197967;
        bh=RCERVD4EomtNaF+pux6n2NXGbPprNAKJkf7ml5FnTmk=;
        h=From:To:Cc:Subject:Date:From;
        b=orkQxiit5phDMhqO1XCkNJnK1+ptjz/MIv7j3wDclFJryDg1T5z25dv6EIMTfMk1g
         OfZAwsMgnON3IqgvwkHk6TTgxJwwM++myX3WYTKINnYdaj4G7YP6ozSjcRApAbLuai
         m0ymRbJYihO3j4EFE8/gZLD1ZAt9bYra65W5VPvA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 001/158] wil6210: fix potential out-of-bounds read
Date:   Mon, 15 Jul 2019 09:36:46 -0400
Message-Id: <20190715133923.2890-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit bfabdd6997323adbedccb13a3fed1967fb8cf8f5 ]

Notice that *rc* can evaluate to up to 5, include/linux/netdevice.h:

enum gro_result {
        GRO_MERGED,
        GRO_MERGED_FREE,
        GRO_HELD,
        GRO_NORMAL,
        GRO_DROP,
        GRO_CONSUMED,
};
typedef enum gro_result gro_result_t;

In case *rc* evaluates to 5, we end up having an out-of-bounds read
at drivers/net/wireless/ath/wil6210/txrx.c:821:

	wil_dbg_txrx(wil, "Rx complete %d bytes => %s\n",
		     len, gro_res_str[rc]);

Fix this by adding element "GRO_CONSUMED" to array gro_res_str.

Addresses-Coverity-ID: 1444666 ("Out-of-bounds read")
Fixes: 194b482b5055 ("wil6210: Debug print GRO Rx result")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index 75c8aa297107..1b1b58e0129a 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -736,6 +736,7 @@ void wil_netif_rx_any(struct sk_buff *skb, struct net_device *ndev)
 		[GRO_HELD]		= "GRO_HELD",
 		[GRO_NORMAL]		= "GRO_NORMAL",
 		[GRO_DROP]		= "GRO_DROP",
+		[GRO_CONSUMED]		= "GRO_CONSUMED",
 	};
 
 	wil->txrx_ops.get_netif_rx_params(skb, &cid, &security);
-- 
2.20.1

